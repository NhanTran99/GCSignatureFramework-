# clinical_output.R
#
# Clinical Outputs (Module 15, IDS-006)
#
# Implements the Clinical Outputs responsibility of IDS-006: read-only
# consumption of Clinical Translation Evidence (Module 14), a Clinical
# Output Object (implementation-only, never a Framework artifact)
# capturing the consumed evidence + execution state, and Clinical
# Translation Package (the sole, final Framework artifact of the
# entire Coding Phase, Modules 01-15). Contains no medical advice,
# treatment recommendation, physician decision support, guideline
# interpretation, patient management, or publication-ready report --
# those responsibilities are explicitly outside Module 15 and the
# Coding Phase entirely.
#
# Per the Coding Prompt's Consistency Check: Clinical Translation
# Package uses metadata$framework_layer = "clinical_translation" (same
# layer as Module 14's Clinical Translation Evidence) and
# metadata$artifact_role = "clinical_translation_package". Default
# consumer is "framework_integration", naming the next governed
# milestone after Module 15 (there is no Module 16).
#
# Per the Generic Implementation Principle: the default output
# generator performs only structural execution -- no treatment
# recommendation, medical advice, guideline reasoning, patient
# management, or physician decision support. Real clinical methodology
# remains injectable via the `output_generator` callback (mirroring
# Module 07's `trainer`, Module 09's `validator`, Module 10's
# `benchmarker`, Module 11's `selector`, Module 12's `interpreter`,
# Module 13's `integrator`, and Module 14's `translator`).

# ---- Clinical Output Object (implementation-only) ---------------------------

#' Create a Clinical Output Object
#'
#' Constructs a Clinical Output Object: an implementation-only object
#' (never exposed as a Framework artifact) that encapsulates the
#' consumed Clinical Translation Evidence (Module 14), output
#' components, execution metadata, and implementation state. Clinical
#' Translation Evidence is consumed completely read-only and is never
#' modified by this function or by [run_clinical_output()].
#'
#' Only a `clinical_translation_evidence` object is accepted as the
#' upstream contract; this module never directly consumes
#' Interpretation Package, Interpretation Evidence, Validated
#' Candidate, Benchmark Evidence, or Validation Evidence -- those
#' remain available, if needed, only through the lineage already
#' preserved within the Clinical Translation Evidence.
#'
#' @param clinical_translation_evidence A `clinical_translation_evidence`
#'   object (Module 14).
#' @param metadata List of additional implementation metadata.
#'   Defaults to an empty list.
#'
#' @return An object of class `"clinical_output_object"`, with fields
#'   `clinical_translation_evidence`, `output_components` (initially an
#'   empty list), `execution_metadata` (initially an empty list), and
#'   `metadata`.
#'
#' @export
create_clinical_output_object <- function(clinical_translation_evidence, metadata = list()) {

  if (!inherits(clinical_translation_evidence, "clinical_translation_evidence")) {
    stop("'clinical_translation_evidence' must be a clinical_translation_evidence ",
         "object (Module 14).", call. = FALSE)
  }
  validate_clinical_translation_evidence(clinical_translation_evidence)

  if (!is.list(metadata)) {
    stop("'metadata' must be a list.", call. = FALSE)
  }

  clinical_output_object <- list(
    clinical_translation_evidence = clinical_translation_evidence,
    output_components = list(),
    execution_metadata = list(),
    metadata = metadata
  )

  class(clinical_output_object) <- "clinical_output_object"

  clinical_output_object
}

#' Validate a Clinical Output Object
#'
#' Verifies required fields, object completeness, and structural
#' consistency of a Clinical Output Object, including delegated
#' structural validity of its embedded Clinical Translation Evidence
#' (via the LOCKED Module 14 `validate_clinical_translation_evidence()`).
#' Performs no clinical, biological, or scientific validation.
#'
#' @param x Object to validate.
#'
#' @return Invisibly `TRUE` if `x` is a structurally valid Clinical
#'   Output Object; otherwise raises an error via `stop()`.
#'
#' @export
validate_clinical_output_object <- function(x) {

  if (!.is_clinical_output_object(x)) {
    stop("'x' must be a clinical_output_object object.", call. = FALSE)
  }

  required_fields <- c("clinical_translation_evidence", "output_components",
                        "execution_metadata", "metadata")
  missing_fields <- setdiff(required_fields, names(x))
  if (length(missing_fields) > 0) {
    stop("Clinical Output Object is missing required field(s): ",
         paste(missing_fields, collapse = ", "), call. = FALSE)
  }

  validate_clinical_translation_evidence(x$clinical_translation_evidence)

  if (!is.list(x$output_components)) {
    stop("Clinical Output Object field 'output_components' must be a list.", call. = FALSE)
  }
  if (!is.list(x$execution_metadata)) {
    stop("Clinical Output Object field 'execution_metadata' must be a list.", call. = FALSE)
  }
  if (!is.list(x$metadata)) {
    stop("Clinical Output Object field 'metadata' must be a list.", call. = FALSE)
  }

  invisible(TRUE)
}

#' @keywords internal
#' @noRd
.is_clinical_output_object <- function(x) {
  inherits(x, "clinical_output_object")
}

#' Print a Clinical Output Object
#'
#' @param x A `clinical_output_object` object.
#' @param ... Additional arguments (currently unused).
#'
#' @return `x`, invisibly.
#'
#' @export
print.clinical_output_object <- function(x, ...) {
  cat("<clinical_output_object>\n")
  cat("  clinical_translation_evidence:  embedded (producer: ",
      x$clinical_translation_evidence$producer, ")\n", sep = "")
  cat("  output_components:              ", length(x$output_components), " component(s)\n", sep = "")
  cat("  execution_metadata:             ", length(x$execution_metadata), " item(s)\n", sep = "")
  invisible(x)
}

# ---- Default generic output generator (no real methodology) ----------------

#' @keywords internal
#' @noRd
.default_generic_output_generator <- function(clinical_output_object, ...) {
  list(
    structural_check = list(
      passed = TRUE,
      details = "generic structural check only; no treatment-recommendation/medical-advice/guideline/patient-management methodology"
    )
  )
}

# ---- Clinical Output Workflow / Executor ------------------------------------

#' Run Clinical Output (Workflow + Executor)
#'
#' Orchestrates the Clinical Output workflow for an initial Clinical
#' Output Object: invokes an output generator (the default generic
#' generator, or a caller-supplied one) to produce one or more named
#' `output_components`, returns an updated Clinical Output Object
#' carrying those components, and constructs the resulting Clinical
#' Translation Package -- mirroring Module 09's `run_validation()`
#' through Module 14's `run_clinical_translation()`.
#'
#' The output generator replaces only the execution step; it never
#' bypasses workflow, verification, lineage, or artifact construction
#' performed by this function. The default generator performs only a
#' generic, structural check -- no treatment recommendation, medical
#' advice, guideline reasoning, patient management, or physician
#' decision support is performed by this function or its default
#' generator.
#'
#' @param clinical_output_object A `clinical_output_object`, as
#'   returned by [create_clinical_output_object()].
#' @param output_generator A function taking `(clinical_output_object, ...)`
#'   and returning a named list of output components. Defaults to an
#'   internal generic, structural placeholder generator.
#' @param ... Additional arguments forwarded to `output_generator`.
#'
#' @return A list with elements `clinical_output_object` (the updated
#'   object, with `output_components` populated) and
#'   `clinical_translation_package` (the resulting, final Framework
#'   artifact of the entire Coding Phase).
#'
#' @export
run_clinical_output <- function(clinical_output_object, output_generator = NULL, ...) {

  validate_clinical_output_object(clinical_output_object)

  if (is.null(output_generator)) {
    output_generator <- .default_generic_output_generator
  }
  if (!is.function(output_generator)) {
    stop("'output_generator' must be a function.", call. = FALSE)
  }

  components <- output_generator(clinical_output_object, ...)

  if (!is.list(components)) {
    stop("'output_generator' must return a list of named output components.", call. = FALSE)
  }

  updated <- clinical_output_object
  updated$output_components <- components
  updated$execution_metadata <- c(updated$execution_metadata, list(executed = TRUE))

  validate_clinical_output_object(updated)

  package <- create_clinical_translation_package(updated)

  list(
    clinical_output_object = updated,
    clinical_translation_package = package
  )
}

# ---- Clinical Translation Package (the sole, final Framework artifact) -----

#' Create a Clinical Translation Package
#'
#' Constructs Clinical Translation Package: the sole Framework
#' artifact produced by Module 15 (via the LOCKED Module 02
#' `create_artifact_contract()`), and the final Framework artifact of
#' the entire Coding Phase (Modules 01-15). Structurally independent
#' from the supplied Clinical Output Object while preserving complete
#' lineage by embedding it unchanged. Clinical Translation Package
#' never contains treatment recommendation, medical advice, physician
#' decision support, guideline interpretation, patient management, or
#' publication-ready discussion.
#'
#' @param clinical_output_object A `clinical_output_object`, typically
#'   the updated object produced by [run_clinical_output()].
#' @param producer Character scalar identifying the producer. Defaults
#'   to the embedded Clinical Translation Evidence's `producer`.
#' @param consumer Character scalar identifying the intended downstream
#'   consumer. Defaults to `"framework_integration"`, naming the next
#'   governed milestone after Module 15 (there is no Module 16).
#' @param metadata Additional list of metadata merged into the
#'   artifact's `metadata` field. Defaults to an empty list. Must not
#'   contain `framework_layer`, `artifact_role`, or
#'   `clinical_output_object` (set internally), nor
#'   `treatment_recommendation`, `medical_advice`,
#'   `physician_decision_support`, `guideline_interpretation`,
#'   `patient_management`, or `publication_ready_discussion`
#'   (explicitly forbidden content).
#'
#' @return An object of class `c("clinical_translation_package", "artifact_contract", "contract")`.
#'
#' @export
create_clinical_translation_package <- function(clinical_output_object,
                                                 producer = NULL,
                                                 consumer = "framework_integration",
                                                 metadata = list()) {

  validate_clinical_output_object(clinical_output_object)

  if (!is.list(metadata)) {
    stop("'metadata' must be a list.", call. = FALSE)
  }

  reserved <- intersect(names(metadata),
                         c("framework_layer", "artifact_role", "clinical_output_object"))
  if (length(reserved) > 0) {
    stop("'metadata' must not contain reserved key(s): ",
         paste(reserved, collapse = ", "), call. = FALSE)
  }

  forbidden <- intersect(names(metadata),
                          c("treatment_recommendation", "medical_advice",
                            "physician_decision_support", "guideline_interpretation",
                            "patient_management", "publication_ready_discussion"))
  if (length(forbidden) > 0) {
    stop("Clinical Translation Package SHALL NOT contain: ",
         paste(forbidden, collapse = ", "), call. = FALSE)
  }

  if (is.null(producer)) {
    producer <- clinical_output_object$clinical_translation_evidence$producer
  }

  full_metadata <- c(
    list(
      framework_layer = "clinical_translation",
      artifact_role = "clinical_translation_package",
      clinical_output_object = clinical_output_object
    ),
    metadata
  )

  package <- create_artifact_contract(
    producer = producer,
    consumer = consumer,
    inputs = list("clinical_translation_evidence"),
    outputs = list("clinical_translation_package"),
    dependencies = list(),
    metadata = full_metadata
  )

  class(package) <- c("clinical_translation_package", class(package))

  package
}

#' Validate a Clinical Translation Package
#'
#' Verifies required fields, contract validity (via the LOCKED Module
#' 02 `validate_artifact_contract()`), and lineage integrity of
#' Clinical Translation Package. Confirms the forbidden-content
#' guarantee (no treatment recommendation, medical advice, physician
#' decision support, guideline interpretation, patient management, or
#' publication-ready discussion). Performs no clinical, biological, or
#' scientific validation.
#'
#' @param x Object to validate.
#'
#' @return Invisibly `TRUE` if `x` is structurally valid; otherwise
#'   raises an error via `stop()`.
#'
#' @export
validate_clinical_translation_package <- function(x) {

  if (!inherits(x, "clinical_translation_package")) {
    stop("'x' must be a clinical_translation_package object.", call. = FALSE)
  }

  if (!is_artifact_contract(x)) {
    stop("'x' must be an artifact_contract object (Module 02).", call. = FALSE)
  }

  validate_artifact_contract(x)

  if (!identical(x$contract_type, "artifact")) {
    stop("Clinical Translation Package field 'contract_type' must equal 'artifact'. ",
         "Received: '", x$contract_type, "'.", call. = FALSE)
  }

  if (!identical(x$metadata$artifact_role, "clinical_translation_package")) {
    stop("Clinical Translation Package must have metadata$artifact_role == 'clinical_translation_package'.",
         call. = FALSE)
  }

  if (is.null(x$metadata$clinical_output_object)) {
    stop("Clinical Translation Package is missing its embedded clinical_output_object ",
         "(lineage integrity).", call. = FALSE)
  }
  validate_clinical_output_object(x$metadata$clinical_output_object)

  forbidden_present <- intersect(names(x$metadata),
                                  c("treatment_recommendation", "medical_advice",
                                    "physician_decision_support", "guideline_interpretation",
                                    "patient_management", "publication_ready_discussion"))
  if (length(forbidden_present) > 0) {
    stop("Clinical Translation Package must not contain: ",
         paste(forbidden_present, collapse = ", "), call. = FALSE)
  }

  invisible(TRUE)
}

#' Print a Clinical Translation Package
#'
#' @param x A `clinical_translation_package` object.
#' @param ... Additional arguments (currently unused).
#'
#' @return `x`, invisibly.
#'
#' @export
print.clinical_translation_package <- function(x, ...) {
  cat("<clinical_translation_package>\n")
  cat("  producer:            ", x$producer, "\n", sep = "")
  cat("  consumer:            ", x$consumer, "\n", sep = "")
  components <- x$metadata$clinical_output_object$output_components
  cat("  output_components:   ",
      if (length(components) > 0) paste(names(components), collapse = ", ") else "(none yet)",
      "\n", sep = "")
  cat("  clinical_output_object: embedded (lineage preserved)\n", sep = "")
  invisible(x)
}
