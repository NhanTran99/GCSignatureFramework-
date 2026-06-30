library(GCSignatureFramework)

cat("========================================\n")
cat("Module 11 Runtime Demonstration\n")
cat("========================================\n\n")

############################################################
# Module 05 boundary
############################################################

artifact <- create_artifact_contract(
  producer = "discovery_pipeline",
  consumer = "modeling_pipeline",
  outputs = list("processed_dataset"),
  metadata = list(
    framework_layer = "processing"
  )
)

############################################################
# Module 06
############################################################

spec <- create_model_specification(
  algorithm_id = "demo_algorithm",
  parameter_schema = list(alpha = "numeric")
)

contract <- create_model_contract(
  spec,
  artifact
)

model_object <- create_model_object(
  spec,
  contract
)

############################################################
# Module 07
############################################################

trained_model <- train_model(model_object)

training_object <- create_training_object(
  trained_model,
  model_object
)

############################################################
# Module 08
############################################################

output <- create_model_output(training_object)

############################################################
# Module 09
############################################################

validation_object <-
  create_validation_object(
    output$model_candidate,
    output$modeling_evidence
  )

validation_result <- run_validation(validation_object)

############################################################
# Module 10
############################################################

benchmark_object <-
  create_benchmark_object(
    validation_result$validation_evidence
  )

benchmark_result <-
  run_benchmark(benchmark_object)

############################################################
# Module 11
############################################################

selection_object <-
  create_candidate_selection_object(
    benchmark_result$benchmark_evidence
  )

cat("\nInitial Candidate Selection Object\n")
print(selection_object)

selection_result <-
  run_candidate_selection(selection_object)

cat("\nUpdated Candidate Selection Object\n")
print(selection_result$candidate_selection_object)

cat("\nValidated Candidate\n")
print(selection_result$validated_candidate)

############################################################
# Candidate Selection APIs
############################################################

validate_candidate_selection_object(
  selection_result$candidate_selection_object
)

validate_validated_candidate(
  selection_result$validated_candidate
)

cat("\nCandidate Selection APIs: PASSED\n")

############################################################
# Components
############################################################

cat("\nSelection Components\n")
print(
  selection_result$
    candidate_selection_object$
    selection_components
)

cat("\nExecution Metadata\n")
print(
  selection_result$
    candidate_selection_object$
    execution_metadata
)

############################################################
# Lineage
############################################################

lineage_artifact <-
  selection_result$
  validated_candidate$
  metadata$
  candidate_selection_object$
  benchmark_evidence$
  metadata$
  benchmark_object$
  validation_evidence$
  metadata$
  validation_object$
  model_candidate$
  metadata$
  training_object$
  model_object$
  contract$
  discovery_artifacts[[1]]

cat(
  "\nLineage preserved: ",
  identical(lineage_artifact, artifact),
  "\n",
  sep = ""
)

cat("\n========================================\n")
cat("Module 11 Runtime Demo Finished\n")
cat("========================================\n")