> library(GCSignatureFramework)
> ############################################################
> # Module 05 output
> ############################################################
> 
> discovery_artifact <- create_artifact_contract(
+   producer = "discovery",
+   consumer = "modeling",
+   payload = list(genes = c("A","B","C"))
+ )
Error in create_artifact_contract(producer = "discovery", consumer = "modeling",  : 
  unused argument (payload = list(genes = c("A", "B", "C")))
> library(GCSignatureFramework)
> 
> cat("========================================\n")
========================================
> cat("Module 09 Runtime Demonstration\n")
Module 09 Runtime Demonstration
> cat("========================================\n\n")
========================================

> 
> ############################################################
> # Discovery artifact (Module 05 boundary)
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
> cat("Model Candidate\n")
Model Candidate
> print(output$model_candidate)
<model_candidate>
  producer:        demo_algorithm
  consumer:        validation_benchmark
  algorithm_id:    demo_algorithm
  training_object: embedded (lineage preserved)
> 
> cat("\nModeling Evidence\n")

Modeling Evidence
> print(output$modeling_evidence)
<modeling_evidence>
  producer:  demo_algorithm
  consumer:  validation_benchmark
  sections:  predictive_model, risk_score_definition, performance_profile, interpretability_profile, clinical_evaluation_profile
  training_object: embedded (lineage preserved)
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
> cat("\nInitial Validation Object\n")

Initial Validation Object
> print(validation_object)
<validation_object>
  model_candidate:        embedded (producer: demo_algorithm)
  modeling_evidence:      embedded (producer: demo_algorithm)
  validation_components:  0 component(s)
  execution_metadata:     0 item(s)
> 
> ############################################################
> # Execute validation
> ############################################################
> 
> result <- run_validation(validation_object)
> 
> cat("\nUpdated Validation Object\n")

Updated Validation Object
> print(result$validation_object)
<validation_object>
  model_candidate:        embedded (producer: demo_algorithm)
  modeling_evidence:      embedded (producer: demo_algorithm)
  validation_components:  1 component(s)
  execution_metadata:     1 item(s)
> 
> cat("\nValidation Evidence\n")

Validation Evidence
> print(result$validation_evidence)
<validation_evidence>
  producer:               demo_algorithm
  consumer:               benchmark
  validation_components:  structural_check
  validation_object:      embedded (lineage preserved)
> 
> ############################################################
> # Validation API
> ############################################################
> 
> validate_validation_object(
+   result$validation_object
+ )
> 
> validate_validation_evidence(
+   result$validation_evidence
+ )
> 
> cat("\nValidation APIs: PASSED\n")

Validation APIs: PASSED
> 
> ############################################################
> # Show validator output
> ############################################################
> 
> cat("\nValidation Components\n")

Validation Components
> print(result$validation_object$validation_components)
$structural_check
$structural_check$passed
[1] TRUE

$structural_check$details
[1] "generic structural check only; no statistical/biological methodology"


> 
> cat("\nExecution Metadata\n")

Execution Metadata
> print(result$validation_object$execution_metadata)
$executed
[1] TRUE

> 
> ############################################################
> # Lineage check
> ############################################################
> 
> lineage_artifact <-
+   result$validation_evidence$
+   metadata$
+   validation_object$
+   model_candidate$
+   metadata$
+   training_object$
+   model_object$
+   contract$
+   discovery_artifacts[[1]]
> 
> cat("\nLineage preserved: ",
+     identical(lineage_artifact, artifact),
+     "\n",
+     sep = "")

Lineage preserved: TRUE
> 
> cat("\n========================================\n")

========================================
> cat("Module 09 Runtime Demo Finished\n")
Module 09 Runtime Demo Finished
> cat("========================================\n")
========================================