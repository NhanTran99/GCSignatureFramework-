# evidence_integration.R
#
# Evidence Integration (Module 13, IDS-005)
#
# Implements the Evidence Integration responsibility of IDS-005:
# read-only consumption of Interpretation Evidence (Module 12), an
# Evidence Integration Object (implementation-only, never a Framework
# artifact) capturing the consumed evidence + execution state, and
# Interpretation Package (the sole, final Framework artifact produced
# by IDS-005). Contains no evidence synthesis, biological/clinical
# integration, publication formatting, or scientific conclusions --
# those responsibilities are explicitly outside Module 13 and IDS-005
# entirely.
#
# Per the Coding Prompt's Consistency Check: Interpretation Package
# uses metadata$framework_layer = "interpretability" (same layer as
# Module 12's Interpretation Evidence) and metadata$artifact_role =
# "interpretation_package". Default consumer is "clinical_translation"
# (Phase F, IDS-006, Modules 14-15).
#
# Per the Generic Implementation Principle: the default integrator
# performs only structural execution -- no evidence synthesis,
# biological/clinical integration, publication formatting, or
# scientific conclusions. Real methodology remains injectable via the
# `integrator` callback (mirroring Module 07's `trainer`, Module 09's
# `validator`, Module 10's `benchmarker`, Module 11's `selector`, and
# Module 12's `interpreter`).

# ---- Evidence Integration Object (implementation-only) ----------------------

#' Create an Evidence Integration Object
#'
#' Constructs an Evidence Integration Object: an implementation-only
#' object (never exposed as a Framework artifact) that encapsulates
#' the consumed Interpretation Evidence (Module 12), integration
#' components, execution metadata, and implementation state.
#' Interpretation Evidence is consumed completely read-only and is
#' never modified by this function or by [run_evidence_integration()].
#'
#' Only an `interpretation_evidence` object is accepted as the
#' upstream contract; this module never directly consumes Validated
#' Candidate, Benchmark Evidence, or Validation Evidence -- those
#' remain available, if needed, only through the lineage already
#' preserved within the Interpretation Evidence.
#'
#' @param interpretation_evidence An `interpretation_evidence` object
#'   (Module 12).
#' @param metadata List of additional implementation metadata.
#'   Defaults to an empty list.
#'
#' @return An object of class `"evidence_integration_object"`, with
#'   fields `interpretation_evidence`, `integration_components`
#'   (initially an empty list), `execution_metadata` (initially an
#'   empty list), and `metadata`.
#'
#' @export
create_evidence_integration_object <- function(interpretation_evidence, metadata = list()) {

  if (!inherits(interpretation_evidence, "interpretation_evidence")) {
    stop("'interpretation_evidence' must be an interpretation_evidence object (Module 12).",
         call. = FALSE)
  }
  validate_interpretation_evidence(interpretation_evidence)

  if (!is.list(metadata)) {
    stop("'metadata' must be a list.", call. = FALSE)
  }

  evidence_integration_object <- list(
    interpretation_evidence = interpretation_evidence,
    integration_components = list(),
    execution_metadata = list(),
    metadata = metadata
  )

  class(evidence_integration_object) <- "evidence_integration_object"

  evidence_integration_object
}

#' Validate an Evidence Integration Object
#'
#' Verifies required fields, object completeness, and structural
#' consistency of an Evidence Integration Object, including delegated
#' structural validity of its embedded Interpretation Evidence (via
#' the LOCKED Module 12 `validate_interpretation_evidence()`). Performs
#' no scientific, statistical, or biological validation.
#'
#' @param x Object to validate.
#'
#' @return Invisibly `TRUE` if `x` is a structurally valid Evidence
#'   Integration Object; otherwise raises an error via `stop()`.
#'
#' @export
validate_evidence_integration_object <- function(x) {

  if (!.is_evidence_integration_object(x)) {
    stop("'x' must be an evidence_integration_object object.", call. = FALSE)
  }

  required_fields <- c("interpretation_evidence", "integration_components",
                        "execution_metadata", "metadata")
  missing_fields <- setdiff(required_fields, names(x))
  if (length(missing_fields) > 0) {
    stop("Evidence Integration Object is missing required field(s): ",
         paste(missing_fields, collapse = ", "), call. = FALSE)
  }

  validate_interpretation_evidence(x$interpretation_evidence)

  if (!is.list(x$integration_components)) {
    stop("Evidence Integration Object field 'integration_components' must be a list.", call. = FALSE)
  }
  if (!is.list(x$execution_metadata)) {
    stop("Evidence Integration Object field 'execution_metadata' must be a list.", call. = FALSE)
  }
  if (!is.list(x$metadata)) {
    stop("Evidence Integration Object field 'metadata' must be a list.", call. = FALSE)
  }

  invisible(TRUE)
}

#' @keywords internal
#' @noRd
.is_evidence_integration_object <- function(x) {
  inherits(x, "evidence_integration_object")
}

#' Print an Evidence Integration Object
#'
#' @param x An `evidence_integration_object` object.
#' @param ... Additional arguments (currently unused).
#'
#' @return `x`, invisibly.
#'
#' @export
print.evidence_integration_object <- function(x, ...) {
  cat("<evidence_integration_object>\n")
  cat("  interpretation_evidence:  embedded (producer: ", x$interpretation_evidence$producer, ")\n", sep = "")
  cat("  integration_components:   ", length(x$integration_components), " component(s)\n", sep = "")
  cat("  execution_metadata:       ", length(x$execution_metadata), " item(s)\n", sep = "")
  invisible(x)
}

# ---- Default generic integrator (no real methodology) ----------------------

#' @keywords internal
#' @noRd
.default_generic_integrator <- function(evidence_integration_object, ...) {
  list(
    structural_check = list(
      passed = TRUE,
      details = "generic structural check only; no evidence-synthesis/biological/clinical/publication methodology"
    )
  )
}

# ---- Evidence Integration Workflow / Executor -------------------------------

#' Run Evidence Integration (Workflow + Executor)
#'
#' Orchestrates the Evidence Integration workflow for an initial
#' Evidence Integration Object: invokes an integrator (the default
#' generic integrator, or a caller-supplied one) to produce one or more
#' named `integration_components`, returns an updated Evidence
#' Integration Object carrying those components, and constructs the
#' resulting Interpretation Package -- mirroring Module 09's
#' `run_validation()`, Module 10's `run_benchmark()`, Module 11's
#' `run_candidate_selection()`, and Module 12's `run_interpretation()`.
#'
#' The integrator replaces only the execution step; it never bypasses
#' workflow, verification, lineage, or artifact construction performed
#' by this function. The default integrator performs only a generic,
#' structural check -- no evidence synthesis, biological/clinical
#' integration, publication formatting, or scientific conclusions is
#' performed by this function or its default integrator.
#'
#' @param evidence_integration_object An `evidence_integration_object`,
#'   as returned by [create_evidence_integration_object()].
#' @param integrator A function taking `(evidence_integration_object, ...)`
#'   and returning a named list of integration components. Defaults to
#'   an internal generic, structural placeholder integrator.
#' @param ... Additional arguments forwarded to `integrator`.
#'
#' @return A list with elements `evidence_integration_object` (the
#'   updated object, with `integration_components` populated) and
#'   `interpretation_package` (the resulting, final Framework artifact
#'   of IDS-005).
#'
#' @export
run_evidence_integration <- function(evidence_integration_object, integrator = NULL, ...) {

  validate_evidence_integration_object(evidence_integration_object)

  if (is.null(integrator)) {
    integrator <- .default_generic_integrator
  }
  if (!is.function(integrator)) {
    stop("'integrator' must be a function.", call. = FALSE)
  }

  components <- integrator(evidence_integration_object, ...)

  if (!is.list(components)) {
    stop("'integrator' must return a list of named integration components.", call. = FALSE)
  }

  updated <- evidence_integration_object
  updated$integration_components <- components
  updated$execution_metadata <- c(updated$execution_metadata, list(executed = TRUE))

  validate_evidence_integration_object(updated)

  package <- create_interpretation_package(updated)

  list(
    evidence_integration_object = updated,
    interpretation_package = package
  )
}

# ---- Interpretation Package (the sole, final Framework artifact of IDS-005) -

#' Create an Interpretation Package
#'
#' Constructs Interpretation Package: the sole Framework artifact
#' produced by Module 13 (via the LOCKED Module 02
#' `create_artifact_contract()`), and the final Framework artifact
#' produced by IDS-005. Structurally independent from the supplied
#' Evidence Integration Object while preserving complete lineage by
#' embedding it unchanged. Interpretation Package never contains
#' biological reasoning, clinical interpretation, therapeutic
#' recommendation, publication-ready discussion, or scientific
#' conclusions.
#'
#' @param evidence_integration_object An `evidence_integration_object`,
#'   typically the updated object produced by [run_evidence_integration()].
#' @param producer Character scalar identifying the producer. Defaults
#'   to the embedded Interpretation Evidence's `producer`.
#' @param consumer Character scalar identifying the intended downstream
#'   consumer. Defaults to `"clinical_translation"` (Phase F, IDS-006,
#'   Modules 14-15).
#' @param metadata Additional list of metadata merged into the
#'   artifact's `metadata` field. Defaults to an empty list. Must not
#'   contain `framework_layer`, `artifact_role`, or
#'   `evidence_integration_object` (set internally), nor
#'   `biological_reasoning`, `clinical_interpretation`,
#'   `therapeutic_recommendation`, `publication_ready_discussion`, or
#'   `scientific_conclusions` (explicitly forbidden content).
#'
#' @return An object of class `c("interpretation_package", "artifact_contract", "contract")`.
#'
#' @export
create_interpretation_package <- function(evidence_integration_object,
                                           producer = NULL,
                                           consumer = "clinical_translation",
                                           metadata = list()) {

  validate_evidence_integration_object(evidence_integration_object)

  if (!is.list(metadata)) {
    stop("'metadata' must be a list.", call. = FALSE)
  }

  reserved <- intersect(names(metadata),
                         c("framework_layer", "artifact_role", "evidence_integration_object"))
  if (length(reserved) > 0) {
    stop("'metadata' must not contain reserved key(s): ",
         paste(reserved, collapse = ", "), call. = FALSE)
  }

  forbidden <- intersect(names(metadata),
                          c("biological_reasoning", "clinical_interpretation",
                            "therapeutic_recommendation", "publication_ready_discussion",
                            "scientific_conclusions"))
  if (length(forbidden) > 0) {
    stop("Interpretation Package SHALL NOT contain: ",
         paste(forbidden, collapse = ", "), call. = FALSE)
  }

  if (is.null(producer)) {
    producer <- evidence_integration_object$interpretation_evidence$producer
  }

  full_metadata <- c(
    list(
      framework_layer = "interpretability",
      artifact_role = "interpretation_package",
      evidence_integration_object = evidence_integration_object
    ),
    metadata
  )

  package <- create_artifact_contract(
    producer = producer,
    consumer = consumer,
    inputs = list("interpretation_evidence"),
    outputs = list("interpretation_package"),
    dependencies = list(),
    metadata = full_metadata
  )

  class(package) <- c("interpretation_package", class(package))

  package
}

#' Validate an Interpretation Package
#'
#' Verifies required fields, contract validity (via the LOCKED Module
#' 02 `validate_artifact_contract()`), and lineage integrity of
#' Interpretation Package. Confirms the forbidden-content guarantee (no
#' biological reasoning, clinical interpretation, therapeutic
#' recommendation, publication-ready discussion, or scientific
#' conclusions). Performs no scientific, statistical, or biological
#' validation.
#'
#' @param x Object to validate.
#'
#' @return Invisibly `TRUE` if `x` is structurally valid; otherwise
#'   raises an error via `stop()`.
#'
#' @export
validate_interpretation_package <- function(x) {

  if (!inherits(x, "interpretation_package")) {
    stop("'x' must be an interpretation_package object.", call. = FALSE)
  }

  if (!is_artifact_contract(x)) {
    stop("'x' must be an artifact_contract object (Module 02).", call. = FALSE)
  }

  validate_artifact_contract(x)

  if (!identical(x$contract_type, "artifact")) {
    stop("Interpretation Package field 'contract_type' must equal 'artifact'. ",
         "Received: '", x$contract_type, "'.", call. = FALSE)
  }

  if (!identical(x$metadata$artifact_role, "interpretation_package")) {
    stop("Interpretation Package must have metadata$artifact_role == 'interpretation_package'.",
         call. = FALSE)
  }

  if (is.null(x$metadata$evidence_integration_object)) {
    stop("Interpretation Package is missing its embedded evidence_integration_object ",
         "(lineage integrity).", call. = FALSE)
  }
  validate_evidence_integration_object(x$metadata$evidence_integration_object)

  forbidden_present <- intersect(names(x$metadata),
                                  c("biological_reasoning", "clinical_interpretation",
                                    "therapeutic_recommendation", "publication_ready_discussion",
                                    "scientific_conclusions"))
  if (length(forbidden_present) > 0) {
    stop("Interpretation Package must not contain: ",
         paste(forbidden_present, collapse = ", "), call. = FALSE)
  }

  invisible(TRUE)
}

#' Print an Interpretation Package
#'
#' @param x An `interpretation_package` object.
#' @param ... Additional arguments (currently unused).
#'
#' @return `x`, invisibly.
#'
#' @export
print.interpretation_package <- function(x, ...) {
  cat("<interpretation_package>\n")
  cat("  producer:                  ", x$producer, "\n", sep = "")
  cat("  consumer:                  ", x$consumer, "\n", sep = "")
  components <- x$metadata$evidence_integration_object$integration_components
  cat("  integration_components:    ",
      if (length(components) > 0) paste(names(components), collapse = ", ") else "(none yet)",
      "\n", sep = "")
  cat("  evidence_integration_object: embedded (lineage preserved)\n", sep = "")
  invisible(x)
}
