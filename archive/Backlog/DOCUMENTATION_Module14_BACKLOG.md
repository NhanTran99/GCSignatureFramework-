> library(GCSignatureFramework)
> 
> cat("========================================\n")
========================================
> cat("Module 14 Runtime Demonstration\n")
Module 14 Runtime Demonstration
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
> integration_result <-
+   run_evidence_integration(integration_object)
> 
> ############################################################
> # Module 14
> ############################################################
> 
> clinical_object <-
+   create_clinical_translation_object(
+     integration_result$interpretation_package
+   )
> 
> cat("\nInitial Clinical Translation Object\n")

Initial Clinical Translation Object
> print(clinical_object)
<clinical_translation_object>
  interpretation_package:  embedded (producer: demo_algorithm)
  translation_components:  0 component(s)
  execution_metadata:      0 item(s)
> 
> clinical_result <-
+   run_clinical_translation(clinical_object)
> 
> cat("\nUpdated Clinical Translation Object\n")

Updated Clinical Translation Object
> print(clinical_result$clinical_translation_object)
<clinical_translation_object>
  interpretation_package:  embedded (producer: demo_algorithm)
  translation_components:  1 component(s)
  execution_metadata:      1 item(s)
> 
> cat("\nClinical Translation Evidence\n")

Clinical Translation Evidence
> print(clinical_result$clinical_translation_evidence)
<clinical_translation_evidence>
  producer:                 demo_algorithm
  consumer:                 clinical_translation_package
  translation_components:   structural_check
  clinical_translation_object: embedded (lineage preserved)
> 
> ############################################################
> # Clinical Translation APIs
> ############################################################
> 
> validate_clinical_translation_object(
+   clinical_result$clinical_translation_object
+ )
> 
> validate_clinical_translation_evidence(
+   clinical_result$clinical_translation_evidence
+ )
> 
> cat("\nClinical Translation APIs: PASSED\n")

Clinical Translation APIs: PASSED
> 
> ############################################################
> # Components
> ############################################################
> 
> cat("\nTranslation Components\n")

Translation Components
> print(
+   clinical_result$
+     clinical_translation_object$
+     translation_components
+ )
$structural_check
$structural_check$passed
[1] TRUE

$structural_check$details
[1] "generic structural check only; no treatment-recommendation/guideline/patient-stratification/therapeutic methodology"


> 
> cat("\nExecution Metadata\n")

Execution Metadata
> print(
+   clinical_result$
+     clinical_translation_object$
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
+   clinical_result$
+   clinical_translation_evidence$
+   metadata$
+   clinical_translation_object$
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
> cat("Module 14 Runtime Demo Finished\n")
Module 14 Runtime Demo Finished
> cat("========================================\n")
========================================
