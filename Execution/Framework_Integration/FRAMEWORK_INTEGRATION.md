# FRAMEWORK INTEGRATION — Architecture and Methodology

**Status:** LOCKED (APPROVED — Project Coordinator confirmed)
**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework
**Document Type:** Framework Integration (Stage-level architecture and methodology specification — not an RDR, not a new architectural Layer)
**Builds on:** RDR-000 through RDR-006 (all LOCKED) + their CLOSUREs, Framework Integration Philosophy (LOCKED)
**Governed by:** PROJECT_GOVERNANCE_PROMPT_v4.5.1.md
**Next Stage:** Framework Integration execution (synthesis, benchmarking, recommendation, reporting — subject to its own governance gates as each deliverable is produced)

This document is an architecture and methodology specialization of the Framework Integration Stage. Consistent with the Framework Integration Philosophy's Governance Philosophy (Locked Statement 10), it introduces no new methodological or architectural decision: it organizes, into a coherent specification, how synthesis, benchmarking, recommendation, reporting, and presentation will be carried out over decisions already locked in RDR-000 through RDR-006. It contains no code, no software packages, no hyperparameters, and no algorithm or statistical procedure recommendation, consistent with the scope discipline already applied throughout the RDR series.

---

## 1. Executive Summary

RDR-000 through RDR-006 specified, in sequence, the framework's foundation, architecture, methodology governance, and the methodology of each artifact-transforming layer (Discovery, Modeling, Validation, Interpretability & Clinical Translation). That series is now complete and locked. This document specifies the Framework Integration Stage that follows it — not a new layer, and not a continuation of the RDR series, but the synthesis stage through which the framework's accumulated, already-locked outputs are organized, benchmarked end-to-end, and presented.

Framework Integration's role, per its locked philosophy, is synthesis rather than methodology development. This document accordingly defines: what Framework Integration receives as input, the three categories into which its outputs are organized, the context-dependent nature of its Framework-Wide Recommendation, its end-to-end benchmarking responsibilities, its scientific narrative responsibilities, the three-level deliverable organization governing the project as a whole, and the conditions under which the framework is considered complete (Definition of Done). It does not redesign, reinterpret, or reopen any RDR or philosophy statement already locked.

---

## 2. Relationship to Prior Governance

This document inherits, without modification:

- **From RDR-000 through RDR-002:** the project's foundational scientific question, four-layer vertical architecture, horizontal cross-cutting principles, methodology governance (component-wise and evidence-constrained modernization, Methodology Decision Layer), Candidate Signature Governance, and Negative Results philosophy — all of which remain in force at the Framework Integration Stage exactly as they applied within the RDR series.
- **From RDR-003 through RDR-006:** the fully specified candidate evolution chain — Discovery Candidate → Model Candidate → Validated Candidate (enriched with Enrichment Evidence at RDR-006) — together with each layer's standardized, named evidence package (Discovery Evidence, Model Evidence, Validation Evidence, Enrichment Evidence) and each layer's component-level benchmark against the corresponding historical Part 1 pathway.
- **From RDR-005, Section 10 (carried forward unmodified through RDR-006):** the fixed governance interpretation distinguishing the **Framework-Wide Recommendation** (a process) from the **Recommended Signature** (the resulting artifact) — a distinction this document operationalizes but does not redefine.
- **From the locked Framework Integration Philosophy (reproduced in full in Section 3):** the eleven locked statements governing this stage, treated here as authoritative and unmodified.

This document does not reinterpret any of the above. It does not redesign Discovery, Modeling, Validation, or Interpretability & Clinical Translation methodology, and per Locked Statement 10, any architectural or methodological idea arising during the drafting of this document that is not already covered by the locked chain is documented separately as a future direction (Section 11) rather than incorporated here.

---

## 3. Locked Framework Integration Philosophy (Reproduced for Reference)

The following was locked by the Project Coordinator and is treated as authoritative throughout this document and all subsequent Framework Integration work:

1. **Stage Objective** — Framework Integration exists to synthesize the outputs of the complete methodology framework into a coherent, transparent, end-to-end framework representation. Its responsibilities include framework-wide recommendation, end-to-end benchmarking, framework-wide reporting, scientific narrative, repository integration, and final framework presentation. It is a synthesis stage, not a methodology-development stage.
2. **Stage Classification** — Framework Integration is a Stage, not a new architectural Layer. Discovery, Modeling, Validation, and Interpretability & Clinical Translation are artifact-transforming layers; Framework Integration does not introduce or transform candidate classes. It synthesizes, evaluates, organizes, recommends, benchmarks, and presents the outputs already produced.
3. **Stage Input** — Framework Integration operates on completed framework outputs, not upstream intermediate artifacts. Its primary inputs are: Validated Candidate(s), Validation Evidence, Validation Recommendation(s), Enrichment Evidence, and framework metadata required for integration. It does not directly consume Discovery Evidence or Model Evidence independently of the validated outputs already assembled upstream.
4. **Stage Output** — Framework Integration produces three categories of outputs: Governance Artifacts (Framework-Wide Recommendation); Framework / Repository Artifacts (Framework Integration, Final Framework Benchmark, framework documentation and repository integration assets); and Publication Support Artifacts (publication figures, publication tables, supplementary materials). These categories serve different audiences and remain conceptually distinct.
5. **Framework-Wide Recommendation Philosophy** — The Framework-Wide Recommendation is context-dependent, not ranking-based. Framework Integration does not identify one universally superior candidate; it identifies the most appropriate candidate(s) for explicitly defined contexts, evaluation objectives, or intended applications.
6. **End-to-End Benchmark Philosophy** — Framework Integration is responsible for end-to-end framework benchmarking, synthesizing evidence across the complete framework: historical-versus-modern framework comparison, Discovery/Modeling/Validation benchmarking summaries, framework-objective assessment, and scientific contribution synthesis. End-to-end benchmarking complements, rather than replaces, component-level benchmarking already completed within individual layers.
7. **Scientific Narrative Philosophy** — Framework Integration produces the project's scientific narrative, explaining historical limitations, framework innovations, accumulated evidence, and expected scientific/translational impact. The narrative is a reusable source for downstream documentation and future manuscripts, but is not itself a manuscript.
8. **Deliverable Organization** — Final deliverables are organized into three governance levels: Governance (governance documents, locked RDRs, closure documents, project status); Framework (Framework Integration, Final Framework Benchmark, governance workflow documentation); Repository (repository documentation, README, figures, examples, supporting assets). These categories remain organizationally independent.
9. **Canonical Documentation Philosophy** — Framework Integration is the project's canonical synthesis document. The RDR series (RDR-000–RDR-006) remains the authoritative historical decision record. Framework Integration synthesizes those decisions without replacing, modifying, or superseding the RDR governance chain.
10. **Governance Philosophy** — Framework Integration introduces no new methodological or architectural decisions; its responsibilities are limited to synthesis, organization, benchmarking, recommendation, reporting, and presentation of decisions already locked. Any architectural or methodological ideas arising during Framework Integration are documented separately as future directions, not incorporated into the locked framework.
11. **Definition of Done** — The framework is complete when: the complete governance chain has been locked; Framework Integration has been completed; end-to-end framework benchmarking has been completed; repository documentation has been finalized; and governance workflow and project documentation have been frozen. Completion closes the current framework version; it does not end future research.

Every section of this document is constructed to be consistent with, and to operationalize, these eleven statements. None is altered here.

---

## 4. Stage Philosophy

Per the locked Stage Classification (Section 3, item 2), Framework Integration's philosophy begins from what it is *not*: it is not a fifth artifact-transforming layer alongside Discovery, Modeling, Validation, and Interpretability & Clinical Translation, and it does not extend the candidate evolution chain (Discovery Candidate → Model Candidate → Validated Candidate) with a new candidate class. Where each prior layer transformed an artifact into the next (gene set into model, model into validated claim, validated claim into enriched understanding), Framework Integration instead operates laterally across the framework's already-completed outputs — synthesizing, organizing, benchmarking, recommending, and presenting them.

This has a direct consequence consistent with the locked Governance Philosophy (item 10): Framework Integration is bound by every methodological and architectural decision already locked in RDR-000 through RDR-006, and is explicitly disallowed from revisiting any of them. Its philosophy is therefore one of disciplined synthesis — drawing together what the governance chain has already produced into a coherent, transparent representation — rather than one of further methodology design. Any apparent gap, ambiguity, or improvement opportunity noticed during Framework Integration is documented as a future direction (Section 11), never resolved by quietly extending or reinterpreting a locked document.

---

## 5. Stage Input

Per the locked Stage Input statement (Section 3, item 3), Framework Integration's inputs are fixed as: Validated Candidate(s), Validation Evidence, Validation Recommendation(s), Enrichment Evidence, and framework metadata required for integration. This is a deliberate architectural restriction: Framework Integration consumes the framework's *completed* outputs, not upstream intermediate artifacts.

This restriction has two direct consequences:

- **No re-derivation from earlier layers.** Framework Integration does not re-examine Discovery Evidence or Model Evidence independently of how that evidence has already been carried forward and assembled into Validation Evidence and Enrichment Evidence by the Validation and Interpretability & Clinical Translation layers respectively. Any concern about an earlier layer's evidence must be raised through that layer's own Methodology Decision Layer process (RDR-002), not addressed by Framework Integration reaching upstream.
- **Multiplicity is inherited, not resolved upstream of Framework Integration.** Because multiple Validated Candidates (each together with Enrichment Evidence) may coexist at the close of RDR-006 (RDR-005, Section 10; RDR-006, Section 6), Framework Integration is the first and only stage responsible for weighing this multiplicity into a Framework-Wide Recommendation (Section 7).

"Framework metadata required for integration" is understood, at this architectural level, as whatever bookkeeping (e.g., candidate lineage references, locked governance document identifiers) is needed to assemble the outputs above coherently — not as a new evidence category requiring its own definition.

---

## 6. Stage Output: Three Output Categories

Per the locked Stage Output statement (Section 3, item 4), Framework Integration's outputs are organized into three categories, each serving a distinct audience and kept conceptually distinct rather than merged:

1. **Governance Artifacts** — the Framework-Wide Recommendation itself, documented with the same rigor and traceability already required of every locked RDR decision.
2. **Framework / Repository Artifacts** — the Framework Integration synthesis document(s), the Final Framework Benchmark (Section 8), and framework documentation/repository integration assets.
3. **Publication Support Artifacts** — publication figures, publication tables, and supplementary materials intended to support downstream scientific communication, distinct from the framework/repository artifacts above and from the project's eventual manuscript itself.

This three-category organization is the Stage Output analogue of the standardized evidence packages used throughout the RDR series (Discovery Evidence, Model Evidence, Validation Evidence, Enrichment Evidence): just as each layer produced a named, structured package rather than an undifferentiated output, Framework Integration produces three named, structured output categories rather than a single undifferentiated deliverable.

---

## 7. Framework-Wide Recommendation

Per the locked Framework-Wide Recommendation Philosophy (Section 3, item 5), the Framework-Wide Recommendation is context-dependent, not ranking-based. It does not attempt to declare one Validated Candidate universally superior; instead, it identifies the most appropriate candidate(s) for explicitly defined contexts, evaluation objectives, or intended applications.

This directly resolves, at the Framework Integration Stage, the governance interpretation already fixed in RDR-005 (Section 10) and carried forward unmodified through RDR-006: the Framework-Wide Recommendation is the *process* by which Validated Candidates from across the entire framework (each already carrying its own narrower, layer-scoped recommendation from Validation — RDR-005, Section 7) are weighed against each other; the **Recommended Signature** is the resulting artifact that process produces. Because the philosophy is explicitly context-dependent rather than ranking-based, the Framework-Wide Recommendation may recommend different Validated Candidates for different contexts, evaluation objectives, or intended applications, rather than collapsing the framework's evidence into a single universally ranked outcome. This preserves, without extending, the Recommended Signature artifact as already locked in RDR-005 — this document introduces no new interpretation of what that artifact is, only confirms that the process producing it remains context-dependent.

---

## 8. End-to-End Benchmark Philosophy and the Final Framework Benchmark

Per the locked End-to-End Benchmark Philosophy (Section 3, item 6), Framework Integration is responsible for synthesizing evidence across the complete framework into a **Final Framework Benchmark**, covering:

- Historical-versus-modern framework comparison.
- Discovery benchmarking summary (drawing on RDR-003, Section 8).
- Modeling benchmarking summary (drawing on RDR-004, Section 8).
- Validation benchmarking summary (drawing on RDR-005, Section 8).
- Framework-objective assessment (against the multi-objective framework defined in RDR-002, Section 8: predictive performance, robustness, stability, interpretability, clinical utility, reproducibility).
- Scientific contribution synthesis.

This end-to-end benchmark is explicitly a synthesis of already-completed component-level benchmarks, not a new benchmarking exercise performed independently of them. It complements rather than replaces those component-level results, consistent with the locked philosophy: every component-level benchmark already performed within Discovery, Modeling, and Validation remains individually valid and individually citable, and the Final Framework Benchmark's role is to present their combined picture, not to supersede any one of them. Consistent with Negative Results (RDR-002) — already applied identically across RDR-003 through RDR-006 — the Final Framework Benchmark may legitimately report that modernization improved some components, left others equivalent, and did not outperform the historical pathway in still others; this mixed outcome is a scientifically valid and fully reportable synthesis, not a deficiency of Framework Integration.

---

## 9. Scientific Narrative

Per the locked Scientific Narrative Philosophy (Section 3, item 7), Framework Integration produces the project's scientific narrative: an account of historical limitations, framework innovations, accumulated evidence, and expected scientific and translational impact.

This narrative is explicitly positioned as a *reusable source*, not a manuscript in itself. It is the synthesized account from which downstream documentation — repository documentation, and any future manuscript — may draw, but producing such downstream documents is not a Framework Integration responsibility fixed by this document; it is a use of the narrative Framework Integration produces. This preserves the same separation already established by the Deliverable Organization (Section 10 below) between Framework-level artifacts and Repository-level artifacts.

---

## 10. Deliverable Organization

Per the locked Deliverable Organization (Section 3, item 8), the project's final deliverables — spanning Part 1 and Part 2 in their entirety — are organized into three governance levels, kept organizationally independent:

```
Governance
        (governance documents, locked RDRs, closure documents, project status)

Framework
        (Framework Integration, Final Framework Benchmark, governance workflow documentation)

Repository
        (repository documentation, README, figures, examples, supporting repository assets)
```

This organization is consistent with the repository governance principles already established at the governance-prompt level (PROJECT_GOVERNANCE_PROMPT_v4.5.1.md), while preserving the separation between governance documentation, framework synthesis, and repository-facing assets. Framework Integration is responsible for populating the Framework level (and supplying source material for the Repository level via the scientific narrative, Section 9), but it does not itself perform repository publication — that remains a separate, downstream activity drawing on Framework Integration's outputs.

---

## 11. Out-of-Scope Architectural and Methodological Ideas

Per the locked Governance Philosophy (Section 3, item 10), any architectural or methodological idea identified while drafting this document, but not already covered by a locked RDR or by the locked Framework Integration Philosophy, is recorded here rather than incorporated into the architecture above:

- No such idea has been identified during the drafting of this document. This section is retained as the designated location for recording any future direction that may arise during Framework Integration's eventual execution (e.g., during actual end-to-end benchmarking or recommendation drafting), so that such ideas are captured transparently rather than informally absorbed into a locked artifact.

---

## 12. Definition of Done

Per the locked Definition of Done (Section 3, item 11), the framework is considered complete only when all of the following have been satisfied:

1. The complete governance chain has been locked. *(RDR-000 through RDR-006 are locked as of this document; the Framework Integration Philosophy is locked; this document, once locked, completes the governance chain's architecture-level component.)*
2. Framework Integration has been completed. *(Execution of Sections 6–9 above — producing the actual Framework-Wide Recommendation, Final Framework Benchmark, and scientific narrative — remains outstanding and is not satisfied by this architecture document alone.)*
3. End-to-end framework benchmarking has been completed. *(Outstanding; Section 8 defines its scope and structure but does not itself constitute the completed benchmark.)*
4. Repository documentation has been finalized. *(Outstanding; downstream of Framework Integration's scientific narrative, per Section 9.)*
5. Governance workflow and project documentation have been frozen. *(Outstanding; follows completion of items 2–4.)*

Consistent with the locked philosophy, satisfying these conditions closes the current framework version; it does not preclude future research, future framework versions, or future projects built on this one.

---

## 13. Governance Status

**Status:** LOCKED 

**Implementation:** NOT PERMITTED (this document specifies architecture and methodology only; it does not itself perform synthesis, benchmarking, recommendation, or reporting)

**Next Step:**
1. Generate FRAMEWORK_INTEGRATION_CLOSURE.md
2. Update PROJECT_STATUS.md
3. Proceed to Framework Integration execution under governance
