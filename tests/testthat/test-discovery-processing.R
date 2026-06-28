# ---- Test fixtures -------------------------------------------------------

make_linear_pipeline <- function() {
  p <- create_discovery_pipeline("processing_pipeline")
  p <- register_discovery_stage(
    p, "qc", outputs = "qc_dataset", executor = generic_qc_stage
  )
  p <- register_discovery_stage(
    p, "normalize", inputs = "qc_dataset", outputs = "normalized_dataset",
    dependencies = "qc",
    executor = function(dataset, ...) generic_normalization_stage(dataset, method = "identity")
  )
  p <- register_discovery_stage(
    p, "filter", inputs = "normalized_dataset", outputs = "filtered_dataset",
    dependencies = "normalize", executor = generic_filtering_stage
  )
  p
}

sample_data <- function() {
  data.frame(
    feature_1 = c(1, 2, 3, NA),
    feature_2 = c(4, 5, 6, 7)
  )
}

# ---- Processing execution -------------------------------------------------

test_that("execute_discovery_pipeline runs all stages and returns expected structure", {
  p <- make_linear_pipeline()
  result <- execute_discovery_pipeline(p, sample_data())

  expect_type(result, "list")
  expect_true(all(c("processed_dataset", "artifact", "execution_order") %in% names(result)))
  expect_identical(result$execution_order, c("qc", "normalize", "filter"))
})

test_that("execute_discovery_pipeline respects resolved dependency order for a branching DAG", {
  p <- create_discovery_pipeline("branching")
  p <- register_discovery_stage(p, "load", outputs = "dataset", executor = function(dataset, ...) dataset)
  p <- register_discovery_stage(p, "branch_a", inputs = "dataset", outputs = "a_out",
                                 dependencies = "load",
                                 executor = function(dataset, ...) { attr(dataset, "a") <- TRUE; dataset })
  p <- register_discovery_stage(p, "branch_b", inputs = "dataset", outputs = "b_out",
                                 dependencies = "load",
                                 executor = function(dataset, ...) { attr(dataset, "b") <- TRUE; dataset })
  p <- register_discovery_stage(p, "merge", inputs = c("a_out", "b_out"), outputs = "merged",
                                 dependencies = c("branch_a", "branch_b"),
                                 executor = function(dataset, ...) dataset)

  result <- execute_discovery_pipeline(p, sample_data())
  expect_identical(result$execution_order[1], "load")
  expect_identical(result$execution_order[4], "merge")
})

# ---- Stage execution: generic QC ------------------------------------------

test_that("generic_qc_stage performs structural validation and attaches qc_info", {
  d <- sample_data()
  result <- generic_qc_stage(d)

  qc_info <- attr(result, "qc_info")
  expect_identical(qc_info$dim, dim(d))
  expect_identical(qc_info$n_missing, 1L)
})

test_that("generic_qc_stage rejects a dataset with a zero dimension", {
  empty <- data.frame(feature_1 = numeric(0))
  expect_error(generic_qc_stage(empty))
})

test_that("generic_qc_stage rejects an object with no determinable dimensions", {
  expect_error(generic_qc_stage(list(a = 1, b = 2)))
})

# ---- Stage execution: generic Normalization -------------------------------

test_that("generic_normalization_stage 'identity' returns the dataset unchanged", {
  m <- matrix(1:6, nrow = 2)
  result <- generic_normalization_stage(m, method = "identity")
  expect_identical(result, m)
})

test_that("generic_normalization_stage 'scale' centers and scales a numeric matrix", {
  m <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 3)
  result <- generic_normalization_stage(m, method = "scale")

  expect_true(is.matrix(result))
  expect_equal(unname(colMeans(result)), c(0, 0), tolerance = 1e-10)
})

test_that("generic_normalization_stage rejects non-coercible-to-numeric input for 'scale'", {
  d <- data.frame(a = c("x", "y", "z"))
  expect_error(generic_normalization_stage(d, method = "scale"))
})

test_that("generic_normalization_stage defaults to 'identity'", {
  m <- matrix(1:4, nrow = 2)
  expect_identical(generic_normalization_stage(m), m)
})

# ---- Stage execution: generic Filtering -----------------------------------

test_that("generic_filtering_stage returns the dataset unchanged when no selection is given", {
  d <- sample_data()
  expect_identical(generic_filtering_stage(d), d)
})

test_that("generic_filtering_stage filters rows and columns generically", {
  d <- sample_data()
  result <- generic_filtering_stage(d, keep_rows = c(1, 2), keep_cols = 1)

  expect_identical(nrow(result), 2L)
  expect_identical(ncol(result), 1L)
})

# ---- Immutable Dataset Principle -------------------------------------------

test_that("execute_discovery_pipeline never modifies the original input dataset in place", {
  original <- sample_data()
  original_copy <- sample_data()

  p <- make_linear_pipeline()
  execute_discovery_pipeline(p, original)

  expect_identical(original, original_copy)
})

test_that("generic_qc_stage does not modify the input dataset in place", {
  original <- sample_data()
  original_copy <- sample_data()

  generic_qc_stage(original)

  expect_identical(original, original_copy)
})

test_that("generic_filtering_stage does not modify the input dataset in place", {
  original <- sample_data()
  original_copy <- sample_data()

  generic_filtering_stage(original, keep_rows = 1)

  expect_identical(original, original_copy)
})

# ---- Artifact generation (Contract-first Principle) ------------------------

test_that("execute_discovery_pipeline produces a valid Discovery contractual artifact", {
  p <- make_linear_pipeline()
  result <- execute_discovery_pipeline(p, sample_data())

  expect_true(is_artifact_contract(result$artifact))
  expect_identical(result$artifact$contract_type, "artifact")
  expect_identical(result$artifact$metadata$framework_layer, "processing")
  expect_true(isTRUE(validate_artifact_contract(result$artifact)))
})

test_that("execute_discovery_pipeline artifact records producer/consumer correctly", {
  p <- make_linear_pipeline()
  result <- execute_discovery_pipeline(p, sample_data(), consumer = "modeling_pipeline")

  expect_identical(result$artifact$producer, "processing_pipeline")
  expect_identical(result$artifact$consumer, "modeling_pipeline")
})

test_that("execute_discovery_pipeline artifact records the execution order in metadata", {
  p <- make_linear_pipeline()
  result <- execute_discovery_pipeline(p, sample_data())

  expect_identical(result$artifact$metadata$execution_order, c("qc", "normalize", "filter"))
})

# ---- Dependency consistency (reuses Module 03 APIs, no duplication) -------

test_that("execute_discovery_pipeline raises an error for an invalid pipeline (reuses validate_discovery_pipeline)", {
  p <- create_discovery_pipeline("bad")
  p <- register_discovery_stage(p, "a", dependencies = "missing", executor = function(dataset, ...) dataset)

  expect_error(execute_discovery_pipeline(p, sample_data()))
})

test_that("execute_discovery_pipeline raises an error for a cyclic pipeline (reuses resolve_pipeline_dependencies)", {
  p <- create_discovery_pipeline("cyclic")
  p <- register_discovery_stage(p, "a", dependencies = "b", executor = function(dataset, ...) dataset)
  p <- register_discovery_stage(p, "b", dependencies = "a", executor = function(dataset, ...) dataset)

  expect_error(execute_discovery_pipeline(p, sample_data()))
})

# ---- Execution ordering ----------------------------------------------------

test_that("execute_discovery_pipeline applies stage transformations in the correct order", {
  p <- create_discovery_pipeline("order_check")
  p <- register_discovery_stage(p, "step1", outputs = "out1",
                                 executor = function(dataset, ...) { dataset$log <- "step1"; dataset })
  p <- register_discovery_stage(p, "step2", inputs = "out1", outputs = "out2", dependencies = "step1",
                                 executor = function(dataset, ...) { dataset$log <- paste(dataset$log, "step2"); dataset })

  result <- execute_discovery_pipeline(p, data.frame(x = 1))

  expect_identical(result$processed_dataset$log, "step1 step2")
})
