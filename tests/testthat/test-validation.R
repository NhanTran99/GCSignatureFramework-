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

valid_model_output <- function() {
  create_model_output(valid_training_object())
}

valid_validation_object <- function() {
  output <- valid_model_output()
  create_validation_object(output$model_candidate, output$modeling_evidence)
}

# ---- Validation Object construction ------------------------------------------

test_that("create_validation_object constructs a valid Validation Object", {
  output <- valid_model_output()
  vo <- create_validation_object(output$model_candidate, output$modeling_evidence)

  expect_s3_class(vo, "validation_object")
  expect_identical(vo$model_candidate, output$model_candidate)
  expect_identical(vo$modeling_evidence, output$modeling_evidence)
  expect_identical(vo$validation_components, list())
  expect_identical(vo$execution_metadata, list())
})

test_that("create_validation_object rejects a non-model_candidate", {
  output <- valid_model_output()
  expect_error(create_validation_object(list(), output$modeling_evidence))
})

test_that("create_validation_object rejects a non-modeling_evidence", {
  output <- valid_model_output()
  expect_error(create_validation_object(output$model_candidate, list()))
})

# ---- Validation Object is never a Framework artifact ------------------------

test_that("Validation Object is not exposed as a Framework artifact", {
  vo <- valid_validation_object()
  expect_false(is_artifact_contract(vo))
  expect_false(inherits(vo, "validation_evidence"))
})

# ---- Workflow orchestration: run_validation() -------------------------------

test_that("run_validation orchestrates execution and returns both object and evidence", {
  vo <- valid_validation_object()
  result <- run_validation(vo)

  expect_type(result, "list")
  expect_true(all(c("validation_object", "validation_evidence") %in% names(result)))
  expect_s3_class(result$validation_object, "validation_object")
  expect_s3_class(result$validation_evidence, "validation_evidence")
})

test_that("run_validation populates validation_components via the default validator", {
  result <- run_validation(valid_validation_object())
  expect_identical(names(result$validation_object$validation_components), "structural_check")
  expect_true(result$validation_object$validation_components$structural_check$passed)
})

test_that("run_validation records execution_metadata", {
  result <- run_validation(valid_validation_object())
  expect_true(isTRUE(result$validation_object$execution_metadata$executed))
})

# ---- Default validator: generic implementation only -------------------------

test_that("the default validator performs no statistical/biological methodology", {
  result <- run_validation(valid_validation_object())
  details <- result$validation_object$validation_components$structural_check$details
  expect_true(grepl("generic structural check only", details))
})

# ---- Custom validator (callback pattern) ------------------------------------

test_that("run_validation invokes a caller-supplied validator", {
  custom_validator <- function(validation_object, ...) {
    list(custom_component = list(passed = TRUE, note = "custom"))
  }

  result <- run_validation(valid_validation_object(), validator = custom_validator)
  expect_identical(names(result$validation_object$validation_components), "custom_component")
})

test_that("run_validation forwards additional arguments to the validator", {
  validator <- function(validation_object, threshold = 0, ...) {
    list(check = list(threshold_used = threshold))
  }

  result <- run_validation(valid_validation_object(), validator = validator, threshold = 5)
  expect_identical(result$validation_object$validation_components$check$threshold_used, 5)
})

# ---- Multiple independent validation components (Section 8) -----------------

test_that("run_validation supports multiple independent validation components", {
  validator <- function(validation_object, ...) {
    list(
      component_a = list(passed = TRUE),
      component_b = list(passed = TRUE),
      component_c = list(passed = FALSE, reason = "example")
    )
  }

  result <- run_validation(valid_validation_object(), validator = validator)
  components <- result$validation_object$validation_components

  expect_identical(names(components), c("component_a", "component_b", "component_c"))
  expect_false(components$component_c$passed)
})

# ---- Failure handling --------------------------------------------------------

test_that("run_validation rejects a non-validation_object input", {
  expect_error(run_validation(list()))
})

test_that("run_validation rejects a non-function validator", {
  expect_error(run_validation(valid_validation_object(), validator = "not a function"))
})

test_that("run_validation rejects a validator that does not return a list", {
  bad_validator <- function(validation_object, ...) "not a list"
  expect_error(run_validation(valid_validation_object(), validator = bad_validator))
})

# ---- Read-only consumption of Modeling artifacts ----------------------------

test_that("create_validation_object does not modify the supplied Modeling artifacts", {
  output <- valid_model_output()
  candidate_copy <- output$model_candidate
  evidence_copy <- output$modeling_evidence

  create_validation_object(output$model_candidate, output$modeling_evidence)

  expect_identical(output$model_candidate, candidate_copy)
  expect_identical(output$modeling_evidence, evidence_copy)
})

test_that("run_validation does not modify the Modeling artifacts embedded in the Validation Object", {
  vo <- valid_validation_object()
  candidate_copy <- vo$model_candidate
  evidence_copy <- vo$modeling_evidence

  run_validation(vo)

  expect_identical(vo$model_candidate, candidate_copy)
  expect_identical(vo$modeling_evidence, evidence_copy)
})

# ---- Validation Evidence construction ---------------------------------------

test_that("create_validation_evidence constructs a valid Validation Evidence", {
  result <- run_validation(valid_validation_object())
  evidence <- result$validation_evidence

  expect_true(is_artifact_contract(evidence))
  expect_s3_class(evidence, "validation_evidence")
  expect_identical(evidence$contract_type, "artifact")
  expect_identical(evidence$metadata$framework_layer, "validation_benchmark")
  expect_identical(evidence$metadata$artifact_role, "validation_evidence")
})

test_that("create_validation_evidence defaults producer/consumer correctly", {
  result <- run_validation(valid_validation_object())
  expect_identical(result$validation_evidence$producer, "placeholder_algorithm")
  expect_identical(result$validation_evidence$consumer, "benchmark")
})

test_that("create_validation_evidence rejects forbidden metadata content", {
  vo <- valid_validation_object()
  expect_error(create_validation_evidence(vo, metadata = list(benchmark_evidence = "x")))
  expect_error(create_validation_evidence(vo, metadata = list(candidate_selection = "x")))
  expect_error(create_validation_evidence(vo, metadata = list(validated_candidate = "x")))
})

test_that("create_validation_evidence introduces no new Framework Contract type", {
  result <- run_validation(valid_validation_object())
  evidence <- result$validation_evidence

  expect_identical(evidence$contract_type, "artifact")
  expect_false(inherits(evidence, "interface_contract"))
  expect_false(inherits(evidence, "dependency_contract"))
  expect_false(inherits(evidence, "verification_contract"))
})

# ---- Lineage preservation (Validation Evidence <-> Validation Object) -------

test_that("Validation Evidence preserves complete lineage by embedding the Validation Object", {
  result <- run_validation(valid_validation_object())
  expect_identical(result$validation_evidence$metadata$validation_object, result$validation_object)
})

test_that("create_validation_evidence integrates end-to-end with Modules 06-08 construction", {
  artifact <- valid_discovery_artifact()
  spec <- create_model_specification(algorithm_id = "e2e_algorithm")
  contract <- create_model_contract(spec, artifact)
  mo <- create_model_object(spec, contract)
  to <- create_training_object(train_model(mo), mo)
  output <- create_model_output(to)

  vo <- create_validation_object(output$model_candidate, output$modeling_evidence)
  result <- run_validation(vo)

  lineage_artifact <- result$validation_evidence$metadata$validation_object$
    model_candidate$metadata$training_object$model_object$contract$discovery_artifacts[[1]]
  expect_identical(lineage_artifact, artifact)
})

# ---- Verification APIs -------------------------------------------------------

test_that("validate_validation_object accepts a valid object and rejects an invalid one", {
  expect_true(isTRUE(validate_validation_object(valid_validation_object())))
  expect_error(validate_validation_object(list()))
})

test_that("validate_validation_evidence accepts valid evidence and rejects invalid input", {
  result <- run_validation(valid_validation_object())
  expect_true(isTRUE(validate_validation_evidence(result$validation_evidence)))
  expect_error(validate_validation_evidence(list()))
  expect_error(validate_validation_evidence(valid_validation_object()))
})

test_that("validate_validation_evidence rejects evidence with the wrong artifact_role", {
  result <- run_validation(valid_validation_object())
  evidence <- result$validation_evidence
  evidence$metadata$artifact_role <- "something_else"
  expect_error(validate_validation_evidence(evidence))
})

# ---- S3 methods --------------------------------------------------------------

test_that("print.validation_object executes without error and is invisible", {
  vo <- valid_validation_object()
  expect_output(print(vo), "validation_object")
  expect_invisible(print(vo))
})

test_that("print.validation_evidence executes without error and is invisible", {
  result <- run_validation(valid_validation_object())
  expect_output(print(result$validation_evidence), "validation_evidence")
  expect_invisible(print(result$validation_evidence))
})

# ---- Public API surface -----------------------------------------------------

test_that("Module 09 exposes exactly the 5 required public functions plus the 2 print methods", {
  ns <- asNamespace("GCSignatureFramework")
  exported <- getNamespaceExports(ns)

  module_09_functions <- c(
    "create_validation_object", "validate_validation_object",
    "create_validation_evidence", "validate_validation_evidence",
    "run_validation"
  )

  for (fn in module_09_functions) {
    expect_true(fn %in% exported)
  }

  expect_false(is.null(getS3method("print", "validation_object", optional = TRUE)))
  expect_false(is.null(getS3method("print", "validation_evidence", optional = TRUE)))

  expect_false(".is_validation_object" %in% exported)
  expect_false(".default_generic_validator" %in% exported)
})
