> #Demo 1
> 
> library(GCSignatureFramework)
> 
> dummy_executor <- function(dataset, ...) {
+   dataset
+ }
> 
> pipeline <- create_discovery_pipeline("demo")
> 
> pipeline <- register_discovery_stage(
+   pipeline,
+   stage_name = "qc",
+   executor = dummy_executor
+ )
> 
> result <- execute_discovery_pipeline(
+   pipeline,
+   iris
+ )
> 
> str(result)
List of 3
 $ processed_dataset:'data.frame':	150 obs. of  5 variables:
  ..$ Sepal.Length: num [1:150] 5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
  ..$ Sepal.Width : num [1:150] 3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
  ..$ Petal.Length: num [1:150] 1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
  ..$ Petal.Width : num [1:150] 0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
  ..$ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ artifact         :List of 7
  ..$ contract_type: chr "artifact"
  ..$ producer     : chr "demo"
  ..$ consumer     : chr "discovery_downstream"
  ..$ inputs       :List of 1
  .. ..$ : chr "dataset"
  ..$ outputs      :List of 1
  .. ..$ : chr "processed_dataset"
  ..$ dependencies : list()
  ..$ metadata     :List of 2
  .. ..$ framework_layer: chr "processing"
  .. ..$ execution_order: chr "qc"
  ..- attr(*, "class")= chr [1:2] "artifact_contract" "contract"
 $ execution_order  : chr "qc"
> 
> #Demo 2
> report <- DiscoveryOutputVerifier(result$artifact)
> 
> print(report)
<verification_report>
  artifact_count: 1
  passed:         TRUE
  - contract: PASS
  - interface: PASS
  - completeness: PASS
  - traceability: PASS
  - downstream_compatibility: PASS
> 
> str(report)
List of 4
 $ artifacts     :List of 1
  ..$ :List of 7
  .. ..$ contract_type: chr "artifact"
  .. ..$ producer     : chr "demo"
  .. ..$ consumer     : chr "discovery_downstream"
  .. ..$ inputs       :List of 1
  .. .. ..$ : chr "dataset"
  .. ..$ outputs      :List of 1
  .. .. ..$ : chr "processed_dataset"
  .. ..$ dependencies : list()
  .. ..$ metadata     :List of 2
  .. .. ..$ framework_layer: chr "processing"
  .. .. ..$ execution_order: chr "qc"
  .. ..- attr(*, "class")= chr [1:2] "artifact_contract" "contract"
 $ categories    :List of 5
  ..$ contract                :List of 2
  .. ..$ passed: logi TRUE
  .. ..$ issues: chr(0) 
  ..$ interface               :List of 2
  .. ..$ passed: logi TRUE
  .. ..$ issues: chr(0) 
  ..$ completeness            :List of 2
  .. ..$ passed: logi TRUE
  .. ..$ issues: chr(0) 
  ..$ traceability            :List of 2
  .. ..$ passed: logi TRUE
  .. ..$ issues: chr(0) 
  ..$ downstream_compatibility:List of 2
  .. ..$ passed: logi TRUE
  .. ..$ issues: chr(0) 
 $ passed        : logi TRUE
 $ artifact_count: int 1
 - attr(*, "class")= chr "verification_report"
> 
> #Demo 3
> outputs <- DiscoveryOutputExporter(
+   result$artifact,
+   report
+ )
> 
> print(outputs)
[[1]]
<artifact_contract>
  producer:     demo
  consumer:     discovery_downstream
  inputs:       1 item(s)
  outputs:      1 item(s)
  dependencies: 0 item(s)
  metadata:     2 item(s)

> 
> str(outputs)
List of 1
 $ :List of 7
  ..$ contract_type: chr "artifact"
  ..$ producer     : chr "demo"
  ..$ consumer     : chr "discovery_downstream"
  ..$ inputs       :List of 1
  .. ..$ : chr "dataset"
  ..$ outputs      :List of 1
  .. ..$ : chr "processed_dataset"
  ..$ dependencies : list()
  ..$ metadata     :List of 2
  .. ..$ framework_layer: chr "processing"
  .. ..$ execution_order: chr "qc"
  ..- attr(*, "class")= chr [1:2] "artifact_contract" "contract"
> 
> #Demo 4
> getNamespaceExports("GCSignatureFramework")
 [1] "create_verification_contract"   "DiscoveryOutputVerifier"       
 [3] "is_dependency_contract"         "validate_discovery_pipeline"   
 [5] "run_discovery_pipeline"         "is_verification_contract"      
 [7] "is_interface_contract"          "execute_discovery_pipeline"    
 [9] "create_dependency_contract"     "resolve_pipeline_dependencies" 
[11] "validate_artifact_contract"     "is_discovery_pipeline"         
[13] "generic_normalization_stage"    "create_artifact_contract"      
[15] "create_interface_contract"      "generic_qc_stage"              
[17] "validate_interface_contract"    "create_discovery_pipeline"     
[19] "validate_dependency_contract"   "DiscoveryOutputExporter"       
[21] "register_discovery_stage"       "validate_verification_contract"
[23] "is_artifact_contract"           "generic_filtering_stage"       
> 
> #Export API guard
> library(GCSignatureFramework)
> 
> artifact <- create_artifact_contract(
+   producer = "A",
+   consumer = "B",
+   outputs = list("x"),
+   metadata = list(
+     framework_layer = "processing"
+   )
+ )
> 
> artifact_before <- artifact
> 
> report <- DiscoveryOutputVerifier(artifact)
> 
> artifact_after <- artifact
> 
> identical(
+   artifact_before,
+   artifact_after
+ )
[1] TRUE
