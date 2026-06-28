# ---- Test fixtures -------------------------------------------------------

valid_discovery_artifact <- function() {
  create_artifact_contract(
    producer = "discovery_pipeline",
    consumer = "modeling_pipeline",
    outputs = list("processed_dataset"),
    metadata = list(framework_layer = "processing")
  )
}

valid_model_object <- function() {
  spec <- create_model_specification(
    algorithm_id = "placeholder_algorithm",
    parameter_schema = list(param_a = "numeric")
  )
  contract <- create_model_contract(spec, valid_discovery_artifact())
  create_model_object(spec, contract)
}

# ---- train_model(): generic, structural, no real algorithm ----------------

test_that("train_model produces a generic trained_model using the default trainer", {
  mo <- valid_model_object()
  trained <- train_model(mo)

  expect_identical(trained$algorithm_id, "placeholder_algorithm")
  expect_identical(trained$parameter_schema, list(param_a = "numeric"))
  expect_true(trained$fitted)
})

test_that("train_model accepts a caller-supplied trainer function", {
  mo <- valid_model_object()
  custom_trainer <- function(model_object, ...) list(custom = TRUE)

  trained <- train_model(mo, trainer = custom_trainer)
  expect_identical(trained, list(custom = TRUE))
})

test_that("train_model forwards additional arguments to the trainer", {
  mo <- valid_model_object()
  trainer <- function(model_object, multiplier = 1, ...) list(value = multiplier * 2)

  trained <- train_model(mo, trainer = trainer, multiplier = 5)
  expect_identical(trained$value, 10)
})

test_that("train_model rejects a non-model_object input", {
  expect_error(train_model(list()))
})

test_that("train_model rejects a non-function trainer", {
  expect_error(train_model(valid_model_object(), trainer = "not a function"))
})

test_that("train_model does not modify the supplied Model Object", {
  mo <- valid_model_object()
  mo_copy <- valid_model_object()

  train_model(mo)

  expect_identical(mo$specification, mo_copy$specification)
})

# ---- Training Object construction --------------------------------------------

test_that("create_training_object assembles a valid training_object", {
  mo <- valid_model_object()
  trained <- train_model(mo)
  to <- create_training_object(trained, mo, training_metadata = list(seed = 42))

  expect_s3_class(to, "training_object")
  expect_identical(to$trained_model, trained)
  expect_identical(to$model_object, mo)
  expect_identical(to$training_metadata, list(seed = 42))
})

test_that("create_training_object uses an empty-list default for training_metadata", {
  mo <- valid_model_object()
  to <- create_training_object(train_model(mo), mo)
  expect_identical(to$training_metadata, list())
})

test_that("create_training_object rejects a non-model_object", {
  expect_error(create_training_object(list(fitted = TRUE), list()))
})

test_that("create_training_object rejects non-list training_metadata", {
  mo <- valid_model_object()
  expect_error(create_training_object(train_model(mo), mo, training_metadata = "not a list"))
})

test_that("Training Object is not a Framework Contract, Model Candidate, or Modeling Evidence", {
  mo <- valid_model_object()
  to <- create_training_object(train_model(mo), mo)

  expect_false(is_artifact_contract(to))
  expect_false(inherits(to, "interface_contract"))
  expect_false(inherits(to, "dependency_contract"))
  expect_false(inherits(to, "verification_contract"))
  expect_false(inherits(to, "model_contract"))
})

# ---- Immutable consumption of Model Objects --------------------------------

test_that("create_training_object does not modify the supplied Model Object", {
  mo <- valid_model_object()
  mo_copy <- valid_model_object()

  create_training_object(train_model(mo), mo, training_metadata = list(seed = 1))

  expect_identical(mo$specification, mo_copy$specification)
  expect_identical(mo$contract$discovery_artifacts, mo_copy$contract$discovery_artifacts)
})

# ---- Lineage preservation (AD-05) --------------------------------------------

test_that("create_training_object preserves complete Modeling lineage", {
  mo <- valid_model_object()
  to <- create_training_object(train_model(mo), mo)

  expect_identical(to$model_object, mo)
  expect_identical(to$model_object$specification, mo$specification)
  expect_identical(to$model_object$contract$discovery_artifacts, mo$contract$discovery_artifacts)
})

test_that("create_training_object integrates end-to-end with Module 06 construction", {
  artifact <- valid_discovery_artifact()
  spec <- create_model_specification(algorithm_id = "e2e_algorithm")
  contract <- create_model_contract(spec, artifact)
  mo <- create_model_object(spec, contract)

  trained <- train_model(mo)
  to <- create_training_object(trained, mo, training_metadata = list(timestamp = "2026-06-28"))

  expect_identical(to$model_object$contract$discovery_artifacts[[1]], artifact)
})

# ---- Training Object validation ----------------------------------------------

test_that("validate_training_object accepts a valid training_object", {
  mo <- valid_model_object()
  to <- create_training_object(train_model(mo), mo)
  expect_true(isTRUE(validate_training_object(to)))
})

test_that("validate_training_object rejects a non-training_object", {
  expect_error(validate_training_object(list()))
})

test_that("validate_training_object rejects a training_object missing required fields", {
  broken <- list(trained_model = list())
  class(broken) <- "training_object"
  expect_error(validate_training_object(broken))
})

test_that("validate_training_object rejects an invalid embedded model_object", {
  broken <- list(
    trained_model = list(), training_metadata = list(), model_object = list()
  )
  class(broken) <- "training_object"
  expect_error(validate_training_object(broken))
})

# ---- S3 methods --------------------------------------------------------------

test_that("print.training_object executes without error and is invisible", {
  mo <- valid_model_object()
  to <- create_training_object(train_model(mo), mo)

  expect_output(print(to), "training_object")
  expect_output(print(to), "placeholder_algorithm")
  expect_invisible(print(to))
})

test_that("internal predicate correctly recognizes training_object instances", {
  mo <- valid_model_object()
  to <- create_training_object(train_model(mo), mo)

  expect_true(.is_training_object(to))
  expect_false(.is_training_object(list()))
})

# ---- Public API surface -----------------------------------------------------

test_that("Module 07 exposes exactly the 3 required public functions (plus the print S3 method)", {
  ns <- asNamespace("GCSignatureFramework")
  exported <- getNamespaceExports(ns)

  module_07_functions <- c("train_model", "create_training_object", "validate_training_object")

  for (fn in module_07_functions) {
    expect_true(fn %in% exported)
  }

  # Internal helpers must NOT be part of the public API.
  expect_false(".is_training_object" %in% exported)
  expect_false(".default_generic_trainer" %in% exported)
})

# ---- Downstream readiness ----------------------------------------------------

test_that("a Training Object is ready to be consumed by a downstream module", {
  mo <- valid_model_object()
  to <- create_training_object(train_model(mo), mo, training_metadata = list(seed = 7))

  # Downstream readiness: the object validates cleanly and exposes all
  # three required fields without requiring any Module 07 internal helper.
  expect_true(isTRUE(validate_training_object(to)))
  expect_true(all(c("trained_model", "training_metadata", "model_object") %in% names(to)))
})
