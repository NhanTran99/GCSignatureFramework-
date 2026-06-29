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

valid_clinical_translation_evidence <- function() {
  output <- create_model_output(valid_training_object())
  vo <- create_validation_object(output$model_candidate, output$modeling_evidence)
  validation_result <- run_validation(vo)
  bo <- create_benchmark_object(validation_result$validation_evidence)
  benchmark_result <- run_benchmark(bo)
  cso <- create_candidate_selection_object(benchmark_result$benchmark_evidence)
  selection_result <- run_candidate_selection(cso)
  io <- create_interpretation_object(selection_result$validated_candidate)
  interpretation_result <- run_interpretation(io)
  eio <- create_evidence_integration_object(interpretation_result$interpretation_evidence)
  integration_result <- run_evidence_integration(eio)
  cto <- create_clinical_translation_object(integration_result$interpretation_package)
  run_clinical_translation(cto)$clinical_translation_evidence
}

valid_clinical_output_object <- function() {
  create_clinical_output_object(valid_clinical_translation_evidence())
}

# ---- Clinical Output Object construction --------------------------------------

test_that("create_clinical_output_object constructs a valid object", {
  cte <- valid_clinical_translation_evidence()
  coo <- create_clinical_output_object(cte)

  expect_s3_class(coo, "clinical_output_object")
  expect_identical(coo$clinical_translation_evidence, cte)
  expect_identical(coo$output_components, list())
  expect_identical(coo$execution_metadata, list())
})

test_that("create_clinical_output_object rejects a non-clinical_translation_evidence", {
  expect_error(create_clinical_output_object(list()))
})

# ---- Clinical Output Object is never a Framework artifact -------------------

test_that("Clinical Output Object is not exposed as a Framework artifact", {
  coo <- valid_clinical_output_object()
  expect_false(is_artifact_contract(coo))
  expect_false(inherits(coo, "clinical_translation_package"))
})

# ---- Workflow orchestration: run_clinical_output() ---------------------------

test_that("run_clinical_output orchestrates execution and returns both object and package", {
  result <- run_clinical_output(valid_clinical_output_object())

  expect_type(result, "list")
  expect_true(all(c("clinical_output_object", "clinical_translation_package") %in% names(result)))
  expect_s3_class(result$clinical_output_object, "clinical_output_object")
  expect_s3_class(result$clinical_translation_package, "clinical_translation_package")
})

test_that("run_clinical_output populates output_components via the default generator", {
  result <- run_clinical_output(valid_clinical_output_object())
  expect_identical(names(result$clinical_output_object$output_components), "structural_check")
  expect_true(result$clinical_output_object$output_components$structural_check$passed)
})

test_that("run_clinical_output records execution_metadata", {
  result <- run_clinical_output(valid_clinical_output_object())
  expect_true(isTRUE(result$clinical_output_object$execution_metadata$executed))
})

# ---- Default generator: generic implementation only --------------------------

test_that("the default output generator performs no treatment-recommendation/medical-advice methodology", {
  result <- run_clinical_output(valid_clinical_output_object())
  details <- result$clinical_output_object$output_components$structural_check$details
  expect_true(grepl("generic structural check only", details))
  expect_true(result$clinical_output_object$output_components$structural_check$passed)
})

# ---- Custom generator (callback pattern) --------------------------------------

test_that("run_clinical_output invokes a caller-supplied output_generator", {
  custom_generator <- function(clinical_output_object, ...) {
    list(custom_component = list(passed = TRUE, note = "custom"))
  }

  result <- run_clinical_output(valid_clinical_output_object(), output_generator = custom_generator)
  expect_identical(names(result$clinical_output_object$output_components), "custom_component")
})

test_that("run_clinical_output forwards additional arguments to the output_generator", {
  generator <- function(clinical_output_object, threshold = 0, ...) {
    list(check = list(threshold_used = threshold))
  }

  result <- run_clinical_output(valid_clinical_output_object(), output_generator = generator, threshold = 8)
  expect_identical(result$clinical_output_object$output_components$check$threshold_used, 8)
})

# ---- Multiple independent output components (Section 8) ---------------------

test_that("run_clinical_output supports multiple independent output components", {
  generator <- function(clinical_output_object, ...) {
    list(
      component_a = list(passed = TRUE),
      component_b = list(passed = TRUE),
      component_c = list(passed = FALSE, reason = "example")
    )
  }

  result <- run_clinical_output(valid_clinical_output_object(), output_generator = generator)
  components <- result$clinical_output_object$output_components

  expect_identical(names(components), c("component_a", "component_b", "component_c"))
  expect_false(components$component_c$passed)
})

# ---- Failure handling --------------------------------------------------------

test_that("run_clinical_output rejects a non-clinical_output_object input", {
  expect_error(run_clinical_output(list()))
})

test_that("run_clinical_output rejects a non-function output_generator", {
  expect_error(run_clinical_output(valid_clinical_output_object(), output_generator = "not a function"))
})

test_that("run_clinical_output rejects an output_generator that does not return a list", {
  bad_generator <- function(clinical_output_object, ...) "not a list"
  expect_error(run_clinical_output(valid_clinical_output_object(), output_generator = bad_generator))
})

# ---- Read-only consumption of Clinical Translation Evidence ------------------

test_that("create_clinical_output_object does not modify the supplied Clinical Translation Evidence", {
  cte <- valid_clinical_translation_evidence()
  cte_copy <- cte

  create_clinical_output_object(cte)

  expect_identical(cte, cte_copy)
})

test_that("run_clinical_output does not modify the Clinical Translation Evidence embedded in the object", {
  coo <- valid_clinical_output_object()
  cte_copy <- coo$clinical_translation_evidence

  run_clinical_output(coo)

  expect_identical(coo$clinical_translation_evidence, cte_copy)
})

# ---- Clinical Translation Package construction --------------------------------

test_that("create_clinical_translation_package constructs a valid package", {
  result <- run_clinical_output(valid_clinical_output_object())
  package <- result$clinical_translation_package

  expect_true(is_artifact_contract(package))
  expect_s3_class(package, "clinical_translation_package")
  expect_identical(package$contract_type, "artifact")
  expect_identical(package$metadata$framework_layer, "clinical_translation")
  expect_identical(package$metadata$artifact_role, "clinical_translation_package")
})

test_that("create_clinical_translation_package defaults producer/consumer correctly", {
  result <- run_clinical_output(valid_clinical_output_object())
  expect_identical(result$clinical_translation_package$producer, "placeholder_algorithm")
  expect_identical(result$clinical_translation_package$consumer, "framework_integration")
})

test_that("create_clinical_translation_package rejects forbidden metadata content", {
  coo <- valid_clinical_output_object()
  expect_error(create_clinical_translation_package(coo, metadata = list(treatment_recommendation = "x")))
  expect_error(create_clinical_translation_package(coo, metadata = list(medical_advice = "x")))
  expect_error(create_clinical_translation_package(coo, metadata = list(physician_decision_support = "x")))
  expect_error(create_clinical_translation_package(coo, metadata = list(guideline_interpretation = "x")))
  expect_error(create_clinical_translation_package(coo, metadata = list(patient_management = "x")))
  expect_error(create_clinical_translation_package(coo, metadata = list(publication_ready_discussion = "x")))
})

test_that("create_clinical_translation_package introduces no new Framework Contract type", {
  result <- run_clinical_output(valid_clinical_output_object())
  package <- result$clinical_translation_package

  expect_identical(package$contract_type, "artifact")
  expect_false(inherits(package, "interface_contract"))
  expect_false(inherits(package, "dependency_contract"))
  expect_false(inherits(package, "verification_contract"))
})

# ---- Lineage preservation -----------------------------------------------------

test_that("Clinical Translation Package preserves complete lineage by embedding the Clinical Output Object", {
  result <- run_clinical_output(valid_clinical_output_object())
  expect_identical(
    result$clinical_translation_package$metadata$clinical_output_object,
    result$clinical_output_object
  )
})

# ---- Verification APIs -------------------------------------------------------

test_that("validate_clinical_output_object accepts a valid object and rejects an invalid one", {
  expect_true(isTRUE(validate_clinical_output_object(valid_clinical_output_object())))
  expect_error(validate_clinical_output_object(list()))
})

test_that("validate_clinical_translation_package accepts a valid package and rejects invalid input", {
  result <- run_clinical_output(valid_clinical_output_object())
  expect_true(isTRUE(validate_clinical_translation_package(result$clinical_translation_package)))
  expect_error(validate_clinical_translation_package(list()))
  expect_error(validate_clinical_translation_package(valid_clinical_output_object()))
})

test_that("validate_clinical_translation_package rejects a package with the wrong artifact_role", {
  result <- run_clinical_output(valid_clinical_output_object())
  package <- result$clinical_translation_package
  package$metadata$artifact_role <- "something_else"
  expect_error(validate_clinical_translation_package(package))
})

# ---- S3 methods --------------------------------------------------------------

test_that("print.clinical_output_object executes without error and is invisible", {
  coo <- valid_clinical_output_object()
  expect_output(print(coo), "clinical_output_object")
  expect_invisible(print(coo))
})

test_that("print.clinical_translation_package executes without error and is invisible", {
  result <- run_clinical_output(valid_clinical_output_object())
  expect_output(print(result$clinical_translation_package), "clinical_translation_package")
  expect_invisible(print(result$clinical_translation_package))
})

# ---- Public API surface -----------------------------------------------------

test_that("Module 15 exposes exactly the 5 required public functions plus the 2 print methods", {
  ns <- asNamespace("GCSignatureFramework")
  exported <- getNamespaceExports(ns)

  module_15_functions <- c(
    "create_clinical_output_object", "validate_clinical_output_object",
    "create_clinical_translation_package", "validate_clinical_translation_package",
    "run_clinical_output"
  )

  for (fn in module_15_functions) {
    expect_true(fn %in% exported)
  }

  expect_false(is.null(getS3method("print", "clinical_output_object", optional = TRUE)))
  expect_false(is.null(getS3method("print", "clinical_translation_package", optional = TRUE)))

  expect_false(".is_clinical_output_object" %in% exported)
  expect_false(".default_generic_output_generator" %in% exported)
})

# ---- Full Coding Phase end-to-end lineage (Modules 01-15) --------------------

test_that("create_clinical_translation_package integrates end-to-end across the complete Coding Phase (Modules 06-15)", {
  artifact <- valid_discovery_artifact()
  spec <- create_model_specification(algorithm_id = "e2e_algorithm")
  contract <- create_model_contract(spec, artifact)
  mo <- create_model_object(spec, contract)
  to <- create_training_object(train_model(mo), mo)
  output <- create_model_output(to)
  vo <- create_validation_object(output$model_candidate, output$modeling_evidence)
  validation_result <- run_validation(vo)
  bo <- create_benchmark_object(validation_result$validation_evidence)
  benchmark_result <- run_benchmark(bo)
  cso <- create_candidate_selection_object(benchmark_result$benchmark_evidence)
  selection_result <- run_candidate_selection(cso)
  io <- create_interpretation_object(selection_result$validated_candidate)
  interpretation_result <- run_interpretation(io)
  eio <- create_evidence_integration_object(interpretation_result$interpretation_evidence)
  integration_result <- run_evidence_integration(eio)
  cto <- create_clinical_translation_object(integration_result$interpretation_package)
  translation_result <- run_clinical_translation(cto)

  coo <- create_clinical_output_object(translation_result$clinical_translation_evidence)
  result <- run_clinical_output(coo)

  lineage_artifact <- result$clinical_translation_package$metadata$clinical_output_object$
    clinical_translation_evidence$metadata$clinical_translation_object$interpretation_package$
    metadata$evidence_integration_object$interpretation_evidence$metadata$interpretation_object$
    validated_candidate$metadata$candidate_selection_object$benchmark_evidence$
    metadata$benchmark_object$validation_evidence$metadata$validation_object$model_candidate$
    metadata$training_object$model_object$contract$discovery_artifacts[[1]]

  expect_identical(lineage_artifact, artifact)
  expect_identical(result$clinical_translation_package$contract_type, "artifact")
  expect_identical(result$clinical_translation_package$metadata$artifact_role, "clinical_translation_package")
})
