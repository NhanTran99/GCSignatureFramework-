# ---- Test fixtures -------------------------------------------------------

valid_artifact <- function(consumer = "modeling_pipeline") {
  create_artifact_contract(
    producer = "discovery_pipeline",
    consumer = consumer,
    outputs = list("processed_dataset"),
    metadata = list(framework_layer = "processing")
  )
}

# ---- DiscoveryOutputVerifier: contract verification ------------------------

test_that("DiscoveryOutputVerifier passes contract verification for a valid artifact", {
  report <- DiscoveryOutputVerifier(valid_artifact())
  expect_true(report$categories$contract$passed)
  expect_length(report$categories$contract$issues, 0)
})

test_that("DiscoveryOutputVerifier fails contract verification for a non-artifact_contract object", {
  report <- DiscoveryOutputVerifier(list("not an artifact"))
  expect_false(report$categories$contract$passed)
  expect_true(length(report$categories$contract$issues) > 0)
})

# ---- DiscoveryOutputVerifier: interface verification -----------------------

test_that("DiscoveryOutputVerifier passes interface verification for a valid artifact", {
  report <- DiscoveryOutputVerifier(valid_artifact())
  expect_true(report$categories$interface$passed)
})

test_that("DiscoveryOutputVerifier fails interface verification for a non-'artifact' contract_type", {
  bad <- list(
    contract_type = "interface", producer = "A", consumer = "B",
    inputs = list(), outputs = list("x"), dependencies = list(),
    metadata = list(framework_layer = "processing")
  )
  report <- DiscoveryOutputVerifier(list(bad))
  expect_false(report$categories$interface$passed)
})

# ---- DiscoveryOutputVerifier: completeness verification --------------------

test_that("DiscoveryOutputVerifier passes completeness verification when outputs are declared", {
  report <- DiscoveryOutputVerifier(valid_artifact())
  expect_true(report$categories$completeness$passed)
})

test_that("DiscoveryOutputVerifier fails completeness verification when no outputs are declared", {
  no_outputs <- create_artifact_contract(
    producer = "discovery_pipeline", consumer = "modeling_pipeline",
    outputs = list(), metadata = list(framework_layer = "processing")
  )
  report <- DiscoveryOutputVerifier(no_outputs)
  expect_false(report$categories$completeness$passed)
})

test_that("DiscoveryOutputVerifier fails completeness verification for an empty artifact collection", {
  report <- DiscoveryOutputVerifier(list())
  expect_false(report$categories$completeness$passed)
})

# ---- DiscoveryOutputVerifier: traceability verification --------------------

test_that("DiscoveryOutputVerifier passes traceability verification when framework_layer is present", {
  report <- DiscoveryOutputVerifier(valid_artifact())
  expect_true(report$categories$traceability$passed)
})

test_that("DiscoveryOutputVerifier fails traceability verification when framework_layer is missing", {
  no_layer <- create_artifact_contract(
    producer = "discovery_pipeline", consumer = "modeling_pipeline",
    outputs = list("x"), metadata = list()
  )
  report <- DiscoveryOutputVerifier(no_layer)
  expect_false(report$categories$traceability$passed)
})

# ---- DiscoveryOutputVerifier: downstream compatibility verification --------

test_that("DiscoveryOutputVerifier passes downstream compatibility when consumer is declared", {
  report <- DiscoveryOutputVerifier(valid_artifact())
  expect_true(report$categories$downstream_compatibility$passed)
})

# ---- Collect-all verification behaviour -------------------------------------

test_that("DiscoveryOutputVerifier evaluates every category and reports all failures at once", {
  no_outputs_no_layer <- list(
    contract_type = "artifact", producer = "A", consumer = "B",
    inputs = list(), outputs = list(), dependencies = list(), metadata = list()
  )
  report <- DiscoveryOutputVerifier(list(no_outputs_no_layer))

  # Multiple categories should fail simultaneously, all recorded -- not
  # fail-fast (i.e. it doesn't stop after the first failing category).
  expect_false(report$categories$completeness$passed)
  expect_false(report$categories$traceability$passed)
  expect_false(report$passed)
})

test_that("DiscoveryOutputVerifier never raises an error for verification failures", {
  expect_error(DiscoveryOutputVerifier(list("not an artifact")), NA)
})

# ---- VerificationReport generation ------------------------------------------

test_that("DiscoveryOutputVerifier returns a verification_report object with expected structure", {
  report <- DiscoveryOutputVerifier(valid_artifact())

  expect_s3_class(report, "verification_report")
  expect_true(report$passed)
  expect_identical(report$artifact_count, 1L)
  expect_identical(
    names(report$categories),
    c("contract", "interface", "completeness", "traceability", "downstream_compatibility")
  )
})

test_that("DiscoveryOutputVerifier accepts a single artifact_contract or a list of them", {
  single_report <- DiscoveryOutputVerifier(valid_artifact())
  list_report <- DiscoveryOutputVerifier(list(valid_artifact()))

  expect_identical(single_report$artifact_count, 1L)
  expect_identical(list_report$artifact_count, 1L)
})

test_that("print.verification_report executes without error and is invisible", {
  report <- DiscoveryOutputVerifier(valid_artifact())
  expect_output(print(report), "verification_report")
  expect_invisible(print(report))
})

# ---- Discovery output export ------------------------------------------------

test_that("DiscoveryOutputExporter exports artifacts unchanged after successful verification", {
  artifacts <- list(valid_artifact())
  report <- DiscoveryOutputVerifier(artifacts)

  exported <- DiscoveryOutputExporter(artifacts, report)

  expect_identical(exported, artifacts)
})

test_that("DiscoveryOutputExporter accepts a single artifact_contract (not wrapped in a list)", {
  a <- valid_artifact()
  report <- DiscoveryOutputVerifier(a)

  exported <- DiscoveryOutputExporter(a, report)

  expect_identical(exported, list(a))
})

test_that("DiscoveryOutputExporter blocks export when verification did not pass", {
  bad <- create_artifact_contract(
    producer = "discovery_pipeline", consumer = "modeling_pipeline",
    outputs = list(), metadata = list()
  )
  report <- DiscoveryOutputVerifier(bad)

  expect_error(DiscoveryOutputExporter(bad, report))
})

test_that("DiscoveryOutputExporter rejects a report object of the wrong class", {
  expect_error(DiscoveryOutputExporter(valid_artifact(), list(passed = TRUE)))
})

test_that("DiscoveryOutputExporter rejects artifacts that do not match the verified report", {
  artifacts_a <- list(valid_artifact(consumer = "modeling_pipeline"))
  artifacts_b <- list(valid_artifact(consumer = "a_different_consumer"))
  report <- DiscoveryOutputVerifier(artifacts_a)

  expect_error(DiscoveryOutputExporter(artifacts_b, report))
})

# ---- Output immutability ----------------------------------------------------

test_that("DiscoveryOutputVerifier does not modify the supplied artifacts", {
  original <- valid_artifact()
  original_copy <- valid_artifact()

  DiscoveryOutputVerifier(original)

  expect_identical(original, original_copy)
})

test_that("DiscoveryOutputExporter does not modify the supplied artifacts", {
  artifacts <- list(valid_artifact())
  artifacts_copy <- list(valid_artifact())
  report <- DiscoveryOutputVerifier(artifacts)

  DiscoveryOutputExporter(artifacts, report)

  expect_identical(artifacts, artifacts_copy)
})

# ---- Contractual lineage preservation ---------------------------------------

test_that("DiscoveryOutputExporter preserves contractual identity exactly (no relabeling)", {
  artifacts <- list(valid_artifact())
  report <- DiscoveryOutputVerifier(artifacts)
  exported <- DiscoveryOutputExporter(artifacts, report)

  expect_identical(exported[[1]]$contract_type, "artifact")
  expect_identical(exported[[1]]$metadata$framework_layer, "processing")
  expect_identical(exported[[1]]$producer, artifacts[[1]]$producer)
  expect_identical(exported[[1]]$consumer, artifacts[[1]]$consumer)
})

test_that("DiscoveryOutputVerifier integrates end-to-end with execute_discovery_pipeline() output", {
  p <- create_discovery_pipeline("e2e_pipeline")
  p <- register_discovery_stage(p, "qc", outputs = "qc_dataset", executor = generic_qc_stage)

  result <- execute_discovery_pipeline(p, data.frame(x = 1:3), consumer = "modeling_pipeline")
  report <- DiscoveryOutputVerifier(result$artifact)

  expect_true(report$passed)

  exported <- DiscoveryOutputExporter(result$artifact, report)
  expect_identical(exported, list(result$artifact))
})
