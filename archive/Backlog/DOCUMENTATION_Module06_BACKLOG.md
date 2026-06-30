> 
> artifact <- create_artifact_contract(
+   producer = "Discovery",
+   consumer = "Modeling",
+   outputs = list(
+     selected_features = c("A","B","C")
+   )
+ )
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
> model <- create_model_object(
+   specification = spec,
+   contract = contract
+ )
> 
> print(model)
<model_object>
  algorithm_id:          placeholder_algorithm
  parameter_schema:      2 item(s)
  discovery_artifacts:   1 artifact(s)
  metadata:              0 item(s)
> 
> str(model)
List of 3
 $ specification:List of 3
  ..$ algorithm_id    : chr "placeholder_algorithm"
  ..$ parameter_schema:List of 2
  .. ..$ alpha : chr "numeric"
  .. ..$ lambda: chr "numeric"
  ..$ metadata        : list()
  ..- attr(*, "class")= chr "model_specification"
 $ contract     :List of 3
  ..$ specification      :List of 3
  .. ..$ algorithm_id    : chr "placeholder_algorithm"
  .. ..$ parameter_schema:List of 2
  .. .. ..$ alpha : chr "numeric"
  .. .. ..$ lambda: chr "numeric"
  .. ..$ metadata        : list()
  .. ..- attr(*, "class")= chr "model_specification"
  ..$ discovery_artifacts:List of 1
  .. ..$ :List of 7
  .. .. ..$ contract_type: chr "artifact"
  .. .. ..$ producer     : chr "Discovery"
  .. .. ..$ consumer     : chr "Modeling"
  .. .. ..$ inputs       : list()
  .. .. ..$ outputs      :List of 1
  .. .. .. ..$ selected_features: chr [1:3] "A" "B" "C"
  .. .. ..$ dependencies : list()
  .. .. ..$ metadata     : list()
  .. .. ..- attr(*, "class")= chr [1:2] "artifact_contract" "contract"
  ..$ metadata           : list()
  ..- attr(*, "class")= chr "model_contract"
 $ metadata     : list()
 - attr(*, "class")= chr "model_object"
