# Module 09 — Validation

---

## Project

**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework

**Coding Module:** Module 09 — Validation

**Execution Phase**

---

# Governance

This Coding Module is governed, in precedence order, by:

1. PROJECT_GOVERNANCE_PROMPT_v4.6
2. FRAMEWORK_SPEC.md
3. IMPLEMENTATION_PHILOSOPHY_IDS_PHASE.md
4. IDS-004_Validation_Benchmark_Implementation.md
5. MODULE_TAXONOMY.md
6. IMPLEMENTATION_MASTER_PLAN.md
7. CODING_PHASE_PHILOSOPHY.md

All governing documents are LOCKED.

No governance document shall be modified or reinterpreted.

This document specializes the locked IDS-004 implementation contracts for Module 09 only. It introduces no new governance, no new framework contracts, and no modification of previous Coding Modules.

---

## Coding Prompt Consistency Check (performed before implementation)

`MODULE_09_PROMPT_SPEC.md` was checked against all previously LOCKED modules (01–08) and against IDS-004. **No conflict was identified.** Two design points were underspecified by the Spec and are clarified here for traceability:

**Clarification 1 — Validation Evidence's `metadata` context tags.** The Spec does not specify the `metadata$framework_layer` / `metadata$artifact_role` values for Validation Evidence. Resolved, extending the convention established across Modules 03–08 (`"discovery"` → `"processing"` → `"modeling"`): `metadata$framework_layer = "validation_benchmark"` (matching the IDS-004 domain name) and `metadata$artifact_role = "validation_evidence"` (matching the `model_candidate` / `modeling_evidence` precedent from Module 08, anticipating that Module 10 — Benchmark and Module 11 — Candidate Selection will introduce sibling `artifact_role` values within the same `framework_layer`). `contract_type` remains exactly `"artifact"`.

**Clarification 2 — S3 print methods.** The Spec's Public API list (Section 5) does not request `print.validation_object()` or `print.validation_evidence()`. Every implementation-object/Framework-artifact type introduced since Module 05 (`verification_report`, `model_object`, `training_object`, `model_candidate`, `modeling_evidence`) has nonetheless received a print method, exported only as the S3-dispatch registration (not counted as boundary-level public API, per the precedent established in those modules). The same two print methods are added here for consistency and usability; this is flagged explicitly for Strategist confirmation, since the Spec did not request it.

**Design note (not a conflict, confirming symmetry):** `run_validation()`'s responsibility list ("construct Validation Object; construct Validation Evidence") combined with its signature (`run_validation(validation_object, validator = NULL, ...)`) is implemented as: the caller first builds an initial Validation Object via `create_validation_object()` (encapsulating the consumed Model Candidate / Modeling Evidence read-only), then `run_validation()` executes the validator against it, returns an updated Validation Object (with `validation_components` and `execution_metadata` populated) together with the resulting Validation Evidence — mirroring Module 04's `execute_discovery_pipeline()`, which similarly returns `list(processed_dataset, artifact, execution_order)`. This symmetry was confirmed against the Spec's explicit statement that "Module 09 follows the Module 07 extensibility pattern" and the established Workflow/Execution architectural separation from Phase B/C.

**Implementation note:** Module 09 reuses Module 08's existing internal `.validate_modeling_evidence()` helper directly (calling, not reimplementing, the existing structural check on an embedded Modeling Evidence) — this fulfills, rather than violates, the anti-duplication constraint, since it is the same package and the helper already exists for exactly this purpose. No Module 08 file is modified.

No LOCKED module was modified to resolve either clarification.

---

# Roles

## Project Coordinator

* executes implementation locally
* performs local verification
* determines Module LOCK

## Coding Agent (Claude)

* implements this Coding Module only

## Strategist AI (ChatGPT)

* reviews implementation
* evaluates governance compliance
* evaluates IDS compliance
* requests revisions if necessary

---

# 1. Module Responsibility

Module 09 implements the **Validation responsibility** of IDS-004.

Its responsibilities are limited to:

* consume Modeling artifacts;
* execute Validation workflow;
* construct Validation Object;
* construct Validation Evidence;
* verify Validation artifacts;
* expose Validation Evidence for downstream Benchmark.

Module 09 SHALL NOT:

* produce Benchmark Evidence;
* perform Benchmark;
* perform Candidate Selection;
* produce Validated Candidates.

---

# Additive-only Principle

This module extends all previously LOCKED Coding Modules.

No locked implementation may be modified.

Only additive implementation is permitted.

---

# Stable API Principle

Previously established public APIs SHALL retain their function names, parameter semantics, return semantics, and implementation responsibilities.

This module may consume existing APIs but SHALL NOT redefine them.

---

# 2. Architectural Pattern

Module 09 follows the same execution architecture established in previous phases.

```
Validation Workflow

↓

Validation Executor

↓

Validation Object

↓

Validation Evidence
```

Responsibilities remain separated.

Workflow performs orchestration only.

Executor performs execution only.

Validation Object captures implementation state.

Validation Evidence is the Framework artifact.

---

# 3. Validation Object

Validation Object is an implementation object.

Its purpose is to encapsulate:

* consumed Modeling artifacts;
* execution metadata;
* validator output;
* execution lineage;
* implementation state.

Validation Object SHALL NOT be exposed as a Framework artifact.

---

# 4. Validation Evidence

Validation Evidence is the only Framework artifact produced by Module 09.

It represents the contractual Validation output defined by IDS-004.

Validation Evidence shall be structurally independent from Validation Object while preserving complete lineage.

Validation Evidence SHALL NOT contain:

* Benchmark Evidence;
* Candidate Selection;
* Validated Candidate information.

---

# 5. Public API

Module 09 exports:

## Primary execution

```r
run_validation(
    validation_object,
    validator = NULL,
    ...
)
```

Responsibilities:

* orchestrate execution;
* invoke validator;
* preserve workflow lifecycle;
* preserve contractual lineage;
* construct (update) Validation Object;
* construct Validation Evidence.

## Constructors

```r
create_validation_object()

create_validation_evidence()
```

## Validators

```r
validate_validation_object()

validate_validation_evidence()
```

## Required S3 print methods (per Consistency Check Clarification 2)

```r
print.validation_object()

print.validation_evidence()
```

---

# 6. Validation Callback Pattern

Module 09 follows the Module 07 extensibility pattern.

```
run_validation()

↓

validator = NULL
or
user validator

↓

Validation Executor

↓

Validation Object
```

If `validator = NULL`, Module 09 shall invoke the default generic validator.

If `validator` is supplied, Module 09 shall invoke the user validator.

The validator replaces only the execution step. It SHALL NOT bypass workflow, verification, lineage, or artifact construction.

---

# 7. Generic Implementation Principle

Default implementation shall remain generic.

The default validator performs only structural execution.

It SHALL NOT implement statistical validation, benchmark methodology, biological interpretation, candidate ranking, or model selection.

Real validation methodology remains injectable through the validator callback.

---

# 8. Validation Granularity

Validation shall support multiple independent validation components.

Module 09 aggregates these components into Validation Evidence.

Validation SHALL NOT collapse multiple validation components into one opaque result.

---

# 9. Artifact Consumption

Module 09 consumes only Model Candidate and Modeling Evidence.

Consumption remains read-only.

Module 09 SHALL NOT modify Modeling artifacts.

---

# 10. Verification

Module 09 verifies: Validation Object integrity; Validation Evidence integrity; artifact completeness; interface compliance; lineage preservation; downstream compatibility.

Scientific validity is explicitly outside Module 09.

---

# 11. Documentation

Document every exported API using roxygen2.

Documentation shall describe purpose, arguments, return values, and implementation semantics.

Do not document downstream Benchmark behavior.

---

# 12. Testing Requirements

Tests shall verify:

* Workflow orchestration.
* Default validator execution.
* Custom validator execution.
* Validation Object construction.
* Validation Evidence construction.
* Validation lineage preservation.
* Read-only consumption of Modeling artifacts.
* Verification APIs.
* Multiple validation component support.
* Failure handling.
* Generic implementation behavior.

Tests SHALL NOT verify benchmark methodology, statistical correctness, or scientific validity.

---

# 13. Additive Constraints

Module 09 SHALL NOT modify Modules 01–08, public APIs, Framework contracts, or IDS contracts.

Module 09 is additive only.

---

# Execution History

Create:

Execution/

Module_09/

* Prompt.md
* Artifacts.md
* Execution_Log.md
* Review.md
* LOCK.md

Artifacts.md shall follow the standardized structure established in Module 01.

---

# 14. Deliverables

Implementation shall include: Validation workflow; Validation executor; Validation Object; Validation Evidence; validators; documentation; tests; execution history.

---

# 15. Definition of Done (Module-specific)

Module 09 is complete only when:

1. Validation workflow implemented.
2. Generic validator implemented.
3. Validator callback mechanism implemented.
4. Validation Object implemented.
5. Validation Evidence implemented.
6. Validation verification implemented.
7. All tests pass.
8. `devtools::check()` reports 0 ERROR / 0 WARNING.
9. Local execution succeeds.
10. Governance review passes.
11. IDS compliance passes.
12. Execution history completed.
13. Read-only consumption of Model Candidate / Modeling Evidence verified, via test, to leave both unchanged (`identical()`).
14. Validation Evidence verified, via test, to introduce no new Framework Contract type and to not contain Benchmark Evidence, Candidate Selection, or Validated Candidate information.
15. Public API surface verified to expose exactly the 5 required functions plus the 2 required print methods — no more, no fewer.
16. Strategist Review passes.
17. Project Coordinator approves Module LOCK.

---

# Constraints

This module SHALL NOT redesign previously LOCKED modules, modify existing public APIs, duplicate implementation already owned by previous modules, or introduce functionality outside the approved module scope.

---

# Deliverables (Module Output Summary)

* Validation workflow / executor
* Validation Object implementation
* Validation Evidence implementation
* `validate_validation_object()` / `validate_validation_evidence()`
* Public Validation API
* Documentation
* Test Suite
* Execution history

---

End of Module 09 Coding Prompt (merged from MODULE_09_PROMPT_SPEC.md, post Coding Prompt Consistency Check).
