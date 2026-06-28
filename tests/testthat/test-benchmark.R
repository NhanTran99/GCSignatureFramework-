# ---- Test fixtures -------------------------------------------------------

valid_discovery_artifact <- function() {
  create_artifact_contract(
    producer = "discovery_pipeline",
    consumer = "modeling_pipeline",
    outputs = list("processed_dataset"),
    metadata = list(framework_layer = "processing")
  )
}

valid_training_object <- function() {
  spec <- create_model_specification(
    algorithm_id = "placeholder_algorithm",
    parameter_schema = list(param_a = "numeric")
  )
  contract <- create_model_contract(spec, valid_discovery_artifact())
  mo <- create_model_object(spec, contract)
  create_training_object(train_model(mo), mo)
}

valid_validation_evidence <- function() {
  output <- create_model_output(valid_training_object())
  vo <- create_validation_object(output$model_candidate, output$modeling_evidence)
  run_validation(vo)$validation_evidence
}

valid_benchmark_object <- function() {
  create_benchmark_object(valid_validation_evidence())
}

# ---- Benchmark Object construction --------------------------------------------

test_that("create_benchmark_object constructs a valid Benchmark Object", {
  ve <- valid_validation_evidence()
  bo <- create_benchmark_object(ve)

  expect_s3_class(bo, "benchmark_object")
  expect_identical(bo$validation_evidence, ve)
  expect_identical(bo$benchmark_components, list())
  expect_identical(bo$execution_metadata, list())
})

test_that("create_benchmark_object rejects a non-validation_evidence", {
  expect_error(create_benchmark_object(list()))
})

# ---- Benchmark Object is never a Framework artifact -------------------------

test_that("Benchmark Object is not exposed as a Framework artifact", {
  bo <- valid_benchmark_object()
  expect_false(is_artifact_contract(bo))
  expect_false(inherits(bo, "benchmark_evidence"))
})

# ---- Workflow orchestration: run_benchmark() --------------------------------

test_that("run_benchmark orchestrates execution and returns both object and evidence", {
  result <- run_benchmark(valid_benchmark_object())

  expect_type(result, "list")
  expect_true(all(c("benchmark_object", "benchmark_evidence") %in% names(result)))
  expect_s3_class(result$benchmark_object, "benchmark_object")
  expect_s3_class(result$benchmark_evidence, "benchmark_evidence")
})

test_that("run_benchmark populates benchmark_components via the default benchmarker", {
  result <- run_benchmark(valid_benchmark_object())
  expect_identical(names(result$benchmark_object$benchmark_components), "structural_check")
  expect_true(result$benchmark_object$benchmark_components$structural_check$passed)
})

test_that("run_benchmark records execution_metadata", {
  result <- run_benchmark(valid_benchmark_object())
  expect_true(isTRUE(result$benchmark_object$execution_metadata$executed))
})

# ---- Default benchmarker: generic implementation only -----------------------

test_that("the default benchmarker performs no ROC/AUC/statistical/ML methodology", {
  result <- run_benchmark(valid_benchmark_object())
  details <- result$benchmark_object$benchmark_components$structural_check$details
  expect_true(grepl("generic structural check only", details))
  expect_true(result$benchmark_object$benchmark_components$structural_check$passed)
})

# ---- Custom benchmarker (callback pattern) ----------------------------------

test_that("run_benchmark invokes a caller-supplied benchmarker", {
  custom_benchmarker <- function(benchmark_object, ...) {
    list(custom_component = list(passed = TRUE, note = "custom"))
  }

  result <- run_benchmark(valid_benchmark_object(), benchmarker = custom_benchmarker)
  expect_identical(names(result$benchmark_object$benchmark_components), "custom_component")
})

test_that("run_benchmark forwards additional arguments to the benchmarker", {
  benchmarker <- function(benchmark_object, threshold = 0, ...) {
    list(check = list(threshold_used = threshold))
  }

  result <- run_benchmark(valid_benchmark_object(), benchmarker = benchmarker, threshold = 9)
  expect_identical(result$benchmark_object$benchmark_components$check$threshold_used, 9)
})

# ---- Multiple independent benchmark components (Section 8) ------------------

test_that("run_benchmark supports multiple independent benchmark components", {
  benchmarker <- function(benchmark_object, ...) {
    list(
      component_a = list(passed = TRUE),
      component_b = list(passed = TRUE),
      component_c = list(passed = FALSE, reason = "example")
    )
  }

  result <- run_benchmark(valid_benchmark_object(), benchmarker = benchmarker)
  components <- result$benchmark_object$benchmark_components

  expect_identical(names(components), c("component_a", "component_b", "component_c"))
  expect_false(components$component_c$passed)
})

# ---- Failure handling --------------------------------------------------------

test_that("run_benchmark rejects a non-benchmark_object input", {
  expect_error(run_benchmark(list()))
})

test_that("run_benchmark rejects a non-function benchmarker", {
  expect_error(run_benchmark(valid_benchmark_object(), benchmarker = "not a function"))
})

test_that("run_benchmark rejects a benchmarker that does not return a list", {
  bad_benchmarker <- function(benchmark_object, ...) "not a list"
  expect_error(run_benchmark(valid_benchmark_object(), benchmarker = bad_benchmarker))
})

# ---- Read-only consumption of Validation Evidence ---------------------------

test_that("create_benchmark_object does not modify the supplied Validation Evidence", {
  ve <- valid_validation_evidence()
  ve_copy <- ve

  create_benchmark_object(ve)

  expect_identical(ve, ve_copy)
})

test_that("run_benchmark does not modify the Validation Evidence embedded in the Benchmark Object", {
  bo <- valid_benchmark_object()
  ve_copy <- bo$validation_evidence

  run_benchmark(bo)

  expect_identical(bo$validation_evidence, ve_copy)
})

# ---- Benchmark Evidence construction ----------------------------------------

test_that("create_benchmark_evidence constructs a valid Benchmark Evidence", {
  result <- run_benchmark(valid_benchmark_object())
  evidence <- result$benchmark_evidence

  expect_true(is_artifact_contract(evidence))
  expect_s3_class(evidence, "benchmark_evidence")
  expect_identical(evidence$contract_type, "artifact")
  expect_identical(evidence$metadata$framework_layer, "validation_benchmark")
  expect_identical(evidence$metadata$artifact_role, "benchmark_evidence")
})

test_that("create_benchmark_evidence defaults producer/consumer correctly", {
  result <- run_benchmark(valid_benchmark_object())
  expect_identical(result$benchmark_evidence$producer, "placeholder_algorithm")
  expect_identical(result$benchmark_evidence$consumer, "candidate_selection")
})

test_that("create_benchmark_evidence rejects forbidden metadata content", {
  bo <- valid_benchmark_object()
  expect_error(create_benchmark_evidence(bo, metadata = list(candidate_selection = "x")))
  expect_error(create_benchmark_evidence(bo, metadata = list(validated_candidate = "x")))
  expect_error(create_benchmark_evidence(bo, metadata = list(final_recommendation = "x")))
  expect_error(create_benchmark_evidence(bo, metadata = list(model_approval = "x")))
})

test_that("create_benchmark_evidence introduces no new Framework Contract type", {
  result <- run_benchmark(valid_benchmark_object())
  evidence <- result$benchmark_evidence

  expect_identical(evidence$contract_type, "artifact")
  expect_false(inherits(evidence, "interface_contract"))
  expect_false(inherits(evidence, "dependency_contract"))
  expect_false(inherits(evidence, "verification_contract"))
})

# ---- Lineage preservation -----------------------------------------------------

test_that("Benchmark Evidence preserves complete lineage by embedding the Benchmark Object", {
  result <- run_benchmark(valid_benchmark_object())
  expect_identical(result$benchmark_evidence$metadata$benchmark_object, result$benchmark_object)
})

test_that("create_benchmark_evidence integrates end-to-end with Modules 06-09 construction", {
  artifact <- valid_discovery_artifact()
  spec <- create_model_specification(algorithm_id = "e2e_algorithm")
  contract <- create_model_contract(spec, artifact)
  mo <- create_model_object(spec, contract)
  to <- create_training_object(train_model(mo), mo)
  output <- create_model_output(to)
  vo <- create_validation_object(output$model_candidate, output$modeling_evidence)
  validation_result <- run_validation(vo)

  bo <- create_benchmark_object(validation_result$validation_evidence)
  result <- run_benchmark(bo)

  lineage_artifact <- result$benchmark_evidence$metadata$benchmark_object$validation_evidence$
    metadata$validation_object$model_candidate$metadata$training_object$model_object$
    contract$discovery_artifacts[[1]]
  expect_identical(lineage_artifact, artifact)
})

# ---- Verification APIs -------------------------------------------------------

test_that("validate_benchmark_object accepts a valid object and rejects an invalid one", {
  expect_true(isTRUE(validate_benchmark_object(valid_benchmark_object())))
  expect_error(validate_benchmark_object(list()))
})

test_that("validate_benchmark_evidence accepts valid evidence and rejects invalid input", {
  result <- run_benchmark(valid_benchmark_object())
  expect_true(isTRUE(validate_benchmark_evidence(result$benchmark_evidence)))
  expect_error(validate_benchmark_evidence(list()))
  expect_error(validate_benchmark_evidence(valid_benchmark_object()))
})

test_that("validate_benchmark_evidence rejects evidence with the wrong artifact_role", {
  result <- run_benchmark(valid_benchmark_object())
  evidence <- result$benchmark_evidence
  evidence$metadata$artifact_role <- "something_else"
  expect_error(validate_benchmark_evidence(evidence))
})

# ---- S3 methods --------------------------------------------------------------

test_that("print.benchmark_object executes without error and is invisible", {
  bo <- valid_benchmark_object()
  expect_output(print(bo), "benchmark_object")
  expect_invisible(print(bo))
})

test_that("print.benchmark_evidence executes without error and is invisible", {
  result <- run_benchmark(valid_benchmark_object())
  expect_output(print(result$benchmark_evidence), "benchmark_evidence")
  expect_invisible(print(result$benchmark_evidence))
})

# ---- Public API surface -----------------------------------------------------

test_that("Module 10 exposes exactly the 5 required public functions plus the 2 print methods", {
  ns <- asNamespace("GCSignatureFramework")
  exported <- getNamespaceExports(ns)

  module_10_functions <- c(
    "create_benchmark_object", "validate_benchmark_object",
    "create_benchmark_evidence", "validate_benchmark_evidence",
    "run_benchmark"
  )

  for (fn in module_10_functions) {
    expect_true(fn %in% exported)
  }

  expect_false(is.null(getS3method("print", "benchmark_object", optional = TRUE)))
  expect_false(is.null(getS3method("print", "benchmark_evidence", optional = TRUE)))

  expect_false(".is_benchmark_object" %in% exported)
  expect_false(".default_generic_benchmarker" %in% exported)
})
