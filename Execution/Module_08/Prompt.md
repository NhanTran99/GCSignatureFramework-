# Module 08 — Model Outputs

---

## Project

**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework

**Coding Module:** Module 08 — Model Outputs

**Execution Phase**

---

# Governance

This Coding Module is governed, in precedence order, by:

1. PROJECT_GOVERNANCE_PROMPT_v4.6
2. FRAMEWORK_SPEC.md
3. IMPLEMENTATION_PHILOSOPHY_IDS_PHASE.md
4. IDS-003_Modeling_Implementation.md
5. MODULE_TAXONOMY.md
6. IMPLEMENTATION_MASTER_PLAN.md
7. CODING_PHASE_PHILOSOPHY.md

All governing documents are LOCKED.

No governance document shall be modified or reinterpreted.

---

## Coding Prompt Consistency Check (performed before implementation)

`MODULE_08_PROMPT_SPEC.md` was checked against all previously LOCKED modules (01–07) and against IDS-003. **No conflict was identified.** Two design points were underspecified by the Spec and are clarified here for traceability:

**Clarification 1 — Framework artifact representation.** Model Candidate and Modeling Evidence are each constructed via the LOCKED Module 02 `create_artifact_contract()`, unmodified. `contract_type` remains exactly `"artifact"` in both cases — consistent with the project's established rule that `contract_type` is a pure contract-ontology field and is never overloaded to encode domain or layer context (first established in Module 03's Pre-Implementation Decision Record). To distinguish the two artifact types within the same Modeling layer, a new `metadata` key, `artifact_role` (`"model_candidate"` or `"modeling_evidence"`), is introduced alongside the existing `metadata$framework_layer = "modeling"` convention. This extends, rather than violates, the established "context belongs in metadata, never in contract_type" rule, and introduces no new Framework Contract schema field.

**Clarification 2 — S3 print dispatch.** The Spec requires `print.model_candidate()` and `print.modeling_evidence()` as distinct S3 methods. Since both objects are, at base, `artifact_contract` objects (Module 02), each is additionally tagged with one extra, prepended S3 class for print dispatch only — e.g. `class(x) <- c("model_candidate", "artifact_contract", "contract")`. This is presentation-layer subclassing only: `is_artifact_contract()` and `validate_artifact_contract()` (Module 02, unmodified) continue to work exactly as LOCKED, since `"artifact_contract"` remains present in the class vector. This introduces no new Framework Contract type; `contract_type` remains exactly `"artifact"`.

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

# Module Responsibility

Module 08 implements the **Model Output Boundary** of the Modeling domain.

Its responsibility is limited to transforming a completed Training Object into Framework-level Modeling artifacts.

Module 08 is the unique producer of:

* Model Candidate
* Modeling Evidence

Module 08 closes the Modeling implementation domain.

---

# Architectural Responsibility

Module 08 consumes:

Training Object

↓

Produces

* Model Candidate
* Modeling Evidence

No additional implementation responsibilities are introduced.

---

# Additive-only Principle

This module extends all previously LOCKED Coding Modules.

No locked implementation may be modified.

Only additive implementation is permitted.

---

# Stable API Principle

Previously established public APIs SHALL retain:

* function names
* parameter semantics
* return semantics
* implementation responsibilities

This module may consume existing APIs but SHALL NOT redefine them.

Additional module-specific API constraints are defined below.

---

# Architectural Decisions (LOCKED)

## AD-01

Module 08 is the only Coding Module permitted to create Model Candidates.

No downstream module may create new Model Candidates.

---

## AD-02

Module 08 is the only Coding Module permitted to create Modeling Evidence.

Downstream modules consume Modeling Evidence but do not create it.

---

## AD-03

Training Objects remain immutable.

Training Objects shall never be modified.

Module 08 always produces new Framework artifacts.

---

## AD-04

Model Candidate and Modeling Evidence are independent Framework artifacts.

Neither artifact embeds the other.

Both are created together by Module 08.

---

## AD-05

Model Candidate preserves complete lineage by embedding the originating Training Object.

Lineage shall be preserved by composition.

---

# Model Candidate

Model Candidate represents exactly one candidate.

It is a Framework artifact.

Multiplicity shall be managed by orchestration, not by the artifact itself.

---

# Modeling Evidence

Modeling Evidence is a Framework artifact.

It accompanies exactly one Model Candidate.

Modeling Evidence acts as a structural evidence container.

Scientific content is intentionally deferred to downstream Validation & Benchmark modules.

---

# Evidence Container

Module 08 defines the structural container only.

Typical sections may include:

* predictive_model
* risk_score_definition
* performance_profile
* interpretability_profile
* clinical_evaluation_profile

These fields may initially contain placeholder implementation objects (`NULL`).

Module 08 SHALL NOT perform benchmark, statistical analysis or clinical evaluation.

---

# Structural vs Scientific Validation

Module 08 may validate:

* object structure;
* required fields;
* contract completeness;
* lineage integrity.

Module 08 SHALL NOT validate:

* predictive performance;
* biological validity;
* statistical validity;
* calibration;
* clinical usefulness;
* model superiority.

These responsibilities belong to IDS-004.

---

# Opaque Implementation Principle

Module 08 shall treat the incoming `trained_model` as an opaque implementation object.

No assumption shall be made regarding its internal schema.

Module 08 packages the trained model into Framework artifacts (by embedding the complete, unmodified Training Object) without interpreting or transforming its algorithm-specific content.

---

# Public API

Module 08 shall expose only the boundary-level APIs required for the Model Output Boundary.

Expected public API:

* `create_model_candidate()`
* `create_modeling_evidence()`
* `validate_model_candidate()`

Required S3 print methods:

* `print.model_candidate()`
* `print.modeling_evidence()`

An internal helper (`create_model_output()`) creates both artifacts together but SHALL remain non-exported.

No exported `validate_modeling_evidence()` is required by the Spec; structural validation of Modeling Evidence is performed internally within `create_modeling_evidence()`.

---

# Documentation

Document all exported APIs using roxygen2.

Documentation shall describe:

* purpose
* arguments
* return values
* implementation semantics

Do not document downstream behaviour (benchmarking, validation, candidate selection) beyond the module contract.

---

# Tests

Tests shall verify:

* successful Model Candidate construction;
* successful Modeling Evidence construction;
* immutable Training Object consumption;
* lineage preservation;
* structural validation;
* public API;
* S3 methods;
* downstream readiness.

Tests SHALL NOT verify:

* benchmarking;
* predictive performance;
* biological correctness;
* statistical superiority;
* calibration;
* candidate ranking;
* clinical utility.

---

# Execution History

Create:

Execution/

Module_08/

* Prompt.md
* Artifacts.md
* Execution_Log.md
* Review.md
* LOCK.md

Artifacts.md shall follow the standardized structure established in Module 01.

---

# In Scope

* Model Candidate construction
* Modeling Evidence construction
* Framework artifact creation
* Lineage preservation
* Structural validation
* Documentation
* Tests

---

# Out of Scope

Module 08 SHALL NOT implement:

* Benchmarking
* Candidate selection
* Model comparison
* Performance ranking
* Statistical evaluation
* Biological evaluation
* Calibration
* Interpretability analysis
* Clinical evaluation

These responsibilities belong to IDS-004.

---

# Downstream Contract

Module 08 produces:

* one Model Candidate;
* one Modeling Evidence.

IDS-004 consumes these artifacts.

No additional Framework artifacts are produced.

---

# Success Criteria

`create_model_candidate()` produces a valid `artifact_contract`-based Model Candidate embedding the complete, unmodified Training Object, with `contract_type == "artifact"` and `metadata$artifact_role == "model_candidate"`.

`create_modeling_evidence()` produces a valid `artifact_contract`-based Modeling Evidence with a structural evidence container (5 placeholder sections), `contract_type == "artifact"`, and `metadata$artifact_role == "modeling_evidence"`.

Neither artifact embeds the other (AD-04); both share lineage to the same Training Object.

`validate_model_candidate()` correctly accepts valid Model Candidates and rejects structurally invalid ones, without performing any scientific/statistical/biological check.

Training Objects consumed by this module remain completely unmodified (AD-03), verified directly in tests.

Public API exposes exactly `create_model_candidate()`, `create_modeling_evidence()`, `validate_model_candidate()`, plus `print.model_candidate()` and `print.modeling_evidence()`.

All tests pass; `devtools::check()` reports 0 errors and 0 warnings.

Repository remains additive relative to Module 07.

---

# Definition of Done

Module completion requires:

1. Module implementation complete.
2. Documentation generated successfully.
3. Required tests pass.
4. Local execution succeeds.
5. `devtools::check()` reports **0 ERROR** and **0 WARNING**.
6. Governance compliance passes.
7. IDS compliance passes.
8. Repository remains additive.
9. Execution History updated.
10. Strategist Review passes.
11. Project Coordinator approves Module LOCK.

Additional module-specific completion criteria:

12. All five Architectural Decisions (AD-01 through AD-05) are satisfied.
13. Training Objects consumed by this module are verified, via test, to remain byte-for-byte unchanged (`identical()`) after Model Candidate / Modeling Evidence construction.
14. Model Candidate and Modeling Evidence are verified, via test, to introduce no new Framework Contract type (`contract_type` remains exactly `"artifact"` in both) and to not embed each other.
15. Public API surface is verified to expose exactly the 3 required functions plus the 2 required S3 print methods — no more, no fewer.

---

# Constraints

This module SHALL NOT:

* redesign previously LOCKED modules;
* modify existing public APIs;
* duplicate implementation already owned by previous modules;
* introduce functionality outside the approved module scope.

Module-specific constraints (Implementation Constraints):

Module 08 SHALL:

* preserve additive compatibility with Modules 01–07;
* preserve immutable Training Objects;
* preserve complete Modeling lineage;
* introduce no Governance changes;
* introduce no new Framework Contract types;
* remain entirely within IDS-003 boundaries.

---

# Deliverables

* Model Candidate implementation
* Modeling Evidence implementation
* Internal `create_model_output()` helper (non-exported)
* Public Modeling API (Model Output Boundary)
* Documentation
* Test Suite
* Execution history

---

End of Module 08 Coding Prompt (merged from CODING_PROMPT_TEMPLATE.md + MODULE_08_PROMPT_SPEC.md, post Coding Prompt Consistency Check).
