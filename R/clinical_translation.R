# clinical_translation.R
#
# Clinical Translation (Module 14, IDS-006)
#
# Implements the Clinical Translation responsibility of IDS-006:
# read-only consumption of Interpretation Package (Module 13), a
# Clinical Translation Object (implementation-only, never a Framework
# artifact) capturing the consumed package + execution state, and
# Clinical Translation Evidence (the sole Framework artifact produced
# by this module). Contains no treatment recommendation, clinical
# guideline reasoning, patient stratification, therapeutic reasoning,
# or clinician-facing outputs -- those responsibilities are explicitly
# outside Module 14, and the final Clinical Translation Package
# belongs to Module 15.
#
# Per the Coding Prompt's Consistency Check: Clinical Translation
# Evidence uses metadata$framework_layer = "clinical_translation" (the
# first IDS-006 layer name) and metadata$artifact_role =
# "clinical_translation_evidence". Default consumer is
# "clinical_translation_package" (Module 15).
#
# Per the Generic Implementation Principle: the default translator
# performs only structural execution -- no treatment recommendation,
# guideline reasoning, patient stratification, therapeutic reasoning,
# or clinician-facing output. Real clinical methodology remains
# injectable via the `translator` callback (mirroring Module 07's
# `trainer`, Module 09's `validator`, Module 10's `benchmarker`,
# Module 11's `selector`, Module 12's `interpreter`, and Module 13's
# `integrator`).

# ---- Clinical Translation Object (implementation-only) ----------------------

#' Create a Clinical Translation Object
#'
#' Constructs a Clinical Translation Object: an implementation-only
#' object (never exposed as a Framework artifact) that encapsulates
#' the consumed Interpretation Package (Module 13), translation
#' components, execution metadata, and implementation state.
#' Interpretation Package is consumed completely read-only and is
#' never modified by this function or by [run_clinical_translation()].
#'
#' Only an `interpretation_package` object is accepted as the upstream
#' contract; this module never directly consumes Interpretation
#' Evidence, Validated Candidate, Benchmark Evidence, or Validation
#' Evidence -- those remain available, if needed, only through the
#' lineage already preserved within the Interpretation Package.
#'
#' @param interpretation_package An `interpretation_package` object
#'   (Module 13).
#' @param metadata List of additional implementation metadata.
#'   Defaults to an empty list.
#'
#' @return An object of class `"clinical_translation_object"`, with
#'   fields `interpretation_package`, `translation_components`
#'   (initially an empty list), `execution_metadata` (initially an
#'   empty list), and `metadata`.
#'
#' @export
create_clinical_translation_object <- function(interpretation_package, metadata = list()) {

  if (!inherits(interpretation_package, "interpretation_package")) {
    stop("'interpretation_package' must be an interpretation_package object (Module 13).",
         call. = FALSE)
  }
  validate_interpretation_package(interpretation_package)

  if (!is.list(metadata)) {
    stop("'metadata' must be a list.", call. = FALSE)
  }

  clinical_translation_object <- list(
    interpretation_package = interpretation_package,
    translation_components = list(),
    execution_metadata = list(),
    metadata = metadata
  )

  class(clinical_translation_object) <- "clinical_translation_object"

  clinical_translation_object
}

#' Validate a Clinical Translation Object
#'
#' Verifies required fields, object completeness, and structural
#' consistency of a Clinical Translation Object, including delegated
#' structural validity of its embedded Interpretation Package (via the
#' LOCKED Module 13 `validate_interpretation_package()`). Performs no
#' clinical, biological, or scientific validation.
#'
#' @param x Object to validate.
#'
#' @return Invisibly `TRUE` if `x` is a structurally valid Clinical
#'   Translation Object; otherwise raises an error via `stop()`.
#'
#' @export
validate_clinical_translation_object <- function(x) {

  if (!.is_clinical_translation_object(x)) {
    stop("'x' must be a clinical_translation_object object.", call. = FALSE)
  }

  required_fields <- c("interpretation_package", "translation_components",
                        "execution_metadata", "metadata")
  missing_fields <- setdiff(required_fields, names(x))
  if (length(missing_fields) > 0) {
    stop("Clinical Translation Object is missing required field(s): ",
         paste(missing_fields, collapse = ", "), call. = FALSE)
  }

  validate_interpretation_package(x$interpretation_package)

  if (!is.list(x$translation_components)) {
    stop("Clinical Translation Object field 'translation_components' must be a list.", call. = FALSE)
  }
  if (!is.list(x$execution_metadata)) {
    stop("Clinical Translation Object field 'execution_metadata' must be a list.", call. = FALSE)
  }
  if (!is.list(x$metadata)) {
    stop("Clinical Translation Object field 'metadata' must be a list.", call. = FALSE)
  }

  invisible(TRUE)
}

#' @keywords internal
#' @noRd
.is_clinical_translation_object <- function(x) {
  inherits(x, "clinical_translation_object")
}

#' Print a Clinical Translation Object
#'
#' @param x A `clinical_translation_object` object.
#' @param ... Additional arguments (currently unused).
#'
#' @return `x`, invisibly.
#'
#' @export
print.clinical_translation_object <- function(x, ...) {
  cat("<clinical_translation_object>\n")
  cat("  interpretation_package:  embedded (producer: ", x$interpretation_package$producer, ")\n", sep = "")
  cat("  translation_components:  ", length(x$translation_components), " component(s)\n", sep = "")
  cat("  execution_metadata:      ", length(x$execution_metadata), " item(s)\n", sep = "")
  invisible(x)
}

# ---- Default generic translator (no real methodology) ----------------------

#' @keywords internal
#' @noRd
.default_generic_translator <- function(clinical_translation_object, ...) {
  list(
    structural_check = list(
      passed = TRUE,
      details = "generic structural check only; no treatment-recommendation/guideline/patient-stratification/therapeutic methodology"
    )
  )
}

# ---- Clinical Translation Workflow / Executor -------------------------------

#' Run Clinical Translation (Workflow + Executor)
#'
#' Orchestrates the Clinical Translation workflow for an initial
#' Clinical Translation Object: invokes a translator (the default
#' generic translator, or a caller-supplied one) to produce one or more
#' named `translation_components`, returns an updated Clinical
#' Translation Object carrying those components, and constructs the
#' resulting Clinical Translation Evidence -- mirroring Module 09's
#' `run_validation()` through Module 13's `run_evidence_integration()`.
#'
#' The translator replaces only the execution step; it never bypasses
#' workflow, verification, lineage, or artifact construction performed
#' by this function. The default translator performs only a generic,
#' structural check -- no treatment recommendation, clinical guideline
#' reasoning, patient stratification, therapeutic reasoning, or
#' clinician-facing output is performed by this function or its
#' default translator.
#'
#' @param clinical_translation_object A `clinical_translation_object`,
#'   as returned by [create_clinical_translation_object()].
#' @param translator A function taking `(clinical_translation_object, ...)`
#'   and returning a named list of translation components. Defaults to
#'   an internal generic, structural placeholder translator.
#' @param ... Additional arguments forwarded to `translator`.
#'
#' @return A list with elements `clinical_translation_object` (the
#'   updated object, with `translation_components` populated) and
#'   `clinical_translation_evidence` (the resulting Framework
#'   artifact).
#'
#' @export
run_clinical_translation <- function(clinical_translation_object, translator = NULL, ...) {

  validate_clinical_translation_object(clinical_translation_object)

  if (is.null(translator)) {
    translator <- .default_generic_translator
  }
  if (!is.function(translator)) {
    stop("'translator' must be a function.", call. = FALSE)
  }

  components <- translator(clinical_translation_object, ...)

  if (!is.list(components)) {
    stop("'translator' must return a list of named translation components.", call. = FALSE)
  }

  updated <- clinical_translation_object
  updated$translation_components <- components
  updated$execution_metadata <- c(updated$execution_metadata, list(executed = TRUE))

  validate_clinical_translation_object(updated)

  evidence <- create_clinical_translation_evidence(updated)

  list(
    clinical_translation_object = updated,
    clinical_translation_evidence = evidence
  )
}

# ---- Clinical Translation Evidence (the sole Framework artifact) -----------

#' Create Clinical Translation Evidence
#'
#' Constructs Clinical Translation Evidence: the sole Framework
#' artifact produced by Module 14 (via the LOCKED Module 02
#' `create_artifact_contract()`), structurally independent from the
#' supplied Clinical Translation Object while preserving complete
#' lineage by embedding it unchanged. Clinical Translation Evidence
#' never contains treatment recommendation, clinical guideline
#' reasoning, clinician-facing interpretation, patient recommendation,
#' or clinical decision support.
#'
#' @param clinical_translation_object A `clinical_translation_object`,
#'   typically the updated object produced by [run_clinical_translation()].
#' @param producer Character scalar identifying the producer. Defaults
#'   to the embedded Interpretation Package's `producer`.
#' @param consumer Character scalar identifying the intended downstream
#'   consumer. Defaults to `"clinical_translation_package"` (Module 15,
#'   IDS-006).
#' @param metadata Additional list of metadata merged into the
#'   artifact's `metadata` field. Defaults to an empty list. Must not
#'   contain `framework_layer`, `artifact_role`, or
#'   `clinical_translation_object` (set internally), nor
#'   `treatment_recommendation`, `clinical_guideline_reasoning`,
#'   `clinician_facing_interpretation`, `patient_recommendation`, or
#'   `clinical_decision_support` (explicitly forbidden content).
#'
#' @return An object of class `c("clinical_translation_evidence", "artifact_contract", "contract")`.
#'
#' @export
create_clinical_translation_evidence <- function(clinical_translation_object,
                                                  producer = NULL,
                                                  consumer = "clinical_translation_package",
                                                  metadata = list()) {

  validate_clinical_translation_object(clinical_translation_object)

  if (!is.list(metadata)) {
    stop("'metadata' must be a list.", call. = FALSE)
  }

  reserved <- intersect(names(metadata),
                         c("framework_layer", "artifact_role", "clinical_translation_object"))
  if (length(reserved) > 0) {
    stop("'metadata' must not contain reserved key(s): ",
         paste(reserved, collapse = ", "), call. = FALSE)
  }

  forbidden <- intersect(names(metadata),
                          c("treatment_recommendation", "clinical_guideline_reasoning",
                            "clinician_facing_interpretation", "patient_recommendation",
                            "clinical_decision_support"))
  if (length(forbidden) > 0) {
    stop("Clinical Translation Evidence SHALL NOT contain: ",
         paste(forbidden, collapse = ", "), call. = FALSE)
  }

  if (is.null(producer)) {
    producer <- clinical_translation_object$interpretation_package$producer
  }

  full_metadata <- c(
    list(
      framework_layer = "clinical_translation",
      artifact_role = "clinical_translation_evidence",
      clinical_translation_object = clinical_translation_object
    ),
    metadata
  )

  evidence <- create_artifact_contract(
    producer = producer,
    consumer = consumer,
    inputs = list("interpretation_package"),
    outputs = list("clinical_translation_evidence"),
    dependencies = list(),
    metadata = full_metadata
  )

  class(evidence) <- c("clinical_translation_evidence", class(evidence))

  evidence
}

#' Validate Clinical Translation Evidence
#'
#' Verifies required fields, contract validity (via the LOCKED Module
#' 02 `validate_artifact_contract()`), and lineage integrity of
#' Clinical Translation Evidence. Confirms the forbidden-content
#' guarantee (no treatment recommendation, clinical guideline
#' reasoning, clinician-facing interpretation, patient recommendation,
#' or clinical decision support). Performs no clinical, biological, or
#' scientific validation.
#'
#' @param x Object to validate.
#'
#' @return Invisibly `TRUE` if `x` is structurally valid; otherwise
#'   raises an error via `stop()`.
#'
#' @export
validate_clinical_translation_evidence <- function(x) {

  if (!inherits(x, "clinical_translation_evidence")) {
    stop("'x' must be a clinical_translation_evidence object.", call. = FALSE)
  }

  if (!is_artifact_contract(x)) {
    stop("'x' must be an artifact_contract object (Module 02).", call. = FALSE)
  }

  validate_artifact_contract(x)

  if (!identical(x$contract_type, "artifact")) {
    stop("Clinical Translation Evidence field 'contract_type' must equal 'artifact'. ",
         "Received: '", x$contract_type, "'.", call. = FALSE)
  }

  if (!identical(x$metadata$artifact_role, "clinical_translation_evidence")) {
    stop("Clinical Translation Evidence must have metadata$artifact_role == 'clinical_translation_evidence'.",
         call. = FALSE)
  }

  if (is.null(x$metadata$clinical_translation_object)) {
    stop("Clinical Translation Evidence is missing its embedded clinical_translation_object ",
         "(lineage integrity).", call. = FALSE)
  }
  validate_clinical_translation_object(x$metadata$clinical_translation_object)

  forbidden_present <- intersect(names(x$metadata),
                                  c("treatment_recommendation", "clinical_guideline_reasoning",
                                    "clinician_facing_interpretation", "patient_recommendation",
                                    "clinical_decision_support"))
  if (length(forbidden_present) > 0) {
    stop("Clinical Translation Evidence must not contain: ",
         paste(forbidden_present, collapse = ", "), call. = FALSE)
  }

  invisible(TRUE)
}

#' Print Clinical Translation Evidence
#'
#' @param x A `clinical_translation_evidence` object.
#' @param ... Additional arguments (currently unused).
#'
#' @return `x`, invisibly.
#'
#' @export
print.clinical_translation_evidence <- function(x, ...) {
  cat("<clinical_translation_evidence>\n")
  cat("  producer:                 ", x$producer, "\n", sep = "")
  cat("  consumer:                 ", x$consumer, "\n", sep = "")
  components <- x$metadata$clinical_translation_object$translation_components
  cat("  translation_components:   ",
      if (length(components) > 0) paste(names(components), collapse = ", ") else "(none yet)",
      "\n", sep = "")
  cat("  clinical_translation_object: embedded (lineage preserved)\n", sep = "")
  invisible(x)
}
