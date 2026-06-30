# RDR-006 — Interpretability and Clinical Translation Methodology

**Status:** LOCKED (APPROVED — Project Coordinator confirmed)
**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework
**Document Type:** Reconstruction/Research Design Record (Methodology Specialization)
**Builds on:** RDR-000_Project_Foundation.md (LOCKED), RDR-001_Modern_Framework_Architecture.md (LOCKED), RDR-002_Modern_Methodology_Architecture.md (LOCKED), RDR-003_Discovery_Methodology.md (LOCKED) + CLOSURE, RDR-004_Modeling_Methodology.md (LOCKED) + CLOSURE, RDR-005_Validation_and_Benchmark_Methodology.md (LOCKED) + CLOSURE, Interpretability & Clinical Translation Philosophy (LOCKED in Phase A, per RDR-006_PREPARATION.md)
**Governed by:** PROJECT_GOVERNANCE_PROMPT_v4.5.1.md
**Next Stage:** Framework Integration (separately governed; not a numbered RDR within this methodology series)

This document is an architecture and methodology specialization. It is not implementation, not an IDS, and contains no code, no software packages, no hyperparameters, and no algorithm or statistical procedure recommendation beyond conceptual methodology discussion, consistent with the Modernization Boundaries already locked in RDR-002 and the scope discipline already applied in RDR-003 through RDR-005.

---

## 1. Executive Summary

RDR-005 specialized the framework's architecture for the Validation Layer, fixing its internal four-stage sequence, the Validated Candidate's Validation Evidence package, and the downstream progression toward RDR-006 and Framework Integration. This document, RDR-006, specializes the same architecture for the Interpretability and Clinical Translation Layer, building entirely on the already-locked Phase A philosophy (RDR-006_PREPARATION.md) and on RDR-000 through RDR-005.

Unlike RDR-003 through RDR-005, RDR-006 does not introduce a new candidate type. The Interpretability and Clinical Translation Layer enriches the existing Validated Candidate with biological interpretation, model explanation, and clinical translation, completing the scientific understanding required for transparent downstream Framework Integration — without altering the Validated Candidate's identity or producing a new artifact class. This document defines that layer's philosophy, internal architecture, candidate enrichment responsibilities, evidence, benchmarking approach against Part 1's historical clinical translation pathway, and boundary with Framework Integration, in conceptual terms only.

---

## 2. Relationship to Prior Governance

This document inherits, without modification:

- **From RDR-000:** the Benchmark Philosophy, Design Principles, Framework Philosophy, and disease-agnostic positioning.
- **From RDR-001:** the four-layer vertical architecture and the horizontal cross-cutting principles, within which this layer sits downstream of the originally specified Interpretability Layer and Clinical Translation Layer (RDR-001, Sections 6.4–6.5), here unified into a single architectural layer per the locked Layer Boundary (Section 3 below).
- **From RDR-002:** component-wise and evidence-constrained modernization, the Methodology Decision Layer and its four outcomes, the Historical Mapping Matrix entry concerning the clinical translation extension, Candidate Signature Governance, and Negative Results.
- **From RDR-003 and RDR-004:** the precedent of an internal architecture specified as stage *roles*, and the standardized, named evidence package pattern (Discovery Evidence, Model Evidence).
- **From RDR-005:** the Validated Candidate — the fixed starting input to this document — together with its Validation Evidence, and the explicit three-stage downstream progression (Validation Layer → RDR-006 → Framework Integration) and the Framework-Wide Recommendation / Recommended Signature distinction, both of which this document treats as already fixed and does not redefine.
- **From the locked Interpretability & Clinical Translation Philosophy (Phase A, RDR-006_PREPARATION.md):** the statements reproduced in Section 3 below, treated here as authoritative and unmodified.

RDR-006 does not reinterpret any of the above. It does not redesign Discovery, Modeling, or Validation, and it does not redefine Framework Integration beyond confirming that several specific responsibilities (Section 9) remain outside this document's scope and belong to that later, separately governed stage.

---

## 3. Locked Interpretability & Clinical Translation Philosophy (Reproduced for Reference)

The following was locked in Phase A and is treated as authoritative throughout this document and all downstream Interpretability and Clinical Translation work:

1. **Layer Objective** — The Interpretability and Clinical Translation Layer exists to enrich Validated Candidates with biological interpretation, model explanation, and clinical translation, enabling transparent understanding and appropriate downstream use. This layer does NOT create a new candidate type and does NOT perform framework-wide reporting, framework-wide recommendation, or framework integration.
2. **Interpretability Philosophy** — Interpretability is inherently multi-dimensional; no single perspective dominates. The framework treats interpretability as complementary evidence across multiple dimensions, including biological interpretation, model explanation, evidence interpretation, and clinical interpretation.
3. **Clinical Translation Philosophy** — Clinical Translation is defined as any methodology that translates framework outputs into meaningful clinical context — a general architectural concept, not a particular methodology. RDR-006 remains methodology-agnostic; specific clinical translation approaches are future methodology decisions.
4. **Historical Benchmark Philosophy** — The historical Part 1 workflow (Validated Candidate → Nomogram → Calibration → Decision Curve → Clinical Interpretation) is reconstructed conceptually as one governed benchmark pathway — not the mandatory architecture, not the default recommendation.
5. **Layer Boundary** — Interpretability and Clinical Translation constitute a single architectural layer, not two independent layers. The downstream progression is fixed as: Discovery Candidate → Model Candidate → Validated Candidate → Interpretability & Clinical Translation (enrichment) → Framework Integration.
6. **Candidate Philosophy** — No additional candidate type is introduced (no "Interpreted Candidate," "Clinical Candidate," or "Translation Candidate"). This layer enriches the existing Validated Candidate rather than replacing or extending it with a new candidate class.
7. **Modernization Philosophy** — Modernization focuses primarily on improving interpretability and explainability, expanding the framework's ability to generate transparent, explainable scientific outputs while preserving appropriate clinical translation. Historical methodology remains a valid governed pathway; modernization does not imply replacement.
8. **Scope of Interpretability** — The layer focuses on three major domains: biological interpretation, model explanation, and clinical translation.
9. **Success Criterion** — Success is achieved when a Validated Candidate has been sufficiently enriched through biological interpretation, model explanation, and clinical translation to support transparent downstream Framework Integration. This layer completes the scientific understanding of a Validated Candidate without altering its identity.

Every section of this document is constructed to be consistent with, and to operationalize, these nine statements. None is altered here.

---

## 4. Layer Philosophy

The Interpretability and Clinical Translation Layer's philosophy follows directly from the locked Layer Objective (Section 3, item 1) and Interpretability Philosophy (item 2): enrichment is multi-dimensional, and no single dimension — biological, model-explanatory, evidence-based, or clinical — is permitted to dominate or substitute for the others. This is the same refusal to let a single criterion dominate that has governed every prior layer's success criteria (Discovery, RDR-003; Modeling, RDR-004; Validation, RDR-005), now applied to enrichment rather than to selection or evidence-sufficiency.

The locked Clinical Translation Philosophy (item 3) has a direct architectural consequence: because Clinical Translation is defined as *any* methodology that translates framework outputs into meaningful clinical context, this document must remain neutral as to which specific clinical translation methodology — historical or modernized — is eventually adopted. This mirrors the same data-first, methodology-agnostic posture already established for Discovery (RDR-003, Section 4) and extended through Modeling and Validation: the architecture defines what enrichment must accomplish, not how.

Consistent with the locked Candidate Philosophy (item 6), this layer's philosophy is explicitly one of *enrichment*, not *transformation*: a Validated Candidate that passes through this layer remains, scientifically and architecturally, the same Validated Candidate — now accompanied by additional interpretive and translational evidence, but not reissued as a new artifact type with a new identity.

---

## 5. Internal Architecture

The locked Historical Benchmark Philosophy (Section 3, item 4) already specifies the historical clinical translation pathway's structure. This section generalizes that structure into the layer's internal architecture, expressed at the level of stage roles consistent with the locked Scope of Interpretability (item 8):

```
Validated Candidate
        ↓
Biological Interpretation
        ↓
Model Explanation
        ↓
Clinical Translation
        ↓
Validated Candidate (together with Enrichment Evidence)
```

Each stage is described here by responsibility only, with no statistical procedure, explanation technique, or clinical tool named:

- **Biological Interpretation** — situates the Validated Candidate's underlying gene set and model behavior within available biological knowledge, consistent with the project's data-first Biological Knowledge Strategy (RDR-003, Section 3, item 5): biological context here supplements and contextualizes an already-validated result, rather than driving discovery.
- **Model Explanation** — produces explanatory evidence describing how the Validated Candidate's underlying model behaves, building on and extending the interpretability profile already carried within the originating Model Candidate (RDR-004, Section 7) and Validation Evidence (RDR-005, Section 7), rather than duplicating it from scratch.
- **Clinical Translation** — translates the Validated Candidate's outputs into meaningful clinical context, conceptually generalizing the historical pathway's Nomogram, Calibration, and Decision Curve components into a single stage role, consistent with the locked Clinical Translation Philosophy's broad, methodology-agnostic definition.
- **Validated Candidate, together with Enrichment Evidence** — the layer's terminal output: the same Validated Candidate that entered this layer, now accompanied by the complete enrichment evidence required by Section 7. No new artifact is produced; the Validated Candidate's identity is unchanged.

This internal sequence is itself a candidate for component-wise, evidence-constrained modernization (RDR-002, Sections 4–6): each stage may independently be modernized, retained, deferred, or rejected by the Methodology Decision Layer once a specific methodology proposal is brought forward. RDR-006 fixes the *sequence and responsibilities*, not the *method* by which any stage is carried out — exactly as RDR-003 through RDR-005 did for their respective layers.

The historical pathway's final "Clinical Interpretation" component (Section 3, item 4) corresponds to the synthesis already required of the Clinical Translation stage above, rather than to a separate fifth stage, preserving the locked Layer Boundary's framing of Interpretability and Clinical Translation as one layer, not two.

---

## 6. Candidate Enrichment

Per the locked Candidate Philosophy (Section 3, item 6), this layer does not produce a new candidate type. Its sole artifact-level effect is to enrich the Validated Candidate it receives as input (RDR-005, Section 7) with the evidence produced by the internal architecture in Section 5.

This has two direct consequences for candidate governance:

- **Identity preservation.** The Validated Candidate, together with its Enrichment Evidence, remains scientifically and architecturally the same Validated Candidate that entered this layer — no new artifact or candidate type is created. Its Model Candidate and Discovery Candidate lineage (RDR-004, Section 6; RDR-005, Section 6) remains unchanged and fully traceable.
- **No new selection function is introduced.** Because no new candidate type is created, this layer does not perform — and must not be read as performing — any additional selection or ranking among Validated Candidates beyond what RDR-005 already established. Multiple Validated Candidates that entered this layer remain multiple (now enriched) Validated Candidates leaving it; this layer's responsibility is enrichment, not adjudication.

This preserves, without modification, the evidence-governed candidate evolution already fixed in RDR-005, Section 10:

```
Discovery Candidate
        ↓
Model Candidate
        ↓
Validated Candidate
```

with enrichment understood as a property added to the Validated Candidate stage, not a fourth stage in this chain.

---

## 7. Enrichment Evidence

Consistent with RDR-001's Evidence Layer, RDR-002's Evidence Flow, and the standardized, named evidence package pattern already established by Discovery Evidence (RDR-003), Model Evidence (RDR-004), and Validation Evidence (RDR-005), this layer produces **Enrichment Evidence**: the standardized evidence package documenting how a Validated Candidate was enriched. Per the locked Scope of Interpretability (Section 3, item 8) and the internal architecture (Section 5), Enrichment Evidence consists of:

- **Biological interpretation evidence** — the output of the Biological Interpretation stage.
- **Model explanation evidence** — the output of the Model Explanation stage.
- **Clinical translation evidence** — the output of the Clinical Translation stage.

**Enrichment Evidence extends, rather than replaces, Validation Evidence.** It does not supersede, duplicate, or re-derive the discrimination, calibration, robustness, external robustness, clinical utility, and reproducibility evidence already assembled and locked within the Validated Candidate's Validation Evidence (RDR-005, Section 7). Instead, Enrichment Evidence builds directly upon that already-completed Validation Evidence, adding biological, explanatory, and clinical-translational context on top of it. This preserves the standardized evidence-package pattern consistently applied across the framework — Discovery Evidence, Model Evidence, Validation Evidence, and now Enrichment Evidence each occupy the same architectural role at their respective layer, with each successive package building on, rather than overwriting, the one before it. No additional evidence component is introduced beyond the three listed above.

The Validated Candidate, together with its Enrichment Evidence, is not considered complete until all three components of the Enrichment Evidence are documented, mirroring the completeness discipline already applied to Discovery Evidence, Model Evidence, and Validation Evidence. This evidence passes through the Evidence Flow (RDR-001) — Strategist Review, FACT/INFERENCE/UNKNOWN classification, Project Coordinator Decision — before any enrichment is treated as final, and it is the primary input to the Methodology Decision Layer whenever a proposed Interpretability or Clinical Translation methodology change is evaluated.

Consistent with the locked Success Criterion (Section 3, item 9), Enrichment Evidence exists to support transparent downstream Framework Integration — it is evidence in service of that later stage's eventual Framework-Wide Recommendation (RDR-005, Section 10), not a recommendation or integration act in its own right.

---

## 8. Benchmark Philosophy

Per the locked Historical Benchmark Philosophy (Section 3, item 4) and RDR-002's component-level Benchmark Philosophy, the historical Part 1 clinical translation pathway — Nomogram, Calibration, Decision Curve Analysis, bootstrap-based internal calibration — must remain directly executable within this layer's internal architecture (Section 5), under the identical datasets and endpoint locked in RDR-000.

As with every prior layer, this requirement is architectural: the historical pathway is one valid instantiation of the Clinical Translation stage in Section 5, rather than an external comparison computed outside the framework. This is what makes benchmarking at this layer genuinely component-level: any modernized instantiation of Biological Interpretation, Model Explanation, or Clinical Translation can be benchmarked directly against the historical instantiation of that same stage, holding the others fixed.

Per the locked Modernization Philosophy (item 7), this benchmarking exists to expand the framework's capacity for transparent, explainable output — not to displace historical clinical translation methodology. The historical pathway remains one governed pathway among others, on equal governance footing with any modernized alternative, consistent with Negative Results (RDR-002): a modernized interpretability or clinical translation approach that fails to outperform the historical pathway is a fully valid and reportable outcome.

---

## 9. Layer Boundary

Per the locked Layer Boundary (Section 3, item 5), this document fixes the same downstream progression already introduced in RDR-005, Section 9, now specialized at this layer's resolution:

```
Validated Candidate
        ↓
Interpretability & Clinical Translation (this document — enrichment)
        ↓
Framework Integration
```

This layer's responsibility ends at producing the Validated Candidate together with complete Enrichment Evidence (Section 7). The following responsibilities explicitly belong to Framework Integration and are out of scope for RDR-006:

- Framework-wide reporting
- Scientific communication
- Clinical reporting
- Framework-Wide Recommendation (RDR-005, Section 10)
- End-to-end framework presentation
- Final integrated framework outputs

This layer does not anticipate or absorb any of the above. Its output — one or more Validated Candidates, each together with its Enrichment Evidence — is handed forward to Framework Integration exactly as Validation handed forward Validated Candidates to this layer (RDR-005, Section 9), preserving the same separation of concerns at each successive boundary in the framework.

---

## 10. Governance

This layer's governance follows the same pattern already established across Discovery, Modeling, and Validation:

- **Component-wise, evidence-constrained modernization** (RDR-002) governs each of the three internal stages (Section 5) independently; no stage's methodology may be modernized without passing through Evidence Review → Feasibility Assessment → Decision.
- **The Methodology Decision Layer** (RDR-002) resolves any proposed change to this layer's methodology to one of its four locked outcomes (Adopt / Retain / Defer / Reject); modernization is not the preferred or default outcome.
- **No new candidate governance mechanism is introduced, and this is a deliberate governance choice, not an omission.** This layer enriches existing Validated Candidates with Enrichment Evidence; it does not create a new candidate type (Section 6). Because no new candidate type exists, there is no new artifact requiring its own governance mechanism: the existing Validated Candidate Governance already established in RDR-005, Section 10 — covering multiplicity, non-collapse of multiplicity, scientific (not clinical) standing, and equal governance footing for historical methodology — already applies in full to the Validated Candidate as it passes through this layer, and remains sufficient without a layer-specific elaboration analogous to RDR-003's Section 10 or RDR-004's Section 10.
- **Enrichment Evidence may be tracked alongside Validation Evidence** in the optional Candidate Register (PROJECT_GOVERNANCE_PROMPT_v4.5.1.md), as an extension of the same Validated Candidate record, not as a separate registry entry for a new candidate type.

---

## 11. Methodology Boundaries

This document does not decide, and explicitly defers to a future, separately governed methodology proposal evaluated through the Methodology Decision Layer:

- Which specific method instantiates Biological Interpretation, Model Explanation, or Clinical Translation.
- Any hyperparameter, software package, or implementation detail associated with any stage.
- The precise form or content of biological interpretation evidence, model explanation evidence, or clinical translation evidence beyond the requirement that each be documented as part of Enrichment Evidence.
- Any aspect of Framework Integration, including Framework-Wide Recommendation, framework-wide reporting, and end-to-end presentation — explicitly reserved for that later, separately governed stage.

These remain open decisions, to be raised individually, evaluated through Evidence Review → Feasibility Assessment → Decision (RDR-002), and locked only with explicit Project Coordinator approval — consistent with the Decision Escalation Policy (PROJECT_GOVERNANCE_PROMPT_v4.5.1.md).

---

## 12. Governance Status

**Status:** LOCKED (APPROVED — Project Coordinator confirmed)

**Implementation:** NOT PERMITTED

**Next Step:**
1. Generate RDR-006_CLOSURE.md
2. Transition to Framework Integration (separately governed)
