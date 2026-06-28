# Module 04 — Discovery Processing — Artifacts

**Status:** DRAFT (Phase B — awaiting Project Coordinator local execution + Strategist Review)

---

## Module

Module 04 — Discovery Processing

---

## Purpose

Implement the Discovery Processing **Execution Layer** (`execute_discovery_pipeline()`) plus a small set of generic, domain-agnostic processing stages (Quality Control, Normalization, Filtering), and produce Discovery contractual artifacts upon successful execution — per IDS-002_Discovery_Implementation.md and the Module 04 Coding Prompt (v2, including its Pre-Implementation Decision Record).

---

## Inputs

- `Execution/Module_04/Prompt.md` (Coding Prompt v2, issued by Project Coordinator after Strategist discussion, including the Pre-Implementation Decision Record)
- IDS-002_Discovery_Implementation.md (LOCKED)
- Locked Module 01–03 repository state (additive base) — in particular, Module 02's `create_artifact_contract()` family and Module 03's `validate_discovery_pipeline()` / `resolve_pipeline_dependencies()`, all consumed read-only/as-is, unmodified

---

## Pre-Implementation Decision Record (summary; full record in `Prompt.md`)

The original Module 04 prompt implied that `run_discovery_pipeline()` (Module 03, LOCKED) would invoke stage executors. This conflicts with Module 03's LOCKED, tested behavior: orchestration only, never invoking executors. Resolved (consistent with the precedent set in Module 03's own `contract_type` decision): LOCKED implementation outranks Prompt wording. `run_discovery_pipeline()` is unchanged. Module 04 introduces a new, additive function, `execute_discovery_pipeline()`, which reuses `validate_discovery_pipeline()` and `resolve_pipeline_dependencies()` as-is and is solely responsible for actually invoking stage executors. This establishes an explicit architectural separation: Module 03 = Workflow/Orchestration Layer, Module 04 = Execution Layer — to be preserved by all future modules.

---

## Outputs

- One new R source file (`R/discovery_processing.R`) implementing the Execution Layer and three generic processing stages.
- One new test file (`tests/testthat/test-discovery-processing.R`) covering processing execution, stage execution, immutable dataset behavior, artifact generation, dependency consistency (reuse of Module 03 APIs), and execution ordering.
- Execution history for Module 04.

---

## Files Created

```
GCSignatureFramework/
├── R/
│   └── discovery_processing.R   (execute_discovery_pipeline, generic_qc_stage,
│                                  generic_normalization_stage, generic_filtering_stage,
│                                  plus internal .generic_dataset_dim helper)
├── tests/testthat/
│   └── test-discovery-processing.R
└── Execution/Module_04/
    ├── Prompt.md      (v2, with Pre-Implementation Decision Record)
    ├── Artifacts.md
    ├── Execution_Log.md   (template)
    ├── Review.md          (template)
    └── LOCK.md            (template)
```

**Not yet generated locally (requires live R execution by Project Coordinator):**
- Regenerated `NAMESPACE` (4 new exports expected: `execute_discovery_pipeline`, `generic_qc_stage`, `generic_normalization_stage`, `generic_filtering_stage`)
- Generated `man/*.Rd` files for each newly exported function

---

## Files Modified

None. Modules 01–03 were not modified — additive-only principle respected. `run_discovery_pipeline()`, `validate_discovery_pipeline()`, `resolve_pipeline_dependencies()`, and `create_artifact_contract()` are all consumed exactly as LOCKED.

---

## Files Removed

None.

---

## Produced Artifacts

| Artifact | Type | Producer |
|---|---|---|
| Discovery Processing Execution Layer (`execute_discovery_pipeline()`) | New, additive public API (per Pre-Implementation Decision Record) | Coding Agent (this module) |
| Generic processing stages (`generic_qc_stage()`, `generic_normalization_stage()`, `generic_filtering_stage()`) | Reusable, domain-agnostic stage executors conforming to the `process(dataset, ...) -> processed_dataset` interface | Coding Agent (this module) |
| Test suite (1 file, 22 individual `test_that()` blocks) | Verification of execution, stage behavior, immutability, artifact generation, dependency-consistency reuse, and execution ordering | Coding Agent (this module) |
| Discovery contractual artifact (runtime output of `execute_discovery_pipeline()`, not a static repository file) | `artifact_contract` object (Module 02), `metadata$framework_layer = "processing"` | `execute_discovery_pipeline()`, at call time |

---

## Verification Results

**Pending.** Verification requires the Project Coordinator to run, locally in R:

1. `devtools::document()` — regenerates `NAMESPACE`/`man/` (4 new exports expected).
2. `devtools::test()` — expects all Module 01–04 tests to pass.
3. `devtools::check()` — per the Coding Prompt's explicit Definition-of-Done requirement: **0 ERROR and 0 WARNING** (notes acceptable only if already expected, e.g. system-clock note, per Module 02/03 precedent).

Results of this local run are to be recorded in `Execution/Module_04/Execution_Log.md`.

---

## Downstream Dependencies

Module 05 (Discovery Outputs, per MODULE_TAXONOMY) and all later domains depend on this module providing:

- A stable Execution Layer (`execute_discovery_pipeline()`) — function name, parameter semantics, and returned list structure (`processed_dataset` / `artifact` / `execution_order`) are now stable per the "Stable API Principle"; future modules may extend usage but must not break this surface.
- The architectural separation between Module 03 (orchestration/workflow definition) and Module 04 (execution) — future modules must preserve this separation rather than re-merging the two responsibilities.
- Three generic, reusable stage executors directly registerable via Module 03's `register_discovery_stage()`, demonstrating the `process(dataset, ...) -> processed_dataset` interface in practice.
- The confirmed pattern that any Discovery contractual artifact produced during execution uses `create_artifact_contract()` with `metadata$framework_layer = "processing"` — consistent with Module 03's `"discovery"` framework-layer convention, extending it without modification to Module 02.

---

## Notes

- Zero Scientific Assumption Principle respected throughout: no references to genes, RNA, sequencing, microarray, proteins, clinical variables, cancer, or biomarker type anywhere in `R/discovery_processing.R` or its tests. Generic stage names and abstract dataset operations only.
- `generic_qc_stage()` performs structural validation (two-dimensional, non-zero dimensions) and a best-effort missing-value count (`tryCatch`-guarded, so it degrades gracefully rather than erroring on dataset types where `is.na()` is not meaningfully defined, e.g. some `SummarizedExperiment` usages) — attaches a `"qc_info"` attribute to a new object; never mutates the input in place.
- `generic_normalization_stage()` defaults to `"identity"` (no-op, returns input unchanged) and offers an explicit, opt-in `"scale"` mode using only base R `scale()` — no statistical modelling or feature selection logic.
- `generic_filtering_stage()` performs only explicit, caller-supplied row/column index selection — no statistical or biological filtering criterion is built in; defaults to identity (no filtering) when no selection is supplied.
- `SummarizedExperiment` support is "soft": no package dependency was added to `DESCRIPTION` (per the Coding Prompt's package-dependency constraints); generic base functions (`dim()`, `is.na()`, `[`) are used, which dispatch correctly via S4 if the class and its generics happen to be loaded in the calling session, with graceful (`tryCatch`-guarded) degradation otherwise. This is documented here as the basis for the Coding Prompt's "(if available)" qualifier on this dataset type.
- Immutable Dataset Principle is verified directly in tests: the original object passed to `execute_discovery_pipeline()`, `generic_qc_stage()`, and `generic_filtering_stage()` is confirmed unchanged (via `expect_identical()` against an independent copy) after each call.
- `execute_discovery_pipeline()` threads a single dataset value sequentially through the dependency-resolved stage order; for branching DAGs, all branches currently receive and operate on the same threaded dataset value (multi-input merging of distinct per-branch datasets is not implemented and was not required by this Coding Prompt, which describes a single dataset in / processed dataset out model). This is noted here for Strategist visibility and as context for any future module that requires true multi-dataset DAG data flow.
- No machine learning or statistical package dependencies were introduced (only base R); `DESCRIPTION` was not modified.
- No business logic, visualization, logging framework, or domain functionality (feature selection, biomarker discovery, modeling, validation, interpretability, clinical translation) was introduced.
- Modules 01–03's files were not modified — additive-only principle respected.
