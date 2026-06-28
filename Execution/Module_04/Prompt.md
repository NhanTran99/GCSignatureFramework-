# Module 04 — Discovery Processing

---

## Project

**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework

**Coding Module:** Module 04 — Discovery Processing

**Execution Phase**

---

# Governance

This Coding Module is governed, in precedence order, by:

1. PROJECT_GOVERNANCE_PROMPT_v4.6
2. FRAMEWORK_SPEC.md
3. IMPLEMENTATION_PHILOSOPHY_IDS_PHASE.md
4. IDS-002_Discovery_Implementation.md
5. MODULE_TAXONOMY.md
6. IMPLEMENTATION_MASTER_PLAN.md
7. CODING_PHASE_PHILOSOPHY.md

All governing documents are LOCKED.

No governance document shall be modified or reinterpreted.

---

# Pre-Implementation Decision Record

## Conflict Identified

The original Module 04 prompt stated that Discovery Processing should execute through the Discovery Pipeline using registered stage executors.

However, Module 03 has already been LOCKED with the following architectural decision:

* `run_discovery_pipeline()` performs orchestration only.
* It validates the pipeline.
* It resolves execution order.
* It SHALL NOT invoke stage executors.

Changing this behavior would violate:

* Stable API Principle
* Additive-only Principle
* Locked Module 03 implementation

---

## Decision

Locked implementation takes precedence over Prompt wording.

Module 03 SHALL remain unchanged.

Module 04 SHALL introduce a new execution-layer API:

`execute_discovery_pipeline(pipeline, dataset)`

This API SHALL:

1. validate the pipeline using the existing Module 03 API.
2. resolve execution order using the existing Module 03 API.
3. execute registered stage executors sequentially.
4. preserve the Immutable Dataset Principle.
5. produce the final processed dataset.
6. generate Discovery contractual artifacts.

No Module 03 code may be modified.

---

## Architectural Principle

Workflow orchestration and stage execution are separate responsibilities.

Module 03

↓

Workflow Layer

↓

Module 04

↓

Execution Layer

Future modules shall preserve this separation.

---

# Roles

Project Coordinator

* executes implementation locally
* performs local verification
* determines Module LOCK

Coding Agent (Claude)

* implements Discovery Processing only

Strategist AI (ChatGPT)

* reviews implementation
* evaluates governance and IDS compliance
* requests revisions if necessary

---

# Module Responsibility

Implement the Discovery Processing Layer.

The objective is to process generic datasets through reusable processing stages and produce Discovery contractual artifacts.

No scientific discovery algorithm shall be implemented.

---

# Additive-only Principle

Module 04 extends Modules 01–03.

No locked implementation may be modified.

Only additive implementation is permitted.

---

# Stable API Principle

No public API introduced in Modules 01–03 may change semantics.

New APIs introduced in Module 04 become stable after Module LOCK.

---

# Contract-first Principle

All produced artifacts shall use:

`create_artifact_contract()`

The canonical contract type remains:

`artifact`

Processing context SHALL be represented through:

```r
metadata = list(
    framework_layer = "processing"
)
```

No contract schema modifications are permitted.

---

# Zero Scientific Assumption Principle

Processing remains completely domain-agnostic.

The implementation SHALL NOT assume:

* genes
* RNA
* sequencing
* microarray
* proteins
* clinical variables
* cancer
* biomarker type

Processing operates only on generic datasets.

---

# Supported Dataset Types

Support generic processing of:

* data.frame
* matrix
* SummarizedExperiment (if available)

No project-specific dataset assumptions.

No GSE-specific logic.

---

# Processing Philosophy

Processing represents generic data preparation.

Scientific interpretation is explicitly outside the responsibility of this module.

---

# Processing Engine

Processing shall execute only through the Discovery Pipeline architecture.

Module 04 introduces the Execution Layer.

The canonical execution entry point is:

`execute_discovery_pipeline(pipeline, dataset)`

This function SHALL internally reuse:

* validate_discovery_pipeline()
* resolve_pipeline_dependencies()

It SHALL NOT duplicate orchestration logic.

---

# Processing Stage Interface

All processing executors shall implement:

```text
process(dataset, ...)
        ↓
processed_dataset
```

All stages shall follow the same interface.

---

# Generic Processing Stages

Implement generic reusable stages:

* Quality Control
* Normalization
* Filtering

Acceptable generic behaviour includes:

* structural validation
* missing-value inspection
* identity normalization or generic scaling
* generic row/column filtering

No statistical modelling.

No biological assumptions.

No feature selection.

---

# Immutable Dataset Principle

Input datasets SHALL never be modified in place.

Every processing stage returns a new processed dataset.

---

# Pipeline Integration

Processing execution SHALL occur through:

Discovery Pipeline

↓

validate_discovery_pipeline()

↓

resolve_pipeline_dependencies()

↓

execute_discovery_pipeline()

↓

processed dataset

↓

Discovery contractual artifact

---

# Produced Artifact

After successful processing:

Create a Discovery contractual artifact using:

`create_artifact_contract()`

with

```r
metadata = list(
    framework_layer = "processing"
)
```

No additional object model may be introduced.

---

# Required Public API

Implement the Processing Execution Layer.

Public API shall include:

* execute_discovery_pipeline()

Processing-specific APIs shall integrate directly with the Discovery Pipeline.

---

# Package Dependencies

Do not introduce:

* machine learning frameworks
* statistical modelling packages
* domain-specific dependencies

Only generic infrastructure may be used.

---

# Documentation

Document all exported APIs using roxygen2.

Documentation shall describe:

* purpose
* arguments
* return values
* execution semantics

Do not document downstream scientific algorithms.

---

# Tests

Test:

* processing execution
* stage execution
* immutable dataset behaviour
* pipeline integration
* artifact generation
* dependency consistency
* execution ordering

Do NOT test:

* PCA
* feature selection
* biomarker discovery
* machine learning
* statistical modelling

---

# Execution History

Create:

Execution/

Module_04/

* Prompt.md
* Artifacts.md
* Execution_Log.md
* Review.md
* LOCK.md

Artifacts.md shall follow the standardized structure established in Module 01.

---

# In Scope

This module SHALL:

* implement the Processing Execution Layer
* implement generic QC
* implement generic Normalization
* implement generic Filtering
* execute registered processing stages
* integrate execution with the Discovery Pipeline
* produce Discovery contractual artifacts
* preserve contractual lineage

---

# Out of Scope

This module SHALL NOT implement:

* feature selection
* biomarker discovery
* statistical analysis
* machine learning
* modelling
* benchmarking
* interpretation
* clinical translation
* biological knowledge
* project-specific dataset logic

---

# Success Criteria

Processing execution succeeds.

Pipeline execution succeeds.

Input datasets remain immutable.

Processed datasets are produced.

Discovery contractual artifacts are generated.

All tests pass.

Repository remains additive relative to Module 03.

---

# Definition of Done

Module 04 is complete only if:

1. Processing Execution Layer implemented.
2. Generic QC implemented.
3. Generic Normalization implemented.
4. Generic Filtering implemented.
5. `execute_discovery_pipeline()` implemented.
6. Module 03 APIs reused without modification.
7. Immutable Dataset Principle respected.
8. Discovery contractual artifacts produced.
9. Contract-first implementation maintained.
10. Documentation generated successfully.
11. Tests pass.
12. Local execution succeeds.
13. `devtools::check()` reports **0 ERROR** and **0 WARNING**.
14. Governance compliance passes.
15. IDS compliance passes.
16. Repository remains additive.
17. Execution history updated.
18. Strategist Review passes.
19. Project Coordinator approves Module LOCK.

---

# Constraints

Do not redesign Modules 01–03.

Do not modify `run_discovery_pipeline()`.

Do not duplicate orchestration logic.

Do not introduce scientific algorithms.

Do not introduce machine learning.

Do not introduce biological assumptions.

Do not create new object models.

Implement the Discovery Processing Execution Layer only.

---

# Deliverables

* Processing Execution Layer
* Generic QC Stage
* Generic Normalization Stage
* Generic Filtering Stage
* `execute_discovery_pipeline()`
* Discovery Processing artifact generation
* Pipeline integration
* Documentation
* Test Suite
* Execution history templates

No additional functionality shall be introduced.

---

End of Module 04 Coding Prompt (v2).
