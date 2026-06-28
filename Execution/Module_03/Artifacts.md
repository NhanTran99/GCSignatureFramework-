# Module 03 — Discovery Framework Layer — Artifacts

**Status:** DRAFT (Phase B — awaiting Project Coordinator local execution + Strategist Review)

---

## Module

Module 03 — Discovery Framework Layer

---

## Purpose

Implement the domain-agnostic Discovery orchestration layer: pipeline construction, stage registration, DAG-ready dependency resolution, and pipeline validation/run — with zero scientific, biological, or statistical assumptions, per IDS-002_Discovery_Implementation.md and the (corrected) Module 03 Coding Prompt.

---

## Inputs

- `Execution/Module_03/Prompt.md` (Coding Prompt, issued by Project Coordinator, corrected per the Pre-Implementation Decision Record before implementation began)
- IDS-002_Discovery_Implementation.md (LOCKED)
- MODULE_TAXONOMY.md (LOCKED) — Module 03 = "Discovery Inputs" (taxonomy label); this Coding Prompt scopes it as "Discovery Framework Layer"
- Locked Module 01 + Module 02 repository state (additive base) — in particular, Module 02's `create_artifact_contract()` / `validate_artifact_contract()` / `is_artifact_contract()`, consumed read-only/as-is, unmodified

---

## Pre-Implementation Decision Record (summary; full record in `Prompt.md`)

The original Coding Prompt specified `contract_type = "discovery"` for Discovery artifacts, which conflicts with the LOCKED Module 02 API (`create_artifact_contract()` always sets `contract_type = "artifact"`; `validate_artifact_contract()` requires it). Per Project Coordinator decision: LOCKED implementation outranks the Prompt. The Prompt was corrected — Discovery context is recorded under `metadata$framework_layer = "discovery"` instead; `contract_type` remains a pure contract-ontology field (artifact/interface/dependency/verification) and is never overloaded to encode domain or framework-layer information. No Module 02 code, schema, or validator was modified. This decision is verified by a dedicated "Contract consistency" test (see Tests section).

---

## Outputs

- One new R source file (`R/discovery_pipeline.R`) implementing the full Discovery Framework Layer.
- One new test file (`tests/testthat/test-discovery-pipeline.R`) covering pipeline construction, stage registration, dependency resolution (including DAG branching, cycle detection, input/output compatibility), pipeline validation, the orchestration-only `run_discovery_pipeline()`, the `is_discovery_pipeline()` predicate, the print method, and contract consistency with Module 02.
- Execution history for Module 03.

---

## Files Created

```
GCSignatureFramework/
├── R/
│   └── discovery_pipeline.R   (create_discovery_pipeline, register_discovery_stage,
│                                resolve_pipeline_dependencies, validate_discovery_pipeline,
│                                run_discovery_pipeline, is_discovery_pipeline,
│                                print.discovery_pipeline)
├── tests/testthat/
│   └── test-discovery-pipeline.R
└── Execution/Module_03/
    ├── Prompt.md      (corrected, with Pre-Implementation Decision Record)
    ├── Artifacts.md
    ├── Execution_Log.md   (template)
    ├── Review.md          (template)
    └── LOCK.md            (template)
```

**Not yet generated locally (requires live R execution by Project Coordinator via the existing `dev/bootstrap.R`, unchanged from Modules 01–02):**
- Regenerated `NAMESPACE` (will now export the 7 new public functions from Module 03)
- Generated `man/*.Rd` files for each newly exported function

---

## Files Modified

None. Modules 01 and 02 were not modified — additive-only principle respected. (Module 02's `create_artifact_contract()` family is consumed exactly as LOCKED, with no change.)

---

## Files Removed

None.

---

## Produced Artifacts

| Artifact | Type | Producer |
|---|---|---|
| Discovery Framework Layer (`R/discovery_pipeline.R`) | Orchestration-only pipeline representation (base R list + S3 class `discovery_pipeline`) | Coding Agent (this module) |
| Public Discovery API: `create_discovery_pipeline()`, `register_discovery_stage()`, `resolve_pipeline_dependencies()`, `validate_discovery_pipeline()`, `run_discovery_pipeline()`, `is_discovery_pipeline()`, `print.discovery_pipeline()` (7 exported functions) | Stable framework API (per "Stable API Principle") | Coding Agent (this module) |
| Test suite (1 file, 27 individual `test_that()` blocks) | Verification of Discovery Framework Layer, including DAG branching/cycle detection and Module 02 contract consistency | Coding Agent (this module) |

This module's output is the Discovery **orchestration layer** itself — not a domain-specific contractual artifact under IDS-002 (Discovery Candidate / Discovery Evidence). No such artifact is produced by this module; downstream Discovery implementation modules will use this orchestration layer plus `create_artifact_contract()` (per the corrected Contract-first Principle) to produce actual Discovery Candidates/Evidence.

---

## Verification Results

**Pending.** Verification requires the Project Coordinator to run the existing `dev/bootstrap.R` (or `devtools::document()` / `devtools::test()` / `devtools::check()` directly) locally in R, which will:

1. Regenerate `NAMESPACE`/`man/` via roxygen2 (7 new exports expected).
2. Confirm the package loads (`devtools::load_all()`).
3. Run the full test suite (`devtools::test()`), expecting all Module 01–03 tests to pass, including the 2 "contract consistency" tests confirming Module 02 is unaffected.
4. Run `devtools::check()`, per the Coding Prompt's explicit Definition-of-Done requirement: **0 ERROR and 0 WARNING** (notes acceptable only if already expected at this project stage, e.g. system-clock note, per the precedent set in Module 02's revision cycle).

Results of this local run are to be recorded in `Execution/Module_03/Execution_Log.md`.

---

## Downstream Dependencies

Modules 04–05 (remaining Discovery-domain modules, per MODULE_TAXONOMY: "Discovery Processing", "Discovery Outputs") and all later domains depend on this module providing:

- The stable Discovery Pipeline construction/registration/resolution/validation/run API — function names, parameter semantics, and returned object structure are now stable per the "Stable API Principle"; future modules may extend usage but must not break this surface.
- The DAG-ready dependency representation (`dependencies` as a character vector per stage, supporting many-to-one/many-to-many structures, not just linear chains) as the canonical way future Discovery stages declare ordering.
- The confirmed, tested convention that any actual Discovery *artifact* (contractual object) is constructed via Module 02's `create_artifact_contract()` with `metadata$framework_layer = "discovery"` — not a new object model, and not a new `contract_type` value.

No scientific, biological, or statistical logic is exposed by this layer; downstream modules must not expect any such behavior from it. `executor` fields registered in this module remain inert placeholders; this module never invokes them.

---

## Notes

- Zero Scientific Assumption Principle respected throughout: no references to genes, RNA, microarray, sequencing, clinical variables, radiomics, cancer, or biomarker type anywhere in `R/discovery_pipeline.R` or its tests. Only abstract concepts (dataset, feature, sample, target, metadata, pipeline, stage, artifact) are used, consistent with the Coding Prompt and the test suite's example stage names (`load`, `filter`, `branch_a`/`branch_b`, `merge`).
- DAG-ready Principle respected: `resolve_pipeline_dependencies()` performs a general topological sort (Kahn's algorithm) over a `dependencies` graph that supports branching/merging (many-to-many), with linear pipelines as a special case; the function never executes a stage.
- `run_discovery_pipeline()` is explicitly orchestration-only: it validates the pipeline and records a resolved execution order, but never calls any stage's `executor`. This is verified directly in tests via a side-effect flag that remains `FALSE` after `run_discovery_pipeline()` completes.
- No machine learning or statistical package dependencies were introduced (only base R); `DESCRIPTION` was not modified.
- No business logic, visualization, logging framework, or domain functionality (Discovery algorithms, Modeling, Validation, Interpretability, Clinical Translation) was introduced.
- Modules 01 and 02's files were not modified — additive-only principle respected.
