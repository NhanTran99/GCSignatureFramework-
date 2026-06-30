## Module 04

Title:
Workflow Layer vs Execution Layer

Priority:
High

Purpose:
Demonstrate the architectural separation between
run_discovery_pipeline() and execute_discovery_pipeline().

Content:
- Build a simple pipeline
- Register generic stages
- Show run_discovery_pipeline() does not invoke executors
- Show execute_discovery_pipeline() invokes executors
- Demonstrate Immutable Dataset Principle
- Demonstrate artifact generation



> dataset <- data.frame(
+   A = c(1, 2, 3, 4, 5),
+   B = c(6, 7, 8, 9, 10)
+ )
> 
> dataset_original <- dataset
> pipeline <- create_discovery_pipeline(
+   pipeline_name = "Demo Processing Pipeline"
+ )
> pipeline <- register_discovery_stage(
+   pipeline = pipeline,
+   stage_name = "qc",
+   outputs = "qc_dataset",
+   executor = generic_qc_stage
+ )
> pipeline <- register_discovery_stage(
+   pipeline = pipeline,
+   stage_name = "normalization",
+   inputs = "qc_dataset",
+   outputs = "normalized_dataset",
+   dependencies = "qc",
+   executor = generic_normalization_stage
+ )
> pipeline <- register_discovery_stage(
+   pipeline = pipeline,
+   stage_name = "filtering",
+   inputs = "normalized_dataset",
+   outputs = "processed_dataset",
+   dependencies = "normalization",
+   executor = generic_filtering_stage
+ )
> validate_discovery_pipeline(pipeline)
> resolve_pipeline_dependencies(pipeline)
[1] "qc"            "normalization" "filtering"    
> workflow <- run_discovery_pipeline(pipeline)
> workflow
<discovery_pipeline>
  pipeline_name: Demo Processing Pipeline
  status:        executed
  stages:        3 stage(s)
    - qc (depends on: none)
    - normalization (depends on: qc)
    - filtering (depends on: normalization)
  metadata:      1 item(s)
> result <- execute_discovery_pipeline(
+   pipeline,
+   dataset
+ )
> result$processed_dataset
  A  B
1 1  6
2 2  7
3 3  8
4 4  9
5 5 10
> print(result$artifact)
<artifact_contract>
  producer:     Demo Processing Pipeline
  consumer:     discovery_downstream
  inputs:       1 item(s)
  outputs:      1 item(s)
  dependencies: 0 item(s)
  metadata:     2 item(s)
> result$execution_order
[1] "qc"            "normalization" "filtering"    
> identical(dataset, dataset_original)
[1] TRUE
> attributes(result$processed_dataset)
$names
[1] "A" "B"

$class
[1] "data.frame"

$row.names
[1] 1 2 3 4 5

$qc_info
$qc_info$dim
[1] 5 2

$qc_info$n_missing
[1] 0


> result$artifact$metadata
$framework_layer
[1] "processing"

$execution_order
[1] "qc"            "normalization" "filtering"    

> flag <- FALSE
> 
> dummy_stage <- function(dataset, ...) {
+   flag <<- TRUE
+   dataset
+ }
> pipeline2 <- create_discovery_pipeline("Flag Demo")
> 
> pipeline2 <- register_discovery_stage(
+   pipeline2,
+   stage_name = "dummy",
+   outputs = "dataset",
+   executor = dummy_stage
+ )
> flag <- FALSE
> 
> run_discovery_pipeline(pipeline2)
<discovery_pipeline>
  pipeline_name: Flag Demo
  status:        executed
  stages:        1 stage(s)
    - dummy (depends on: none)
  metadata:      1 item(s)
> 
> flag
[1] FALSE
> flag <- FALSE
> 
> execute_discovery_pipeline(
+   pipeline2,
+   dataset
+ )
$processed_dataset
  A  B
1 1  6
2 2  7
3 3  8
4 4  9
5 5 10

$artifact
<artifact_contract>
  producer:     Flag Demo
  consumer:     discovery_downstream
  inputs:       1 item(s)
  outputs:      1 item(s)
  dependencies: 0 item(s)
  metadata:     2 item(s)

$execution_order
[1] "dummy"

> 
> flag
[1] TRUE
