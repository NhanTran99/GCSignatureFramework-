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

valid_interpretation_package <- function() {
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
  run_evidence_integration(eio)$interpretation_package
}

valid_clinical_translation_object <- function() {
  create_clinical_translation_object(valid_interpretation_package())
}

# ---- Clinical Translation Object construction --------------------------------

test_that("create_clinical_translation_object constructs a valid object", {
  ip <- valid_interpretation_package()
  cto <- create_clinical_translation_object(ip)

  expect_s3_class(cto, "clinical_translation_object")
  expect_identical(cto$interpretation_package, ip)
  expect_identical(cto$translation_components, list())
  expect_identical(cto$execution_metadata, list())
})

test_that("create_clinical_translation_object rejects a non-interpretation_package", {
  expect_error(create_clinical_translation_object(list()))
})

# ---- Clinical Translation Object is never a Framework artifact -------------

test_that("Clinical Translation Object is not exposed as a Framework artifact", {
  cto <- valid_clinical_translation_object()
  expect_false(is_artifact_contract(cto))
  expect_false(inherits(cto, "clinical_translation_evidence"))
})

# ---- Workflow orchestration: run_clinical_translation() ---------------------

test_that("run_clinical_translation orchestrates execution and returns both object and evidence", {
  result <- run_clinical_translation(valid_clinical_translation_object())

  expect_type(result, "list")
  expect_true(all(c("clinical_translation_object", "clinical_translation_evidence") %in% names(result)))
  expect_s3_class(result$clinical_translation_object, "clinical_translation_object")
  expect_s3_class(result$clinical_translation_evidence, "clinical_translation_evidence")
})

test_that("run_clinical_translation populates translation_components via the default translator", {
  result <- run_clinical_translation(valid_clinical_translation_object())
  expect_identical(names(result$clinical_translation_object$translation_components), "structural_check")
  expect_true(result$clinical_translation_object$translation_components$structural_check$passed)
})

test_that("run_clinical_translation records execution_metadata", {
  result <- run_clinical_translation(valid_clinical_translation_object())
  expect_true(isTRUE(result$clinical_translation_object$execution_metadata$executed))
})

# ---- Default translator: generic implementation only -------------------------

test_that("the default translator performs no treatment-recommendation/guideline/patient methodology", {
  result <- run_clinical_translation(valid_clinical_translation_object())
  details <- result$clinical_translation_object$translation_components$structural_check$details
  expect_true(grepl("generic structural check only", details))
  expect_true(result$clinical_translation_object$translation_components$structural_check$passed)
})

# ---- Custom translator (callback pattern) -------------------------------------

test_that("run_clinical_translation invokes a caller-supplied translator", {
  custom_translator <- function(clinical_translation_object, ...) {
    list(custom_component = list(passed = TRUE, note = "custom"))
  }

  result <- run_clinical_translation(valid_clinical_translation_object(), translator = custom_translator)
  expect_identical(names(result$clinical_translation_object$translation_components), "custom_component")
})

test_that("run_clinical_translation forwards additional arguments to the translator", {
  translator <- function(clinical_translation_object, threshold = 0, ...) {
    list(check = list(threshold_used = threshold))
  }

  result <- run_clinical_translation(valid_clinical_translation_object(), translator = translator, threshold = 6)
  expect_identical(result$clinical_translation_object$translation_components$check$threshold_used, 6)
})

# ---- Multiple independent translation components (Section 8) ----------------

test_that("run_clinical_translation supports multiple independent translation components", {
  translator <- function(clinical_translation_object, ...) {
    list(
      component_a = list(passed = TRUE),
      component_b = list(passed = TRUE),
      component_c = list(passed = FALSE, reason = "example")
    )
  }

  result <- run_clinical_translation(valid_clinical_translation_object(), translator = translator)
  components <- result$clinical_translation_object$translation_components

  expect_identical(names(components), c("component_a", "component_b", "component_c"))
  expect_false(components$component_c$passed)
})

# ---- Failure handling --------------------------------------------------------

test_that("run_clinical_translation rejects a non-clinical_translation_object input", {
  expect_error(run_clinical_translation(list()))
})

test_that("run_clinical_translation rejects a non-function translator", {
  expect_error(run_clinical_translation(valid_clinical_translation_object(), translator = "not a function"))
})

test_that("run_clinical_translation rejects a translator that does not return a list", {
  bad_translator <- function(clinical_translation_object, ...) "not a list"
  expect_error(run_clinical_translation(valid_clinical_translation_object(), translator = bad_translator))
})

# ---- Read-only consumption of Interpretation Package -------------------------

test_that("create_clinical_translation_object does not modify the supplied Interpretation Package", {
  ip <- valid_interpretation_package()
  ip_copy <- ip

  create_clinical_translation_object(ip)

  expect_identical(ip, ip_copy)
})

test_that("run_clinical_translation does not modify the Interpretation Package embedded in the object", {
  cto <- valid_clinical_translation_object()
  ip_copy <- cto$interpretation_package

  run_clinical_translation(cto)

  expect_identical(cto$interpretation_package, ip_copy)
})

# ---- Clinical Translation Evidence construction -------------------------------

test_that("create_clinical_translation_evidence constructs a valid Clinical Translation Evidence", {
  result <- run_clinical_translation(valid_clinical_translation_object())
  evidence <- result$clinical_translation_evidence

  expect_true(is_artifact_contract(evidence))
  expect_s3_class(evidence, "clinical_translation_evidence")
  expect_identical(evidence$contract_type, "artifact")
  expect_identical(evidence$metadata$framework_layer, "clinical_translation")
  expect_identical(evidence$metadata$artifact_role, "clinical_translation_evidence")
})

test_that("create_clinical_translation_evidence defaults producer/consumer correctly", {
  result <- run_clinical_translation(valid_clinical_translation_object())
  expect_identical(result$clinical_translation_evidence$producer, "placeholder_algorithm")
  expect_identical(result$clinical_translation_evidence$consumer, "clinical_translation_package")
})

test_that("create_clinical_translation_evidence rejects forbidden metadata content", {
  cto <- valid_clinical_translation_object()
  expect_error(create_clinical_translation_evidence(cto, metadata = list(treatment_recommendation = "x")))
  expect_error(create_clinical_translation_evidence(cto, metadata = list(clinical_guideline_reasoning = "x")))
  expect_error(create_clinical_translation_evidence(cto, metadata = list(clinician_facing_interpretation = "x")))
  expect_error(create_clinical_translation_evidence(cto, metadata = list(patient_recommendation = "x")))
  expect_error(create_clinical_translation_evidence(cto, metadata = list(clinical_decision_support = "x")))
})

test_that("create_clinical_translation_evidence introduces no new Framework Contract type", {
  result <- run_clinical_translation(valid_clinical_translation_object())
  evidence <- result$clinical_translation_evidence

  expect_identical(evidence$contract_type, "artifact")
  expect_false(inherits(evidence, "interface_contract"))
  expect_false(inherits(evidence, "dependency_contract"))
  expect_false(inherits(evidence, "verification_contract"))
})

# ---- Lineage preservation -----------------------------------------------------

test_that("Clinical Translation Evidence preserves complete lineage by embedding the Clinical Translation Object", {
  result <- run_clinical_translation(valid_clinical_translation_object())
  expect_identical(
    result$clinical_translation_evidence$metadata$clinical_translation_object,
    result$clinical_translation_object
  )
})

test_that("create_clinical_translation_evidence integrates end-to-end with Modules 06-13 construction", {
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
  result <- run_clinical_translation(cto)

  lineage_artifact <- result$clinical_translation_evidence$metadata$clinical_translation_object$
    interpretation_package$metadata$evidence_integration_object$interpretation_evidence$
    metadata$interpretation_object$validated_candidate$metadata$candidate_selection_object$
    benchmark_evidence$metadata$benchmark_object$validation_evidence$metadata$validation_object$
    model_candidate$metadata$training_object$model_object$contract$discovery_artifacts[[1]]
  expect_identical(lineage_artifact, artifact)
})

# ---- Verification APIs -------------------------------------------------------

test_that("validate_clinical_translation_object accepts a valid object and rejects an invalid one", {
  expect_true(isTRUE(validate_clinical_translation_object(valid_clinical_translation_object())))
  expect_error(validate_clinical_translation_object(list()))
})

test_that("validate_clinical_translation_evidence accepts valid evidence and rejects invalid input", {
  result <- run_clinical_translation(valid_clinical_translation_object())
  expect_true(isTRUE(validate_clinical_translation_evidence(result$clinical_translation_evidence)))
  expect_error(validate_clinical_translation_evidence(list()))
  expect_error(validate_clinical_translation_evidence(valid_clinical_translation_object()))
})

test_that("validate_clinical_translation_evidence rejects evidence with the wrong artifact_role", {
  result <- run_clinical_translation(valid_clinical_translation_object())
  evidence <- result$clinical_translation_evidence
  evidence$metadata$artifact_role <- "something_else"
  expect_error(validate_clinical_translation_evidence(evidence))
})

# ---- S3 methods --------------------------------------------------------------

test_that("print.clinical_translation_object executes without error and is invisible", {
  cto <- valid_clinical_translation_object()
  expect_output(print(cto), "clinical_translation_object")
  expect_invisible(print(cto))
})

test_that("print.clinical_translation_evidence executes without error and is invisible", {
  result <- run_clinical_translation(valid_clinical_translation_object())
  expect_output(print(result$clinical_translation_evidence), "clinical_translation_evidence")
  expect_invisible(print(result$clinical_translation_evidence))
})

# ---- Public API surface -----------------------------------------------------

test_that("Module 14 exposes exactly the 5 required public functions plus the 2 print methods", {
  ns <- asNamespace("GCSignatureFramework")
  exported <- getNamespaceExports(ns)

  module_14_functions <- c(
    "create_clinical_translation_object", "validate_clinical_translation_object",
    "create_clinical_translation_evidence", "validate_clinical_translation_evidence",
    "run_clinical_translation"
  )

  for (fn in module_14_functions) {
    expect_true(fn %in% exported)
  }

  expect_false(is.null(getS3method("print", "clinical_translation_object", optional = TRUE)))
  expect_false(is.null(getS3method("print", "clinical_translation_evidence", optional = TRUE)))

  expect_false(".is_clinical_translation_object" %in% exported)
  expect_false(".default_generic_translator" %in% exported)
})
