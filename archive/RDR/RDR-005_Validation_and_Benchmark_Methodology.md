# RDR-005 — Validation and Benchmark Methodology

**Status:** LOCKED (APPROVED — Project Coordinator confirmed)
**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework
**Document Type:** Reconstruction/Research Design Record (Methodology Specialization)
**Builds on:** RDR-000_Project_Foundation.md (LOCKED), RDR-001_Modern_Framework_Architecture.md (LOCKED), RDR-002_Modern_Methodology_Architecture.md (LOCKED), RDR-002_CLOSURE.md, RDR-003_Discovery_Methodology.md (LOCKED), RDR-003_CLOSURE.md, RDR-004_Modeling_Methodology.md (LOCKED), RDR-004_CLOSURE.md, Validation Philosophy (LOCKED in Phase A)
**Governed by:** PROJECT_GOVERNANCE_PROMPT_v4.5.1.md
**Next Document:** RDR-006_Interpretability_and_Clinical_Translation_Methodology.md

This document is an architecture and methodology specialization. It is not implementation, not an IDS, and contains no code, no software packages, no hyperparameters, and no algorithm recommendation beyond conceptual methodology discussion, consistent with the Modernization Boundaries already locked in RDR-002 and the scope discipline already applied in RDR-003 and RDR-004.

---

## 1. Executive Summary

RDR-004 specialized the framework's architecture for the Modeling Layer, fixing its internal four-stage sequence, its Model Candidate definition, and its interface to the Validation Layer. This document, RDR-005, specializes the same architecture for the Validation Layer, building entirely on the already-locked Validation Philosophy (Phase A) and on RDR-000 through RDR-004.

RDR-005 defines the Validation Layer's philosophy, internal architecture, output structure, evidence and candidate governance, benchmarking approach against Part 1's historical validation pathway, and the boundary at which RDR-005's responsibility ends — in conceptual terms only. It introduces no statistical test, performance metric implementation, or software detail, and it does not redesign Discovery or Modeling, nor does it anticipate framework-wide integration, end-to-end benchmarking, or the Interpretability/Clinical Translation methodology reserved for RDR-006.

---

## 2. Relationship to Prior Governance

This document inherits, without modification:

- **From RDR-000:** the Benchmark Philosophy, Design Principles, Framework Philosophy, and disease-agnostic positioning.
- **From RDR-001:** the four-layer vertical architecture, the horizontal cross-cutting principles, the Validation Layer's originally specified purpose/inputs/outputs/dependencies/downstream impact, and the Framework Interfaces contract among Discovery, Modeling, and Validation.
- **From RDR-002:** component-wise and evidence-constrained modernization, the Methodology Decision Layer and its four outcomes, the Historical Mapping Matrix entries concerning external validation and survival analysis, Candidate Signature Governance, and Negative Results.
- **From RDR-003:** the precedent of an internal architecture specified as stage *roles*, and the Discovery Candidate as the project's first fully-specified candidate type.
- **From RDR-004:** the Model Candidate — the fixed starting input to this document — consisting of predictive model, risk score definition, model evidence, performance profile, interpretability profile, and clinical evaluation profile; and the explicit deferral of candidate *selection* from the Modeling Layer to the Validation Layer (RDR-004, Sections 9–10).
- **From the locked Validation Philosophy (Phase A):** the nine locked statements reproduced in Section 3 below, treated here as authoritative and unmodified.

RDR-005 does not reinterpret any of the above. It does not redesign Discovery's or Modeling's internal architecture or output structure, and it does not draft Interpretability/Clinical Translation methodology beyond confirming that it lies beyond the Validation boundary fixed in Section 9.

---

## 3. Locked Validation Philosophy (Reproduced for Reference)

The following was locked in Phase A and is treated as authoritative throughout this document and all downstream Validation work:

1. **Validation Objective** — The Validation Layer exists to determine which Model Candidates have accumulated sufficient evidence to become Validated Candidates. Validation is an evidence-integration process, not a single performance assessment.
2. **Validation Input** — The Validation Layer receives one or more Model Candidates (predictive model, risk score definition, model evidence, performance profile, interpretability profile, clinical evaluation profile). It does NOT receive raw prediction outputs alone.
3. **Validation Output** — The Validation Layer produces one or more Validated Candidates, each a Model Candidate that has completed the framework's validation requirements together with complete validation evidence. Validation also provides a transparent recommendation identifying the most appropriate candidate under stated evaluation criteria, explaining why it is preferred, under which criteria, for which intended context or population, and under which performance profile.
4. **Validation Success Criteria** — Validation jointly evaluates Model Candidates using multiple complementary evidence domains, including (without limiting future methodology) discrimination, calibration, robustness, external robustness, clinical utility, and reproducibility. No single metric is sufficient on its own; validation is evidence-driven, not metric-driven.
5. **Historical Validation Benchmark** — Historical validation is reconstructed within the same framework using identical datasets and endpoints, conceptually represented as: Model Candidate → Risk Groups → Training Cohort (KM, log-rank, ROC/AUC) → External Validation Cohort (KM, log-rank, Cox analysis) → Clinical Translation Extension (nomogram, calibration, DCA, bootstrap). Historical methodology remains one governed validation pathway, not a baseline that must be replaced.
6. **Motivation for Modernization** — Historical validation's principal limitations are: a single validation pathway, limited assessment of external robustness, and limited multi-criteria benchmarking across competing candidates. Modernization focuses on Validation Candidate Governance, not on replacing historical validation methodology; historical validation becomes one governed pathway inside the framework.
7. **Validation Governance** — Validation does not simply score Model Candidates; it determines whether they accumulate sufficient evidence to become Validated Candidates. Multiple Validated Candidates may coexist. Validation provides transparent recommendations while preserving all supporting evidence.
8. **Benchmarking Philosophy** — Component-level benchmarking remains mandatory; historical and modern validation methodologies are benchmarked under identical datasets, endpoints, and evaluation objectives. End-to-end benchmarking of the complete framework is explicitly outside RDR-005's scope, reserved for the final Framework Integration stage.
9. **Validation Boundary** — The Validation Layer begins immediately after Model Candidates are produced. Its responsibility ends after producing Validated Candidates together with transparent evidence-based recommendations. Framework-wide recommendation, integration, and end-to-end benchmarking remain outside RDR-005's scope.

Every section of this document is constructed to be consistent with, and to operationalize, these nine statements. None is altered here.

---

## 4. Validation Layer Philosophy

The Validation Layer's philosophy is the direct application of the locked Validation Objective (Section 3, item 1) within the framework's broader Framework Philosophy (RDR-001): Validation is an act of evidence integration across multiple complementary domains (item 4), not a single pass/fail performance check. This distinguishes Validation from a simple benchmark computation — it is the layer where the framework's accumulated evidence about a Model Candidate is weighed jointly, consistent with the project's general refusal (RDR-000, RDR-002, RDR-004) to let any single criterion dominate a methodology decision.

This philosophy has a direct consequence for what "becoming a Validated Candidate" means: it is not merely crossing a numeric threshold on one metric, but accumulating sufficient evidence across discrimination, calibration, robustness, external robustness, clinical utility, and reproducibility (Section 3, item 4) for the Methodology Decision Layer and Project Coordinator to judge the evidence sufficient. Consistent with Negative Results (RDR-002) and the Candidate Governance philosophy already established for Discovery and Modeling, a Model Candidate that does not accumulate sufficient evidence does not become a Validated Candidate, and that outcome is itself a scientifically valid and fully reportable result — not a failure of the Validation Layer.

---

## 5. Validation Layer Internal Architecture

The locked Historical Validation Benchmark (Section 3, item 5) already specifies the historical validation pathway's structure in detail. This section generalizes that structure into the Validation Layer's internal architecture, expressed at the level of stage roles rather than specific statistical procedures:

```
Model Candidate
        ↓
Internal Evidence Assembly
        ↓
External Evidence Assembly
        ↓
Multi-Criteria Evidence Integration
        ↓
Validated Candidate + Recommendation
```

Each stage is described here by responsibility only, with no statistical test, performance metric, or procedure named:

- **Internal Evidence Assembly** — gathers evidence about the Model Candidate's behavior on the training/discovery cohort(s) under the locked datasets and endpoint, conceptually generalizing the historical pathway's training-cohort Kaplan–Meier, log-rank, and ROC/AUC assessment.
- **External Evidence Assembly** — gathers evidence about the Model Candidate's behavior on the independent external validation cohort, conceptually generalizing the historical pathway's external Kaplan–Meier, log-rank, and Cox analysis, and directly supporting the locked Validation Success Criteria's external-robustness component (item 4).
- **Multi-Criteria Evidence Integration** — combines internal and external evidence across the full set of locked evaluation domains (discrimination, calibration, robustness, external robustness, clinical utility, reproducibility) into a joint evidence picture for the Model Candidate, consistent with the locked principle that no single metric is sufficient on its own.
- **Validated Candidate + Recommendation** — the Validation Layer's terminal output: a Validated Candidate together with the transparent recommendation required by the locked Validation Output statement (item 3).

This internal sequence is itself a candidate for component-wise, evidence-constrained modernization (RDR-002, Sections 4–6): each stage may independently be modernized, retained, deferred, or rejected by the Methodology Decision Layer once a specific methodology proposal is brought forward. RDR-005 fixes the *sequence and responsibilities*, not the *method* by which any stage is carried out — exactly as RDR-003 and RDR-004 did for their respective layers.

Consistent with the locked Validation Boundary (item 9), the Clinical Translation Extension named in the historical pathway (nomogram, calibration, DCA, bootstrap) is explicitly positioned outside this internal architecture: it is reserved for RDR-006 (Interpretability and Clinical Translation Methodology), not absorbed into Validation's own stages.

---

## 6. From Model Candidate to Validated Candidate

The Validation Layer's input is fixed by RDR-004 and reaffirmed by the locked Validation Input statement (Section 3, item 2): a complete Model Candidate (predictive model, risk score definition, model evidence, performance profile, interpretability profile, clinical evaluation profile), never raw prediction outputs alone. This requirement is architectural: every Validated Candidate produced by this layer must remain traceable to the specific Model Candidate, and the Model Evidence and Modeling Provenance (RDR-004, Section 6) attached to it, that it validates.

This traceability requirement directly supports the locked Validation Governance principle (item 7): because more than one Model Candidate may exist simultaneously (RDR-004, Section 10), the Validation Layer must be able to relate each resulting Validated Candidate back to exactly one originating Model Candidate, extending the same auditable lineage already established for Discovery Candidate → Model Candidate (RDR-004, Section 6) one step further: Model Candidate → Validated Candidate.

---

## 7. Validated Candidate Definition and Evidence

Consistent with RDR-001's Evidence Layer and RDR-002's Evidence Flow, the Validation Layer produces evidence — not a self-certifying conclusion — at its output boundary. Per the locked Validation Output statement (Section 3, item 3), every Validated Candidate consists of:

- **The originating Model Candidate**, carried forward in full, preserving the lineage required by Section 6.
- **Complete validation evidence**, spanning the locked evaluation domains (discrimination, calibration, robustness, external robustness, clinical utility, reproducibility — Section 3, item 4), assembled through the internal architecture's Internal and External Evidence Assembly stages (Section 5).
- **A transparent recommendation**, which must explicitly state: why the candidate is preferred, under which evaluation criteria, for which intended context or population, and under which performance profile — exactly as locked in Section 3, item 3.

Taken together, these three components constitute **Validation Evidence**: the Validation Layer's standardized evidence package, occupying the same architectural role for Validated Candidates that Discovery Evidence (RDR-003, Section 7) occupies for Discovery Candidates and Model Evidence (RDR-004, Section 7) occupies for Model Candidates. This naming makes explicit a symmetry that was already implicit in the framework's design: every layer in the Discovery → Modeling → Validation chain produces its own named, standardized evidence package as the condition for its candidate type to be considered complete. Validation Evidence does not add any required component beyond the three already listed above; it is a unifying name for that same fixed set, not an expansion of it.

A Validated Candidate is not considered complete until its Validation Evidence is fully documented, mirroring the same completeness discipline RDR-003 and RDR-004 applied to Discovery Evidence and Model Evidence respectively. This evidence is what passes through the Evidence Flow (RDR-001) — Strategist Review, FACT/INFERENCE/UNKNOWN classification, Project Coordinator Decision — before any Validated Candidate or its accompanying recommendation is treated as final, and it is the primary input to the Methodology Decision Layer whenever a proposed Validation methodology change is evaluated.

---

## 8. Benchmarking Philosophy for Validation

Per the locked Benchmarking Philosophy (Section 3, item 8) and RDR-002's component-level Benchmark Philosophy, the historical Part 1 validation pathway — training-cohort KM/log-rank/ROC-AUC, external-cohort KM/log-rank/Cox analysis — must remain directly executable within the Validation Layer's internal architecture (Section 5), under the identical datasets and endpoint locked in RDR-000.

As with Discovery and Modeling, this requirement is architectural: the historical pathway is one valid instantiation of the four-stage sequence in Section 5 — its Internal Evidence Assembly stage instantiated as training-cohort KM/log-rank/ROC-AUC, its External Evidence Assembly stage instantiated as external-cohort KM/log-rank/Cox analysis — rather than an external comparison computed outside the framework. This is what makes Validation-stage benchmarking genuinely component-level: any modernized instantiation of a given stage can be benchmarked directly against the historical instantiation of that same stage, holding the other stages fixed.

Per the locked Motivation for Modernization (item 6), this benchmarking exists to address historical validation's documented limitations — a single validation pathway, limited external-robustness assessment, and limited multi-criteria benchmarking across competing candidates — not to displace historical validation methodology. Historical validation remains one governed validation pathway, on equal governance footing with any modernized alternative, consistent with Negative Results (RDR-002).

Per the locked Validation Boundary (item 9), end-to-end benchmarking of the complete framework — spanning Discovery, Modeling, Validation, and any subsequent layer — is explicitly out of scope for RDR-005 and is reserved for the final Framework Integration stage.

---

## 9. Validation Layer Boundary and Downstream Interface

The Validation Layer begins immediately after Model Candidates are produced (Section 3, item 9; RDR-004, Section 9) and ends after producing Validated Candidates together with their transparent, evidence-based recommendations. This document fixes that boundary, and the downstream progression beyond it, as follows:

```
Validation Layer (this document)
        ↓
RDR-006 (Interpretability & Clinical Translation)
        ↓
Framework Integration
```

This progression does not change any responsibility or boundary already fixed elsewhere in this document; it states explicitly, in sequence, what RDR-005 Sections 8–10 already establish individually: Validation hands forward Validated Candidates; RDR-006 is the next, separately governed methodology document, scoped to Interpretability and Clinical Translation (including the historical Clinical Translation Extension — nomogram, calibration, DCA, bootstrap — explicitly excluded from Validation's own internal architecture in Section 5); and Framework Integration is the final, separately governed stage at which Framework-Wide Recommendation and end-to-end benchmarking occur (Section 3, item 8).

| | Modeling (RDR-004, LOCKED) | Validation (this document) | RDR-006 (Interpretability & Clinical Translation) | Framework Integration |
|---|---|---|---|---|
| **Boundary artifact received** | — | One or more Model Candidates, each with full evidence | One or more Validated Candidates, each with Validation Evidence and a recommendation | Output of RDR-006 |
| **What this stage adds** | — | Internal/external evidence assembly, multi-criteria integration, recommendation (Section 7) | Interpretability and Clinical Translation methodology (reserved for RDR-006) | Framework-Wide Recommendation and end-to-end benchmarking (reserved for Framework Integration) |
| **What this stage does NOT do** | — | Does not perform Framework-Wide Recommendation, integration, or end-to-end benchmarking; does not perform Clinical Translation Extension methodology — reserved downstream | Not specified by this document | Not specified by this document |

The Validation Layer's own recommendation (Section 7) is scoped to identifying the most appropriate Validated Candidate(s) under stated criteria within the Validation Layer's evidence domains; it is explicitly distinct from, and does not anticipate, the Framework-Wide Recommendation reserved for Framework Integration (see Section 10 for the precise relationship between the two).

---

## 10. Validated Candidate Governance

RDR-002 established Candidate Signature Governance at the project level; RDR-003 and RDR-004 strengthened it within Discovery and Modeling respectively. This document strengthens it specifically within the Validation Layer, consistent with the locked Validation Governance statement (Section 3, item 7).

- **Multiplicity may persist even at this stage.** Because Modeling may produce multiple Model Candidates (RDR-004, Section 10), and because the historical validation pathway must remain executable alongside any modernized alternative (Section 8), the Validation Layer should expect that more than one Model Candidate may successfully accumulate sufficient evidence to become a Validated Candidate. Multiple Validated Candidates may coexist (Section 3, item 7).
- **Validation does not collapse multiplicity by itself.** Becoming a Validated Candidate is a statement about evidence sufficiency, not a statement that all other candidates have been eliminated. The transparent recommendation required by Section 7 identifies the most appropriate candidate under stated criteria, but it does so without discarding the other Validated Candidates or their evidence.
- **Validated Candidates represent the framework's most evidence-complete scientific conclusions to this point, not final clinical decisions.** Consistent with the locked Validation Objective (item 1) and the Clinical Translatability framing already established in RDR-004 (a design objective, not clinical deployment), a Validated Candidate's recommendation is a methodological and scientific judgment, not a clinical recommendation for patient care.
- **Historical methodology remains one governed Validated Candidate pathway, not a baseline to be superseded.** Per the locked Motivation for Modernization (item 6), the historical validation pathway is carried forward as a candidate validation pathway in its own right, on equal governance footing with any modernized alternative, consistent with Negative Results (RDR-002).
- **Validated Candidates may be tracked in the optional Candidate Register** (PROJECT_GOVERNANCE_PROMPT_v4.5.1.md), particularly once multiple Discovery-Candidate-derived and Model-Candidate-derived lineages reach Validated Candidate status.

This candidate governance completes, for the Validation Layer, the same evidence-governed candidate evolution already established across Discovery and Modeling:

```
Discovery Candidates
        ↓
Model Candidates
        ↓
Validated Candidates
        ↓
Framework-Wide Recommendation
        ↓
Recommended Signature
```

To avoid ambiguity between two terms that have appeared in prior project discussion, this document fixes a single governance interpretation: the **Framework-Wide Recommendation** is the process, reserved for Framework Integration (Section 9), by which one or more Validated Candidates from across the entire framework are weighed against each other to produce the **Recommended Signature** — the resulting artifact. The Validation Layer's own recommendation (Section 7) is a narrower, criteria-scoped judgment about Validated Candidates produced within this layer; it is an input to the eventual Framework-Wide Recommendation, but it is not itself the Framework-Wide Recommendation, and RDR-005 does not produce a Recommended Signature.

---

## 11. Validation Methodology Boundaries

This document does not decide, and explicitly defers to a future, separately governed methodology proposal evaluated through the Methodology Decision Layer:

- Which specific statistical procedures instantiate Internal Evidence Assembly or External Evidence Assembly.
- Which specific quantitative definitions are used for discrimination, calibration, robustness, external robustness, clinical utility, or reproducibility within Multi-Criteria Evidence Integration.
- The specific procedure by which the transparent recommendation (Section 7) is generated from integrated evidence.
- Any hyperparameter, software package, or implementation detail associated with any stage.
- Interpretability and Clinical Translation methodology (nomogram, calibration, DCA, bootstrap, or any modernized alternative) — explicitly reserved for RDR-006.
- Framework-Wide Recommendation, integration, and end-to-end benchmarking — explicitly reserved for the final Framework Integration stage.

These remain open decisions, to be raised individually, evaluated through Evidence Review → Feasibility Assessment → Decision (RDR-002), and locked only with explicit Project Coordinator approval — consistent with the Decision Escalation Policy (PROJECT_GOVERNANCE_PROMPT_v4.5.1.md).

---

## 12. Governance Status

**Status:** LOCKED (APPROVED — Project Coordinator confirmed)

**Implementation:** NOT PERMITTED

**Next Step:**
1. Generate RDR-005_CLOSURE.md
2. Proceed to RDR-006 Phase A (Interpretability & Clinical Translation Philosophy Discussion)
