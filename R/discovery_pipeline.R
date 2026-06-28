# discovery_pipeline.R
#
# Discovery Framework Layer (Module 03)
#
# Implements the domain-agnostic orchestration layer for Discovery
# pipelines: pipeline construction, stage registration, dependency
# resolution (DAG-ready), and pipeline validation/run. This file
# contains no scientific, biological, or statistical computation --
# only workflow representation and orchestration validation, per
# IDS-002_Discovery_Implementation.md and the Module 03 Coding Prompt.
#
# Per the Module 03 "Contract-first Principle" (as revised in the
# Pre-Implementation Decision Record, Execution/Module_03/Prompt.md):
# whenever a Discovery *artifact* (a contractual object exchanged
# between a producer and a consumer) is required, it shall be
# constructed via the existing, LOCKED `create_artifact_contract()`
# from Module 02, with Discovery context recorded under
# `metadata$framework_layer = "discovery"` -- never via a new
# `contract_type` value and never via a new object model. The
# Discovery Pipeline object defined in this file is the orchestration
# representation itself (its own minimal schema, per the Coding
# Prompt's "Pipeline Representation" section) and is distinct from,
# and does not replace, the Framework Contract object model.

#' Create a Discovery Pipeline
#'
#' Constructs an empty Discovery Pipeline orchestration object. A
#' Discovery Pipeline is a domain-agnostic container for registered
#' stages; it performs no computation itself.
#'
#' @param pipeline_name Character scalar. A unique, human-readable
#'   name for the pipeline.
#' @param metadata List of pipeline-level metadata. Defaults to an
#'   empty list. Framework-layer or other contextual information may
#'   be recorded here (e.g. `list(framework_layer = "discovery")`),
#'   consistent with how context is recorded on Framework Contracts.
#'
#' @return An object of class `"discovery_pipeline"`, with fields
#'   `pipeline_name`, `stages` (initially an empty named list),
#'   `metadata`, and `status` (initially `"created"`).
#'
#' @export
create_discovery_pipeline <- function(pipeline_name, metadata = list()) {

  if (!is.character(pipeline_name) || length(pipeline_name) != 1 ||
      !nzchar(pipeline_name)) {
    stop("'pipeline_name' must be a single non-empty character string.",
         call. = FALSE)
  }

  if (!is.list(metadata)) {
    stop("'metadata' must be a list.", call. = FALSE)
  }

  pipeline <- list(
    pipeline_name = pipeline_name,
    stages = list(),
    metadata = metadata,
    status = "created"
  )

  class(pipeline) <- "discovery_pipeline"

  pipeline
}

#' Register a Discovery Pipeline Stage
#'
#' Adds a stage to a Discovery Pipeline. A stage is a named
#' orchestration unit declaring its abstract inputs, outputs, and
#' dependencies on other stages. The `executor` is a placeholder only;
#' no executable algorithm is attached or invoked by this function or
#' by this module.
#'
#' @param pipeline A `discovery_pipeline` object, as returned by
#'   [create_discovery_pipeline()].
#' @param stage_name Character scalar. A unique name for the stage
#'   within the pipeline.
#' @param inputs Character vector of abstract input names required by
#'   this stage. Defaults to `character()`.
#' @param outputs Character vector of abstract output names produced
#'   by this stage. Defaults to `character()`.
#' @param dependencies Character vector of `stage_name`s that this
#'   stage depends on. Defaults to `character()`.
#' @param executor A function serving as a placeholder for future
#'   algorithm execution. This module never invokes it; no algorithm
#'   may be attached here.
#'
#' @return The updated `discovery_pipeline` object, with the new stage
#'   added and `status` set to `"stages_registered"`.
#'
#' @export
register_discovery_stage <- function(pipeline,
                                      stage_name,
                                      inputs = character(),
                                      outputs = character(),
                                      dependencies = character(),
                                      executor) {

  if (!is_discovery_pipeline(pipeline)) {
    stop("'pipeline' must be a discovery_pipeline object.", call. = FALSE)
  }

  if (!is.character(stage_name) || length(stage_name) != 1 ||
      !nzchar(stage_name)) {
    stop("'stage_name' must be a single non-empty character string.",
         call. = FALSE)
  }

  if (stage_name %in% names(pipeline$stages)) {
    stop("Stage '", stage_name, "' is already registered in this pipeline.",
         call. = FALSE)
  }

  if (!is.character(inputs)) {
    stop("'inputs' must be a character vector.", call. = FALSE)
  }

  if (!is.character(outputs)) {
    stop("'outputs' must be a character vector.", call. = FALSE)
  }

  if (!is.character(dependencies)) {
    stop("'dependencies' must be a character vector.", call. = FALSE)
  }

  if (missing(executor) || !is.function(executor)) {
    stop("'executor' must be a function. It remains a placeholder only ",
         "-- no algorithm may be attached at this module.", call. = FALSE)
  }

  stage <- list(
    stage_name = stage_name,
    inputs = inputs,
    outputs = outputs,
    dependencies = dependencies,
    executor = executor
  )

  pipeline$stages[[stage_name]] <- stage
  pipeline$status <- "stages_registered"

  pipeline
}

#' Resolve Discovery Pipeline Stage Dependencies
#'
#' Performs orchestration-only validation of a Discovery Pipeline's
#' stage dependency graph: verifies that every declared dependency
#' refers to a registered stage, verifies input/output compatibility
#' between dependent stages, detects cyclic dependencies, and computes
#' a valid topological execution order. This function never executes
#' any stage; it performs validation and ordering only. The underlying
#' dependency graph is a general Directed Acyclic Graph (DAG); linear
#' pipelines are a valid special case.
#'
#' @param pipeline A `discovery_pipeline` object.
#'
#' @return A character vector giving a valid topological execution
#'   order of stage names (registration order is not guaranteed to be
#'   preserved). Raises an error via `stop()` if any dependency is
#'   unknown, any required input is not produced by a declared
#'   dependency, or a cyclic dependency is detected.
#'
#' @export
resolve_pipeline_dependencies <- function(pipeline) {

  if (!is_discovery_pipeline(pipeline)) {
    stop("'pipeline' must be a discovery_pipeline object.", call. = FALSE)
  }

  stages <- pipeline$stages
  stage_names <- names(stages)

  if (length(stage_names) == 0) {
    return(character())
  }

  # Verify dependency consistency: every declared dependency must be
  # a registered stage.
  for (s in stages) {
    unknown <- setdiff(s$dependencies, stage_names)
    if (length(unknown) > 0) {
      stop("Stage '", s$stage_name, "' declares unknown dependency/dependencies: ",
           paste(unknown, collapse = ", "), call. = FALSE)
    }
  }

  # Verify input/output compatibility: every input a stage declares
  # must be produced by the outputs of (at least one of) its declared
  # dependencies.
  for (s in stages) {
    if (length(s$inputs) > 0 && length(s$dependencies) > 0) {
      available_outputs <- unlist(lapply(stages[s$dependencies], function(d) d$outputs))
      missing_inputs <- setdiff(s$inputs, available_outputs)
      if (length(missing_inputs) > 0) {
        stop("Stage '", s$stage_name, "' requires input(s) not produced by ",
             "its declared dependencies: ", paste(missing_inputs, collapse = ", "),
             call. = FALSE)
      }
    } else if (length(s$inputs) > 0 && length(s$dependencies) == 0) {
      stop("Stage '", s$stage_name, "' declares input(s) but has no ",
           "dependencies to produce them: ", paste(s$inputs, collapse = ", "),
           call. = FALSE)
    }
  }

  # Topological sort (Kahn's algorithm), with cycle detection.
  resolved <- character()
  remaining <- stage_names

  repeat {
    if (length(remaining) == 0) break

    ready <- remaining[vapply(remaining, function(n) {
      all(stages[[n]]$dependencies %in% resolved)
    }, logical(1))]

    if (length(ready) == 0) {
      stop("Cyclic dependency detected among stage(s): ",
           paste(remaining, collapse = ", "), call. = FALSE)
    }

    resolved <- c(resolved, ready)
    remaining <- setdiff(remaining, ready)
  }

  resolved
}

#' Validate a Discovery Pipeline
#'
#' Verifies the structural integrity of a Discovery Pipeline: required
#' fields, stage field completeness, and dependency-graph validity
#' (via [resolve_pipeline_dependencies()]). Performs no scientific,
#' statistical, or biological validation.
#'
#' @param pipeline A `discovery_pipeline` object.
#'
#' @return Invisibly `TRUE` if `pipeline` is structurally valid;
#'   otherwise raises an error via `stop()`.
#'
#' @export
validate_discovery_pipeline <- function(pipeline) {

  if (!is_discovery_pipeline(pipeline)) {
    stop("'pipeline' must be a discovery_pipeline object.", call. = FALSE)
  }

  required_fields <- c("pipeline_name", "stages", "metadata", "status")
  missing_fields <- setdiff(required_fields, names(pipeline))
  if (length(missing_fields) > 0) {
    stop("Discovery pipeline is missing required field(s): ",
         paste(missing_fields, collapse = ", "), call. = FALSE)
  }

  if (!is.character(pipeline$pipeline_name) || length(pipeline$pipeline_name) != 1 ||
      !nzchar(pipeline$pipeline_name)) {
    stop("Discovery pipeline field 'pipeline_name' must be a single ",
         "non-empty character string.", call. = FALSE)
  }

  if (!is.list(pipeline$stages)) {
    stop("Discovery pipeline field 'stages' must be a list.", call. = FALSE)
  }

  if (!is.list(pipeline$metadata)) {
    stop("Discovery pipeline field 'metadata' must be a list.", call. = FALSE)
  }

  if (!is.character(pipeline$status) || length(pipeline$status) != 1) {
    stop("Discovery pipeline field 'status' must be a single character string.",
         call. = FALSE)
  }

  required_stage_fields <- c("stage_name", "inputs", "outputs", "dependencies", "executor")
  for (s in pipeline$stages) {
    missing_stage_fields <- setdiff(required_stage_fields, names(s))
    if (length(missing_stage_fields) > 0) {
      stop("A stage in the pipeline is missing required field(s): ",
           paste(missing_stage_fields, collapse = ", "), call. = FALSE)
    }
    if (!is.function(s$executor)) {
      stop("Stage '", s$stage_name, "' field 'executor' must be a function.",
           call. = FALSE)
    }
  }

  # Dependency-graph validity (raises an informative error on failure).
  resolve_pipeline_dependencies(pipeline)

  invisible(TRUE)
}

#' Run a Discovery Pipeline (Orchestration Only)
#'
#' Performs an orchestration-only "run" of a Discovery Pipeline:
#' validates the pipeline, resolves a valid stage execution order, and
#' records that order on the pipeline's metadata and status. This
#' function does **not** invoke any stage's `executor`, and performs no
#' computation of any kind; the placeholder executors registered via
#' [register_discovery_stage()] are never called by this module.
#'
#' @param pipeline A `discovery_pipeline` object.
#'
#' @return The updated `discovery_pipeline` object, with `status` set
#'   to `"executed"` and `metadata$execution_order` set to the
#'   resolved stage execution order (character vector of stage names).
#'
#' @export
run_discovery_pipeline <- function(pipeline) {

  validate_discovery_pipeline(pipeline)

  execution_order <- resolve_pipeline_dependencies(pipeline)

  pipeline$status <- "executed"
  pipeline$metadata$execution_order <- execution_order

  pipeline
}

#' Test whether an object is a Discovery Pipeline
#'
#' @param x Object to test.
#'
#' @return `TRUE` if `x` inherits from class `"discovery_pipeline"`,
#'   `FALSE` otherwise.
#'
#' @export
is_discovery_pipeline <- function(x) {
  inherits(x, "discovery_pipeline")
}

#' Print a Discovery Pipeline
#'
#' @param x A `discovery_pipeline` object.
#' @param ... Additional arguments (currently unused).
#'
#' @return `x`, invisibly.
#'
#' @export
print.discovery_pipeline <- function(x, ...) {
  cat("<discovery_pipeline>\n")
  cat("  pipeline_name: ", x$pipeline_name, "\n", sep = "")
  cat("  status:        ", x$status, "\n", sep = "")
  cat("  stages:        ", length(x$stages), " stage(s)\n", sep = "")

  if (length(x$stages) > 0) {
    for (s in x$stages) {
      deps <- if (length(s$dependencies) > 0) paste(s$dependencies, collapse = ", ") else "none"
      cat("    - ", s$stage_name, " (depends on: ", deps, ")\n", sep = "")
    }
  }

  cat("  metadata:      ", length(x$metadata), " item(s)\n", sep = "")

  invisible(x)
}
