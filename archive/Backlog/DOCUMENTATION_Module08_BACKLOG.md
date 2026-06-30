> library(GCSignatureFramework)
> 
> ## --------------------------------------------------
> ## Module 02
> ## --------------------------------------------------
> 
> artifact <- create_artifact_contract(
+   producer = "Discovery",
+   consumer = "Modeling",
+   outputs = list(
+     selected_features = c("A", "B", "C")
+   )
+ )
> 
> ## --------------------------------------------------
> ## Module 06
> ## --------------------------------------------------
> 
> spec <- create_model_specification(
+   algorithm_id = "placeholder_algorithm",
+   parameter_schema = list(
+     alpha = "numeric",
+     lambda = "numeric"
+   )
+ )
> 
> contract <- create_model_contract(
+   specification = spec,
+   discovery_artifacts = artifact
+ )
> 
> model_object <- create_model_object(
+   specification = spec,
+   contract = contract
+ )
> 
> ## --------------------------------------------------
> ## Module 07
> ## --------------------------------------------------
> 
> trained_model <- train_model(model_object)
> 
> training_object <- create_training_object(
+   trained_model = trained_model,
+   model_object = model_object
+ )
> 
> ## --------------------------------------------------
> ## Module 08
> ## --------------------------------------------------
> 
> candidate <- create_model_candidate(
+   training_object = training_object
+ )
> 
> evidence <- create_modeling_evidence(
+   training_object = training_object
+ )
> 
> print(candidate)
<model_candidate>
  producer:        placeholder_algorithm
  consumer:        validation_benchmark
  algorithm_id:    placeholder_algorithm
  training_object: embedded (lineage preserved)
> 
> print(evidence)
<modeling_evidence>
  producer:  placeholder_algorithm
  consumer:  validation_benchmark
  sections:  predictive_model, risk_score_definition, performance_profile, interpretability_profile, clinical_evaluation_profile
  training_object: embedded (lineage preserved)
> 
> str(candidate)
List of 7
 $ contract_type: chr "artifact"
 $ producer     : chr "placeholder_algorithm"
 $ consumer     : chr "validation_benchmark"
 $ inputs       :List of 1
  ..$ : chr "training_object"
 $ outputs      :List of 1
  ..$ : chr "model_candidate"
 $ dependencies : list()
 $ metadata     :List of 3
  ..$ framework_layer: chr "modeling"
  ..$ artifact_role  : chr "model_candidate"
  ..$ training_object:List of 3
  .. ..$ trained_model    :List of 3
  .. .. ..$ algorithm_id    : chr "placeholder_algorithm"
  .. .. ..$ parameter_schema:List of 2
  .. .. .. ..$ alpha : chr "numeric"
  .. .. .. ..$ lambda: chr "numeric"
  .. .. ..$ fitted          : logi TRUE
  .. ..$ training_metadata: list()
  .. ..$ model_object     :List of 3
  .. .. ..$ specification:List of 3
  .. .. .. ..$ algorithm_id    : chr "placeholder_algorithm"
  .. .. .. ..$ parameter_schema:List of 2
  .. .. .. .. ..$ alpha : chr "numeric"
  .. .. .. .. ..$ lambda: chr "numeric"
  .. .. .. ..$ metadata        : list()
  .. .. .. ..- attr(*, "class")= chr "model_specification"
  .. .. ..$ contract     :List of 3
  .. .. .. ..$ specification      :List of 3
  .. .. .. .. ..$ algorithm_id    : chr "placeholder_algorithm"
  .. .. .. .. ..$ parameter_schema:List of 2
  .. .. .. .. .. ..$ alpha : chr "numeric"
  .. .. .. .. .. ..$ lambda: chr "numeric"
  .. .. .. .. ..$ metadata        : list()
  .. .. .. .. ..- attr(*, "class")= chr "model_specification"
  .. .. .. ..$ discovery_artifacts:List of 1
  .. .. .. .. ..$ :List of 7
  .. .. .. .. .. ..$ contract_type: chr "artifact"
  .. .. .. .. .. ..$ producer     : chr "Discovery"
  .. .. .. .. .. ..$ consumer     : chr "Modeling"
  .. .. .. .. .. ..$ inputs       : list()
  .. .. .. .. .. ..$ outputs      :List of 1
  .. .. .. .. .. .. ..$ selected_features: chr [1:3] "A" "B" "C"
  .. .. .. .. .. ..$ dependencies : list()
  .. .. .. .. .. ..$ metadata     : list()
  .. .. .. .. .. ..- attr(*, "class")= chr [1:2] "artifact_contract" "contract"
  .. .. .. ..$ metadata           : list()
  .. .. .. ..- attr(*, "class")= chr "model_contract"
  .. .. ..$ metadata     : list()
  .. .. ..- attr(*, "class")= chr "model_object"
  .. ..- attr(*, "class")= chr "training_object"
 - attr(*, "class")= chr [1:3] "model_candidate" "artifact_contract" "contract"
> 
> str(evidence)
List of 7
 $ contract_type: chr "artifact"
 $ producer     : chr "placeholder_algorithm"
 $ consumer     : chr "validation_benchmark"
 $ inputs       :List of 1
  ..$ : chr "training_object"
 $ outputs      :List of 1
  ..$ : chr "modeling_evidence"
 $ dependencies : list()
 $ metadata     :List of 4
  ..$ framework_layer  : chr "modeling"
  ..$ artifact_role    : chr "modeling_evidence"
  ..$ training_object  :List of 3
  .. ..$ trained_model    :List of 3
  .. .. ..$ algorithm_id    : chr "placeholder_algorithm"
  .. .. ..$ parameter_schema:List of 2
  .. .. .. ..$ alpha : chr "numeric"
  .. .. .. ..$ lambda: chr "numeric"
  .. .. ..$ fitted          : logi TRUE
  .. ..$ training_metadata: list()
  .. ..$ model_object     :List of 3
  .. .. ..$ specification:List of 3
  .. .. .. ..$ algorithm_id    : chr "placeholder_algorithm"
  .. .. .. ..$ parameter_schema:List of 2
  .. .. .. .. ..$ alpha : chr "numeric"
  .. .. .. .. ..$ lambda: chr "numeric"
  .. .. .. ..$ metadata        : list()
  .. .. .. ..- attr(*, "class")= chr "model_specification"
  .. .. ..$ contract     :List of 3
  .. .. .. ..$ specification      :List of 3
  .. .. .. .. ..$ algorithm_id    : chr "placeholder_algorithm"
  .. .. .. .. ..$ parameter_schema:List of 2
  .. .. .. .. .. ..$ alpha : chr "numeric"
  .. .. .. .. .. ..$ lambda: chr "numeric"
  .. .. .. .. ..$ metadata        : list()
  .. .. .. .. ..- attr(*, "class")= chr "model_specification"
  .. .. .. ..$ discovery_artifacts:List of 1
  .. .. .. .. ..$ :List of 7
  .. .. .. .. .. ..$ contract_type: chr "artifact"
  .. .. .. .. .. ..$ producer     : chr "Discovery"
  .. .. .. .. .. ..$ consumer     : chr "Modeling"
  .. .. .. .. .. ..$ inputs       : list()
  .. .. .. .. .. ..$ outputs      :List of 1
  .. .. .. .. .. .. ..$ selected_features: chr [1:3] "A" "B" "C"
  .. .. .. .. .. ..$ dependencies : list()
  .. .. .. .. .. ..$ metadata     : list()
  .. .. .. .. .. ..- attr(*, "class")= chr [1:2] "artifact_contract" "contract"
  .. .. .. ..$ metadata           : list()
  .. .. .. ..- attr(*, "class")= chr "model_contract"
  .. .. ..$ metadata     : list()
  .. .. ..- attr(*, "class")= chr "model_object"
  .. ..- attr(*, "class")= chr "training_object"
  ..$ evidence_sections:List of 5
  .. ..$ predictive_model           : NULL
  .. ..$ risk_score_definition      : NULL
  .. ..$ performance_profile        : NULL
  .. ..$ interpretability_profile   : NULL
  .. ..$ clinical_evaluation_profile: NULL
 - attr(*, "class")= chr [1:3] "modeling_evidence" "artifact_contract" "contract"
> 
> ## --------------------------------------------------
> ## Validation
> ## --------------------------------------------------
> 
> validate_model_candidate(candidate)
> 
> identical(
+   candidate$training_object,
+   training_object
+ )
[1] FALSE
> 
> ## --------------------------------------------------
> #Structural validation (AD-03)
> 
>   training_before <- training_object
> 
> candidate <- create_model_candidate(
+   training_object = training_object
+ )
> 
> identical(
+   training_before,
+   training_object
+ )
[1] TRUE
> 
> ## --------------------------------------------------
> #Opaque Principle
> 
>   custom_training_object <- training_object
> 
> custom_training_object$trained_model <- list(
+   backend = "custom_engine",
+   payload = "opaque_object"
+ )
> 
> candidate <- create_model_candidate(
+   training_object = custom_training_object
+ )
> 
> evidence <- create_modeling_evidence(
+   training_object = custom_training_object
+ )
> 
> print(candidate)
<model_candidate>
  producer:        placeholder_algorithm
  consumer:        validation_benchmark
  algorithm_id:    placeholder_algorithm
  training_object: embedded (lineage preserved)
> 
> print(evidence)
<modeling_evidence>
  producer:  placeholder_algorithm
  consumer:  validation_benchmark
  sections:  predictive_model, risk_score_definition, performance_profile, interpretability_profile, clinical_evaluation_profile
  training_object: embedded (lineage preserved)
