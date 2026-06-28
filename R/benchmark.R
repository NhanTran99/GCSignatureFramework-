# benchmark.R
#
# Benchmark (Module 10, IDS-004)
#
# Implements the Benchmark responsibility of IDS-004: read-only
# consumption of Validation Evidence (Module 09), a Benchmark Object
# (implementation-only, never a Framework artifact) capturing the
# consumed evidence + execution state, and Benchmark Evidence (the
# sole Framework artifact produced by this module). Contains no
# Candidate Selection, ROC/AUC, survival, statistical, or ML
# methodology -- those responsibilities belong to downstream IDS-004
# modules (Module 11) or are intentionally deferred.
#
# Per the Coding Prompt's Consistency Check: Benchmark Evidence uses
# metadata$framework_layer = "validation_benchmark" (same layer as
# Validation Evidence) and metadata$artifact_role = "benchmark_evidence"
# (the sibling value anticipated in Module 09's own Consistency Check).
#
# Per the Generic Implementation Principle: the default benchmarker
# performs only structural execution -- no ROC analysis, AUC
# computation, survival comparison, statistical comparison, ranking,
# or machine learning methodology. Real benchmark methodology remains
# injectable via the `benchmarker` callback (mirroring Module 09's
# `validator` / Module 07's `trainer` pattern).

# ---- Benchmark Object (implementation-only) --------------------------------

#' Create a Benchmark Object
#'
#' Constructs a Benchmark Object: an implementation-only object (never
#' exposed as a Framework artifact) that encapsulates the consumed
#' Validation Evidence (Module 09), benchmark components, execution
#' metadata, and implementation state. Validation Evidence is consumed
#' completely read-only and is never modified by this function or by
#' [run_benchmark()].
#'
#' @param validation_evidence A `validation_evidence` object (Module 09).
#' @param metadata List of additional implementation metadata.
#'   Defaults to an empty list.
#'
#' @return An object of class `"benchmark_object"`, with fields
#'   `validation_evidence`, `benchmark_components` (initially an empty
#'   list), `execution_metadata` (initially an empty list), and
#'   `metadata`.
#'
#' @export
create_benchmark_object <- function(validation_evidence, metadata = list()) {

  if (!inherits(validation_evidence, "validation_evidence")) {
    stop("'validation_evidence' must be a validation_evidence object (Module 09).",
         call. = FALSE)
  }
  validate_validation_evidence(validation_evidence)

  if (!is.list(metadata)) {
    stop("'metadata' must be a list.", call. = FALSE)
  }

  benchmark_object <- list(
    validation_evidence = validation_evidence,
    benchmark_components = list(),
    execution_metadata = list(),
    metadata = metadata
  )

  class(benchmark_object) <- "benchmark_object"

  benchmark_object
}

#' Validate a Benchmark Object
#'
#' Verifies required fields, object completeness, and structural
#' consistency of a Benchmark Object, including delegated structural
#' validity of its embedded Validation Evidence (via the LOCKED Module
#' 09 `validate_validation_evidence()`). Performs no scientific,
#' statistical, or benchmark-methodology validation.
#'
#' @param x Object to validate.
#'
#' @return Invisibly `TRUE` if `x` is a structurally valid Benchmark
#'   Object; otherwise raises an error via `stop()`.
#'
#' @export
validate_benchmark_object <- function(x) {

  if (!.is_benchmark_object(x)) {
    stop("'x' must be a benchmark_object object.", call. = FALSE)
  }

  required_fields <- c("validation_evidence", "benchmark_components", "execution_metadata", "metadata")
  missing_fields <- setdiff(required_fields, names(x))
  if (length(missing_fields) > 0) {
    stop("Benchmark Object is missing required field(s): ",
         paste(missing_fields, collapse = ", "), call. = FALSE)
  }

  validate_validation_evidence(x$validation_evidence)

  if (!is.list(x$benchmark_components)) {
    stop("Benchmark Object field 'benchmark_components' must be a list.", call. = FALSE)
  }
  if (!is.list(x$execution_metadata)) {
    stop("Benchmark Object field 'execution_metadata' must be a list.", call. = FALSE)
  }
  if (!is.list(x$metadata)) {
    stop("Benchmark Object field 'metadata' must be a list.", call. = FALSE)
  }

  invisible(TRUE)
}

#' @keywords internal
#' @noRd
.is_benchmark_object <- function(x) {
  inherits(x, "benchmark_object")
}

#' Print a Benchmark Object
#'
#' @param x A `benchmark_object` object.
#' @param ... Additional arguments (currently unused).
#'
#' @return `x`, invisibly.
#'
#' @export
print.benchmark_object <- function(x, ...) {
  cat("<benchmark_object>\n")
  cat("  validation_evidence:   embedded (producer: ", x$validation_evidence$producer, ")\n", sep = "")
  cat("  benchmark_components:  ", length(x$benchmark_components), " component(s)\n", sep = "")
  cat("  execution_metadata:    ", length(x$execution_metadata), " item(s)\n", sep = "")
  invisible(x)
}

# ---- Default generic benchmarker (no real methodology) ---------------------

#' @keywords internal
#' @noRd
.default_generic_benchmarker <- function(benchmark_object, ...) {
  list(
    structural_check = list(
      passed = TRUE,
      details = "generic structural check only; no ROC/AUC/survival/statistical/ML methodology"
    )
  )
}

# ---- Benchmark Workflow / Executor -------------------------------------------

#' Run Benchmark (Workflow + Executor)
#'
#' Orchestrates the Benchmark workflow for an initial Benchmark Object:
#' invokes a benchmarker (the default generic benchmarker, or a
#' caller-supplied one) to produce one or more named
#' `benchmark_components`, returns an updated Benchmark Object carrying
#' those components, and constructs the resulting Benchmark Evidence --
#' mirroring Module 09's `run_validation()`.
#'
#' The benchmarker replaces only the execution step; it never bypasses
#' workflow, verification, lineage, or artifact construction performed
#' by this function. The default benchmarker performs only a generic,
#' structural check -- no ROC analysis, AUC computation, survival
#' comparison, statistical comparison, ranking, or machine learning
#' methodology is performed by this function or its default benchmarker.
#'
#' @param benchmark_object A `benchmark_object`, as returned by
#'   [create_benchmark_object()].
#' @param benchmarker A function taking `(benchmark_object, ...)` and
#'   returning a named list of benchmark components. Defaults to an
#'   internal generic, structural placeholder benchmarker.
#' @param ... Additional arguments forwarded to `benchmarker`.
#'
#' @return A list with elements `benchmark_object` (the updated
#'   Benchmark Object, with `benchmark_components` populated) and
#'   `benchmark_evidence` (the resulting Framework artifact).
#'
#' @export
run_benchmark <- function(benchmark_object, benchmarker = NULL, ...) {

  validate_benchmark_object(benchmark_object)

  if (is.null(benchmarker)) {
    benchmarker <- .default_generic_benchmarker
  }
  if (!is.function(benchmarker)) {
    stop("'benchmarker' must be a function.", call. = FALSE)
  }

  components <- benchmarker(benchmark_object, ...)

  if (!is.list(components)) {
    stop("'benchmarker' must return a list of named benchmark components.", call. = FALSE)
  }

  updated <- benchmark_object
  updated$benchmark_components <- components
  updated$execution_metadata <- c(updated$execution_metadata, list(executed = TRUE))

  validate_benchmark_object(updated)

  evidence <- create_benchmark_evidence(updated)

  list(
    benchmark_object = updated,
    benchmark_evidence = evidence
  )
}

# ---- Benchmark Evidence (the sole Framework artifact) ------------------------

#' Create Benchmark Evidence
#'
#' Constructs Benchmark Evidence: the sole Framework artifact produced
#' by Module 10 (via the LOCKED Module 02 `create_artifact_contract()`),
#' structurally independent from the supplied Benchmark Object while
#' preserving complete lineage by embedding it unchanged. Benchmark
#' Evidence never contains Candidate Selection, Validated Candidate,
#' final recommendation, or model approval information.
#'
#' @param benchmark_object A `benchmark_object`, typically the updated
#'   object produced by [run_benchmark()].
#' @param producer Character scalar identifying the producer. Defaults
#'   to the embedded Validation Evidence's `producer`.
#' @param consumer Character scalar identifying the intended downstream
#'   consumer. Defaults to `"candidate_selection"` (Module 11, IDS-004).
#' @param metadata Additional list of metadata merged into the
#'   artifact's `metadata` field. Defaults to an empty list. Must not
#'   contain `framework_layer`, `artifact_role`, or `benchmark_object`
#'   (set internally), nor `candidate_selection`, `validated_candidate`,
#'   `final_recommendation`, or `model_approval` (explicitly forbidden
#'   content).
#'
#' @return An object of class `c("benchmark_evidence", "artifact_contract", "contract")`.
#'
#' @export
create_benchmark_evidence <- function(benchmark_object,
                                       producer = NULL,
                                       consumer = "candidate_selection",
                                       metadata = list()) {

  validate_benchmark_object(benchmark_object)

  if (!is.list(metadata)) {
    stop("'metadata' must be a list.", call. = FALSE)
  }

  reserved <- intersect(names(metadata), c("framework_layer", "artifact_role", "benchmark_object"))
  if (length(reserved) > 0) {
    stop("'metadata' must not contain reserved key(s): ",
         paste(reserved, collapse = ", "), call. = FALSE)
  }

  forbidden <- intersect(names(metadata),
                          c("candidate_selection", "validated_candidate",
                            "final_recommendation", "model_approval"))
  if (length(forbidden) > 0) {
    stop("Benchmark Evidence SHALL NOT contain: ",
         paste(forbidden, collapse = ", "), call. = FALSE)
  }

  if (is.null(producer)) {
    producer <- benchmark_object$validation_evidence$producer
  }

  full_metadata <- c(
    list(
      framework_layer = "validation_benchmark",
      artifact_role = "benchmark_evidence",
      benchmark_object = benchmark_object
    ),
    metadata
  )

  evidence <- create_artifact_contract(
    producer = producer,
    consumer = consumer,
    inputs = list("validation_evidence"),
    outputs = list("benchmark_evidence"),
    dependencies = list(),
    metadata = full_metadata
  )

  class(evidence) <- c("benchmark_evidence", class(evidence))

  evidence
}

#' Validate Benchmark Evidence
#'
#' Verifies required fields, contract validity (via the LOCKED Module
#' 02 `validate_artifact_contract()`), and lineage integrity of
#' Benchmark Evidence. Confirms the forbidden-content guarantee (no
#' Candidate Selection, Validated Candidate, final recommendation, or
#' model approval information). Performs no scientific, statistical,
#' or benchmark-methodology validation.
#'
#' @param x Object to validate.
#'
#' @return Invisibly `TRUE` if `x` is structurally valid; otherwise
#'   raises an error via `stop()`.
#'
#' @export
validate_benchmark_evidence <- function(x) {

  if (!inherits(x, "benchmark_evidence")) {
    stop("'x' must be a benchmark_evidence object.", call. = FALSE)
  }

  if (!is_artifact_contract(x)) {
    stop("'x' must be an artifact_contract object (Module 02).", call. = FALSE)
  }

  validate_artifact_contract(x)

  if (!identical(x$contract_type, "artifact")) {
    stop("Benchmark Evidence field 'contract_type' must equal 'artifact'. ",
         "Received: '", x$contract_type, "'.", call. = FALSE)
  }

  if (!identical(x$metadata$artifact_role, "benchmark_evidence")) {
    stop("Benchmark Evidence must have metadata$artifact_role == 'benchmark_evidence'.",
         call. = FALSE)
  }

  if (is.null(x$metadata$benchmark_object)) {
    stop("Benchmark Evidence is missing its embedded benchmark_object (lineage integrity).",
         call. = FALSE)
  }
  validate_benchmark_object(x$metadata$benchmark_object)

  forbidden_present <- intersect(names(x$metadata),
                                  c("candidate_selection", "validated_candidate",
                                    "final_recommendation", "model_approval"))
  if (length(forbidden_present) > 0) {
    stop("Benchmark Evidence must not contain: ",
         paste(forbidden_present, collapse = ", "), call. = FALSE)
  }

  invisible(TRUE)
}

#' Print Benchmark Evidence
#'
#' @param x A `benchmark_evidence` object.
#' @param ... Additional arguments (currently unused).
#'
#' @return `x`, invisibly.
#'
#' @export
print.benchmark_evidence <- function(x, ...) {
  cat("<benchmark_evidence>\n")
  cat("  producer:              ", x$producer, "\n", sep = "")
  cat("  consumer:              ", x$consumer, "\n", sep = "")
  components <- x$metadata$benchmark_object$benchmark_components
  cat("  benchmark_components:  ",
      if (length(components) > 0) paste(names(components), collapse = ", ") else "(none yet)",
      "\n", sep = "")
  cat("  benchmark_object:      embedded (lineage preserved)\n", sep = "")
  invisible(x)
}
