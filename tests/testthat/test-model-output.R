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
  create_training_object(train_model(mo), mo, training_metadata = list(seed = 1))
}

# ---- Model Candidate construction --------------------------------------------

test_that("create_model_candidate constructs a valid Model Candidate", {
  to <- valid_training_object()
  candidate <- create_model_candidate(to)

  expect_true(is_artifact_contract(candidate))
  expect_s3_class(candidate, "model_candidate")
  expect_identical(candidate$contract_type, "artifact")
  expect_identical(candidate$metadata$artifact_role, "model_candidate")
  expect_identical(candidate$metadata$framework_layer, "modeling")
})

test_that("create_model_candidate defaults producer to the algorithm_id", {
  to <- valid_training_object()
  candidate <- create_model_candidate(to)
  expect_identical(candidate$producer, "placeholder_algorithm")
})

test_that("create_model_candidate accepts an explicit producer/consumer", {
  to <- valid_training_object()
  candidate <- create_model_candidate(to, producer = "custom_producer", consumer = "custom_consumer")
  expect_identical(candidate$producer, "custom_producer")
  expect_identical(candidate$consumer, "custom_consumer")
})

test_that("create_model_candidate rejects a non-training_object", {
  expect_error(create_model_candidate(list()))
})

test_that("create_model_candidate rejects metadata with reserved keys", {
  to <- valid_training_object()
  expect_error(create_model_candidate(to, metadata = list(artifact_role = "x")))
  expect_error(create_model_candidate(to, metadata = list(framework_layer = "x")))
  expect_error(create_model_candidate(to, metadata = list(training_object = "x")))
})

# ---- Modeling Evidence construction --------------------------------------------

test_that("create_modeling_evidence constructs a valid Modeling Evidence", {
  to <- valid_training_object()
  evidence <- create_modeling_evidence(to)

  expect_true(is_artifact_contract(evidence))
  expect_s3_class(evidence, "modeling_evidence")
  expect_identical(evidence$contract_type, "artifact")
  expect_identical(evidence$metadata$artifact_role, "modeling_evidence")
})

test_that("create_modeling_evidence initializes all 5 structural placeholder sections", {
  to <- valid_training_object()
  evidence <- create_modeling_evidence(to)

  sections <- evidence$metadata$evidence_sections
  expect_identical(
    names(sections),
    c("predictive_model", "risk_score_definition", "performance_profile",
      "interpretability_profile", "clinical_evaluation_profile")
  )
  expect_true(all(vapply(sections, is.null, logical(1))))
})

test_that("create_modeling_evidence rejects a non-training_object", {
  expect_error(create_modeling_evidence(list()))
})

test_that("create_modeling_evidence rejects metadata with reserved keys", {
  to <- valid_training_object()
  expect_error(create_modeling_evidence(to, metadata = list(evidence_sections = "x")))
})

# ---- AD-04: independent artifacts; neither embeds the other ----------------

test_that("Model Candidate and Modeling Evidence do not embed each other", {
  to <- valid_training_object()
  candidate <- create_model_candidate(to)
  evidence <- create_modeling_evidence(to)

  expect_null(candidate$metadata$modeling_evidence)
  expect_null(evidence$metadata$model_candidate)
  expect_false(inherits(candidate, "modeling_evidence"))
  expect_false(inherits(evidence, "model_candidate"))
})

test_that("Model Candidate and Modeling Evidence introduce no new Framework Contract type", {
  to <- valid_training_object()
  candidate <- create_model_candidate(to)
  evidence <- create_modeling_evidence(to)

  expect_identical(candidate$contract_type, "artifact")
  expect_identical(evidence$contract_type, "artifact")
  expect_false(inherits(candidate, "interface_contract"))
  expect_false(inherits(candidate, "dependency_contract"))
  expect_false(inherits(candidate, "verification_contract"))
})

# ---- create_model_output(): shared lineage across both artifacts ----------

test_that("create_model_output produces a Candidate and Evidence sharing the same lineage", {
  to <- valid_training_object()
  output <- create_model_output(to)

  expect_identical(output$model_candidate$producer, output$modeling_evidence$producer)
  expect_identical(
    output$model_candidate$metadata$training_object,
    output$modeling_evidence$metadata$training_object
  )
})

# ---- Immutable Training Object consumption (AD-03) --------------------------

test_that("create_model_candidate does not modify the supplied Training Object", {
  to <- valid_training_object()
  to_copy <- valid_training_object()

  create_model_candidate(to)

  expect_identical(to$model_object, to_copy$model_object)
  expect_identical(to$trained_model, to_copy$trained_model)
})

test_that("create_modeling_evidence does not modify the supplied Training Object", {
  to <- valid_training_object()
  to_copy <- valid_training_object()

  create_modeling_evidence(to)

  expect_identical(to$model_object, to_copy$model_object)
  expect_identical(to$trained_model, to_copy$trained_model)
})

# ---- Lineage preservation (AD-05) --------------------------------------------

test_that("Model Candidate preserves complete Training Object lineage", {
  to <- valid_training_object()
  candidate <- create_model_candidate(to)

  expect_identical(candidate$metadata$training_object, to)
  expect_identical(candidate$metadata$training_object$model_object$contract$discovery_artifacts[[1]]$metadata$framework_layer, "processing")
})

test_that("create_model_candidate integrates end-to-end with Modules 06-07 construction", {
  artifact <- valid_discovery_artifact()
  spec <- create_model_specification(algorithm_id = "e2e_algorithm")
  contract <- create_model_contract(spec, artifact)
  mo <- create_model_object(spec, contract)
  to <- create_training_object(train_model(mo), mo)

  candidate <- create_model_candidate(to)

  expect_identical(
    candidate$metadata$training_object$model_object$contract$discovery_artifacts[[1]],
    artifact
  )
})

# ---- Structural validation ---------------------------------------------------

test_that("validate_model_candidate accepts a valid Model Candidate", {
  to <- valid_training_object()
  candidate <- create_model_candidate(to)
  expect_true(isTRUE(validate_model_candidate(candidate)))
})

test_that("validate_model_candidate rejects a non-model_candidate object", {
  expect_error(validate_model_candidate(list()))
  expect_error(validate_model_candidate(valid_training_object()))
})

test_that("validate_model_candidate rejects a candidate with the wrong artifact_role", {
  to <- valid_training_object()
  candidate <- create_model_candidate(to)
  candidate$metadata$artifact_role <- "modeling_evidence"
  expect_error(validate_model_candidate(candidate))
})

test_that("validate_model_candidate rejects a candidate missing its training_object", {
  to <- valid_training_object()
  candidate <- create_model_candidate(to)
  candidate$metadata$training_object <- NULL
  expect_error(validate_model_candidate(candidate))
})

test_that("internal .validate_modeling_evidence accepts a valid Modeling Evidence", {
  to <- valid_training_object()
  evidence <- create_modeling_evidence(to)
  expect_true(isTRUE(.validate_modeling_evidence(evidence)))
})

test_that("internal .validate_modeling_evidence rejects evidence missing a required section", {
  to <- valid_training_object()
  evidence <- create_modeling_evidence(to)
  evidence$metadata$evidence_sections$predictive_model <- NULL
  expect_error(.validate_modeling_evidence(evidence))
})

# ---- S3 methods --------------------------------------------------------------

test_that("print.model_candidate executes without error and is invisible", {
  candidate <- create_model_candidate(valid_training_object())
  expect_output(print(candidate), "model_candidate")
  expect_invisible(print(candidate))
})

test_that("print.modeling_evidence executes without error and is invisible", {
  evidence <- create_modeling_evidence(valid_training_object())
  expect_output(print(evidence), "modeling_evidence")
  expect_invisible(print(evidence))
})

test_that("print() dispatches to the subclass print method, not print.artifact_contract", {
  candidate <- create_model_candidate(valid_training_object())
  expect_output(print(candidate), "<model_candidate>")
  expect_false(any(grepl("^<artifact_contract>$", capture.output(print(candidate)))))
})

# ---- Public API surface -----------------------------------------------------

test_that("Module 08 exposes exactly the 3 required public functions plus the 2 print methods", {
  ns <- asNamespace("GCSignatureFramework")
  exported <- getNamespaceExports(ns)

  module_08_functions <- c("create_model_candidate", "create_modeling_evidence", "validate_model_candidate")

  for (fn in module_08_functions) {
    expect_true(fn %in% exported)
  }

  # S3 print methods are registered in NAMESPACE via S3method(), not export();
  # getNamespaceExports() does not (and should not) list them by name. Verify
  # registration via getS3method() instead, which is the correct way to check
  # that print() dispatch is registered for these classes.
  expect_false(is.null(getS3method("print", "model_candidate", optional = TRUE)))
  expect_false(is.null(getS3method("print", "modeling_evidence", optional = TRUE)))

  # Internal helpers must NOT be part of the public API.
  expect_false("create_model_output" %in% exported)
  expect_false(".validate_modeling_evidence" %in% exported)
  expect_false(".new_evidence_sections" %in% exported)
})

# ---- Downstream readiness ----------------------------------------------------

test_that("Model Candidate and Modeling Evidence are ready for IDS-004 consumption", {
  to <- valid_training_object()
  output <- create_model_output(to)

  expect_true(isTRUE(validate_artifact_contract(output$model_candidate)))
  expect_true(isTRUE(validate_artifact_contract(output$modeling_evidence)))
  expect_identical(output$model_candidate$consumer, "validation_benchmark")
  expect_identical(output$modeling_evidence$consumer, "validation_benchmark")
})
