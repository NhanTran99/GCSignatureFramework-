# model_output.R
#
# Model Output Boundary (Module 08)
#
# Implements the unique producer of the Modeling domain's two Framework
# artifacts: Model Candidate and Modeling Evidence, both constructed
# from a completed Training Object (Module 07). Contains no
# benchmarking, candidate selection, model comparison, performance
# ranking, statistical/biological evaluation, calibration,
# interpretability analysis, or clinical evaluation, per
# IDS-003_Modeling_Implementation.md and the Module 08 Coding Prompt
# (these responsibilities belong to IDS-004).
#
# Per the Coding Prompt's Consistency Check clarifications:
#
#   1. Both Model Candidate and Modeling Evidence are constructed via
#      the LOCKED Module 02 create_artifact_contract(), unmodified.
#      `contract_type` remains exactly "artifact" in both cases.
#      `metadata$framework_layer = "modeling"` and a new
#      `metadata$artifact_role` ("model_candidate" / "modeling_evidence")
#      distinguish the two artifact types -- this extends, rather than
#      violates, the established "context belongs in metadata, never
#      in contract_type" rule.
#
#   2. Each object additionally carries one extra, prepended S3 class
#      (e.g. c("model_candidate", "artifact_contract", "contract")) for
#      print() dispatch only. is_artifact_contract() and
#      validate_artifact_contract() (Module 02, unmodified) continue to
#      work exactly as LOCKED, since "artifact_contract" remains in the
#      class vector.
#
# Per the Opaque Implementation Principle: `trained_model` (embedded,
# via the complete Training Object, inside Model Candidate) is never
# inspected or transformed -- only the whole, unmodified Training
# Object is embedded.

# ---- Internal: structural Evidence Container -------------------------------

#' @keywords internal
#' @noRd
.new_evidence_sections <- function() {
  list(
    predictive_model = NULL,
    risk_score_definition = NULL,
    performance_profile = NULL,
    interpretability_profile = NULL,
    clinical_evaluation_profile = NULL
  )
}

# ---- Model Candidate ---------------------------------------------------------

#' Create a Model Candidate
#'
#' Constructs a Model Candidate: a Framework artifact (via the LOCKED
#' Module 02 `create_artifact_contract()`) that preserves complete
#' Modeling lineage by embedding the complete, unmodified Training
#' Object (Module 07). Module 08 is the only Coding Module permitted to
#' create Model Candidates (AD-01).
#'
#' The supplied Training Object is consumed read-only and is never
#' modified (AD-03); `trained_model` within it is treated as an opaque
#' implementation object and is never inspected or transformed (Opaque
#' Implementation Principle).
#'
#' @param training_object A `training_object` (Module 07), as returned
#'   by `create_training_object()`.
#' @param producer Character scalar identifying the producer. Defaults
#'   to the embedded Model Object's `algorithm_id`.
#' @param consumer Character scalar identifying the intended downstream
#'   consumer. Defaults to `"validation_benchmark"` (IDS-004).
#' @param metadata Additional list of metadata merged into the
#'   artifact's `metadata` field. Defaults to an empty list. Must not
#'   contain `framework_layer`, `artifact_role`, or `training_object`
#'   (these are set internally).
#'
#' @return An object of class `c("model_candidate", "artifact_contract", "contract")`.
#'
#' @export
create_model_candidate <- function(training_object,
                                    producer = NULL,
                                    consumer = "validation_benchmark",
                                    metadata = list()) {

  validate_training_object(training_object)

  if (!is.list(metadata)) {
    stop("'metadata' must be a list.", call. = FALSE)
  }

  reserved <- intersect(names(metadata), c("framework_layer", "artifact_role", "training_object"))
  if (length(reserved) > 0) {
    stop("'metadata' must not contain reserved key(s): ",
         paste(reserved, collapse = ", "), call. = FALSE)
  }

  if (is.null(producer)) {
    producer <- training_object$model_object$specification$algorithm_id
  }

  full_metadata <- c(
    list(
      framework_layer = "modeling",
      artifact_role = "model_candidate",
      training_object = training_object
    ),
    metadata
  )

  candidate <- create_artifact_contract(
    producer = producer,
    consumer = consumer,
    inputs = list("training_object"),
    outputs = list("model_candidate"),
    dependencies = list(),
    metadata = full_metadata
  )

  class(candidate) <- c("model_candidate", class(candidate))

  candidate
}

#' Validate a Model Candidate
#'
#' Verifies required fields, object completeness, contract validity
#' (via the LOCKED Module 02 `validate_artifact_contract()`), and
#' lineage integrity (an embedded, valid Training Object) of a Model
#' Candidate. Performs no scientific, statistical, biological,
#' predictive-performance, or clinical-usefulness validation -- those
#' responsibilities belong to IDS-004.
#'
#' @param x Object to validate.
#'
#' @return Invisibly `TRUE` if `x` is a structurally valid Model
#'   Candidate; otherwise raises an error via `stop()`.
#'
#' @export
validate_model_candidate <- function(x) {

  if (!inherits(x, "model_candidate")) {
    stop("'x' must be a model_candidate object.", call. = FALSE)
  }

  if (!is_artifact_contract(x)) {
    stop("'x' must be an artifact_contract object (Module 02).", call. = FALSE)
  }

  validate_artifact_contract(x)

  if (!identical(x$contract_type, "artifact")) {
    stop("Model Candidate field 'contract_type' must equal 'artifact'. ",
         "Received: '", x$contract_type, "'.", call. = FALSE)
  }

  if (!identical(x$metadata$artifact_role, "model_candidate")) {
    stop("Model Candidate must have metadata$artifact_role == 'model_candidate'.",
         call. = FALSE)
  }

  if (is.null(x$metadata$training_object)) {
    stop("Model Candidate is missing its embedded training_object (lineage integrity).",
         call. = FALSE)
  }

  validate_training_object(x$metadata$training_object)

  invisible(TRUE)
}

#' Print a Model Candidate
#'
#' @param x A `model_candidate` object.
#' @param ... Additional arguments (currently unused).
#'
#' @return `x`, invisibly.
#'
#' @export
print.model_candidate <- function(x, ...) {
  cat("<model_candidate>\n")
  cat("  producer:        ", x$producer, "\n", sep = "")
  cat("  consumer:        ", x$consumer, "\n", sep = "")
  cat("  algorithm_id:    ", x$metadata$training_object$model_object$specification$algorithm_id, "\n", sep = "")
  cat("  training_object: embedded (lineage preserved)\n", sep = "")
  invisible(x)
}

# ---- Modeling Evidence --------------------------------------------------------

#' @keywords internal
#' @noRd
.validate_modeling_evidence <- function(x) {

  if (!inherits(x, "modeling_evidence")) {
    stop("'x' must be a modeling_evidence object.", call. = FALSE)
  }

  if (!is_artifact_contract(x)) {
    stop("'x' must be an artifact_contract object (Module 02).", call. = FALSE)
  }

  validate_artifact_contract(x)

  if (!identical(x$contract_type, "artifact")) {
    stop("Modeling Evidence field 'contract_type' must equal 'artifact'. ",
         "Received: '", x$contract_type, "'.", call. = FALSE)
  }

  if (!identical(x$metadata$artifact_role, "modeling_evidence")) {
    stop("Modeling Evidence must have metadata$artifact_role == 'modeling_evidence'.",
         call. = FALSE)
  }

  required_sections <- c("predictive_model", "risk_score_definition", "performance_profile",
                          "interpretability_profile", "clinical_evaluation_profile")
  sections <- x$metadata$evidence_sections
  if (is.null(sections) || !is.list(sections)) {
    stop("Modeling Evidence is missing its structural evidence_sections container.",
         call. = FALSE)
  }
  missing_sections <- setdiff(required_sections, names(sections))
  if (length(missing_sections) > 0) {
    stop("Modeling Evidence evidence_sections is missing required section(s): ",
         paste(missing_sections, collapse = ", "), call. = FALSE)
  }

  if (is.null(x$metadata$training_object)) {
    stop("Modeling Evidence is missing its embedded training_object (lineage integrity).",
         call. = FALSE)
  }

  validate_training_object(x$metadata$training_object)

  invisible(TRUE)
}

#' Create Modeling Evidence
#'
#' Constructs Modeling Evidence: a Framework artifact (via the LOCKED
#' Module 02 `create_artifact_contract()`) acting as a structural
#' evidence container that accompanies exactly one Model Candidate.
#' Module 08 is the only Coding Module permitted to create Modeling
#' Evidence (AD-02).
#'
#' The five structural sections (`predictive_model`,
#' `risk_score_definition`, `performance_profile`,
#' `interpretability_profile`, `clinical_evaluation_profile`) are
#' initialized as placeholder (`NULL`) implementation objects; no
#' benchmark, statistical analysis, or clinical evaluation is performed
#' here (those responsibilities belong to IDS-004).
#'
#' Modeling Evidence does not embed the Model Candidate, and is not
#' embedded by it (AD-04); both independently reference the same,
#' unmodified Training Object for shared lineage.
#'
#' @param training_object A `training_object` (Module 07), as returned
#'   by `create_training_object()`.
#' @param producer Character scalar identifying the producer. Defaults
#'   to the embedded Model Object's `algorithm_id`.
#' @param consumer Character scalar identifying the intended downstream
#'   consumer. Defaults to `"validation_benchmark"` (IDS-004).
#' @param metadata Additional list of metadata merged into the
#'   artifact's `metadata` field. Defaults to an empty list. Must not
#'   contain `framework_layer`, `artifact_role`, `training_object`, or
#'   `evidence_sections` (these are set internally).
#'
#' @return An object of class `c("modeling_evidence", "artifact_contract", "contract")`.
#'
#' @export
create_modeling_evidence <- function(training_object,
                                      producer = NULL,
                                      consumer = "validation_benchmark",
                                      metadata = list()) {

  validate_training_object(training_object)

  if (!is.list(metadata)) {
    stop("'metadata' must be a list.", call. = FALSE)
  }

  reserved <- intersect(names(metadata),
                         c("framework_layer", "artifact_role", "training_object", "evidence_sections"))
  if (length(reserved) > 0) {
    stop("'metadata' must not contain reserved key(s): ",
         paste(reserved, collapse = ", "), call. = FALSE)
  }

  if (is.null(producer)) {
    producer <- training_object$model_object$specification$algorithm_id
  }

  full_metadata <- c(
    list(
      framework_layer = "modeling",
      artifact_role = "modeling_evidence",
      training_object = training_object,
      evidence_sections = .new_evidence_sections()
    ),
    metadata
  )

  evidence <- create_artifact_contract(
    producer = producer,
    consumer = consumer,
    inputs = list("training_object"),
    outputs = list("modeling_evidence"),
    dependencies = list(),
    metadata = full_metadata
  )

  class(evidence) <- c("modeling_evidence", class(evidence))

  .validate_modeling_evidence(evidence)

  evidence
}

#' Print Modeling Evidence
#'
#' @param x A `modeling_evidence` object.
#' @param ... Additional arguments (currently unused).
#'
#' @return `x`, invisibly.
#'
#' @export
print.modeling_evidence <- function(x, ...) {
  cat("<modeling_evidence>\n")
  cat("  producer:  ", x$producer, "\n", sep = "")
  cat("  consumer:  ", x$consumer, "\n", sep = "")
  cat("  sections:  ", paste(names(x$metadata$evidence_sections), collapse = ", "), "\n", sep = "")
  cat("  training_object: embedded (lineage preserved)\n", sep = "")
  invisible(x)
}

# ---- Internal: create both artifacts together -------------------------------

#' Create a Model Candidate and Modeling Evidence together
#'
#' Internal helper that constructs both Framework artifacts from the
#' same Training Object in a single call, ensuring shared lineage
#' (identical `producer` and identical embedded Training Object) across
#' both. Remains non-exported, per the Coding Prompt's Public API
#' specification.
#'
#' @param training_object A `training_object` (Module 07).
#' @param producer Character scalar. Defaults to the embedded Model
#'   Object's `algorithm_id`.
#' @param consumer Character scalar. Defaults to `"validation_benchmark"`.
#'
#' @return A list with elements `model_candidate` and `modeling_evidence`.
#' @keywords internal
#' @noRd
create_model_output <- function(training_object,
                                 producer = NULL,
                                 consumer = "validation_benchmark") {

  if (is.null(producer)) {
    producer <- training_object$model_object$specification$algorithm_id
  }

  list(
    model_candidate = create_model_candidate(training_object, producer = producer, consumer = consumer),
    modeling_evidence = create_modeling_evidence(training_object, producer = producer, consumer = consumer)
  )
}
