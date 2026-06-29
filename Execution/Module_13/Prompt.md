# Module 13 — Interpretation Outputs (Evidence Integration)

---

## Project

**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework

**Coding Module:** Module 13 — Interpretation Outputs (Evidence Integration)

**Execution Phase**

---

# Governance

This Coding Module is governed, in precedence order, by:

1. PROJECT_GOVERNANCE_PROMPT_v4.6
2. FRAMEWORK_SPEC.md
3. IMPLEMENTATION_PHILOSOPHY_IDS_PHASE.md
4. IDS-005_Interpretability_Implementation.md
5. MODULE_TAXONOMY.md
6. IMPLEMENTATION_MASTER_PLAN.md
7. CODING_PHASE_PHILOSOPHY.md

All governing documents are LOCKED.

No governance document shall be modified or reinterpreted.

This document specializes the locked IDS-005 implementation contracts for Module 13 only. It introduces no new governance, no new framework contracts, and no modification of previous Coding Modules.

---

## Coding Prompt Consistency Check (performed before implementation)

`MODULE_13_PROMPT_SPEC.md` was checked against all previously LOCKED modules (01–12) and against IDS-005. **No conflict was identified.** Two design points were underspecified by the Spec and are clarified here for traceability:

**Clarification 1 — Interpretation Package's `metadata` context tags.** Resolved: `metadata$framework_layer = "interpretability"` (same layer as Module 12's Interpretation Evidence, since both belong to IDS-005) and `metadata$artifact_role = "interpretation_package"`. `contract_type` remains exactly `"artifact"`.

**Clarification 2 — Default downstream consumer.** The Spec states Interpretation Package "is the final Framework artifact produced by IDS-005" but does not name its downstream consumer. Resolved: defaults to `"clinical_translation"`, matching `IMPLEMENTATION_MASTER_PLAN.md`'s next phase (Phase F — Clinical Translation, IDS-006, Modules 14–15).

No clarification was required for S3 print methods, since the Spec (Section 5) explicitly requests `print.evidence_integration_object()` and `print.interpretation_package()`.

**Implementation note:** Module 13 reuses Module 12's existing exported `validate_interpretation_evidence()` directly (calling, not reimplementing, the existing structural check on the consumed Interpretation Evidence) — this fulfills, rather than violates, the anti-duplication constraint. No Module 12 file is modified.

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

Module 13 implements the **Evidence Integration** responsibility of IDS-005.

Its responsibilities are limited to:

* consume Interpretation Evidence;
* execute Evidence Integration workflow;
* construct Evidence Integration Object;
* construct Interpretation Package;
* verify Evidence Integration artifacts.

Module 13 SHALL NOT:

* perform biological reasoning;
* perform clinical interpretation;
* perform therapeutic recommendation;
* generate publication-ready discussion;
* generate scientific conclusions.

Interpretation Package is the final Framework artifact produced by IDS-005.

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

Module 13 follows the execution architecture established in Modules 09–12.

```text
Evidence Integration Workflow

↓

Evidence Integration Executor

↓

Evidence Integration Object

↓

Interpretation Package
```

Workflow performs orchestration only.

Executor performs execution only.

Evidence Integration Object captures implementation state.

Interpretation Package is the Framework artifact.

---

# 3. Evidence Integration Object

Evidence Integration Object is an implementation object.

It encapsulates:

* consumed Interpretation Evidence;
* integration components;
* execution metadata;
* execution lineage;
* implementation state.

It SHALL NOT be exposed as a Framework artifact.

---

# 4. Interpretation Package

Interpretation Package is the only Framework artifact produced by Module 13.

It represents the contractual Interpretation Output defined by IDS-005.

Interpretation Package shall preserve complete lineage while remaining structurally independent from Evidence Integration Object.

Interpretation Package SHALL NOT contain:

* biological reasoning;
* clinical interpretation;
* therapeutic recommendation;
* publication-ready discussion;
* scientific conclusions.

---

# 5. Public API

Primary execution:

```r
run_evidence_integration(
    evidence_integration_object,
    integrator = NULL,
    ...
)
```

Constructors:

```r
create_evidence_integration_object(
    interpretation_evidence
)

create_interpretation_package()
```

Validators:

```r
validate_evidence_integration_object()

validate_interpretation_package()
```

Required S3 methods:

```r
print.evidence_integration_object()

print.interpretation_package()
```

---

# 6. Integrator Callback Pattern

Module 13 follows the callback architecture established throughout Modules 07 and 09–12.

If `integrator = NULL`, invoke the default generic integrator.

Otherwise invoke the user-supplied integrator callback.

The callback replaces only the execution step. It SHALL NOT bypass workflow, verification, lineage, or artifact construction.

---

# 7. Generic Implementation Principle

Default implementation shall remain generic.

The default integrator performs only structural execution.

It SHALL NOT implement evidence synthesis, biological integration, clinical integration, publication formatting, or scientific conclusions.

Real methodology remains injectable through callback.

---

# 8. Integration Component Granularity

Evidence Integration shall support multiple independent integration components.

Default implementation shall produce `structural_check`.

Multiple components are aggregated into Interpretation Package.

No opaque integration result shall be produced.

---

# 9. Artifact Consumption

Module 13 consumes only Interpretation Evidence.

Consumption remains read-only.

Module 13 SHALL NOT modify Interpretation Evidence.

Module 13 SHALL NOT directly consume Validated Candidate, Benchmark Evidence, or Validation Evidence.

---

# 10. Lineage Preservation

Module 13 preserves lineage by embedding the complete Interpretation Evidence.

No new lineage shall be introduced.

Complete upstream traceability shall remain preserved automatically.

---

# 11. Verification

Module 13 verifies: Evidence Integration Object integrity; Interpretation Package integrity; artifact completeness; interface compliance; lineage preservation; downstream compatibility.

Scientific correctness is explicitly outside Module 13.

---

# 12. Documentation

Document every exported API using roxygen2.

Documentation shall describe purpose, arguments, return values, and implementation semantics.

Do not document scientific methodology.

---

# 13. Testing Requirements

Tests shall verify:

* Workflow orchestration.
* Default integrator execution.
* Custom integrator execution.
* Evidence Integration Object construction.
* Interpretation Package construction.
* Read-only Interpretation Evidence consumption.
* Complete lineage preservation.
* Verification APIs.
* Multiple integration component support.
* Failure handling.
* Generic implementation behavior.

Tests SHALL NOT verify evidence synthesis, biological correctness, clinical interpretation, publication formatting, or scientific validity.

---

# 14. Additive Constraints

Module 13 SHALL NOT modify Modules 01–12, public APIs, Framework contracts, or IDS contracts.

Module 13 is additive only.

---

# Execution History

Create:

Execution/

Module_13/

* Prompt.md
* Artifacts.md
* Execution_Log.md
* Review.md
* LOCK.md

Artifacts.md shall follow the standardized structure established in Module 01.

---

# 15. Deliverables

Implementation shall include: Evidence Integration workflow; Evidence Integration executor; Evidence Integration Object; Interpretation Package; validators; documentation; tests; execution history.

---

# 16. Definition of Done

Module 13 is complete only when:

1. Evidence Integration workflow implemented.
2. Generic integrator implemented.
3. Integrator callback mechanism implemented.
4. Evidence Integration Object implemented.
5. Interpretation Package implemented.
6. Evidence Integration verification implemented.
7. All tests pass.
8. `devtools::check()` reports 0 ERROR / 0 WARNING.
9. Local execution succeeds.
10. Governance review passes.
11. IDS compliance passes.
12. Execution history completed.
13. Read-only consumption of Interpretation Evidence verified, via test, to leave it unchanged (`identical()`).
14. Interpretation Package verified, via test, to introduce no new Framework Contract type and to not contain biological reasoning, clinical interpretation, therapeutic recommendation, publication-ready discussion, or scientific conclusions.
15. Public API surface verified to expose exactly the 5 required functions plus the 2 required print methods — no more, no fewer.
16. Strategist Review passes.
17. Project Coordinator approves Module LOCK.

---

# Constraints

This module SHALL NOT redesign previously LOCKED modules, modify existing public APIs, duplicate implementation already owned by previous modules, or introduce functionality outside the approved module scope.

---

# Deliverables (Module Output Summary)

* Evidence Integration workflow / executor
* Evidence Integration Object implementation
* Interpretation Package implementation
* `validate_evidence_integration_object()` / `validate_interpretation_package()`
* Public Evidence Integration API
* Documentation
* Test Suite
* Execution history

---

End of Module 13 Coding Prompt (merged from MODULE_13_PROMPT_SPEC.md, post Coding Prompt Consistency Check). This module completes IDS-005 (Interpretability) in full.
