# discovery_output.R
#
# Discovery Output Boundary Layer (Module 05)
#
# Implements the Discovery -> Modeling output boundary: verification of
# Discovery contractual artifacts actually produced upstream (Module
# 04), and controlled, contract-preserving export of those artifacts.
# This module performs no Discovery processing and generates no new
# Discovery artifacts, per IDS-002_Discovery_Implementation.md and the
# Module 05 Coding Prompt (v2, including its Pre-Implementation
# Decision Record).
#
# Per that Decision Record: Module 05 operates generically on whatever
# collection of Discovery contractual artifacts was actually produced
# upstream -- it does not assume a hard-coded Discovery Candidate /
# Discovery Evidence pair, does not relabel, merge, split, or
# synthesize artifacts, and does not invent missing logical artifact
# categories. It verifies and exports exactly the artifact(s) it
# receives, preserving their contractual identity unchanged.
#
# Public API is kept minimal, per the Coding Prompt: only
# DiscoveryOutputVerifier() and DiscoveryOutputExporter() are exported
# (plus a print method for VerificationReport, for usability).
# Verification helper functions remain internal.

# ---- Internal verification helpers (collect-all; never fail-fast) --------
#
# Each helper inspects a list of artifact_contract objects and returns
# list(passed = logical, issues = character()) -- it never calls
# stop(), so that DiscoveryOutputVerifier() can run every category
# before returning, per the collect-all Verification Failure Policy.

#' @keywords internal
#' @noRd
.verify_contract_category <- function(artifacts) {
  issues <- character()

  for (i in seq_along(artifacts)) {
    a <- artifacts[[i]]
    if (!is_artifact_contract(a)) {
      issues <- c(issues, sprintf(
        "Artifact %d is not an artifact_contract object.", i))
      next
    }
    ok <- tryCatch({
      validate_artifact_contract(a)
      TRUE
    }, error = function(e) {
      issues <<- c(issues, sprintf(
        "Artifact %d failed validate_artifact_contract(): %s", i, conditionMessage(e)))
      FALSE
    })
  }

  list(passed = length(issues) == 0, issues = issues)
}

#' @keywords internal
#' @noRd
.verify_interface_category <- function(artifacts) {
  issues <- character()

  for (i in seq_along(artifacts)) {
    a <- artifacts[[i]]
    if (!is_artifact_contract(a)) {
      issues <- c(issues, sprintf(
        "Artifact %d cannot be interface-checked: not an artifact_contract.", i))
      next
    }
    if (!identical(a$contract_type, "artifact")) {
      issues <- c(issues, sprintf(
        "Artifact %d has contract_type '%s'; only 'artifact' may cross the Discovery -> Modeling boundary.",
        i, a$contract_type))
    }
    if (!is.character(a$producer) || length(a$producer) != 1 || !nzchar(a$producer)) {
      issues <- c(issues, sprintf("Artifact %d has an invalid or missing 'producer'.", i))
    }
    if (!is.character(a$consumer) || length(a$consumer) != 1 || !nzchar(a$consumer)) {
      issues <- c(issues, sprintf("Artifact %d has an invalid or missing 'consumer'.", i))
    }
  }

  list(passed = length(issues) == 0, issues = issues)
}

#' @keywords internal
#' @noRd
.verify_completeness_category <- function(artifacts) {
  issues <- character()

  if (length(artifacts) == 0) {
    issues <- c(issues, "No Discovery contractual artifacts were supplied for export.")
  }

  for (i in seq_along(artifacts)) {
    a <- artifacts[[i]]
    if (!is_artifact_contract(a)) {
      issues <- c(issues, sprintf(
        "Artifact %d cannot be completeness-checked: not an artifact_contract.", i))
      next
    }
    if (length(a$outputs) == 0) {
      issues <- c(issues, sprintf(
        "Artifact %d declares no outputs; an artifact crossing the boundary must declare at least one.", i))
    }
  }

  list(passed = length(issues) == 0, issues = issues)
}

#' @keywords internal
#' @noRd
.verify_traceability_category <- function(artifacts) {
  issues <- character()

  for (i in seq_along(artifacts)) {
    a <- artifacts[[i]]
    if (!is_artifact_contract(a)) {
      issues <- c(issues, sprintf(
        "Artifact %d cannot be traceability-checked: not an artifact_contract.", i))
      next
    }
    framework_layer <- a$metadata$framework_layer
    if (is.null(framework_layer) || !is.character(framework_layer) ||
        length(framework_layer) != 1 || !nzchar(framework_layer)) {
      issues <- c(issues, sprintf(
        "Artifact %d is missing a traceable 'metadata$framework_layer' provenance marker.", i))
    }
  }

  list(passed = length(issues) == 0, issues = issues)
}

#' @keywords internal
#' @noRd
.verify_downstream_compatibility_category <- function(artifacts) {
  issues <- character()

  for (i in seq_along(artifacts)) {
    a <- artifacts[[i]]
    if (!is_artifact_contract(a)) {
      issues <- c(issues, sprintf(
        "Artifact %d cannot be downstream-compatibility-checked: not an artifact_contract.", i))
      next
    }
    if (!is.character(a$consumer) || length(a$consumer) != 1 || !nzchar(a$consumer)) {
      issues <- c(issues, sprintf(
        "Artifact %d does not declare a downstream consumer and is not ready to cross the boundary.", i))
    }
  }

  list(passed = length(issues) == 0, issues = issues)
}

# ---- VerificationReport (implementation-only object) -----------------------

#' @keywords internal
#' @noRd
.new_verification_report <- function(artifacts, categories) {
  report <- list(
    artifacts = artifacts,
    categories = categories,
    passed = all(vapply(categories, function(c) isTRUE(c$passed), logical(1))),
    artifact_count = length(artifacts)
  )
  class(report) <- "verification_report"
  report
}

#' Print a Discovery Output VerificationReport
#'
#' `VerificationReport` is an implementation-only object (see
#' [DiscoveryOutputVerifier()]); it is never a Discovery, Framework, or
#' IDS artifact, and never crosses the Discovery -> Modeling boundary.
#' This print method exists for local inspection/debugging only.
#'
#' @param x A `verification_report` object.
#' @param ... Additional arguments (currently unused).
#'
#' @return `x`, invisibly.
#'
#' @export
print.verification_report <- function(x, ...) {
  cat("<verification_report>\n")
  cat("  artifact_count: ", x$artifact_count, "\n", sep = "")
  cat("  passed:         ", x$passed, "\n", sep = "")
  for (cat_name in names(x$categories)) {
    cat_result <- x$categories[[cat_name]]
    cat("  - ", cat_name, ": ", if (isTRUE(cat_result$passed)) "PASS" else "FAIL", "\n", sep = "")
    if (length(cat_result$issues) > 0) {
      for (issue in cat_result$issues) {
        cat("      * ", issue, "\n", sep = "")
      }
    }
  }
  invisible(x)
}

# ---- Public API: DiscoveryOutputVerifier ------------------------------------

#' Discovery Output Verifier
#'
#' The canonical, single verification entry point for the Discovery
#' Output Boundary Layer. Verifies a collection of Discovery
#' contractual artifacts -- exactly the artifact(s) actually produced
#' upstream (e.g. by [execute_discovery_pipeline()]) -- across five
#' verification categories: contract verification, interface
#' verification, completeness verification, traceability verification,
#' and downstream compatibility verification.
#'
#' Verification follows a strict collect-all policy: every category is
#' evaluated for every supplied artifact before this function returns,
#' and all detected issues are recorded in the returned
#' `VerificationReport`. Fail-fast behaviour is never used -- this
#' function does not call `stop()` for verification failures; it
#' reports them in the returned report's `passed` field and per-category
#' `issues`.
#'
#' This function performs no Discovery processing and generates no new
#' Discovery artifacts; it does not assume any specific count or
#' taxonomy of artifacts (e.g. it does not require a Discovery
#' Candidate / Discovery Evidence pair) -- it verifies exactly the
#' artifact(s) supplied.
#'
#' @param artifacts A single `artifact_contract` object, or a list of
#'   such objects, as actually produced by upstream Discovery modules.
#'
#' @return A `verification_report` object (an implementation-only
#'   object; never a Discovery, Framework, or IDS artifact, and never
#'   exported across the Discovery -> Modeling boundary), with fields
#'   `artifacts` (the original artifacts, unchanged), `categories` (a
#'   named list of the five category results), `passed` (overall
#'   logical result), and `artifact_count`.
#'
#' @export
DiscoveryOutputVerifier <- function(artifacts) {

  if (is_artifact_contract(artifacts)) {
    artifacts <- list(artifacts)
  }

  if (!is.list(artifacts)) {
    stop("'artifacts' must be an artifact_contract object or a list of ",
         "artifact_contract objects.", call. = FALSE)
  }

  categories <- list(
    contract                 = .verify_contract_category(artifacts),
    interface                = .verify_interface_category(artifacts),
    completeness              = .verify_completeness_category(artifacts),
    traceability              = .verify_traceability_category(artifacts),
    downstream_compatibility = .verify_downstream_compatibility_category(artifacts)
  )

  .new_verification_report(artifacts, categories)
}

# ---- Public API: DiscoveryOutputExporter ------------------------------------

#' Discovery Output Exporter
#'
#' The canonical, single export component for the Discovery Output
#' Boundary Layer. Accepts a collection of Discovery contractual
#' artifacts together with the `VerificationReport` produced for that
#' exact collection by [DiscoveryOutputVerifier()], and -- only if
#' verification passed -- returns the original artifact collection
#' completely unchanged (Output Immutability Principle). The
#' `VerificationReport` itself never crosses the boundary; only the
#' verified artifacts are returned.
#'
#' Export is blocked (an error is raised) if verification did not pass,
#' or if `artifacts` does not match the exact collection recorded in
#' `report` (preventing a verified report from being reused to export a
#' different, unverified artifact collection).
#'
#' No artifact relabeling, merging, splitting, or wrapper object is
#' introduced; the exporter preserves the original artifact collection
#' exactly as received.
#'
#' @param artifacts A single `artifact_contract` object, or a list of
#'   such objects -- the same collection that was passed to
#'   [DiscoveryOutputVerifier()] to produce `report`.
#' @param report The `verification_report` object returned by
#'   [DiscoveryOutputVerifier()] for `artifacts`.
#'
#' @return The verified artifact collection, exactly as received (same
#'   list structure as `report$artifacts`).
#'
#' @export
DiscoveryOutputExporter <- function(artifacts, report) {

  if (is_artifact_contract(artifacts)) {
    artifacts <- list(artifacts)
  }

  if (!inherits(report, "verification_report")) {
    stop("'report' must be a verification_report object, as returned by ",
         "DiscoveryOutputVerifier().", call. = FALSE)
  }

  if (!identical(artifacts, report$artifacts)) {
    stop("'artifacts' does not match the exact artifact collection that ",
         "was verified in 'report'. Re-run DiscoveryOutputVerifier() on ",
         "the artifacts you intend to export.", call. = FALSE)
  }

  if (!isTRUE(report$passed)) {
    all_issues <- unlist(lapply(report$categories, function(c) c$issues))
    stop("Export blocked: Discovery output verification did not pass. ",
         "Issues:\n", paste("  -", all_issues, collapse = "\n"), call. = FALSE)
  }

  report$artifacts
}
