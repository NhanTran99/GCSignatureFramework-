# RDR-004 — Modeling Methodology

**Status:** PHASE B — REVISED DRAFT UNDER PROJECT COORDINATOR REVIEW
**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework
**Document Type:** Reconstruction/Research Design Record (Methodology Specialization)
**Builds on:** RDR-000_Project_Foundation.md (LOCKED), RDR-001_Modern_Framework_Architecture.md (LOCKED), RDR-002_Modern_Methodology_Architecture.md (LOCKED), RDR-002_CLOSURE.md, RDR-003_Discovery_Methodology.md (LOCKED), RDR-003_CLOSURE.md, Modeling Philosophy (LOCKED in Phase A)
**Governed by:** PROJECT_GOVERNANCE_PROMPT_v4.5.1.md
**Next Document:** RDR-005_Validation_and_Benchmark_Methodology.md

This document is an architecture and methodology specialization. It is not implementation, not an IDS, and contains no code, no software packages, no hyperparameters, and no algorithm recommendation beyond conceptual methodology discussion, consistent with the Modernization Boundaries already locked in RDR-002 and the same scope discipline already applied in RDR-003.

---

## 1. Executive Summary

RDR-003 specialized the framework's architecture for the Discovery Layer, fixing its internal five-stage sequence, its evidence requirements, and its interface to the Modeling Layer. This document, RDR-004, specializes the same architecture for the Modeling Layer, building entirely on the already-locked Modeling Philosophy (Phase A) and on RDR-000 through RDR-003.

RDR-004 defines the Modeling Layer's philosophy, internal architecture, output structure, evidence and candidate governance, benchmarking approach against Part 1's historical modeling pathway, and interface to the Validation Layer — in conceptual terms only. It introduces no algorithm, statistical model, or implementation detail, and it does not redesign Discovery or anticipate Validation beyond the single interface boundary RDR-001 already established between them.

---

## 2. Relationship to Prior Governance

This document inherits, without modification:

- **From RDR-000:** the Benchmark Philosophy, Design Principles, Framework Philosophy, and disease-agnostic positioning.
- **From RDR-001:** the four-layer vertical architecture, the horizontal cross-cutting principles, the Modeling Layer's originally specified purpose/inputs/outputs/dependencies/downstream impact, and the Framework Interfaces contract between Discovery, Modeling, and Validation.
- **From RDR-002:** component-wise and evidence-constrained modernization, the Methodology Decision Layer and its four outcomes, the Historical Mapping Matrix entries concerning dimensionality reduction/predictive index, classification, and median-split risk grouping, Candidate Signature Governance, and Negative Results.
- **From RDR-003:** the Discovery Layer's terminal output — a Discovery Candidate, consisting of gene set, evidence, stability profile, discovery pathway, and quality metrics — which is the fixed starting input to this document, and the precedent that an internal architecture is specified as stage *roles*, not methods.
- **From the locked Modeling Philosophy (Phase A):** the nine locked statements reproduced in Section 3 below, treated here as authoritative and unmodified.

RDR-004 does not reinterpret any of the above. It does not redesign Discovery's internal architecture or output structure, and it does not draft Validation methodology beyond confirming the single interface boundary already anticipated in RDR-001.

---

## 3. Locked Modeling Philosophy (Reproduced for Reference)

The following was locked in Phase A and is treated as authoritative throughout this document and all downstream Modeling work:

1. **Modeling Objective** — The Modeling Layer exists to develop robust predictive models that jointly optimize predictive performance, robustness, reproducibility, and clinical translatability. Clinical translatability is a design objective, not clinical deployment.
2. **Modeling Input** — The Modeling Layer receives one or more Discovery Candidates (gene set, evidence, stability profile, discovery pathway, quality metrics). It does NOT receive raw genes alone.
3. **Modeling Output** — The Modeling Layer produces one or more Model Candidates, each consisting of: predictive model, risk score definition, model evidence, performance profile, interpretability profile, clinical evaluation profile. These become the input to the Validation Layer. The Modeling Layer does NOT determine the final recommended model.
4. **Modeling Success Criteria** — Model quality is jointly evaluated using predictive capability, robustness, reproducibility, interpretability, parsimony, and support for downstream clinical evaluation. No single criterion dominates.
5. **Model Complexity Philosophy** — When two candidate models demonstrate comparable overall performance, the framework prefers the simpler model, to encourage robustness, interpretability, and applicability in resource-constrained settings.
6. **Model Candidate Governance** — The Modeling Layer never assumes only one modeling strategy exists; multiple Model Candidates may coexist (e.g., Discovery Candidate A → Model Candidate A; Discovery Candidate B → Model Candidate B). Selection is NOT performed in the Modeling Layer; selection belongs to the Validation Layer.
7. **Historical Modeling Benchmark** — Historical modeling is executed inside the same framework, under identical datasets and endpoints as modern modeling. Component-level benchmarking is mandatory. End-to-end benchmarking belongs to the final integrated framework and is outside RDR-004's scope.
8. **Modeling Boundary** — Modeling: Discovery Candidate → Representation → Prediction → Risk estimation → Model Candidate. Validation begins immediately after Model Candidates are produced.
9. **Motivation for Modernization** — RDR-004 does not replace historical methodology. Historical PCA → Predictive Index → Median Split → SVM remains a valid historical modeling pathway; its limitation is that it provides only one pathway and lacks governance for evaluating multiple modeling strategies. Modernization introduces Model Candidate Governance, not the rejection of historical methodology; historical methodology becomes one governed candidate within a transparent, evidence-based framework.

Every section of this document is constructed to be consistent with, and to operationalize, these nine statements. None is altered here.

---

## 4. Modeling Layer Philosophy

The Modeling Layer's philosophy is the direct application of the locked Modeling Objective (Section 3, item 1) within the framework's broader Framework Philosophy (RDR-001): predictive performance, robustness, reproducibility, and clinical translatability are evaluated jointly, with no single objective dominating Modeling-stage decisions (item 4).

This has a direct consequence already anticipated by the locked Model Complexity Philosophy (item 5): where two Model Candidates are comparable in overall quality, the framework's stated preference for the simpler model is not a tie-breaking convenience but a direct expression of the project's general philosophy (RDR-000) that, when performance is equivalent, the simpler and more interpretable solution is preferred. Parsimony is therefore treated as a success criterion in its own right (item 4), not merely as a fallback rule applied after other criteria have already decided the outcome.

Consistent with the locked Modeling Objective, "clinical translatability" at this stage is a design property the Modeling Layer must keep visible and evaluable — for example, ensuring a Model Candidate's structure remains compatible with eventual clinical evaluation — and is explicitly not a claim, commitment, or attempt at this stage to deploy, validate, or recommend any model for clinical use. That distinction is preserved throughout this document.

---

## 5. Modeling Layer Internal Architecture

RDR-001 anticipated the Modeling Layer's internal sequence at the resolution of the locked Discovery Layer Boundary (Discovery Philosophy, carried into RDR-003): Candidate gene set → Predictive Index → Classifier → Risk groups. The locked Modeling Boundary (Section 3, item 8) restates this at a slightly more general level of abstraction, consistent with keeping the architecture algorithm-agnostic:

```
Discovery Candidate
        ↓
Representation
        ↓
Prediction
        ↓
Risk Estimation
        ↓
Model Candidate
```

Each stage is described here by responsibility only, with no algorithm, model family, or scoring rule named:

- **Representation** — transforms the Discovery Candidate's gene set into a quantitative representation suitable for predictive modeling. This is the conceptual generalization of Part 1's PCA-based predictive index construction: a representation-building step that need not be PCA-specific, but must occupy the same architectural position.
- **Prediction** — relates the representation to the locked endpoint, producing a model capable of generating patient-level predictions. This is the conceptual generalization of Part 1's SVM classification step.
- **Risk Estimation** — translates the model's predictions into a risk score or risk categorization usable for downstream evaluation. This is the conceptual generalization of Part 1's median-split risk grouping, without committing to a median split, or to any other specific grouping rule, as the mechanism.
- **Model Candidate** — the Modeling Layer's terminal output: one or more Model Candidates, each accompanied by the complete evidence required by the Model Candidate definition (Section 3, item 3).

This internal sequence is itself a candidate for component-wise, evidence-constrained modernization (RDR-002, Sections 4–6): each stage may independently be modernized, retained, deferred, or rejected by the Methodology Decision Layer once a specific methodology proposal is brought forward. RDR-004 fixes the *sequence and responsibilities*, not the *method* by which any stage is carried out — exactly as RDR-003 did for Discovery.

---

## 6. From Discovery Candidate to Model Candidate

The Modeling Layer's input is fixed by RDR-003 and reaffirmed by the locked Modeling Input statement (Section 3, item 2): a complete Discovery Candidate (gene set, evidence, stability profile, discovery pathway, quality metrics), never raw genes alone. This requirement is architectural, not stylistic: every Model Candidate produced by this layer must remain traceable to the specific Discovery Candidate, and the specific Discovery Evidence, that motivated it.

This traceability requirement directly supports the Model Candidate Governance principle (Section 3, item 6): because more than one Discovery Candidate may exist simultaneously (RDR-003, Section 10), the Modeling Layer must be able to relate each resulting Model Candidate back to exactly one originating Discovery Candidate, preserving a clean, auditable lineage of the form Discovery Candidate A → Model Candidate A, Discovery Candidate B → Model Candidate B, rather than allowing Model Candidates to become disconnected from the Discovery evidence that justified them.

### Modeling Provenance

Every Model Candidate's evolution through the Modeling Layer's internal architecture (Section 5) should remain fully traceable, stage by stage:

```
Discovery Candidate
        ↓
Representation
        ↓
Prediction
        ↓
Risk Estimation
        ↓
Model Candidate
```

Each downward transition in this sequence must be recoverable from the Model Candidate's documented evidence: which Discovery Candidate it began from, what representation was derived from that candidate's gene set, what prediction was produced from that representation, and what risk estimate was derived from that prediction. This is a conceptual provenance requirement only — it specifies that the lineage must be traceable, not how any system or process records it. Preserving this lineage is what allows a Model Candidate to be understood, audited, and benchmarked as the product of a specific, reconstructable scientific pathway, rather than as an opaque final artifact disconnected from the Discovery Candidate that motivated it.

---

## 7. Model Candidate Definition and Evidence

Consistent with RDR-001's Evidence Layer and RDR-002's Evidence Flow, the Modeling Layer produces evidence — not a self-certifying conclusion — at its output boundary. Per the locked Modeling Output statement (Section 3, item 3), every Model Candidate consists of six required components:

- **Predictive model** — the fitted structure relating the Discovery Candidate's representation to the endpoint.
- **Risk score definition** — the specific rule by which the model's output is translated into a risk score or risk category, produced by the Risk Estimation stage (Section 5).
- **Model evidence** — the documentation of how the Model Candidate was produced: which Discovery Candidate it originates from, and which methodology occupied each internal stage (Representation, Prediction, Risk Estimation).
- **Performance profile** — predictive capability evidence, addressing the locked Modeling Success Criteria's predictive-capability component (item 4).
- **Interpretability profile** — evidence addressing the locked Modeling Success Criteria's interpretability component, at a level of rigor appropriate to the model type produced.
- **Clinical evaluation profile** — evidence supporting the locked Modeling Objective's clinical-translatability component (item 1), framed as a design-stage property rather than a clinical validation claim.

A Model Candidate is not considered complete until all six components are documented, mirroring the same completeness requirement RDR-003 placed on the Discovery Candidate. This evidence is what passes through the Evidence Flow (RDR-001) — Strategist Review, FACT/INFERENCE/UNKNOWN classification, Project Coordinator Decision — before any Model Candidate is treated as ready for the Validation Layer, and it is the primary input to the Methodology Decision Layer whenever a proposed Modeling methodology change is evaluated.

---

## 8. Benchmarking Philosophy for Modeling

Per the locked Historical Modeling Benchmark (Section 3, item 7) and RDR-002's component-level Benchmark Philosophy, the historical Part 1 modeling pathway — PCA-based predictive index construction, SVM classification, median-split risk grouping — must remain directly executable within the Modeling Layer's internal architecture (Section 5), under the identical datasets and endpoint locked in RDR-000.

As with Discovery (RDR-003, Section 8), this requirement is architectural: the historical pathway is one valid instantiation of the four-stage sequence in Section 5 — its Representation stage instantiated as PCA-based predictive index construction, its Prediction stage instantiated as SVM classification, its Risk Estimation stage instantiated as median-split grouping — rather than an external comparison computed outside the framework. This is what makes Modeling-stage benchmarking genuinely component-level: any modernized instantiation of a given stage can be benchmarked directly against the historical instantiation of that same stage, holding the other stages fixed.

Per the locked Historical Modeling Benchmark, this document's scope is explicitly limited to component-level benchmarking within the Modeling Layer. End-to-end benchmarking of the complete framework — spanning Discovery, Modeling, Validation, and beyond — belongs to the final integrated framework assessment and is out of scope for RDR-004, consistent with Section 9's Motivation for Modernization (item 9): historical methodology is retained as one governed candidate, not eliminated, and Negative Results (RDR-002) remain a fully valid outcome of this benchmarking.

Modernization, within this benchmarking philosophy, is evaluated *relative to* the historical pathway through transparent, component-level comparison — never as a mandate to replace it. The objective of modernizing the Modeling Layer is not to replace PCA-based predictive index construction, median-split risk grouping, or SVM classification as a matter of course. Instead, each of these historical components becomes one governed candidate instantiation of its corresponding stage (Representation, Risk Estimation, Prediction respectively) within an evidence-based framework, standing on the same governance footing as any modernized alternative until component-level evidence determines otherwise.

---

## 9. Modeling → Validation Interface

RDR-001's Framework Interfaces table defined this boundary at the Computational Layer's resolution: Modeling's output (fitted model specification and model specification evidence) is Validation's input. This document confirms and specializes that interface, consistent with the locked Modeling Boundary (Section 3, item 8):

| | Modeling (this document) | Validation (RDR-005, not yet specified) |
|---|---|---|
| **Boundary artifact** | One or more Model Candidates, each with full evidence (Section 7) | Consumes Model Candidate(s) as starting input |
| **What crosses the boundary** | Predictive model, risk score definition, model evidence, performance profile, interpretability profile, clinical evaluation profile | Nothing returns upstream to Modeling within a single pass |
| **What does NOT cross the boundary** | No selection among Model Candidates — selection is explicitly NOT a Modeling Layer function (item 6) | Validation, not Modeling, performs the selection function among coexisting Model Candidates |

The Validation Layer begins immediately after Model Candidates are produced (Section 3, item 8). Consistent with Model Candidate Governance, the Modeling Layer hands forward every complete Model Candidate it produces — it does not pre-select, filter, or rank them before they reach Validation. This boundary is fixed by this document; the specific methodology populating the Validation side of it is reserved entirely for RDR-005.

---

## 10. Model Candidate Governance

RDR-002 established Candidate Signature Governance at the project level, and RDR-003 strengthened it specifically within the Discovery Layer. This document strengthens it specifically within the Modeling Layer, consistent with the locked Model Candidate Governance statement (Section 3, item 6).

- **Multiplicity is the expected default, not an exception.** Because Discovery may produce multiple Discovery Candidates, and because the historical modeling pathway must remain executable alongside any modernized alternative (Section 8), the Modeling Layer should expect to produce more than one Model Candidate as a normal outcome.
- **Every Model Candidate is governed by the full Model Candidate definition.** A fitted model is not a complete Model Candidate (Section 7) until all six required components are documented. An incomplete candidate is not yet eligible to pass to the Validation Layer.
- **No selection occurs within the Modeling Layer.** Selection among multiple Model Candidates — including any decision to prioritize one Discovery-Candidate-derived lineage over another — belongs exclusively to the Validation Layer (Section 3, item 6; Section 9). The Modeling Layer's responsibility ends at producing complete, evidence-bearing Model Candidates, not at choosing among them.
- **Historical methodology is one governed candidate, not a baseline to be superseded.** Per the locked Motivation for Modernization (item 9), the historical PCA → Predictive Index → Median Split → SVM pathway is carried forward as a Model Candidate in its own right, on equal governance footing with any modernized alternative, consistent with Negative Results (RDR-002).
- **Model Candidates may be tracked in the optional Candidate Register** (PROJECT_GOVERNANCE_PROMPT_v4.5.1.md), particularly once multiple Discovery-Candidate-derived lineages accumulate.

This candidate governance is the Modeling-Layer-specific application of the project's broader Framework > Signature philosophy: the framework's value lies in transparently carrying forward and evaluating multiple legitimate Model Candidates into Validation, not in the Modeling Layer prematurely committing to a single model.

**Model Candidates represent competing scientific hypotheses, not competing implementations.** The purpose of allowing multiple Model Candidates to coexist is not to compare algorithms for their own sake, but to preserve multiple scientifically valid modeling hypotheses — each traceable to a specific Discovery Candidate and a specific set of methodology choices — until the Validation Layer is in a position to evaluate them on their merits. A Model Candidate's standing in the framework is therefore scientific, not technical: it persists because it represents a defensible hypothesis about how the endpoint relates to the underlying biology, not because it happens to instantiate a particular algorithm. This reinforces, at the Modeling Layer specifically, the Framework > Signature philosophy already locked in RDR-000 and RDR-001 — the framework's purpose is to adjudicate between hypotheses transparently, not to showcase methodological variety.

---

## 11. Modeling Methodology Boundaries

This document does not decide, and explicitly defers to a future, separately governed methodology proposal evaluated through the Methodology Decision Layer:

- Which specific method instantiates the Representation stage.
- Which specific method instantiates the Prediction stage.
- Which specific method instantiates the Risk Estimation stage.
- Any hyperparameter, software package, or implementation detail associated with any stage.
- The precise quantitative definitions used within the performance, interpretability, or clinical evaluation profiles, beyond the requirement that each be reported as part of Model Candidate evidence.
- How selection among multiple Model Candidates is ultimately performed — this belongs to the Validation Layer and is explicitly reserved for RDR-005.

These remain open decisions, to be raised individually, evaluated through Evidence Review → Feasibility Assessment → Decision (RDR-002), and locked only with explicit Project Coordinator approval — consistent with the Decision Escalation Policy (PROJECT_GOVERNANCE_PROMPT_v4.5.1.md).

---

## 12. Governance Status

**Status:** PHASE B — REVISED DRAFT UNDER PROJECT COORDINATOR REVIEW

**Implementation:** NOT PERMITTED

**Next Step:**
1. Strategist Review
2. Project Coordinator Discussion
3. RDR-004 Lock
4. Generate RDR-004_CLOSURE.md (only after lock, per RDR GOVERNANCE WORKFLOW, PROJECT_GOVERNANCE_PROMPT_v4.5.1.md)
5. Proceed to RDR-005_Validation_and_Benchmark_Methodology.md
