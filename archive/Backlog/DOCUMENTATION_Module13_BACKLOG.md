> library(GCSignatureFramework)
> 
> cat("========================================\n")
========================================
> cat("Module 13 Runtime Demonstration\n")
Module 13 Runtime Demonstration
> cat("========================================\n\n")
========================================

> 
> ############################################################
> # Module 05 boundary
> ############################################################
> 
> artifact <- create_artifact_contract(
+   producer = "discovery_pipeline",
+   consumer = "modeling_pipeline",
+   outputs = list("processed_dataset"),
+   metadata = list(
+     framework_layer = "processing"
+   )
+ )
> 
> ############################################################
> # Module 06
> ############################################################
> 
> spec <- create_model_specification(
+   algorithm_id = "demo_algorithm",
+   parameter_schema = list(alpha = "numeric")
+ )
> 
> contract <- create_model_contract(
+   spec,
+   artifact
+ )
> 
> model_object <- create_model_object(
+   spec,
+   contract
+ )
> 
> ############################################################
> # Module 07
> ############################################################
> 
> trained_model <- train_model(model_object)
> 
> training_object <- create_training_object(
+   trained_model,
+   model_object
+ )
> 
> ############################################################
> # Module 08
> ############################################################
> 
> output <- create_model_output(training_object)
> 
> ############################################################
> # Module 09
> ############################################################
> 
> validation_object <-
+   create_validation_object(
+     output$model_candidate,
+     output$modeling_evidence
+   )
> 
> validation_result <- run_validation(validation_object)
> 
> ############################################################
> # Module 10
> ############################################################
> 
> benchmark_object <-
+   create_benchmark_object(
+     validation_result$validation_evidence
+   )
> 
> benchmark_result <-
+   run_benchmark(benchmark_object)
> 
> ############################################################
> # Module 11
> ############################################################
> 
> selection_object <-
+   create_candidate_selection_object(
+     benchmark_result$benchmark_evidence
+   )
> 
> selection_result <-
+   run_candidate_selection(selection_object)
> 
> ############################################################
> # Module 12
> ############################################################
> 
> interpretation_object <-
+   create_interpretation_object(
+     selection_result$validated_candidate
+   )
> 
> interpretation_result <-
+   run_interpretation(interpretation_object)
> 
> ############################################################
> # Module 13
> ############################################################
> 
> integration_object <-
+   create_evidence_integration_object(
+     interpretation_result$interpretation_evidence
+   )
> 
> cat("\nInitial Evidence Integration Object\n")

Initial Evidence Integration Object
> print(integration_object)
<evidence_integration_object>
  interpretation_evidence:  embedded (producer: demo_algorithm)
  integration_components:   0 component(s)
  execution_metadata:       0 item(s)
> 
> integration_result <-
+   run_evidence_integration(integration_object)
> 
> cat("\nUpdated Evidence Integration Object\n")

Updated Evidence Integration Object
> print(integration_result$evidence_integration_object)
<evidence_integration_object>
  interpretation_evidence:  embedded (producer: demo_algorithm)
  integration_components:   1 component(s)
  execution_metadata:       1 item(s)
> 
> cat("\nInterpretation Package\n")

Interpretation Package
> print(integration_result$interpretation_package)
<interpretation_package>
  producer:                  demo_algorithm
  consumer:                  clinical_translation
  integration_components:    structural_check
  evidence_integration_object: embedded (lineage preserved)
> 
> ############################################################
> # Evidence Integration APIs
> ############################################################
> 
> validate_evidence_integration_object(
+   integration_result$evidence_integration_object
+ )
> 
> validate_interpretation_package(
+   integration_result$interpretation_package
+ )
> 
> cat("\nEvidence Integration APIs: PASSED\n")

Evidence Integration APIs: PASSED
> 
> ############################################################
> # Components
> ############################################################
> 
> cat("\nIntegration Components\n")

Integration Components
> print(
+   integration_result$
+     evidence_integration_object$
+     integration_components
+ )
$structural_check
$structural_check$passed
[1] TRUE

$structural_check$details
[1] "generic structural check only; no evidence-synthesis/biological/clinical/publication methodology"


> 
> cat("\nExecution Metadata\n")

Execution Metadata
> print(
+   integration_result$
+     evidence_integration_object$
+     execution_metadata
+ )
$executed
[1] TRUE

> 
> ############################################################
> # Lineage
> ############################################################
> 
> lineage_artifact <-
+   integration_result$
+   interpretation_package$
+   metadata$
+   evidence_integration_object$
+   interpretation_evidence$
+   metadata$
+   interpretation_object$
+   validated_candidate$
+   metadata$
+   candidate_selection_object$
+   benchmark_evidence$
+   metadata$
+   benchmark_object$
+   validation_evidence$
+   metadata$
+   validation_object$
+   model_candidate$
+   metadata$
+   training_object$
+   model_object$
+   contract$
+   discovery_artifacts[[1]]
> 
> cat(
+   "\nLineage preserved: ",
+   identical(lineage_artifact, artifact),
+   "\n",
+   sep = ""
+ )

Lineage preserved: TRUE
> 
> cat("\n========================================\n")

========================================
> cat("Module 13 Runtime Demo Finished\n")
Module 13 Runtime Demo Finished
> cat("========================================\n")
========================================
