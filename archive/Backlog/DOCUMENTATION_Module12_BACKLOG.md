> library(GCSignatureFramework)
> 
> cat("========================================\n")
========================================
> cat("Module 12 Runtime Demonstration\n")
Module 12 Runtime Demonstration
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
> cat("\nInitial Interpretation Object\n")

Initial Interpretation Object
> print(interpretation_object)
<interpretation_object>
  validated_candidate:        embedded (producer: demo_algorithm)
  interpretation_components:  0 component(s)
  execution_metadata:         0 item(s)
> 
> interpretation_result <-
+   run_interpretation(interpretation_object)
> 
> cat("\nUpdated Interpretation Object\n")

Updated Interpretation Object
> print(interpretation_result$interpretation_object)
<interpretation_object>
  validated_candidate:        embedded (producer: demo_algorithm)
  interpretation_components:  1 component(s)
  execution_metadata:         1 item(s)
> 
> cat("\nInterpretation Evidence\n")

Interpretation Evidence
> print(interpretation_result$interpretation_evidence)
<interpretation_evidence>
  producer:                   demo_algorithm
  consumer:                   interpretation_package
  interpretation_components:  structural_check
  interpretation_object:      embedded (lineage preserved)
> 
> ############################################################
> # Interpretation APIs
> ############################################################
> 
> validate_interpretation_object(
+   interpretation_result$interpretation_object
+ )
> 
> validate_interpretation_evidence(
+   interpretation_result$interpretation_evidence
+ )
> 
> cat("\nInterpretation APIs: PASSED\n")

Interpretation APIs: PASSED
> 
> ############################################################
> # Components
> ############################################################
> 
> cat("\nInterpretation Components\n")

Interpretation Components
> print(
+   interpretation_result$
+     interpretation_object$
+     interpretation_components
+ )
$structural_check
$structural_check$passed
[1] TRUE

$structural_check$details
[1] "generic structural check only; no pathway/enrichment/SHAP/feature-importance/biological methodology"


> 
> cat("\nExecution Metadata\n")

Execution Metadata
> print(
+   interpretation_result$
+     interpretation_object$
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
+   interpretation_result$
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
> cat("Module 12 Runtime Demo Finished\n")
Module 12 Runtime Demo Finished
> cat("========================================\n")
========================================
