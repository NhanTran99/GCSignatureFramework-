> library(GCSignatureFramework)
> 
> ## -----------------------------
> ## Module 02
> ## -----------------------------
> 
> artifact <- create_artifact_contract(
+   producer = "Discovery",
+   consumer = "Modeling",
+   outputs = list(
+     selected_features = c("A", "B", "C")
+   )
+ )
> 
> ## -----------------------------
> ## Module 06
> ## -----------------------------
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
> ## -----------------------------
> ## Module 07
> ## -----------------------------
> 
> trained_model <- train_model(model_object)
> 
> training_object <- create_training_object(
+   trained_model = trained_model,
+   model_object = model_object
+ )
> 
> print(training_object)
<training_object>
  algorithm_id:       placeholder_algorithm
  training_metadata:  0 item(s)
  model_object:       embedded (1 discovery artifact(s) in lineage)
> 
> str(training_object)
List of 3
 $ trained_model    :List of 3
  ..$ algorithm_id    : chr "placeholder_algorithm"
  ..$ parameter_schema:List of 2
  .. ..$ alpha : chr "numeric"
  .. ..$ lambda: chr "numeric"
  ..$ fitted          : logi TRUE
 $ training_metadata: list()
 $ model_object     :List of 3
  ..$ specification:List of 3
  .. ..$ algorithm_id    : chr "placeholder_algorithm"
  .. ..$ parameter_schema:List of 2
  .. .. ..$ alpha : chr "numeric"
  .. .. ..$ lambda: chr "numeric"
  .. ..$ metadata        : list()
  .. ..- attr(*, "class")= chr "model_specification"
  ..$ contract     :List of 3
  .. ..$ specification      :List of 3
  .. .. ..$ algorithm_id    : chr "placeholder_algorithm"
  .. .. ..$ parameter_schema:List of 2
  .. .. .. ..$ alpha : chr "numeric"
  .. .. .. ..$ lambda: chr "numeric"
  .. .. ..$ metadata        : list()
  .. .. ..- attr(*, "class")= chr "model_specification"
  .. ..$ discovery_artifacts:List of 1
  .. .. ..$ :List of 7
  .. .. .. ..$ contract_type: chr "artifact"
  .. .. .. ..$ producer     : chr "Discovery"
  .. .. .. ..$ consumer     : chr "Modeling"
  .. .. .. ..$ inputs       : list()
  .. .. .. ..$ outputs      :List of 1
  .. .. .. .. ..$ selected_features: chr [1:3] "A" "B" "C"
  .. .. .. ..$ dependencies : list()
  .. .. .. ..$ metadata     : list()
  .. .. .. ..- attr(*, "class")= chr [1:2] "artifact_contract" "contract"
  .. ..$ metadata           : list()
  .. ..- attr(*, "class")= chr "model_contract"
  ..$ metadata     : list()
  ..- attr(*, "class")= chr "model_object"
 - attr(*, "class")= chr "training_object"
> 
> ## -----------------------------
> ## Validation
> ## -----------------------------
> 
> validate_training_object(training_object)
> 
> identical(
+   training_object$model_object,
+   model_object
+ )
[1] TRUE
> 
> #AD-02
> model_before <- model_object
> 
> trained_model <- train_model(model_object)
> 
> identical(model_before, model_object)
[1] TRUE
> 
> #Customer trainer
> custom_trainer <- function(model_object) {
+   
+   list(
+     fitted = TRUE,
+     algorithm = "custom",
+     n_parameters = 123
+   )
+   
+ }
> 
> trained_model <- train_model(
+   model_object,
+   trainer = custom_trainer
+ )
> 
> str(trained_model)
List of 3
 $ fitted      : logi TRUE
 $ algorithm   : chr "custom"
 $ n_parameters: num 123
