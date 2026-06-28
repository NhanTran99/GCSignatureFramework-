noop_executor <- function(...) invisible(NULL)

# ---- Pipeline construction -------------------------------------------

test_that("create_discovery_pipeline constructs an empty pipeline", {
  p <- create_discovery_pipeline("my_pipeline")

  expect_true(is_discovery_pipeline(p))
  expect_identical(p$pipeline_name, "my_pipeline")
  expect_identical(p$stages, list())
  expect_identical(p$metadata, list())
  expect_identical(p$status, "created")
})

test_that("create_discovery_pipeline accepts metadata, e.g. framework_layer", {
  p <- create_discovery_pipeline("my_pipeline", metadata = list(framework_layer = "discovery"))
  expect_identical(p$metadata$framework_layer, "discovery")
})

test_that("create_discovery_pipeline rejects invalid pipeline_name", {
  expect_error(create_discovery_pipeline(123))
  expect_error(create_discovery_pipeline(""))
  expect_error(create_discovery_pipeline(c("a", "b")))
})

test_that("create_discovery_pipeline rejects non-list metadata", {
  expect_error(create_discovery_pipeline("p", metadata = "not a list"))
})

# ---- Stage registration -----------------------------------------------

test_that("register_discovery_stage adds a stage and updates status", {
  p <- create_discovery_pipeline("p")
  p <- register_discovery_stage(p, "load", outputs = "dataset", executor = noop_executor)

  expect_identical(names(p$stages), "load")
  expect_identical(p$stages[["load"]]$stage_name, "load")
  expect_identical(p$stages[["load"]]$outputs, "dataset")
  expect_identical(p$status, "stages_registered")
})

test_that("register_discovery_stage rejects duplicate stage_name", {
  p <- create_discovery_pipeline("p")
  p <- register_discovery_stage(p, "load", outputs = "dataset", executor = noop_executor)
  expect_error(register_discovery_stage(p, "load", executor = noop_executor))
})

test_that("register_discovery_stage rejects a non-discovery_pipeline object", {
  expect_error(register_discovery_stage(list(), "load", executor = noop_executor))
})

test_that("register_discovery_stage rejects a missing or non-function executor", {
  p <- create_discovery_pipeline("p")
  expect_error(register_discovery_stage(p, "load"))
  expect_error(register_discovery_stage(p, "load", executor = "not a function"))
})

test_that("register_discovery_stage rejects non-character inputs/outputs/dependencies", {
  p <- create_discovery_pipeline("p")
  expect_error(register_discovery_stage(p, "load", inputs = 1, executor = noop_executor))
  expect_error(register_discovery_stage(p, "load", outputs = 1, executor = noop_executor))
  expect_error(register_discovery_stage(p, "load", dependencies = 1, executor = noop_executor))
})

# ---- Dependency resolution (DAG-ready) --------------------------------

test_that("resolve_pipeline_dependencies orders a simple linear pipeline correctly", {
  p <- create_discovery_pipeline("p")
  p <- register_discovery_stage(p, "load", outputs = "dataset", executor = noop_executor)
  p <- register_discovery_stage(p, "filter", inputs = "dataset", outputs = "filtered",
                                 dependencies = "load", executor = noop_executor)

  order <- resolve_pipeline_dependencies(p)
  expect_identical(order, c("load", "filter"))
})

test_that("resolve_pipeline_dependencies supports branching DAG structures", {
  p <- create_discovery_pipeline("p")
  p <- register_discovery_stage(p, "load", outputs = "dataset", executor = noop_executor)
  p <- register_discovery_stage(p, "branch_a", inputs = "dataset", outputs = "a_out",
                                 dependencies = "load", executor = noop_executor)
  p <- register_discovery_stage(p, "branch_b", inputs = "dataset", outputs = "b_out",
                                 dependencies = "load", executor = noop_executor)
  p <- register_discovery_stage(p, "merge", inputs = c("a_out", "b_out"), outputs = "merged",
                                 dependencies = c("branch_a", "branch_b"), executor = noop_executor)

  order <- resolve_pipeline_dependencies(p)

  expect_identical(order[1], "load")
  expect_identical(order[4], "merge")
  expect_setequal(order[2:3], c("branch_a", "branch_b"))
  expect_true(which(order == "load") < which(order == "branch_a"))
  expect_true(which(order == "branch_a") < which(order == "merge"))
  expect_true(which(order == "branch_b") < which(order == "merge"))
})

test_that("resolve_pipeline_dependencies returns an empty order for an empty pipeline", {
  p <- create_discovery_pipeline("p")
  expect_identical(resolve_pipeline_dependencies(p), character())
})

test_that("resolve_pipeline_dependencies rejects an unknown dependency", {
  p <- create_discovery_pipeline("p")
  p <- register_discovery_stage(p, "filter", dependencies = "does_not_exist", executor = noop_executor)
  expect_error(resolve_pipeline_dependencies(p))
})

test_that("resolve_pipeline_dependencies rejects input/output incompatibility", {
  p <- create_discovery_pipeline("p")
  p <- register_discovery_stage(p, "load", outputs = "dataset", executor = noop_executor)
  p <- register_discovery_stage(p, "filter", inputs = "not_produced", dependencies = "load",
                                 executor = noop_executor)
  expect_error(resolve_pipeline_dependencies(p))
})

test_that("resolve_pipeline_dependencies rejects inputs declared with no dependencies", {
  p <- create_discovery_pipeline("p")
  p <- register_discovery_stage(p, "filter", inputs = "dataset", executor = noop_executor)
  expect_error(resolve_pipeline_dependencies(p))
})

test_that("resolve_pipeline_dependencies detects a cyclic dependency", {
  p <- create_discovery_pipeline("p")
  p <- register_discovery_stage(p, "a", dependencies = "b", executor = noop_executor)
  p <- register_discovery_stage(p, "b", dependencies = "a", executor = noop_executor)
  expect_error(resolve_pipeline_dependencies(p))
})

# ---- Pipeline validation -----------------------------------------------

test_that("validate_discovery_pipeline accepts a valid pipeline", {
  p <- create_discovery_pipeline("p")
  p <- register_discovery_stage(p, "load", outputs = "dataset", executor = noop_executor)
  expect_true(isTRUE(validate_discovery_pipeline(p)))
})

test_that("validate_discovery_pipeline rejects a non-discovery_pipeline object", {
  expect_error(validate_discovery_pipeline(list()))
})

test_that("validate_discovery_pipeline rejects a pipeline missing required fields", {
  broken <- list(pipeline_name = "p", stages = list(), metadata = list())
  class(broken) <- "discovery_pipeline"
  expect_error(validate_discovery_pipeline(broken))
})

test_that("validate_discovery_pipeline rejects a stage missing required fields", {
  p <- create_discovery_pipeline("p")
  p$stages[["bad"]] <- list(stage_name = "bad")
  expect_error(validate_discovery_pipeline(p))
})

test_that("validate_discovery_pipeline propagates dependency-graph errors", {
  p <- create_discovery_pipeline("p")
  p <- register_discovery_stage(p, "a", dependencies = "missing", executor = noop_executor)
  expect_error(validate_discovery_pipeline(p))
})

# ---- run_discovery_pipeline (orchestration only; no computation) -----

test_that("run_discovery_pipeline records execution order without invoking executors", {
  executed_flag <- FALSE
  side_effect_executor <- function(...) {
    executed_flag <<- TRUE
    invisible(NULL)
  }

  p <- create_discovery_pipeline("p")
  p <- register_discovery_stage(p, "load", outputs = "dataset", executor = side_effect_executor)
  p <- register_discovery_stage(p, "filter", inputs = "dataset", outputs = "filtered",
                                 dependencies = "load", executor = side_effect_executor)

  result <- run_discovery_pipeline(p)

  expect_identical(result$status, "executed")
  expect_identical(result$metadata$execution_order, c("load", "filter"))
  expect_false(executed_flag) # confirms no computation/executor invocation occurred
})

test_that("run_discovery_pipeline raises an error for an invalid pipeline", {
  p <- create_discovery_pipeline("p")
  p <- register_discovery_stage(p, "a", dependencies = "missing", executor = noop_executor)
  expect_error(run_discovery_pipeline(p))
})

# ---- Predicate ----------------------------------------------------------

test_that("is_discovery_pipeline correctly distinguishes discovery_pipeline objects", {
  p <- create_discovery_pipeline("p")
  expect_true(is_discovery_pipeline(p))
  expect_false(is_discovery_pipeline(list()))
  expect_false(is_discovery_pipeline(NULL))
})

# ---- Print method --------------------------------------------------------

test_that("print.discovery_pipeline executes without error and is invisible", {
  p <- create_discovery_pipeline("p")
  p <- register_discovery_stage(p, "load", outputs = "dataset", executor = noop_executor)

  expect_output(print(p), "discovery_pipeline")
  expect_output(print(p), "load")
  expect_invisible(print(p))
})

# ---- Contract consistency ------------------------------------------------
# Confirms the Pre-Implementation Decision Record: Discovery context is
# represented via metadata$framework_layer, with contract_type remaining
# "artifact" -- fully consistent with the LOCKED Module 02 validator, with
# no change to Module 02 whatsoever.

test_that("Discovery artifacts use create_artifact_contract() with metadata$framework_layer, not a new contract_type", {
  discovery_artifact <- create_artifact_contract(
    producer = "discovery_pipeline",
    consumer = "modeling_pipeline",
    outputs = list("discovery_candidate"),
    metadata = list(framework_layer = "discovery")
  )

  expect_true(is_artifact_contract(discovery_artifact))
  expect_identical(discovery_artifact$contract_type, "artifact")
  expect_identical(discovery_artifact$metadata$framework_layer, "discovery")
  expect_true(isTRUE(validate_artifact_contract(discovery_artifact)))
})

test_that("a contract_type of 'discovery' would be rejected by the LOCKED Module 02 validator", {
  invalid <- list(
    contract_type = "discovery", producer = "A", consumer = "B",
    inputs = list(), outputs = list(), dependencies = list(), metadata = list()
  )
  expect_error(validate_artifact_contract(invalid))
})
