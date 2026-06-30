# RDR-003 — Discovery Methodology

**Status:** LOCKED (APPROVED — Project Coordinator confirmed)
**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework
**Document Type:** Reconstruction/Research Design Record (Methodology Specialization)
**Builds on:** RDR-000_Project_Foundation.md (LOCKED), RDR-001_Modern_Framework_Architecture.md (LOCKED), RDR-002_Modern_Methodology_Architecture.md (LOCKED), RDR-002_CLOSURE.md, Discovery Philosophy (LOCKED in Phase A)
**Governed by:** PROJECT_GOVERNANCE_PROMPT_v4.5.1.md
**Next Document:** RDR-004_Modeling_Methodology.md

This document is an architecture specialization. It is not implementation, not an IDS, and contains no code, no software packages, no hyperparameters, and no algorithm recommendation beyond conceptual methodology discussion, consistent with the Modernization Boundaries already locked in RDR-002.

---

## 1. Executive Summary

RDR-001 defined the framework's four-layer vertical architecture and located a Discovery Layer within the Computational Layer. RDR-002 defined the methodology architecture governing how any component — including Discovery — may be modernized, introducing the Methodology Decision Layer, component-wise and evidence-constrained modernization, and Candidate Signature Governance. This document, RDR-003, specializes that architecture for the Discovery Layer specifically: it defines the Discovery Layer's philosophy, internal architecture, evidence generation, benchmarking approach, candidate governance, and interface to the Modeling Layer, in conceptual terms only.

RDR-003 does not select a discovery algorithm. It builds entirely on the already-locked Discovery Philosophy (Phase A) and on RDR-000 through RDR-002, and introduces no new scientific commitments beyond what is necessary to specialize the existing architecture for this one layer.

---

## 2. Relationship to Prior Governance

This document inherits, without modification:

- **From RDR-000:** the Benchmark Philosophy (biological question, datasets, endpoint, validation cohorts held constant), the Design Principles, the Framework Philosophy, and the project's disease-agnostic positioning.
- **From RDR-001:** the four-layer vertical architecture (Scientific Layer → Framework Philosophy → Computational Layer → Evidence Layer), the horizontal cross-cutting principles, the Discovery Layer's purpose/inputs/outputs/dependencies/downstream-impact as originally specified, and the Framework Interfaces contract between Discovery and Modeling.
- **From RDR-002:** component-wise and evidence-constrained modernization, the Methodology Decision Layer and its four outcomes (Adopt / Retain / Defer / Reject), the Historical Mapping Matrix entries concerning gene filtering, discovery statistics, and gene intersection, Candidate Signature Governance, and the principle that negative results are scientifically valid.
- **From the locked Discovery Philosophy (Phase A):** the eight locked statements reproduced in Section 3 below, treated here as authoritative and unmodified.

RDR-003 does not reinterpret any of the above. Its sole purpose is to add the next level of specificity — for the Discovery Layer only — that RDR-001 and RDR-002 deliberately left unspecified.

---

## 3. Locked Discovery Philosophy (Reproduced for Reference)

The following was locked in Phase A and is treated as authoritative throughout this document and all downstream Discovery work:

1. **Discovery Objective** — The Discovery Layer exists to identify robust and reproducible candidate biomarkers rather than merely statistically significant genes.
2. **Primary Discovery Unit** — Genes remain the primary computational unit. The framework architecture must remain extensible to future feature-level, pathway-level, or module-level discovery.
3. **Discovery Outputs** — Discovery produces one or more candidate gene sets together with complete evidence describing how each candidate was generated. Discovery does NOT produce final biomarker signatures.
4. **Discovery Success Criteria** — Discovery quality is jointly evaluated using predictive capability, robustness, and reproducibility. No single criterion dominates.
5. **Biological Knowledge Strategy** — Discovery is data-first. Biological knowledge serves as supporting evidence rather than the primary driver of discovery.
6. **Historical Benchmarking Strategy** — Historical discovery must be executable within the framework under identical datasets and endpoints for component-level benchmarking.
7. **Discovery Layer Boundary** — Discovery: QC/preprocessing → statistical discovery → multiple testing/filtering → cross-cohort integration → candidate gene set. Modeling: candidate gene set → predictive index → classifier → risk groups.
8. **Candidate Definition** — A Discovery Candidate consists of: gene set, evidence, stability profile, discovery pathway, and quality metrics.

Every section of this document is constructed to be consistent with, and to operationalize, these eight statements. None is altered here.

---

## 4. Discovery Layer Philosophy

The Discovery Layer's philosophy is the direct application of the locked Discovery Objective (Section 3, item 1) within the framework's broader Framework Philosophy (RDR-001): robustness, reproducibility, and stability are evaluated jointly with predictive capability, and no single criterion is permitted to dominate Discovery-stage decisions (item 4).

This has a direct architectural consequence already anticipated in RDR-001 and RDR-002: a discovery methodology that achieves high statistical significance on a single cohort, but whose selected gene set is unstable under resampling or across cohorts, does not satisfy the Discovery Objective merely by virtue of significance. This is the same instability Part 1 documented empirically (the Path A / Path B divergence), and the Discovery Layer's philosophy treats that instability as the central problem the Discovery Layer exists to characterize and address — not as an incidental finding.

Consistent with the locked Biological Knowledge Strategy (item 5), Discovery remains data-first. Biological annotation, pathway membership, or prior literature may inform interpretation of a candidate gene set, or contribute to evidence supporting a candidate's plausibility, but it does not substitute for, override, or pre-constrain the data-driven discovery process itself.

---

## 5. Discovery Layer Internal Architecture

RDR-001 defined the Discovery Layer's purpose, inputs, outputs, dependencies, and downstream impact at the resolution of the overall Computational Layer. This section specializes that definition into an internal sequence, consistent with the locked Discovery Layer Boundary (Section 3, item 7):

```
QC / Preprocessing
        ↓
Statistical Discovery
        ↓
Multiple Testing / Filtering
        ↓
Cross-Cohort Integration
        ↓
Candidate Gene Set
```

Each stage is described here by responsibility only, with no algorithm, test, or correction procedure named:

- **QC / Preprocessing** — ensures input expression data meets the quality and structural requirements necessary for downstream statistical discovery (e.g., handling of missingness, normalization status, batch considerations), conceptually corresponding to Part 1's gene filtering component (RDR-002, Historical Mapping Matrix).
- **Statistical Discovery** — evaluates the relationship between gene-level features and the locked endpoint, within each discovery cohort, producing a ranked or scored candidate space prior to any cross-cohort combination.
- **Multiple Testing / Filtering** — controls for the multiplicity inherent in high-dimensional, gene-level testing, narrowing the candidate space to a statistically defensible subset within each cohort.
- **Cross-Cohort Integration** — combines per-cohort discovery results into one or more candidate gene sets, consistent with the locked Primary Discovery Unit (item 2) and structurally analogous to, but not necessarily identical in mechanism to, Part 1's gene intersection component.
- **Candidate Gene Set** — the Discovery Layer's terminal output: one or more gene sets, each accompanied by the complete evidence required by the Candidate Definition (item 8).

This internal sequence is itself a candidate for component-wise, evidence-constrained modernization (RDR-002, Sections 4–6): each stage may independently be modernized, retained, deferred, or rejected by the Methodology Decision Layer once a specific methodology proposal is brought forward in a future document. RDR-003 fixes the *sequence and responsibilities*, not the *method* by which any stage is carried out.

---

## 6. Extensibility Beyond the Gene-Level Unit

Per the locked Primary Discovery Unit (Section 3, item 2), genes remain the primary computational unit for this project's demonstration. However, the internal architecture in Section 5 is deliberately expressed in terms general enough to extend to other feature-level units (e.g., transcript-level, pathway-level, or module-level discovery) without restructuring the five-stage sequence itself.

Specifically: QC/Preprocessing, Statistical Discovery, Multiple Testing/Filtering, Cross-Cohort Integration, and Candidate Gene Set are stage *roles*, not gene-specific operations. A future, separately governed extension of this framework to pathway-level or module-level discovery would substitute the unit of analysis within each stage without altering the stage sequence or the Discovery Layer's interface to the Modeling Layer (Section 9). This extensibility is a design property to be preserved, not a claim that such an extension has been attempted or validated within Part 2.

---

## 7. Discovery Evidence

Consistent with RDR-001's Evidence Layer and RDR-002's Evidence Flow, the Discovery Layer produces evidence — not a self-certifying conclusion — at its output boundary. Discovery Evidence, per the locked Discovery Outputs (Section 3, item 3) and Candidate Definition (item 8), must accompany every candidate gene set and includes, conceptually:

- **Gene set composition** — which genes constitute the candidate.
- **Stability profile** — how consistently the candidate's constituent genes are selected under resampling or across cohorts, directly addressing the locked Discovery Success Criteria (item 4).
- **Discovery pathway** — which internal architecture stages (Section 5), and which specific methodology choices within them, produced this candidate, so that the candidate's provenance is fully traceable.
- **Quality metrics** — the joint predictive capability, robustness, and reproducibility evidence required to evaluate the candidate against the locked Discovery Success Criteria, with no single metric weighted as dominant.

This evidence is what passes through the Evidence Flow (RDR-001) — Strategist Review, FACT/INFERENCE/UNKNOWN classification, Project Coordinator Decision — before any candidate gene set is treated as ready for the Modeling Layer. Discovery Evidence is also the primary input to the Methodology Decision Layer (RDR-002) whenever a proposed discovery methodology change is evaluated.

---

## 8. Benchmarking Philosophy for Discovery

Per the locked Historical Benchmarking Strategy (Section 3, item 6) and RDR-002's component-level Benchmark Philosophy, the historical Part 1 discovery pathway (random-variance t-test discovery statistics, fixed-threshold filtering, hard set-intersection across cohorts) must remain directly executable within the Discovery Layer's internal architecture (Section 5), under the identical datasets and endpoint locked in RDR-000.

This requirement is architectural, not optional: the historical pathway is treated as one valid instantiation of the five-stage sequence in Section 5 — its Statistical Discovery stage instantiated as the random-variance t-test, its Cross-Cohort Integration stage instantiated as hard intersection — rather than as an external comparison point computed outside the framework. This is what allows Discovery-stage benchmarking to be genuinely component-level (RDR-002, Section 7) rather than only a comparison of final candidate gene sets: any modernized instantiation of a given stage can be benchmarked directly against the historical instantiation of that same stage, holding every other stage fixed.

Consistent with Negative Results (RDR-002), a modernized Discovery instantiation that fails to outperform the historical instantiation on stability, robustness, or predictive capability is a scientifically valid and fully reportable outcome.

---

## 9. Discovery → Modeling Interface

RDR-001's Framework Interfaces table already defined this boundary at the Computational Layer's resolution: Discovery's output (candidate feature set(s) and stability evidence) is Modeling's input. This document confirms and specializes that interface for the Discovery Layer specifically, consistent with the locked Discovery Layer Boundary (Section 3, item 7):

| | Discovery (this document) | Modeling (RDR-004, not yet specified) |
|---|---|---|
| **Boundary artifact** | Candidate Gene Set, with full Discovery Evidence (Section 7) | Consumes the Candidate Gene Set as its starting input |
| **What crosses the boundary** | Gene set composition, stability profile, discovery pathway, quality metrics | Nothing returns upstream to Discovery within a single pass |
| **What does NOT cross the boundary** | No predictive index, classifier, or risk group — these are exclusively Modeling Layer outputs, per the locked Discovery Outputs (item 3) | No discovery methodology detail is required by Modeling beyond what Discovery Evidence already documents |

Discovery does not produce a final biomarker signature (Section 3, item 3) and does not perform any operation conceptually belonging to the Modeling Layer (predictive index construction, classification, risk grouping), preserving the same separation of concerns already locked in RDR-001's Framework Interfaces. This boundary is fixed by this document; the specific methodology populating the Modeling side of it is reserved entirely for RDR-004.

---

## 10. Candidate Governance Within the Discovery Layer

RDR-002 established Candidate Signature Governance at the project level: no candidate may be silently discarded, and every candidate must eventually be evaluated against performance, robustness, stability, interpretability, clinical utility, and reproducibility. This document strengthens that governance specifically within the Discovery Layer, where multiple candidate gene sets are most likely to first arise.

- **Multiplicity is expected, not exceptional.** Because Cross-Cohort Integration (Section 5) may be instantiated by more than one methodology — and because the historical pathway must remain executable alongside any modernized alternative (Section 8) — the Discovery Layer should expect to produce more than one candidate gene set as a normal outcome, not as an edge case requiring special justification.
- **Every Discovery Candidate is governed by the full Candidate Definition.** A candidate gene set is not considered a complete Discovery Candidate (Section 3, item 8) until its gene set, evidence, stability profile, discovery pathway, and quality metrics are all documented. An incomplete candidate is not yet eligible to pass to the Modeling Layer.
- **No candidate is discarded at the Discovery Layer itself.** Selection among multiple Discovery Candidates — including any decision to carry only a subset forward into Modeling — is a Methodology Decision Layer outcome (RDR-002), reached through evidence review and explicit Project Coordinator decision, never an implicit filtering step internal to Discovery's own execution.
- **Discovery Candidates may be tracked in the optional Candidate Register** (PROJECT_GOVERNANCE_PROMPT_v4.5.1.md), particularly once more than a small number of candidates accumulate across discovery pathways (e.g., historical vs. one or more modernized instantiations).

This candidate governance is the Discovery-Layer-specific application of the project's broader Framework > Signature philosophy (RDR-000, RDR-001): the framework's value lies in transparently carrying forward and evaluating multiple legitimate candidates, not in the Discovery Layer prematurely committing to a single gene set.

---

## 11. Discovery Methodology Boundaries

This document does not decide, and explicitly defers to a future, separately governed methodology proposal evaluated through the Methodology Decision Layer:

- Which specific statistical or machine-learning method instantiates the Statistical Discovery stage.
- Which specific multiple-testing correction or filtering rule instantiates the Multiple Testing / Filtering stage.
- Which specific method instantiates Cross-Cohort Integration (whether a modernized alternative to hard intersection is proposed at all, and if so, what it is).
- Any hyperparameter, software package, or implementation detail associated with any stage.
- The precise quantitative definition of "stability" used in the stability profile (e.g., the specific resampling scheme or stability metric), beyond the requirement that one be reported as part of Discovery Evidence.

These remain open decisions, to be raised individually, evaluated through Evidence Review → Feasibility Assessment → Decision (RDR-002), and locked only with explicit Project Coordinator approval — consistent with the Decision Escalation Policy (PROJECT_GOVERNANCE_PROMPT_v4.5.1.md).

---

## 12. Governance Status

**Status:** LOCKED (APPROVED — Project Coordinator confirmed)

**Implementation:** NOT PERMITTED

**Next Step:**
1. Generate RDR-003_CLOSURE.md
2. Proceed to RDR-004_Modeling_Methodology.md (preparation phase)
