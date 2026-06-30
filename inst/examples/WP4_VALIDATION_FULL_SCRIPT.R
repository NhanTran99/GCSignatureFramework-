# WP4_VALIDATION_FULL_SCRIPT.R
#
# Complete Reproducibility Validation Script
# Modernized Biomarker Discovery Framework — WP4
#
# Purpose
# -------
# Reproduces the full canonical validation sequence defined in
# WP4_REPRODUCIBILITY_RELEASE_PLAN.md, Section 3:
#
#   Clone Repository
#         |
#   Restore Dependencies
#         |
#   Install Package
#         |
#   Load Package
#         |
#   Execute Basic Example (smoke test)
#         |
#   Collect Validation Evidence
#
# Intended use: run this script on a CLEAN machine / clean R session
# (no prior renv cache, no prior package installation) to reproduce
# the repository from scratch and collect evidence per WP4 Section 7.
#
# This script does NOT modify the repository. It only clones, restores,
# installs, loads, and runs the canonical smoke test.

# =======================================================================
# STEP 0 — Environment notes (read before running)
# =======================================================================
# - Run this in a FRESH R session.
# - Run Step 1 (clone) from a terminal / Git Bash, OR adapt Step 1 below
#   to run from within R via system().
# - Requires R >= 4.4 (per DESCRIPTION Depends: R (>= 4.4)).
# - Requires Git installed and on PATH.
# - If prompted for a CRAN mirror, choose "0-Cloud [https://cloud.r-project.org]".
# - If renv reports the project is "not activated yet", choose option 1
#   ("Activate the project and use the project library").

# =======================================================================
# STEP 1 — Clone repository
# =======================================================================
# Run in terminal / Git Bash (recommended), NOT inside this R script,
# since cloning typically happens before R is even opened:
#
#   git clone https://github.com/<username>/GCSignatureFramework.git clean_test
#   cd clean_test
#
# Then open R / RStudio with the working directory set to that clone.
#
# Alternatively, from within R (uncomment to use):
#
# repo_url <- "https://github.com/<username>/GCSignatureFramework.git"
# clone_dir <- "clean_test"
# system(sprintf("git clone %s %s", repo_url, clone_dir))
# setwd(clone_dir)

# Record the commit hash under validation (WP4 Section 7 evidence requirement)
commit_hash <- tryCatch(
  system("git rev-parse HEAD", intern = TRUE),
  error = function(e) NA_character_
)
cat("Validating commit:", commit_hash, "\n")

# =======================================================================
# STEP 2 — Confirm working directory is the package root
# =======================================================================
stopifnot(
  "DESCRIPTION file not found -- set working directory to the package root" =
    file.exists("DESCRIPTION")
)

desc_lines <- readLines("DESCRIPTION")
cat("== DESCRIPTION ==\n")
cat(desc_lines, sep = "\n")
cat("\n")

# =======================================================================
# STEP 3 — Restore dependencies (renv)
# =======================================================================
cat("\n[Step 3] Restoring dependencies via renv...\n")

if (!requireNamespace("renv", quietly = TRUE)) {
  install.packages("renv")
}

# If renv reports the project is not yet activated, you will be prompted
# interactively. Choose option 1 ("Activate the project and use the
# project library"). The R session may restart after activation --
# this is expected. Re-run from here after the restart if needed.
renv::activate()

status <- renv::status()
print(status)

renv::restore()

# =======================================================================
# STEP 4 — Install package
# =======================================================================
cat("\n[Step 4] Installing package...\n")

if (!requireNamespace("devtools", quietly = TRUE)) {
  install.packages("devtools")
}

devtools::document()   # regenerate NAMESPACE/man from roxygen comments
devtools::install()    # build and install the package

# =======================================================================
# STEP 5 — Load package
# =======================================================================
cat("\n[Step 5] Loading package...\n")

pkg_name <- "GCSignatureFramework"

loaded <- requireNamespace(pkg_name, quietly = TRUE)

if (!loaded) {
  stop(
    sprintf(
      "WP4 validation FAILED at Step 5: package '%s' could not be loaded. ",
      pkg_name
    ),
    "Confirm devtools::install() completed successfully with no errors."
  )
}

library(GCSignatureFramework)
cat(sprintf("    OK -- package '%s' loaded successfully.\n", pkg_name))

# =======================================================================
# STEP 6 — Execute basic example (canonical smoke test)
# =======================================================================
cat("\n[Step 6] Running canonical smoke test...\n\n")

smoke_test_path <- system.file(
  "examples", "smoke_test.R",
  package = "GCSignatureFramework"
)

stopifnot(
  "smoke_test.R not found in installed package -- check inst/examples/" =
    nzchar(smoke_test_path)
)

source(smoke_test_path)

# =======================================================================
# STEP 7 — Collect reproducibility evidence (WP4 Section 7)
# =======================================================================
cat("\n[Step 7] Collecting reproducibility evidence...\n\n")

cat("== Commit hash validated ==\n")
cat(commit_hash, "\n\n")

cat("== sessionInfo() ==\n")
print(sessionInfo())

cat("\n== renv::status() (post-restore) ==\n")
print(renv::status())

cat("\n== WP4 VALIDATION COMPLETE ==\n")
cat("If all steps above completed without error, WP4 evidence collection ")
cat("is complete. Save this console output (or redirect to a log file) ")
cat("as the WP4 Reproducibility Evidence artifact.\n")

# -----------------------------------------------------------------------
# TIP: To capture this entire run as a log file for WP4 evidence, wrap
# the whole script invocation like this from a fresh R session:
#
#   sink("WP4_validation_log.txt", split = TRUE)
#   source("WP4_VALIDATION_FULL_SCRIPT.R")
#   sink()
# -----------------------------------------------------------------------
