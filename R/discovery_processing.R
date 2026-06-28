# discovery_processing.R
#
# Discovery Processing -- Execution Layer (Module 04)
#
# Implements the Execution Layer that actually invokes registered
# Discovery Pipeline stage executors, plus a small set of generic,
# domain-agnostic processing stages (Quality Control, Normalization,
# Filtering). Contains no scientific, biological, or statistical
# assumption -- only generic dataset preparation, per
# IDS-002_Discovery_Implementation.md and the Module 04 Coding Prompt
# (v2, including its Pre-Implementation Decision Record).
#
# Per that Decision Record: Module 03's `run_discovery_pipeline()`
# remains unchanged (orchestration only; never invokes executors).
# This file introduces a new, additive function,
# `execute_discovery_pipeline()`, which reuses Module 03's
# `validate_discovery_pipeline()` and `resolve_pipeline_dependencies()`
# as-is, and is solely responsible for actually invoking stage
# executors in resolved order. Orchestration (Module 03) and execution
# (Module 04) are kept as separate responsibilities.
#
# Per the Contract-first Principle (as already established in Module
# 03): any Discovery artifact produced here is constructed via the
# LOCKED Module 02 `create_artifact_contract()`, with
# `metadata$framework_layer = "processing"` -- `contract_type` always
# remains `"artifact"`. No new object model or contract schema is
# introduced.

#' Execute a Discovery Pipeline (Execution Layer)
#'
#' Actually executes a Discovery Pipeline's registered stages, in
#' dependency-resolved order, against a single dataset that is threaded
#' sequentially through each stage's `executor`. This is the Execution
#' Layer introduced by Module 04, kept strictly separate from Module
#' 03's orchestration-only `run_discovery_pipeline()` (which never
#' invokes executors). This function internally reuses
#' [validate_discovery_pipeline()] and [resolve_pipeline_dependencies()]
#' as-is; it does not duplicate any orchestration logic.
#'
#' Per the Immutable Dataset Principle, the `dataset` argument passed
#' in by the caller is never modified in place: each stage executor is
#' expected to return a new processed dataset (per the
#' `process(dataset, ...) -> processed_dataset` interface), and this
#' function only ever rebinds a local variable to thread the data
#' through stages -- the object the caller passed in is left untouched.
#'
#' @param pipeline A `discovery_pipeline` object (see
#'   [create_discovery_pipeline()] and [register_discovery_stage()]).
#' @param dataset The initial dataset to process (e.g. a `data.frame`,
#'   `matrix`, or, if available, a `SummarizedExperiment`). Never
#'   modified in place.
#' @param producer Character scalar identifying the producer for the
#'   resulting Discovery contractual artifact. Defaults to the
#'   pipeline's `pipeline_name`.
#' @param consumer Character scalar identifying the intended consumer
#'   for the resulting Discovery contractual artifact (e.g. a
#'   downstream Modeling pipeline name). Defaults to
#'   `"discovery_downstream"`.
#' @param ... Additional arguments forwarded to every stage executor.
#'
#' @return A list with three elements:
#'   \describe{
#'     \item{processed_dataset}{The final dataset after all stages
#'       have executed, in resolved order.}
#'     \item{artifact}{An `artifact_contract` object (per Module 02),
#'       with `metadata$framework_layer = "processing"`, recording this
#'       execution as a Discovery contractual artifact.}
#'     \item{execution_order}{Character vector giving the stage
#'       execution order that was used.}
#'   }
#'
#' @export
execute_discovery_pipeline <- function(pipeline,
                                        dataset,
                                        producer = NULL,
                                        consumer = "discovery_downstream",
                                        ...) {

  validate_discovery_pipeline(pipeline)

  execution_order <- resolve_pipeline_dependencies(pipeline)

  current_dataset <- dataset

  for (stage_name in execution_order) {
    stage <- pipeline$stages[[stage_name]]
    current_dataset <- stage$executor(current_dataset, ...)
  }

  if (is.null(producer)) {
    producer <- pipeline$pipeline_name
  }

  artifact <- create_artifact_contract(
    producer = producer,
    consumer = consumer,
    inputs = list("dataset"),
    outputs = list("processed_dataset"),
    dependencies = list(),
    metadata = list(
      framework_layer = "processing",
      execution_order = execution_order
    )
  )

  list(
    processed_dataset = current_dataset,
    artifact = artifact,
    execution_order = execution_order
  )
}

# ---- Generic, domain-agnostic processing stages --------------------------
#
# Each function below follows the Processing Stage Interface,
# `process(dataset, ...) -> processed_dataset`, and may be registered
# directly as a stage `executor` via `register_discovery_stage()`. None
# of these functions modify their `dataset` argument in place (per the
# Immutable Dataset Principle), and none contain any biological,
# statistical, or domain-specific assumption.

#' Get the dimensions of a generic dataset
#'
#' Internal helper used by the generic processing stages to obtain the
#' dimensions of a dataset in a way that is agnostic to whether the
#' dataset is a `data.frame`, `matrix`, or (if available, via S4
#' dispatch) a `SummarizedExperiment` -- without this package importing
#' or depending on any such class explicitly.
#'
#' @param dataset The dataset to inspect.
#' @return An integer vector of length 2, `c(nrow, ncol)`, or `NULL` if
#'   dimensions could not be determined.
#' @keywords internal
#' @noRd
.generic_dataset_dim <- function(dataset) {
  d <- tryCatch(dim(dataset), error = function(e) NULL)
  if (is.null(d) || length(d) != 2) {
    return(NULL)
  }
  d
}

#' Generic Quality Control stage
#'
#' A generic, reusable Quality Control processing stage. Performs only
#' structural validation (checks the dataset has two dimensions, and
#' that neither is zero) and a missing-value inspection (where
#' supported), and returns the dataset unchanged, with QC summary
#' information recorded as an attribute on the returned object. No
#' biological, statistical, or domain-specific assumption is made. The
#' input `dataset` is never modified in place; the QC information is
#' attached to a new object that is returned.
#'
#' @param dataset The dataset to inspect (e.g. `data.frame`, `matrix`,
#'   or, if available, `SummarizedExperiment`).
#' @param ... Currently unused; present for interface consistency with
#'   the `process(dataset, ...)` stage interface.
#'
#' @return The dataset, structurally unchanged, with a `"qc_info"`
#'   attribute attached (a list with `dim` and, where supported,
#'   `n_missing`).
#'
#' @export
generic_qc_stage <- function(dataset, ...) {

  d <- .generic_dataset_dim(dataset)

  if (is.null(d)) {
    stop("generic_qc_stage(): could not determine the dimensions of ",
         "'dataset'. Supported types are data.frame, matrix, and ",
         "(if available) SummarizedExperiment.", call. = FALSE)
  }

  if (any(d == 0)) {
    stop("generic_qc_stage(): 'dataset' has a zero dimension (", d[1],
         " x ", d[2], ").", call. = FALSE)
  }

  n_missing <- tryCatch(sum(is.na(dataset)), error = function(e) NA_integer_)

  result <- dataset
  attr(result, "qc_info") <- list(dim = d, n_missing = n_missing)

  result
}

#' Generic Normalization stage
#'
#' A generic, reusable Normalization processing stage. Supports two
#' domain-agnostic modes: `"identity"` (the default; returns the
#' dataset unchanged) and `"scale"` (applies generic centering/scaling
#' via base R [scale()] to numeric matrix-like data). No statistical
#' modelling, feature selection, or biological assumption is performed.
#' The input `dataset` is never modified in place.
#'
#' @param dataset The dataset to normalize (e.g. `data.frame` or
#'   `matrix` of numeric values).
#' @param method Character scalar, one of `"identity"` (default) or
#'   `"scale"`.
#' @param ... Currently unused; present for interface consistency with
#'   the `process(dataset, ...)` stage interface.
#'
#' @return The normalized dataset. For `method = "identity"`, this is
#'   the original dataset (returned as-is, not mutated). For
#'   `method = "scale"`, a new, centered-and-scaled `matrix` (via
#'   [scale()]).
#'
#' @export
generic_normalization_stage <- function(dataset, method = c("identity", "scale"), ...) {

  method <- match.arg(method)

  if (identical(method, "identity")) {
    return(dataset)
  }

  numeric_matrix <- tryCatch(as.matrix(dataset), error = function(e) NULL)

  if (is.null(numeric_matrix) || !is.numeric(numeric_matrix)) {
    stop("generic_normalization_stage(): method = 'scale' requires a ",
         "dataset that can be coerced to a numeric matrix.", call. = FALSE)
  }

  scale(numeric_matrix)
}

#' Generic Filtering stage
#'
#' A generic, reusable Filtering processing stage. Performs only
#' generic row/column subsetting based on explicitly supplied indices
#' or a logical/integer selection -- no statistical or biological
#' criterion is applied internally. When neither `keep_rows` nor
#' `keep_cols` is supplied, the dataset is returned unchanged (identity
#' filtering). The input `dataset` is never modified in place.
#'
#' @param dataset The dataset to filter (e.g. `data.frame` or
#'   `matrix`).
#' @param keep_rows Optional logical or integer vector selecting which
#'   rows to keep. Defaults to `NULL` (keep all rows).
#' @param keep_cols Optional logical or integer vector selecting which
#'   columns to keep. Defaults to `NULL` (keep all columns).
#' @param ... Currently unused; present for interface consistency with
#'   the `process(dataset, ...)` stage interface.
#'
#' @return A new, filtered dataset of the same class as `dataset`.
#'
#' @export
generic_filtering_stage <- function(dataset, keep_rows = NULL, keep_cols = NULL, ...) {

  if (is.null(keep_rows) && is.null(keep_cols)) {
    return(dataset)
  }

  row_index <- if (is.null(keep_rows)) seq_len(nrow(dataset)) else keep_rows
  col_index <- if (is.null(keep_cols)) seq_len(ncol(dataset)) else keep_cols

  dataset[row_index, col_index, drop = FALSE]
}
