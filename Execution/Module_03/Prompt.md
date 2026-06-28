# Module 03 — Discovery Framework Layer

---

## Project

**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework

**Coding Module:** Module 03 — Discovery Framework Layer

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

# Roles

**Project Coordinator**

* executes implementation locally
* performs local verification
* determines Module LOCK

**Coding Agent (Claude)**

* implements the Discovery Framework Layer only

**Strategist AI (ChatGPT)**

* reviews implementation
* evaluates governance and IDS compliance
* requests revisions if necessary

---

# Module Responsibility

Implement the **Discovery Framework Layer**.

This module establishes the orchestration layer used by future Discovery implementations.

No scientific discovery algorithm shall be implemented.

No biological assumptions shall be introduced.

---

# Additive-only Principle

Module 03 extends the LOCKED implementation produced by Module 02.

It shall not overwrite or redesign any existing implementation.

Only additive changes are permitted.

---

# Stable API Principle

All public APIs introduced by this module become stable framework APIs.

Future modules may extend these APIs but shall not rename them, change their semantics, or modify their returned object structure.

---

# Contract-first Principle (REVISED — see Pre-Implementation Decision Record below)

All pipeline objects, stages and workflow artifacts shall use the Framework Contracts implemented in Module 02.

No new object model shall be introduced.

No Discovery-specific artifact class shall be created.

Whenever a Discovery artifact is required, use:

`create_artifact_contract()`

The `contract_type` field SHALL remain `"artifact"`, consistent with the locked Module 02 API. `contract_type` is the framework's contract-ontology field (artifact / interface / dependency / verification) and SHALL NOT be used to encode domain or framework-layer context.

Discovery context SHALL be represented through the existing `metadata` field, for example:

```r
metadata = list(
  framework_layer = "discovery"
)
```

No new contract fields may be introduced. No change to Module 02's locked schema, validators, or any other locked behavior is permitted.

---

## Pre-Implementation Decision Record (Project Coordinator, prior to implementation)

**Issue identified:** the originally issued Coding Prompt specified `contract_type = "discovery"` when constructing Discovery artifacts via `create_artifact_contract()`. This conflicts with the Module 02 LOCKED implementation, where `create_artifact_contract()` has no `contract_type` parameter (it is hard-set internally to `"artifact"`), and `validate_artifact_contract()` requires `contract_type` to equal exactly `"artifact"`. Constructing a contract with `contract_type = "discovery"` would never pass the locked validator.

**Options considered:**
- **Option A (rejected):** add a new `contract_subtype` field to the canonical 7-field contract schema. Rejected because it modifies the LOCKED Module 02 schema and creates ripple effects across all four contract types (interface/dependency/verification would each need the same question answered, and all validators would need revision).
- **Option B (selected, refined):** represent Discovery context exclusively through the existing `metadata` field, with no schema change.

**Governing principle applied:** LOCKED implementation outranks a Coding Prompt; where the two conflict, the Prompt is corrected, not the locked implementation.

**Decision:** Option B, refined as follows — `contract_type` remains strictly an ontological field (artifact / interface / dependency / verification) and is never used to encode domain or framework-layer context. Framework-layer context (Discovery / Modeling / Validation & Benchmark / Interpretability / Clinical Translation) is recorded under `metadata$framework_layer`. This is kept conceptually distinct from a possible future `metadata$scientific_domain` (e.g. `"gastric_cancer"`), which is out of scope for this module and not implemented here.

This Coding Prompt has been corrected accordingly (see "Contract-first Principle" above) before implementation began. No Module 02 code, schema, or validator was modified.

---

# Zero Scientific Assumption Principle

The Discovery Framework Layer shall remain completely domain-agnostic.

The implementation SHALL NOT contain assumptions regarding:

* genes
* RNA
* microarray
* sequencing
* clinical variables
* radiomics
* cancer
* biomarker type

The framework shall operate only on abstract concepts:

* dataset
* feature
* sample
* target
* metadata
* pipeline
* stage
* artifact

---

# Discovery Pipeline Philosophy

Module 03 manages workflow orchestration only.

It does not perform computation.

It defines how Discovery pipelines are represented and validated.

Algorithm execution belongs to downstream modules.

---

# DAG-ready Principle

The pipeline representation shall support Directed Acyclic Graph (DAG) structures.

Module 03 SHALL NOT execute a DAG.

It only defines an internal representation capable of supporting future branching workflows.

Linear pipelines shall be treated as a valid special case of the DAG representation.

---

# Pipeline Representation

Represent a Discovery Pipeline as a structured base R list.

The minimum schema shall include:

* pipeline_name
* stages
* metadata
* status

The schema shall remain stable after Module LOCK.

---

# Stage Registration

Implement stage registration using:

register_discovery_stage()

Each stage shall minimally contain:

* stage_name
* inputs
* outputs
* dependencies
* executor

The executor shall remain a placeholder only.

No executable algorithm shall be attached.

---

# Dependency Resolution

Implement:

resolve_pipeline_dependencies()

Responsibilities:

* verify stage ordering
* verify dependency consistency
* verify input/output compatibility

The function SHALL NOT execute any pipeline stage.

It performs orchestration validation only.

---

# Required Public API

Implement the following public functions:

* create_discovery_pipeline()
* register_discovery_stage()
* run_discovery_pipeline()
* validate_discovery_pipeline()
* resolve_pipeline_dependencies()

Where appropriate, also provide:

* is_discovery_pipeline()
* print.discovery_pipeline()

All APIs shall follow the naming conventions established in Module 02.

---

# Package Dependencies

Do not introduce any machine learning or statistical framework.

Specifically do NOT add dependencies such as:

* glmnet
* xgboost
* caret
* mlr3
* tidymodels
* randomForest
* ranger

Only base R and previously approved package infrastructure may be used.

---

# Documentation

Document all exported APIs using roxygen2.

Documentation shall describe:

* purpose
* arguments
* return values
* orchestration semantics

Do not document future scientific implementations.

---

# Tests

Create dedicated tests for:

* pipeline construction
* stage registration
* dependency resolution
* contract consistency
* pipeline validation
* print methods
* predicate functions

Do NOT test:

* PCA
* normalization
* feature selection
* biomarker discovery
* machine learning
* statistical analysis

---

# Execution History

Create:

Execution/

Module_03/

* Prompt.md
* Artifacts.md
* Execution_Log.md
* Review.md
* LOCK.md

Artifacts.md shall follow the standardized template established in Module 01.

---

# In Scope

This module SHALL:

* implement the Discovery Framework Layer
* implement the Discovery Pipeline abstraction
* implement stage registration
* implement pipeline validation
* implement dependency resolution
* establish the canonical Discovery API

---

# Out of Scope

This module SHALL NOT implement:

* quality control
* normalization
* filtering
* feature engineering
* statistical analysis
* machine learning
* biomarker discovery
* biological interpretation
* visualization
* reporting
* benchmarking
* clinical translation

No scientific computation shall be implemented.

---

# Success Criteria

The Discovery Framework Layer compiles successfully.

Package loads successfully.

All Discovery APIs are available.

Discovery pipelines can be created.

Stages can be registered.

Dependency resolution functions correctly.

Pipeline validation functions correctly.

All tests pass.

Repository remains additive relative to Module 02.

---

# Definition of Done

Module 03 is complete only if:

1. Discovery Framework Layer implemented.
2. Discovery Pipeline representation established.
3. DAG-ready architecture established.
4. Stable Discovery API established.
5. Contract-first implementation maintained.
6. Zero Scientific Assumption Principle maintained.
7. Dependency resolution implemented.
8. Documentation generated successfully.
9. Tests pass.
10. Local execution succeeds.
11. `devtools::check()` reports **0 ERROR** and **0 WARNING**.
12. Governance compliance passes.
13. IDS compliance passes.
14. Repository remains additive.
15. Execution history updated.
16. Strategist Review passes.
17. Project Coordinator approves Module LOCK.

---

# Constraints

Do not redesign Modules 01–02.

Do not introduce scientific algorithms.

Do not introduce machine learning dependencies.

Do not create new object models.

Do not implement execution engines.

Implement orchestration only.

---

# Deliverables

* Discovery Framework Layer
* Discovery Pipeline abstraction
* Stage Registration API
* Dependency Resolution API
* Pipeline Validation API
* Documentation
* Test Suite
* Execution history templates

No additional functionality shall be introduced.

---

End of Module 03 Coding Prompt.
