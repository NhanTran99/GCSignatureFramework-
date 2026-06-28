# validation.R
#
# Validation (Module 09, IDS-004)
#
# Implements the Validation responsibility of IDS-004: read-only
# consumption of Modeling artifacts (Model Candidate, Modeling
# Evidence, Module 08), a Validation Object (implementation-only,
# never a Framework artifact) capturing consumed artifacts + execution
# state, and Validation Evidence (the sole Framework artifact produced
# by this module). Contains no Benchmark, Candidate Selection,
# statistical, or biological methodology -- those responsibilities
# belong to downstream IDS-004 modules (Module 10/11).
#
# Per the Coding Prompt's Consistency Check:
#
#   1. Validation Evidence uses metadata$framework_layer =
#      "validation_benchmark" and metadata$artifact_role =
#      "validation_evidence" -- extending, not violating, the
#      established "context belongs in metadata" convention.
#
#   2. print.validation_object()/print.validation_evidence() are added
#      as S3-dispatch-only exceptions, mirroring every implementation
#      object/Framework artifact introduced since Module 05.
#
#   3. run_validation() mirrors Module 04's execute_discovery_pipeline():
#      it returns both an updated Validation Object and the resulting
#      Validation Evidence.
#
# Per the Generic Implementation Principle: the default validator
# performs only structural execution -- no statistical validation,
# benchmark methodology, biological interpretation, candidate ranking,
# or model selection. Real validation methodology remains injectable
# via the `validator` callback (mirroring Module 07's `trainer`
# pattern).

# ---- Validation Object (implementation-only) --------------------------------

#' Create a Validation Object
#'
#' Constructs a Validation Object: an implementation-only object (never
#' exposed as a Framework artifact) that encapsulates the consumed
#' Modeling artifacts (Model Candidate, Modeling Evidence, Module 08),
#' execution metadata, validator output (`validation_components`), and
#' implementation state. Both Modeling artifacts are consumed
#' completely read-only and are never modified by this function or by
#' [run_validation()].
#'
#' @param model_candidate A `model_candidate` object (Module 08).
#' @param modeling_evidence A `modeling_evidence` object (Module 08).
#' @param metadata List of additional implementation metadata.
#'   Defaults to an empty list.
#'
#' @return An object of class `"validation_object"`, with fields
#'   `model_candidate`, `modeling_evidence`, `validation_components`
#'   (initially an empty list), `execution_metadata` (initially an
#'   empty list), and `metadata`.
#'
#' @export
create_validation_object <- function(model_candidate, modeling_evidence, metadata = list()) {

  if (!inherits(model_candidate, "model_candidate")) {
    stop("'model_candidate' must be a model_candidate object (Module 08).", call. = FALSE)
  }
  validate_model_candidate(model_candidate)

  if (!inherits(modeling_evidence, "modeling_evidence")) {
    stop("'modeling_evidence' must be a modeling_evidence object (Module 08).", call. = FALSE)
  }
  .validate_modeling_evidence(modeling_evidence)

  if (!is.list(metadata)) {
    stop("'metadata' must be a list.", call. = FALSE)
  }

  validation_object <- list(
    model_candidate = model_candidate,
    modeling_evidence = modeling_evidence,
    validation_components = list(),
    execution_metadata = list(),
    metadata = metadata
  )

  class(validation_object) <- "validation_object"

  validation_object
}

#' Validate a Validation Object
#'
#' Verifies required fields, object completeness, and structural
#' consistency of a Validation Object, including delegated structural
#' validity of its embedded Model Candidate (via the LOCKED Module 08
#' `validate_model_candidate()`) and Modeling Evidence (via Module 08's
#' internal evidence validator). Performs no scientific, statistical,
#' or biological validation.
#'
#' @param x Object to validate.
#'
#' @return Invisibly `TRUE` if `x` is a structurally valid Validation
#'   Object; otherwise raises an error via `stop()`.
#'
#' @export
validate_validation_object <- function(x) {

  if (!.is_validation_object(x)) {
    stop("'x' must be a validation_object object.", call. = FALSE)
  }

  required_fields <- c("model_candidate", "modeling_evidence", "validation_components",
                        "execution_metadata", "metadata")
  missing_fields <- setdiff(required_fields, names(x))
  if (length(missing_fields) > 0) {
    stop("Validation Object is missing required field(s): ",
         paste(missing_fields, collapse = ", "), call. = FALSE)
  }

  validate_model_candidate(x$model_candidate)
  .validate_modeling_evidence(x$modeling_evidence)

  if (!is.list(x$validation_components)) {
    stop("Validation Object field 'validation_components' must be a list.", call. = FALSE)
  }
  if (!is.list(x$execution_metadata)) {
    stop("Validation Object field 'execution_metadata' must be a list.", call. = FALSE)
  }
  if (!is.list(x$metadata)) {
    stop("Validation Object field 'metadata' must be a list.", call. = FALSE)
  }

  invisible(TRUE)
}

#' @keywords internal
#' @noRd
.is_validation_object <- function(x) {
  inherits(x, "validation_object")
}

#' Print a Validation Object
#'
#' Exported only as the S3 method required for `print()` to dispatch
#' correctly on a `validation_object` (not a boundary-level public
#' operation), per Consistency Check Clarification 2 -- mirroring the
#' precedent set by `print.model_object()`, `print.training_object()`,
#' etc.
#'
#' @param x A `validation_object` object.
#' @param ... Additional arguments (currently unused).
#'
#' @return `x`, invisibly.
#'
#' @export
print.validation_object <- function(x, ...) {
  cat("<validation_object>\n")
  cat("  model_candidate:        embedded (producer: ", x$model_candidate$producer, ")\n", sep = "")
  cat("  modeling_evidence:      embedded (producer: ", x$modeling_evidence$producer, ")\n", sep = "")
  cat("  validation_components:  ", length(x$validation_components), " component(s)\n", sep = "")
  cat("  execution_metadata:     ", length(x$execution_metadata), " item(s)\n", sep = "")
  invisible(x)
}

# ---- Default generic validator (no real methodology) -----------------------

#' @keywords internal
#' @noRd
.default_generic_validator <- function(validation_object, ...) {
  list(
    structural_check = list(
      passed = TRUE,
      details = "generic structural check only; no statistical/biological methodology"
    )
  )
}

# ---- Validation Workflow / Executor -----------------------------------------

#' Run Validation (Workflow + Executor)
#'
#' Orchestrates the Validation workflow for an initial Validation
#' Object: invokes a validator (the default generic validator, or a
#' caller-supplied one) to produce one or more named
#' `validation_components`, returns an updated Validation Object
#' carrying those components, and constructs the resulting Validation
#' Evidence -- mirroring Module 04's `execute_discovery_pipeline()`.
#'
#' The validator replaces only the execution step; it never bypasses
#' workflow, verification, lineage, or artifact construction performed
#' by this function. The default validator performs only a generic,
#' structural check -- no statistical validation, benchmark
#' methodology, biological interpretation, candidate ranking, or model
#' selection is performed by this function or its default validator.
#'
#' @param validation_object A `validation_object`, as returned by
#'   [create_validation_object()].
#' @param validator A function taking `(validation_object, ...)` and
#'   returning a named list of validation components. Defaults to an
#'   internal generic, structural placeholder validator.
#' @param ... Additional arguments forwarded to `validator`.
#'
#' @return A list with elements `validation_object` (the updated
#'   Validation Object, with `validation_components` populated) and
#'   `validation_evidence` (the resulting Framework artifact).
#'
#' @export
run_validation <- function(validation_object, validator = NULL, ...) {

  validate_validation_object(validation_object)

  if (is.null(validator)) {
    validator <- .default_generic_validator
  }
  if (!is.function(validator)) {
    stop("'validator' must be a function.", call. = FALSE)
  }

  components <- validator(validation_object, ...)

  if (!is.list(components)) {
    stop("'validator' must return a list of named validation components.", call. = FALSE)
  }

  updated <- validation_object
  updated$validation_components <- components
  updated$execution_metadata <- c(updated$execution_metadata, list(executed = TRUE))

  validate_validation_object(updated)

  evidence <- create_validation_evidence(updated)

  list(
    validation_object = updated,
    validation_evidence = evidence
  )
}

# ---- Validation Evidence (the sole Framework artifact) ----------------------

#' Create Validation Evidence
#'
#' Constructs Validation Evidence: the sole Framework artifact produced
#' by Module 09 (via the LOCKED Module 02 `create_artifact_contract()`),
#' structurally independent from the supplied Validation Object while
#' preserving complete lineage by embedding it unchanged. Validation
#' Evidence never contains Benchmark Evidence, Candidate Selection, or
#' Validated Candidate information.
#'
#' @param validation_object A `validation_object`, typically the
#'   updated object produced by [run_validation()].
#' @param producer Character scalar identifying the producer. Defaults
#'   to the embedded Model Candidate's `producer`.
#' @param consumer Character scalar identifying the intended downstream
#'   consumer. Defaults to `"benchmark"` (Module 10, IDS-004).
#' @param metadata Additional list of metadata merged into the
#'   artifact's `metadata` field. Defaults to an empty list. Must not
#'   contain `framework_layer`, `artifact_role`, or `validation_object`
#'   (set internally), nor `benchmark_evidence`, `candidate_selection`,
#'   or `validated_candidate` (explicitly forbidden content).
#'
#' @return An object of class `c("validation_evidence", "artifact_contract", "contract")`.
#'
#' @export
create_validation_evidence <- function(validation_object,
                                        producer = NULL,
                                        consumer = "benchmark",
                                        metadata = list()) {

  validate_validation_object(validation_object)

  if (!is.list(metadata)) {
    stop("'metadata' must be a list.", call. = FALSE)
  }

  reserved <- intersect(names(metadata), c("framework_layer", "artifact_role", "validation_object"))
  if (length(reserved) > 0) {
    stop("'metadata' must not contain reserved key(s): ",
         paste(reserved, collapse = ", "), call. = FALSE)
  }

  forbidden <- intersect(names(metadata), c("benchmark_evidence", "candidate_selection", "validated_candidate"))
  if (length(forbidden) > 0) {
    stop("Validation Evidence SHALL NOT contain: ",
         paste(forbidden, collapse = ", "), call. = FALSE)
  }

  if (is.null(producer)) {
    producer <- validation_object$model_candidate$producer
  }

  full_metadata <- c(
    list(
      framework_layer = "validation_benchmark",
      artifact_role = "validation_evidence",
      validation_object = validation_object
    ),
    metadata
  )

  evidence <- create_artifact_contract(
    producer = producer,
    consumer = consumer,
    inputs = list("model_candidate", "modeling_evidence"),
    outputs = list("validation_evidence"),
    dependencies = list(),
    metadata = full_metadata
  )

  class(evidence) <- c("validation_evidence", class(evidence))

  evidence
}

#' Validate Validation Evidence
#'
#' Verifies required fields, contract validity (via the LOCKED Module
#' 02 `validate_artifact_contract()`), and lineage integrity of
#' Validation Evidence. Confirms the forbidden-content guarantee
#' (no Benchmark Evidence, Candidate Selection, or Validated Candidate
#' information). Performs no scientific, statistical, or biological
#' validation.
#'
#' @param x Object to validate.
#'
#' @return Invisibly `TRUE` if `x` is structurally valid; otherwise
#'   raises an error via `stop()`.
#'
#' @export
validate_validation_evidence <- function(x) {

  if (!inherits(x, "validation_evidence")) {
    stop("'x' must be a validation_evidence object.", call. = FALSE)
  }

  if (!is_artifact_contract(x)) {
    stop("'x' must be an artifact_contract object (Module 02).", call. = FALSE)
  }

  validate_artifact_contract(x)

  if (!identical(x$contract_type, "artifact")) {
    stop("Validation Evidence field 'contract_type' must equal 'artifact'. ",
         "Received: '", x$contract_type, "'.", call. = FALSE)
  }

  if (!identical(x$metadata$artifact_role, "validation_evidence")) {
    stop("Validation Evidence must have metadata$artifact_role == 'validation_evidence'.",
         call. = FALSE)
  }

  if (is.null(x$metadata$validation_object)) {
    stop("Validation Evidence is missing its embedded validation_object (lineage integrity).",
         call. = FALSE)
  }
  validate_validation_object(x$metadata$validation_object)

  forbidden_present <- intersect(names(x$metadata),
                                  c("benchmark_evidence", "candidate_selection", "validated_candidate"))
  if (length(forbidden_present) > 0) {
    stop("Validation Evidence must not contain: ",
         paste(forbidden_present, collapse = ", "), call. = FALSE)
  }

  invisible(TRUE)
}

#' Print Validation Evidence
#'
#' Exported only as the S3 method required for `print()` to dispatch
#' correctly on a `validation_evidence` object, per Consistency Check
#' Clarification 2.
#'
#' @param x A `validation_evidence` object.
#' @param ... Additional arguments (currently unused).
#'
#' @return `x`, invisibly.
#'
#' @export
print.validation_evidence <- function(x, ...) {
  cat("<validation_evidence>\n")
  cat("  producer:               ", x$producer, "\n", sep = "")
  cat("  consumer:               ", x$consumer, "\n", sep = "")
  components <- x$metadata$validation_object$validation_components
  cat("  validation_components:  ",
      if (length(components) > 0) paste(names(components), collapse = ", ") else "(none yet)",
      "\n", sep = "")
  cat("  validation_object:      embedded (lineage preserved)\n", sep = "")
  invisible(x)
}
