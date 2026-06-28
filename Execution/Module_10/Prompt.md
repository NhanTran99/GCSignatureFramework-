# Module 10 — Benchmark

---

## Project

**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework

**Coding Module:** Module 10 — Benchmark

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

This document specializes the locked IDS-004 implementation contracts for Module 10 only. It introduces no new governance, no new framework contracts, and no modification of previous Coding Modules.

---

## Coding Prompt Consistency Check (performed before implementation)

`MODULE_10_PROMPT_SPEC.md` was checked against all previously LOCKED modules (01–09) and against IDS-004. **No conflict was identified.** One design point was underspecified by the Spec and is clarified here for traceability:

**Clarification — Benchmark Evidence's `metadata` context tags.** The Spec does not specify the `metadata$framework_layer` / `metadata$artifact_role` values for Benchmark Evidence. Resolved, continuing the precedent established in Module 09 (which explicitly anticipated this): `metadata$framework_layer = "validation_benchmark"` (same layer as Validation Evidence, since both belong to IDS-004) and `metadata$artifact_role = "benchmark_evidence"` (the sibling value to Module 09's `"validation_evidence"`, exactly as anticipated in Module 09's Consistency Check Clarification 1). `contract_type` remains exactly `"artifact"`.

No clarification was required for S3 print methods this time — unlike prior modules, the Spec (Section 5) explicitly requests `print.benchmark_object()` and `print.benchmark_evidence()`.

**Implementation note:** Module 10 reuses Module 09's existing exported `validate_validation_evidence()` directly (calling, not reimplementing, the existing structural check on the consumed Validation Evidence) — this fulfills, rather than violates, the anti-duplication constraint. No Module 09 file is modified.

No LOCKED module was modified to resolve this clarification.

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

Module 10 implements the **Benchmark responsibility** of IDS-004.

Its responsibilities are limited to:

* consume Validation Evidence;
* execute Benchmark workflow;
* construct Benchmark Object;
* construct Benchmark Evidence;
* verify Benchmark artifacts;
* expose Benchmark Evidence for downstream Candidate Selection.

Module 10 SHALL NOT:

* perform Candidate Selection;
* produce Validated Candidate;
* issue final recommendations;
* approve models.

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

Module 10 follows the same execution architecture established in previous phases.

```text
Benchmark Workflow

↓

Benchmark Executor

↓

Benchmark Object

↓

Benchmark Evidence
```

Responsibilities remain separated.

Workflow performs orchestration only.

Executor performs execution only.

Benchmark Object captures implementation state.

Benchmark Evidence is the Framework artifact.

---

# 3. Benchmark Object

Benchmark Object is an implementation object.

Its purpose is to encapsulate:

* consumed Validation Evidence;
* benchmark components;
* execution metadata;
* execution lineage;
* implementation state.

Benchmark Object SHALL NOT be exposed as a Framework artifact.

---

# 4. Benchmark Evidence

Benchmark Evidence is the only Framework artifact produced by Module 10.

It represents the contractual Benchmark output defined by IDS-004.

Benchmark Evidence shall be structurally independent from Benchmark Object while preserving complete lineage.

Benchmark Evidence SHALL NOT contain:

* Candidate Selection;
* Validated Candidate;
* final recommendation;
* model approval.

---

# 5. Public API

Module 10 exports:

## Primary execution

```r
run_benchmark(
    benchmark_object,
    benchmarker = NULL,
    ...
)
```

Responsibilities: orchestrate execution; invoke benchmarker; preserve workflow lifecycle; preserve contractual lineage; construct (update) Benchmark Object; construct Benchmark Evidence.

## Constructors

```r
create_benchmark_object()

create_benchmark_evidence()
```

## Validators

```r
validate_benchmark_object()

validate_benchmark_evidence()
```

## Required S3 print methods

```r
print.benchmark_object()

print.benchmark_evidence()
```

---

# 6. Benchmarker Callback Pattern

Module 10 follows the Module 09 extensibility pattern.

```text
run_benchmark()

↓

benchmarker = NULL or user benchmarker

↓

Benchmark Executor

↓

Benchmark Object
```

If `benchmarker = NULL`, Module 10 shall invoke the default generic benchmarker.

If a benchmarker is supplied, Module 10 shall invoke the caller-provided benchmark callback.

The callback replaces only the execution step. It SHALL NOT bypass workflow, verification, lineage, or artifact construction.

---

# 7. Generic Implementation Principle

Default implementation shall remain generic.

The default benchmarker performs only structural execution.

It SHALL NOT implement ROC analysis, AUC computation, survival comparison, statistical comparison, ranking, or machine learning methodology.

Real benchmark methodology remains injectable through the benchmark callback.

---

# 8. Benchmark Granularity

Benchmark shall support multiple independent benchmark components.

Module 10 aggregates these components into Benchmark Evidence.

Benchmark SHALL NOT collapse multiple benchmark components into one opaque result.

---

# 9. Artifact Consumption

Module 10 consumes only Validation Evidence.

Consumption remains read-only.

Module 10 SHALL NOT modify Validation Evidence.

Module 10 SHALL NOT directly consume Training Object, Model Candidate, or Modeling Evidence.

---

# 10. Verification

Module 10 verifies: Benchmark Object integrity; Benchmark Evidence integrity; artifact completeness; interface compliance; lineage preservation; downstream compatibility.

Scientific benchmark validity is explicitly outside Module 10.

---

# 11. Documentation

Document every exported API using roxygen2.

Documentation shall describe purpose, arguments, return values, and implementation semantics.

Do not document downstream Candidate Selection behavior.

---

# 12. Testing Requirements

Tests shall verify:

* Workflow orchestration.
* Default benchmarker execution.
* Custom benchmarker execution.
* Benchmark Object construction.
* Benchmark Evidence construction.
* Read-only Validation Evidence consumption.
* Benchmark lineage preservation.
* Verification APIs.
* Multiple benchmark component support.
* Failure handling.
* Generic implementation behavior.

Tests SHALL NOT verify benchmark methodology, ROC, AUC, statistical correctness, or scientific validity.

---

# 13. Additive Constraints

Module 10 SHALL NOT modify Modules 01–09, public APIs, Framework contracts, or IDS contracts.

Module 10 is additive only.

---

# Execution History

Create:

Execution/

Module_10/

* Prompt.md
* Artifacts.md
* Execution_Log.md
* Review.md
* LOCK.md

Artifacts.md shall follow the standardized structure established in Module 01.

---

# 14. Deliverables

Implementation shall include: Benchmark workflow; Benchmark executor; Benchmark Object; Benchmark Evidence; validators; documentation; tests; execution history.

---

# 15. Definition of Done (Module-specific)

Module 10 is complete only when:

1. Benchmark workflow implemented.
2. Generic benchmarker implemented.
3. Benchmarker callback mechanism implemented.
4. Benchmark Object implemented.
5. Benchmark Evidence implemented.
6. Benchmark verification implemented.
7. All tests pass.
8. `devtools::check()` reports 0 ERROR / 0 WARNING.
9. Local execution succeeds.
10. Governance review passes.
11. IDS compliance passes.
12. Execution history completed.
13. Read-only consumption of Validation Evidence verified, via test, to leave it unchanged (`identical()`).
14. Benchmark Evidence verified, via test, to introduce no new Framework Contract type and to not contain Candidate Selection, Validated Candidate, final recommendation, or model approval information.
15. Public API surface verified to expose exactly the 5 required functions plus the 2 required print methods — no more, no fewer.
16. Strategist Review passes.
17. Project Coordinator approves Module LOCK.

---

# Constraints

This module SHALL NOT redesign previously LOCKED modules, modify existing public APIs, duplicate implementation already owned by previous modules, or introduce functionality outside the approved module scope.

---

# Deliverables (Module Output Summary)

* Benchmark workflow / executor
* Benchmark Object implementation
* Benchmark Evidence implementation
* `validate_benchmark_object()` / `validate_benchmark_evidence()`
* Public Benchmark API
* Documentation
* Test Suite
* Execution history

---

End of Module 10 Coding Prompt (merged from MODULE_10_PROMPT_SPEC.md, post Coding Prompt Consistency Check).
