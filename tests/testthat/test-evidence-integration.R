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

valid_interpretation_evidence <- function() {
  output <- create_model_output(valid_training_object())
  vo <- create_validation_object(output$model_candidate, output$modeling_evidence)
  validation_result <- run_validation(vo)
  bo <- create_benchmark_object(validation_result$validation_evidence)
  benchmark_result <- run_benchmark(bo)
  cso <- create_candidate_selection_object(benchmark_result$benchmark_evidence)
  selection_result <- run_candidate_selection(cso)
  io <- create_interpretation_object(selection_result$validated_candidate)
  run_interpretation(io)$interpretation_evidence
}

valid_evidence_integration_object <- function() {
  create_evidence_integration_object(valid_interpretation_evidence())
}

# ---- Evidence Integration Object construction --------------------------------

test_that("create_evidence_integration_object constructs a valid object", {
  ie <- valid_interpretation_evidence()
  eio <- create_evidence_integration_object(ie)

  expect_s3_class(eio, "evidence_integration_object")
  expect_identical(eio$interpretation_evidence, ie)
  expect_identical(eio$integration_components, list())
  expect_identical(eio$execution_metadata, list())
})

test_that("create_evidence_integration_object rejects a non-interpretation_evidence", {
  expect_error(create_evidence_integration_object(list()))
})

# ---- Evidence Integration Object is never a Framework artifact --------------

test_that("Evidence Integration Object is not exposed as a Framework artifact", {
  eio <- valid_evidence_integration_object()
  expect_false(is_artifact_contract(eio))
  expect_false(inherits(eio, "interpretation_package"))
})

# ---- Workflow orchestration: run_evidence_integration() ---------------------

test_that("run_evidence_integration orchestrates execution and returns both object and package", {
  result <- run_evidence_integration(valid_evidence_integration_object())

  expect_type(result, "list")
  expect_true(all(c("evidence_integration_object", "interpretation_package") %in% names(result)))
  expect_s3_class(result$evidence_integration_object, "evidence_integration_object")
  expect_s3_class(result$interpretation_package, "interpretation_package")
})

test_that("run_evidence_integration populates integration_components via the default integrator", {
  result <- run_evidence_integration(valid_evidence_integration_object())
  expect_identical(names(result$evidence_integration_object$integration_components), "structural_check")
  expect_true(result$evidence_integration_object$integration_components$structural_check$passed)
})

test_that("run_evidence_integration records execution_metadata", {
  result <- run_evidence_integration(valid_evidence_integration_object())
  expect_true(isTRUE(result$evidence_integration_object$execution_metadata$executed))
})

# ---- Default integrator: generic implementation only -------------------------

test_that("the default integrator performs no evidence-synthesis/biological/clinical methodology", {
  result <- run_evidence_integration(valid_evidence_integration_object())
  details <- result$evidence_integration_object$integration_components$structural_check$details
  expect_true(grepl("generic structural check only", details))
  expect_true(result$evidence_integration_object$integration_components$structural_check$passed)
})

# ---- Custom integrator (callback pattern) -------------------------------------

test_that("run_evidence_integration invokes a caller-supplied integrator", {
  custom_integrator <- function(evidence_integration_object, ...) {
    list(custom_component = list(passed = TRUE, note = "custom"))
  }

  result <- run_evidence_integration(valid_evidence_integration_object(), integrator = custom_integrator)
  expect_identical(names(result$evidence_integration_object$integration_components), "custom_component")
})

test_that("run_evidence_integration forwards additional arguments to the integrator", {
  integrator <- function(evidence_integration_object, threshold = 0, ...) {
    list(check = list(threshold_used = threshold))
  }

  result <- run_evidence_integration(valid_evidence_integration_object(), integrator = integrator, threshold = 4)
  expect_identical(result$evidence_integration_object$integration_components$check$threshold_used, 4)
})

# ---- Multiple independent integration components (Section 8) ----------------

test_that("run_evidence_integration supports multiple independent integration components", {
  integrator <- function(evidence_integration_object, ...) {
    list(
      component_a = list(passed = TRUE),
      component_b = list(passed = TRUE),
      component_c = list(passed = FALSE, reason = "example")
    )
  }

  result <- run_evidence_integration(valid_evidence_integration_object(), integrator = integrator)
  components <- result$evidence_integration_object$integration_components

  expect_identical(names(components), c("component_a", "component_b", "component_c"))
  expect_false(components$component_c$passed)
})

# ---- Failure handling --------------------------------------------------------

test_that("run_evidence_integration rejects a non-evidence_integration_object input", {
  expect_error(run_evidence_integration(list()))
})

test_that("run_evidence_integration rejects a non-function integrator", {
  expect_error(run_evidence_integration(valid_evidence_integration_object(), integrator = "not a function"))
})

test_that("run_evidence_integration rejects an integrator that does not return a list", {
  bad_integrator <- function(evidence_integration_object, ...) "not a list"
  expect_error(run_evidence_integration(valid_evidence_integration_object(), integrator = bad_integrator))
})

# ---- Read-only consumption of Interpretation Evidence ------------------------

test_that("create_evidence_integration_object does not modify the supplied Interpretation Evidence", {
  ie <- valid_interpretation_evidence()
  ie_copy <- ie

  create_evidence_integration_object(ie)

  expect_identical(ie, ie_copy)
})

test_that("run_evidence_integration does not modify the Interpretation Evidence embedded in the object", {
  eio <- valid_evidence_integration_object()
  ie_copy <- eio$interpretation_evidence

  run_evidence_integration(eio)

  expect_identical(eio$interpretation_evidence, ie_copy)
})

# ---- Interpretation Package construction --------------------------------------

test_that("create_interpretation_package constructs a valid Interpretation Package", {
  result <- run_evidence_integration(valid_evidence_integration_object())
  package <- result$interpretation_package

  expect_true(is_artifact_contract(package))
  expect_s3_class(package, "interpretation_package")
  expect_identical(package$contract_type, "artifact")
  expect_identical(package$metadata$framework_layer, "interpretability")
  expect_identical(package$metadata$artifact_role, "interpretation_package")
})

test_that("create_interpretation_package defaults producer/consumer correctly", {
  result <- run_evidence_integration(valid_evidence_integration_object())
  expect_identical(result$interpretation_package$producer, "placeholder_algorithm")
  expect_identical(result$interpretation_package$consumer, "clinical_translation")
})

test_that("create_interpretation_package rejects forbidden metadata content", {
  eio <- valid_evidence_integration_object()
  expect_error(create_interpretation_package(eio, metadata = list(biological_reasoning = "x")))
  expect_error(create_interpretation_package(eio, metadata = list(clinical_interpretation = "x")))
  expect_error(create_interpretation_package(eio, metadata = list(therapeutic_recommendation = "x")))
  expect_error(create_interpretation_package(eio, metadata = list(publication_ready_discussion = "x")))
  expect_error(create_interpretation_package(eio, metadata = list(scientific_conclusions = "x")))
})

test_that("create_interpretation_package introduces no new Framework Contract type", {
  result <- run_evidence_integration(valid_evidence_integration_object())
  package <- result$interpretation_package

  expect_identical(package$contract_type, "artifact")
  expect_false(inherits(package, "interface_contract"))
  expect_false(inherits(package, "dependency_contract"))
  expect_false(inherits(package, "verification_contract"))
})

# ---- Lineage preservation -----------------------------------------------------

test_that("Interpretation Package preserves complete lineage by embedding the Evidence Integration Object", {
  result <- run_evidence_integration(valid_evidence_integration_object())
  expect_identical(
    result$interpretation_package$metadata$evidence_integration_object,
    result$evidence_integration_object
  )
})

test_that("create_interpretation_package integrates end-to-end with Modules 06-12 construction", {
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
  result <- run_evidence_integration(eio)

  lineage_artifact <- result$interpretation_package$metadata$evidence_integration_object$
    interpretation_evidence$metadata$interpretation_object$validated_candidate$
    metadata$candidate_selection_object$benchmark_evidence$metadata$benchmark_object$
    validation_evidence$metadata$validation_object$model_candidate$metadata$training_object$
    model_object$contract$discovery_artifacts[[1]]
  expect_identical(lineage_artifact, artifact)
})

# ---- Verification APIs -------------------------------------------------------

test_that("validate_evidence_integration_object accepts a valid object and rejects an invalid one", {
  expect_true(isTRUE(validate_evidence_integration_object(valid_evidence_integration_object())))
  expect_error(validate_evidence_integration_object(list()))
})

test_that("validate_interpretation_package accepts a valid package and rejects invalid input", {
  result <- run_evidence_integration(valid_evidence_integration_object())
  expect_true(isTRUE(validate_interpretation_package(result$interpretation_package)))
  expect_error(validate_interpretation_package(list()))
  expect_error(validate_interpretation_package(valid_evidence_integration_object()))
})

test_that("validate_interpretation_package rejects a package with the wrong artifact_role", {
  result <- run_evidence_integration(valid_evidence_integration_object())
  package <- result$interpretation_package
  package$metadata$artifact_role <- "something_else"
  expect_error(validate_interpretation_package(package))
})

# ---- S3 methods --------------------------------------------------------------

test_that("print.evidence_integration_object executes without error and is invisible", {
  eio <- valid_evidence_integration_object()
  expect_output(print(eio), "evidence_integration_object")
  expect_invisible(print(eio))
})

test_that("print.interpretation_package executes without error and is invisible", {
  result <- run_evidence_integration(valid_evidence_integration_object())
  expect_output(print(result$interpretation_package), "interpretation_package")
  expect_invisible(print(result$interpretation_package))
})

# ---- Public API surface -----------------------------------------------------

test_that("Module 13 exposes exactly the 5 required public functions plus the 2 print methods", {
  ns <- asNamespace("GCSignatureFramework")
  exported <- getNamespaceExports(ns)

  module_13_functions <- c(
    "create_evidence_integration_object", "validate_evidence_integration_object",
    "create_interpretation_package", "validate_interpretation_package",
    "run_evidence_integration"
  )

  for (fn in module_13_functions) {
    expect_true(fn %in% exported)
  }

  expect_false(is.null(getS3method("print", "evidence_integration_object", optional = TRUE)))
  expect_false(is.null(getS3method("print", "interpretation_package", optional = TRUE)))

  expect_false(".is_evidence_integration_object" %in% exported)
  expect_false(".default_generic_integrator" %in% exported)
})
