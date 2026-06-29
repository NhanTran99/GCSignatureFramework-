# Module 14 — Clinical Translation

---

## Project

**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework

**Coding Module:** Module 14 — Clinical Translation

**Execution Phase**

---

# Governance

This Coding Module is governed, in precedence order, by:

1. PROJECT_GOVERNANCE_PROMPT_v4.6
2. FRAMEWORK_SPEC.md
3. IMPLEMENTATION_PHILOSOPHY_IDS_PHASE.md
4. IDS-006_Clinical_Translation_Implementation.md
5. MODULE_TAXONOMY.md
6. IMPLEMENTATION_MASTER_PLAN.md
7. CODING_PHASE_PHILOSOPHY.md

All governing documents are LOCKED.

No governance document shall be modified or reinterpreted.

This document specializes the locked IDS-006 implementation contracts for Module 14 only. It introduces no new governance, no new framework contracts, and no modification of previous Coding Modules.

---

## Coding Prompt Consistency Check (performed before implementation)

`MODULE_14_PROMPT_SPEC.md` was checked against all previously LOCKED modules (01–13) and against IDS-006. **No conflict was identified.** Two design points were underspecified by the Spec and are clarified here for traceability:

**Clarification 1 — Clinical Translation Evidence's `metadata` context tags.** As the first module of a new domain (IDS-006), resolved by continuing the layer-naming precedent established across IDS-002–IDS-005 (`"discovery"`/`"processing"` → `"modeling"` → `"validation_benchmark"` → `"interpretability"`): `metadata$framework_layer = "clinical_translation"` (new layer, matching IDS-006's name) and `metadata$artifact_role = "clinical_translation_evidence"`. `contract_type` remains exactly `"artifact"`.

**Clarification 2 — Default downstream consumer.** The Spec states Module 15 is responsible for the final Clinical Translation Package, but does not name the `consumer` value. Resolved: defaults to `"clinical_translation_package"`, naming Module 15's responsibility directly (consistent with how prior defaults named the downstream module's responsibility, e.g. `"interpretation_package"`).

No clarification was required for S3 print methods, since the Spec (Section 5) explicitly requests `print.clinical_translation_object()` and `print.clinical_translation_evidence()`.

**Architectural note (per Strategist recommendation at the Interpretation Checkpoint):** Module 14 continues the identical Workflow → Executor → Implementation Object → Framework Artifact template used in Modules 09–13, with no shortcuts, to keep Modules 09–15 fully symmetric ahead of Coding Framework Integration after Module 15.

**Implementation note:** Module 14 reuses Module 13's existing exported `validate_interpretation_package()` directly (calling, not reimplementing, the existing structural check on the consumed Interpretation Package) — this fulfills, rather than violates, the anti-duplication constraint. No Module 13 file is modified.

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

Module 14 implements the **Clinical Translation** responsibility of IDS-006.

Its responsibilities are limited to:

* consume Interpretation Package;
* execute Clinical Translation workflow;
* construct Clinical Translation Object;
* construct Clinical Translation Evidence;
* verify Clinical Translation artifacts.

Module 14 SHALL NOT:

* generate Clinical Reports;
* construct Recommendation Packages;
* produce clinician-facing outputs;
* perform treatment recommendation;
* implement clinical decision support.

Module 15 is responsible for the final Clinical Translation Package.

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

Module 14 follows the execution architecture established in Modules 09–13.

```text
Clinical Translation Workflow

↓

Clinical Translation Executor

↓

Clinical Translation Object

↓

Clinical Translation Evidence
```

Workflow performs orchestration only.

Executor performs execution only.

Clinical Translation Object captures implementation state.

Clinical Translation Evidence is the Framework artifact.

---

# 3. Clinical Translation Object

Clinical Translation Object is an implementation object.

It encapsulates:

* consumed Interpretation Package;
* translation components;
* execution metadata;
* execution lineage;
* implementation state.

It SHALL NOT be exposed as a Framework artifact.

---

# 4. Clinical Translation Evidence

Clinical Translation Evidence is the only Framework artifact produced by Module 14.

It represents the contractual Clinical Translation output defined by IDS-006.

Clinical Translation Evidence shall preserve complete lineage while remaining structurally independent from Clinical Translation Object.

Clinical Translation Evidence SHALL NOT contain:

* treatment recommendation;
* clinical guideline reasoning;
* clinician-facing interpretation;
* patient recommendation;
* clinical decision support.

---

# 5. Public API

Primary execution:

```r
run_clinical_translation(
    clinical_translation_object,
    translator = NULL,
    ...
)
```

Constructors:

```r
create_clinical_translation_object(
    interpretation_package
)

create_clinical_translation_evidence()
```

Validators:

```r
validate_clinical_translation_object()

validate_clinical_translation_evidence()
```

Required S3 methods:

```r
print.clinical_translation_object()

print.clinical_translation_evidence()
```

---

# 6. Translator Callback Pattern

Module 14 follows the callback architecture established throughout Modules 07–13.

If `translator = NULL`, invoke the default generic translator.

Otherwise invoke the user-supplied translator callback.

The callback replaces only the execution step. It SHALL NOT bypass workflow, verification, lineage, or artifact construction.

---

# 7. Generic Implementation Principle

Default implementation shall remain generic.

The default translator performs only structural execution.

It SHALL NOT implement treatment recommendation, clinical guideline reasoning, patient stratification, therapeutic reasoning, or clinician-facing outputs.

Real clinical methodology remains injectable through callback.

---

# 8. Translation Component Granularity

Clinical Translation shall support multiple independent translation components.

Default implementation shall produce `structural_check`.

Multiple translation components are aggregated into Clinical Translation Evidence.

No opaque translation result shall be produced.

---

# 9. Artifact Consumption

Module 14 consumes only Interpretation Package.

Consumption remains read-only.

Module 14 SHALL NOT modify Interpretation Package.

Module 14 SHALL NOT directly consume Interpretation Evidence, Validated Candidate, Benchmark Evidence, or Validation Evidence.

---

# 10. Lineage Preservation

Module 14 preserves lineage by embedding the complete Interpretation Package.

No new lineage shall be introduced.

Complete upstream traceability shall remain preserved automatically.

---

# 11. Verification

Module 14 verifies: Clinical Translation Object integrity; Clinical Translation Evidence integrity; artifact completeness; interface compliance; lineage preservation; downstream compatibility.

Clinical correctness is explicitly outside Module 14.

---

# 12. Documentation

Document every exported API using roxygen2.

Documentation shall describe purpose, arguments, return values, and implementation semantics.

Do not document clinical methodology.

---

# 13. Testing Requirements

Tests shall verify:

* Workflow orchestration.
* Default translator execution.
* Custom translator execution.
* Clinical Translation Object construction.
* Clinical Translation Evidence construction.
* Read-only Interpretation Package consumption.
* Complete lineage preservation.
* Verification APIs.
* Multiple translation component support.
* Failure handling.
* Generic implementation behavior.

Tests SHALL NOT verify treatment recommendation, guideline reasoning, clinical correctness, or medical validity.

---

# 14. Additive Constraints

Module 14 SHALL NOT modify Modules 01–13, public APIs, Framework contracts, or IDS contracts.

Module 14 is additive only.

---

# Execution History

Create:

Execution/

Module_14/

* Prompt.md
* Artifacts.md
* Execution_Log.md
* Review.md
* LOCK.md

Artifacts.md shall follow the standardized structure established in Module 01.

---

# 15. Deliverables

Implementation shall include: Clinical Translation workflow; Clinical Translation executor; Clinical Translation Object; Clinical Translation Evidence; validators; documentation; tests; execution history.

---

# 16. Definition of Done

Module 14 is complete only when:

1. Clinical Translation workflow implemented.
2. Generic translator implemented.
3. Translator callback mechanism implemented.
4. Clinical Translation Object implemented.
5. Clinical Translation Evidence implemented.
6. Clinical Translation verification implemented.
7. All tests pass.
8. `devtools::check()` reports 0 ERROR / 0 WARNING.
9. Local execution succeeds.
10. Governance review passes.
11. IDS compliance passes.
12. Execution history completed.
13. Read-only consumption of Interpretation Package verified, via test, to leave it unchanged (`identical()`).
14. Clinical Translation Evidence verified, via test, to introduce no new Framework Contract type and to not contain treatment recommendation, clinical guideline reasoning, clinician-facing interpretation, patient recommendation, or clinical decision support.
15. Public API surface verified to expose exactly the 5 required functions plus the 2 required print methods — no more, no fewer.
16. Strategist Review passes.
17. Project Coordinator approves Module LOCK.

---

# Constraints

This module SHALL NOT redesign previously LOCKED modules, modify existing public APIs, duplicate implementation already owned by previous modules, or introduce functionality outside the approved module scope.

---

# Deliverables (Module Output Summary)

* Clinical Translation workflow / executor
* Clinical Translation Object implementation
* Clinical Translation Evidence implementation
* `validate_clinical_translation_object()` / `validate_clinical_translation_evidence()`
* Public Clinical Translation API
* Documentation
* Test Suite
* Execution history

---

End of Module 14 Coding Prompt (merged from MODULE_14_PROMPT_SPEC.md, post Coding Prompt Consistency Check). This module begins IDS-006 (Clinical Translation).
