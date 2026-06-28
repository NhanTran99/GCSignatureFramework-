# model_construction.R
#
# Model Construction Layer (Module 06)
#
# Implements the Modeling domain's construction foundation: Model
# Specification (generic algorithm_id + parameter_schema), Model
# Contract (an implementation-only object preserving Specification
# lineage, Discovery artifact lineage, and Framework metadata -- NOT a
# new Framework Contract type), and Model Object (a self-contained,
# read-only S3 object embedding its Specification and referencing its
# Contract). Contains no model training, validation, benchmarking, or
# statistical/biological computation, per IDS-003_Modeling_Implementation.md
# and the Module 06 Coding Prompt.
#
# Per AD-03/AD-04: model_specification and model_contract are
# implementation-only objects (not Framework artifacts, not IDS
# artifacts, not cross-domain interface objects, and not a new
# Framework Contract type) -- consistent with the precedent set by
# Module 05's VerificationReport.
#
# Per "Discovery Consumption": Module 06 consumes only the verified
# Discovery contractual artifacts already produced/exported by Module
# 05 (via DiscoveryOutputVerifier()/DiscoveryOutputExporter()), and
# preserves their contractual identity, lineage, and integrity
# unchanged -- it never reinterprets, modifies, or generates new
# Discovery artifacts.
#
# Public API is kept to exactly the 4 functions required by the
# Coding Prompt: create_model_specification(), validate_model_specification(),
# create_model_contract(), create_model_object(). The Model Object
# predicate and validator remain internal; print.model_object() is
# exported only as the S3 method required for print() to dispatch
# correctly (not a boundary-level operation), mirroring Module 05's
# print.verification_report() precedent.

# ---- Model Specification ---------------------------------------------------

#' Create a Model Specification
#'
#' Constructs a generic Model Specification: an implementation-only
#' object (not a Framework artifact, IDS artifact, or cross-domain
#' interface object) describing only an algorithm identifier and a
#' generic parameter schema. No statistical method, machine learning
#' algorithm, biological assumption, or project-specific knowledge may
#' be encoded here.
#'
#' @param algorithm_id Character scalar. A generic identifier for the
#'   algorithm this specification describes (e.g. `"placeholder"`).
#'   This module attaches no meaning to specific values; it is an
#'   opaque, caller-supplied label.
#' @param parameter_schema List describing the generic parameter
#'   schema (e.g. parameter names and types). Defaults to an empty
#'   list. Contains no algorithm-specific weights or fitted values.
#' @param metadata List of additional generic metadata. Defaults to an
#'   empty list.
#'
#' @return An object of class `"model_specification"`.
#'
#' @export
create_model_specification <- function(algorithm_id,
                                        parameter_schema = list(),
                                        metadata = list()) {

  specification <- list(
    algorithm_id = algorithm_id,
    parameter_schema = parameter_schema,
    metadata = metadata
  )

  class(specification) <- "model_specification"

  validate_model_specification(specification)

  specification
}

#' Validate a Model Specification
#'
#' Verifies required fields, object completeness, and structural
#' consistency of a Model Specification. Performs no scientific,
#' statistical, algorithmic, or biological validation.
#'
#' @param x Object to validate.
#'
#' @return Invisibly `TRUE` if `x` is a structurally valid Model
#'   Specification; otherwise raises an error via `stop()`.
#'
#' @export
validate_model_specification <- function(x) {

  if (!.is_model_specification(x)) {
    stop("'x' must be a model_specification object.", call. = FALSE)
  }

  required_fields <- c("algorithm_id", "parameter_schema", "metadata")
  missing_fields <- setdiff(required_fields, names(x))
  if (length(missing_fields) > 0) {
    stop("Model Specification is missing required field(s): ",
         paste(missing_fields, collapse = ", "), call. = FALSE)
  }

  if (!is.character(x$algorithm_id) || length(x$algorithm_id) != 1 ||
      !nzchar(x$algorithm_id)) {
    stop("Model Specification field 'algorithm_id' must be a single ",
         "non-empty character string.", call. = FALSE)
  }

  if (!is.list(x$parameter_schema)) {
    stop("Model Specification field 'parameter_schema' must be a list.",
         call. = FALSE)
  }

  if (!is.list(x$metadata)) {
    stop("Model Specification field 'metadata' must be a list.", call. = FALSE)
  }

  invisible(TRUE)
}

#' @keywords internal
#' @noRd
.is_model_specification <- function(x) {
  inherits(x, "model_specification")
}

# ---- Model Contract (implementation-only; not a Framework Contract type) --

#' Create a Model Contract
#'
#' Constructs a Model Contract: an internal, implementation-only
#' object (NOT a new Framework Contract type, and not a modification
#' of the canonical Framework Contract hierarchy established in Module
#' 02) that preserves Model Specification lineage, Discovery artifact
#' lineage, and Framework metadata. Model Contract remains internal to
#' the Modeling implementation and is never exported across any
#' domain boundary.
#'
#' The supplied Discovery artifact(s) are consumed read-only: they are
#' verified to be `artifact_contract` objects (per Module 02) and are
#' otherwise preserved completely unchanged -- this function never
#' reinterprets, modifies, or generates a Discovery artifact.
#'
#' @param specification A `model_specification` object, as returned by
#'   [create_model_specification()].
#' @param discovery_artifacts A single `artifact_contract` object, or
#'   a list of such objects, as verified and exported by Module 05
#'   (e.g. via `DiscoveryOutputExporter()`).
#' @param metadata List of additional Framework metadata to record on
#'   the contract. Defaults to an empty list.
#'
#' @return An object of class `"model_contract"`, with fields
#'   `specification` (the supplied Model Specification, unchanged),
#'   `discovery_artifacts` (the supplied Discovery artifact(s),
#'   unchanged, always as a list), and `metadata`.
#'
#' @export
create_model_contract <- function(specification,
                                   discovery_artifacts,
                                   metadata = list()) {

  validate_model_specification(specification)

  if (is_artifact_contract(discovery_artifacts)) {
    discovery_artifacts <- list(discovery_artifacts)
  }

  if (!is.list(discovery_artifacts) || length(discovery_artifacts) == 0) {
    stop("'discovery_artifacts' must be a single artifact_contract object ",
         "or a non-empty list of artifact_contract objects.", call. = FALSE)
  }

  not_artifacts <- which(!vapply(discovery_artifacts, is_artifact_contract, logical(1)))
  if (length(not_artifacts) > 0) {
    stop("'discovery_artifacts' contains element(s) that are not ",
         "artifact_contract objects, at position(s): ",
         paste(not_artifacts, collapse = ", "), call. = FALSE)
  }

  if (!is.list(metadata)) {
    stop("'metadata' must be a list.", call. = FALSE)
  }

  contract <- list(
    specification = specification,
    discovery_artifacts = discovery_artifacts,
    metadata = metadata
  )

  class(contract) <- "model_contract"

  contract
}

# ---- Model Object (self-contained, read-only S3 object) -------------------

#' Create a Model Object
#'
#' Constructs a Model Object: a self-contained, read-only S3 object
#' that embeds the complete Model Specification and references its
#' Model Contract. Model Object is immutable after construction -- no
#' function in this module mutates an existing Model Object; producing
#' a trained model is the responsibility of Module 07 and SHALL
#' produce a new, distinct downstream object.
#'
#' The supplied `contract` must have been constructed from exactly the
#' supplied `specification` (verified via `identical()`); this
#' prevents assembling a Model Object from a mismatched
#' specification/contract pair.
#'
#' @param specification A `model_specification` object. Must be
#'   identical to `contract$specification`.
#' @param contract A `model_contract` object, as returned by
#'   [create_model_contract()].
#' @param metadata List of additional generic metadata. Defaults to an
#'   empty list.
#'
#' @return An object of class `"model_object"`, with fields
#'   `specification`, `contract`, and `metadata`.
#'
#' @export
create_model_object <- function(specification, contract, metadata = list()) {

  validate_model_specification(specification)

  if (!inherits(contract, "model_contract")) {
    stop("'contract' must be a model_contract object.", call. = FALSE)
  }

  if (!identical(specification, contract$specification)) {
    stop("'specification' does not match the specification embedded in ",
         "'contract'. A Model Object must be constructed from the exact ",
         "specification that its contract was built from.", call. = FALSE)
  }

  if (!is.list(metadata)) {
    stop("'metadata' must be a list.", call. = FALSE)
  }

  model_object <- list(
    specification = specification,
    contract = contract,
    metadata = metadata
  )

  class(model_object) <- "model_object"

  model_object
}

#' @keywords internal
#' @noRd
.is_model_object <- function(x) {
  inherits(x, "model_object")
}

#' @keywords internal
#' @noRd
.validate_model_object <- function(x) {

  if (!.is_model_object(x)) {
    stop("'x' must be a model_object object.", call. = FALSE)
  }

  required_fields <- c("specification", "contract", "metadata")
  missing_fields <- setdiff(required_fields, names(x))
  if (length(missing_fields) > 0) {
    stop("Model Object is missing required field(s): ",
         paste(missing_fields, collapse = ", "), call. = FALSE)
  }

  validate_model_specification(x$specification)

  if (!inherits(x$contract, "model_contract")) {
    stop("Model Object field 'contract' must be a model_contract object.",
         call. = FALSE)
  }

  if (!identical(x$specification, x$contract$specification)) {
    stop("Model Object's 'specification' does not match its 'contract' ",
         "embedded specification.", call. = FALSE)
  }

  invisible(TRUE)
}

#' Print a Model Object
#'
#' Exported only as the S3 method required for `print()` to dispatch
#' correctly on a `model_object` (not a boundary-level public
#' operation), consistent with the precedent set by Module 05's
#' `print.verification_report()`.
#'
#' @param x A `model_object` object.
#' @param ... Additional arguments (currently unused).
#'
#' @return `x`, invisibly.
#'
#' @export
print.model_object <- function(x, ...) {
  cat("<model_object>\n")
  cat("  algorithm_id:          ", x$specification$algorithm_id, "\n", sep = "")
  cat("  parameter_schema:      ", length(x$specification$parameter_schema), " item(s)\n", sep = "")
  cat("  discovery_artifacts:   ", length(x$contract$discovery_artifacts), " artifact(s)\n", sep = "")
  cat("  metadata:              ", length(x$metadata), " item(s)\n", sep = "")
  invisible(x)
}
