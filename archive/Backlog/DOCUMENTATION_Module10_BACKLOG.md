> library(GCSignatureFramework)
> 
> cat("========================================\n")
========================================
> cat("Module 10 Runtime Demonstration\n")
Module 10 Runtime Demonstration
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
> cat("\nInitial Benchmark Object\n")

Initial Benchmark Object
> print(benchmark_object)
<benchmark_object>
  validation_evidence:   embedded (producer: demo_algorithm)
  benchmark_components:  0 component(s)
  execution_metadata:    0 item(s)
> 
> benchmark_result <-
+   run_benchmark(benchmark_object)
> 
> cat("\nUpdated Benchmark Object\n")

Updated Benchmark Object
> print(benchmark_result$benchmark_object)
<benchmark_object>
  validation_evidence:   embedded (producer: demo_algorithm)
  benchmark_components:  1 component(s)
  execution_metadata:    1 item(s)
> 
> cat("\nBenchmark Evidence\n")

Benchmark Evidence
> print(benchmark_result$benchmark_evidence)
<benchmark_evidence>
  producer:              demo_algorithm
  consumer:              candidate_selection
  benchmark_components:  structural_check
  benchmark_object:      embedded (lineage preserved)
> 
> ############################################################
> # Benchmark APIs
> ############################################################
> 
> validate_benchmark_object(
+   benchmark_result$benchmark_object
+ )
> 
> validate_benchmark_evidence(
+   benchmark_result$benchmark_evidence
+ )
> 
> cat("\nBenchmark APIs: PASSED\n")

Benchmark APIs: PASSED
> 
> ############################################################
> # Components
> ############################################################
> 
> cat("\nBenchmark Components\n")

Benchmark Components
> print(
+   benchmark_result$
+     benchmark_object$
+     benchmark_components
+ )
$structural_check
$structural_check$passed
[1] TRUE

$structural_check$details
[1] "generic structural check only; no ROC/AUC/survival/statistical/ML methodology"


> 
> cat("\nExecution Metadata\n")

Execution Metadata
> print(
+   benchmark_result$
+     benchmark_object$
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
+   benchmark_result$
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
> cat("Module 10 Runtime Demo Finished\n")
Module 10 Runtime Demo Finished
> cat("========================================\n")
========================================
