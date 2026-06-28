# ---- Test fixtures -------------------------------------------------------

valid_discovery_artifact <- function() {
  create_artifact_contract(
    producer = "discovery_pipeline",
    consumer = "modeling_pipeline",
    outputs = list("processed_dataset"),
    metadata = list(framework_layer = "processing")
  )
}

valid_specification <- function() {
  create_model_specification(
    algorithm_id = "placeholder_algorithm",
    parameter_schema = list(param_a = "numeric", param_b = "character")
  )
}

# ---- Model Specification construction --------------------------------------

test_that("create_model_specification constructs a valid specification", {
  spec <- valid_specification()

  expect_s3_class(spec, "model_specification")
  expect_identical(spec$algorithm_id, "placeholder_algorithm")
  expect_identical(spec$parameter_schema, list(param_a = "numeric", param_b = "character"))
})

test_that("create_model_specification uses empty-list defaults", {
  spec <- create_model_specification(algorithm_id = "x")
  expect_identical(spec$parameter_schema, list())
  expect_identical(spec$metadata, list())
})

test_that("create_model_specification rejects an invalid algorithm_id", {
  expect_error(create_model_specification(algorithm_id = 123))
  expect_error(create_model_specification(algorithm_id = ""))
  expect_error(create_model_specification(algorithm_id = c("a", "b")))
})

# ---- Model Specification validation -----------------------------------------

test_that("validate_model_specification accepts a valid specification", {
  expect_true(isTRUE(validate_model_specification(valid_specification())))
})

test_that("validate_model_specification rejects a non-model_specification object", {
  expect_error(validate_model_specification(list()))
  expect_error(validate_model_specification("not a specification"))
})

test_that("validate_model_specification rejects a specification missing required fields", {
  broken <- list(algorithm_id = "x")
  class(broken) <- "model_specification"
  expect_error(validate_model_specification(broken))
})

test_that("validate_model_specification rejects non-list parameter_schema or metadata", {
  broken <- list(algorithm_id = "x", parameter_schema = "not a list", metadata = list())
  class(broken) <- "model_specification"
  expect_error(validate_model_specification(broken))
})

# ---- Model Contract construction --------------------------------------------

test_that("create_model_contract constructs a valid contract", {
  spec <- valid_specification()
  artifact <- valid_discovery_artifact()
  contract <- create_model_contract(spec, artifact)

  expect_s3_class(contract, "model_contract")
  expect_identical(contract$specification, spec)
  expect_identical(contract$discovery_artifacts, list(artifact))
})

test_that("create_model_contract accepts a list of multiple Discovery artifacts", {
  spec <- valid_specification()
  artifacts <- list(valid_discovery_artifact(), valid_discovery_artifact())
  contract <- create_model_contract(spec, artifacts)

  expect_identical(contract$discovery_artifacts, artifacts)
})

test_that("create_model_contract rejects a non-model_specification", {
  expect_error(create_model_contract(list(), valid_discovery_artifact()))
})

test_that("create_model_contract rejects non-artifact_contract discovery_artifacts", {
  spec <- valid_specification()
  expect_error(create_model_contract(spec, list("not an artifact")))
  expect_error(create_model_contract(spec, list()))
})

test_that("create_model_contract does not introduce a new Framework Contract type", {
  spec <- valid_specification()
  contract <- create_model_contract(spec, valid_discovery_artifact())

  # model_contract must NOT be (or be confused with) an artifact_contract,
  # interface_contract, dependency_contract, or verification_contract.
  expect_false(is_artifact_contract(contract))
  expect_false(inherits(contract, "interface_contract"))
  expect_false(inherits(contract, "dependency_contract"))
  expect_false(inherits(contract, "verification_contract"))
  expect_false(identical(class(contract), class(valid_discovery_artifact())))
})

# ---- Model lineage preservation ---------------------------------------------

test_that("create_model_contract preserves Specification lineage exactly", {
  spec <- valid_specification()
  contract <- create_model_contract(spec, valid_discovery_artifact())
  expect_identical(contract$specification, spec)
})

test_that("create_model_contract preserves Discovery artifact lineage exactly", {
  artifact <- valid_discovery_artifact()
  contract <- create_model_contract(valid_specification(), artifact)

  expect_identical(contract$discovery_artifacts[[1]], artifact)
  expect_identical(contract$discovery_artifacts[[1]]$contract_type, "artifact")
  expect_identical(contract$discovery_artifacts[[1]]$metadata$framework_layer, "processing")
})

test_that("create_model_contract preserves Framework metadata", {
  contract <- create_model_contract(
    valid_specification(), valid_discovery_artifact(),
    metadata = list(framework_layer = "modeling")
  )
  expect_identical(contract$metadata$framework_layer, "modeling")
})

# ---- Discovery artifact consumption (read-only; unmodified) ----------------

test_that("create_model_contract does not modify the supplied Discovery artifact", {
  original <- valid_discovery_artifact()
  original_copy <- valid_discovery_artifact()

  create_model_contract(valid_specification(), original)

  expect_identical(original, original_copy)
})

test_that("create_model_contract integrates end-to-end with the verified Discovery output boundary", {
  p <- create_discovery_pipeline("modeling_input_pipeline")
  p <- register_discovery_stage(p, "qc", outputs = "qc_dataset", executor = generic_qc_stage)

  result <- execute_discovery_pipeline(p, data.frame(x = 1:3), consumer = "modeling_pipeline")
  report <- DiscoveryOutputVerifier(result$artifact)
  exported <- DiscoveryOutputExporter(result$artifact, report)

  contract <- create_model_contract(valid_specification(), exported)

  expect_identical(contract$discovery_artifacts, exported)
})

# ---- Model Object construction ----------------------------------------------

test_that("create_model_object constructs a valid object embedding specification and contract", {
  spec <- valid_specification()
  contract <- create_model_contract(spec, valid_discovery_artifact())
  obj <- create_model_object(spec, contract)

  expect_s3_class(obj, "model_object")
  expect_identical(obj$specification, spec)
  expect_identical(obj$contract, contract)
})

test_that("create_model_object rejects a mismatched specification/contract pair", {
  spec1 <- create_model_specification(algorithm_id = "algo_1")
  spec2 <- create_model_specification(algorithm_id = "algo_2")
  contract <- create_model_contract(spec1, valid_discovery_artifact())

  expect_error(create_model_object(spec2, contract))
})

test_that("create_model_object rejects a non-model_contract", {
  expect_error(create_model_object(valid_specification(), list()))
})

# ---- Model Object immutability ----------------------------------------------

test_that("Model Object construction does not modify its inputs", {
  spec <- valid_specification()
  spec_copy <- valid_specification()
  contract <- create_model_contract(spec, valid_discovery_artifact())
  contract_copy <- create_model_contract(spec, valid_discovery_artifact())

  create_model_object(spec, contract)

  expect_identical(spec, spec_copy)
  expect_identical(contract$specification, contract_copy$specification)
})

test_that("no function in this module mutates an existing Model Object", {
  spec <- valid_specification()
  contract <- create_model_contract(spec, valid_discovery_artifact())
  obj <- create_model_object(spec, contract)
  obj_copy <- create_model_object(spec, contract)

  print(obj) # the only other public-facing operation on a model_object

  expect_identical(obj, obj_copy)
})

# ---- S3 methods --------------------------------------------------------------

test_that("print.model_object executes without error and is invisible", {
  spec <- valid_specification()
  contract <- create_model_contract(spec, valid_discovery_artifact())
  obj <- create_model_object(spec, contract)

  expect_output(print(obj), "model_object")
  expect_output(print(obj), "placeholder_algorithm")
  expect_invisible(print(obj))
})

test_that("internal predicate and validator correctly recognize model_object instances", {
  spec <- valid_specification()
  contract <- create_model_contract(spec, valid_discovery_artifact())
  obj <- create_model_object(spec, contract)

  expect_true(.is_model_object(obj))
  expect_false(.is_model_object(list()))
  expect_true(isTRUE(.validate_model_object(obj)))
  expect_error(.validate_model_object(list()))
})

# ---- Public API surface -----------------------------------------------------

test_that("Module 06 exposes exactly the 4 required public functions (plus the print S3 method)", {
  ns <- asNamespace("GCSignatureFramework")
  exported <- getNamespaceExports(ns)

  module_06_functions <- c(
    "create_model_specification", "validate_model_specification",
    "create_model_contract", "create_model_object"
  )

  for (fn in module_06_functions) {
    expect_true(fn %in% exported)
  }

  # Internal helpers must NOT be part of the public API.
  expect_false(".is_model_specification" %in% exported)
  expect_false(".is_model_object" %in% exported)
  expect_false(".validate_model_object" %in% exported)
})
