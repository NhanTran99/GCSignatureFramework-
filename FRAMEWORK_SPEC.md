# FRAMEWORK_SPEC.md

**Modernized Biomarker Discovery Framework — Canonical Technical Specification**

**Project:** 12-Gene Gastric Cancer Signature — Part 2
**Document Type:** Consolidated Technical Specification (per PROJECT_GOVERNANCE_PROMPT_v4.5.1.md, FRAMEWORK_SPEC.md document type)
**Synthesizes:** RDR-000 through RDR-006 (all LOCKED), Discovery/Modeling/Validation/Interpretability & Clinical Translation Philosophies (all LOCKED), Framework Integration Philosophy (LOCKED), FRAMEWORK_INTEGRATION.md Architecture and Methodology (LOCKED)
**Status:** TECHNICAL SPECIFICATION — SYNTHESIS ONLY, NO NEW DECISIONS
**Implementation:** NOT PERMITTED (this document is a reference specification, not an IDS)

---

## How to Read This Document

This is not a governance document, and it is not an implementation guide. It introduces no methodological, architectural, or governance decision beyond what RDR-000 through RDR-006 and the Framework Integration architecture have already locked. Its purpose is to consolidate that already-locked decision record into a single, stable, technical reference — the kind of document a future implementer, reviewer, or collaborator could read on its own to understand what the framework *is*, without needing to read all seven prior governance documents in sequence.

Where this specification states something, the authoritative source remains the locked RDR or philosophy document cited alongside it. If any apparent discrepancy exists between this specification and a locked document, the locked document governs; this specification should be corrected to match it, never the reverse.

No algorithm, statistical procedure, hyperparameter, or software package is named anywhere in this document, consistent with the algorithm-agnostic, methodology-deferred posture maintained throughout RDR-000 through RDR-006.

---

## 1. Framework Architecture

### 1.1 Vertical Architecture

The framework is organized into four conceptual layers through which scientific intent becomes computation, and computation becomes reviewable evidence *(RDR-001, Section 4)*:

```
Scientific Layer
        ↓
Framework Philosophy
        ↓
Computational Layer
        ↓
Evidence Layer
```

- **Scientific Layer** — carries the biological question, scientific question, benchmark philosophy, and design principles into the architecture; the constraint surface against which every downstream methodology choice is justified *(RDR-001, Section 5)*.
- **Framework Philosophy** — the standing evaluation criteria (robustness, reproducibility, stability, transparency, interpretability, generalizability) against which every layer's design and methodology is judged; the framework is designed to maximize these, not predictive accuracy alone *(RDR-000, "Framework Philosophy"; RDR-001, Section 3)*.
- **Computational Layer** — where the discovery problem is actually executed, organized into five artifact-transforming modules (Section 3 below).
- **Evidence Layer** — captures what each computational module produces as reviewable evidence rather than a self-certifying conclusion *(RDR-001, Section 7)*.

### 1.2 Horizontal Architecture

Orthogonal to the vertical architecture, a fixed set of principles applies simultaneously across all four layers *(RDR-001, "Vertical vs. Horizontal Architecture")*: Reproducibility, Transparency, Leakage Prevention, Benchmarkability, Auditability, Documentation, Version Control, Governance Compliance *(RDR-001, Section 8)*.

### 1.3 Architecture Invariants vs. Replaceable Components

*(RDR-001, "Architecture Invariants")*

**Invariant** (never change regardless of methodology): Scientific Question, Benchmark Philosophy, Cross-cutting Principles, Governance Workflow, Evidence Generation, Reproducibility Requirements.

**Replaceable** (specified and potentially revised in later RDR/IDS documents): Algorithms, Statistical models, Validation procedures, Hyperparameters, Software packages.

### 1.4 Framework Lifecycle

*(RDR-001, "Framework Lifecycle")*

```
Scientific Question → Architecture → Methodology → Implementation → Evidence → Review → Benchmark → Publication → Reusable Framework
```

### 1.5 Stage vs. Layer Distinction

Discovery, Modeling, Validation, and Interpretability & Clinical Translation are **artifact-transforming Layers** — each receives one candidate type and produces the next. **Framework Integration is a Stage, not a Layer** — it does not transform or introduce candidate classes; it synthesizes, organizes, benchmarks, recommends, and presents outputs already produced by the four layers *(Framework Integration Philosophy, Locked Statement 2)*.

---

## 2. Candidate Evolution

The framework's central artifact lineage, fully specified across RDR-003 through RDR-006:

```
Discovery Candidate
        ↓
Model Candidate
        ↓
Validated Candidate (together with Enrichment Evidence)
        ↓
Framework-Wide Recommendation  ──→  Recommended Signature
```

- **Discovery Candidate** *(RDR-003, Section 3, item 8; Section 7)* — gene set, evidence, stability profile, discovery pathway, quality metrics.
- **Model Candidate** *(RDR-004, Section 3, item 3; Section 7)* — predictive model, risk score definition, model evidence, performance profile, interpretability profile, clinical evaluation profile. Traceable to exactly one originating Discovery Candidate *(RDR-004, Section 6, "Modeling Provenance")*.
- **Validated Candidate** *(RDR-005, Section 3, item 3; Section 7)* — the originating Model Candidate carried forward in full, complete Validation Evidence, and a transparent recommendation. Traceable to exactly one originating Model Candidate *(RDR-005, Section 6)*.
- **Validated Candidate, together with Enrichment Evidence** *(RDR-006, Sections 6–7)* — the same Validated Candidate, identity unchanged, now accompanied by biological interpretation, model explanation, and clinical translation evidence. **No new candidate type is created at this stage** — this is the framework's only non-transforming step in an otherwise transforming chain.
- **Framework-Wide Recommendation → Recommended Signature** *(RDR-005, Section 10; FRAMEWORK_INTEGRATION.md, Section 7)* — reserved for Framework Integration execution, explicitly deferred under the project's current Option A (Framework-first) phase. The Framework-Wide Recommendation is the *process* (context-dependent, not ranking-based); the Recommended Signature is the resulting artifact.

**Multiplicity is the expected default at every stage**, not an exception: more than one Discovery Candidate, Model Candidate, or Validated Candidate may legitimately coexist, and no candidate is silently discarded — selection occurs only through the Methodology Decision Layer (Section 6 below) or, at the framework level, through the eventual Framework-Wide Recommendation *(RDR-002, "Candidate Governance Principle"; RDR-003/004/005, candidate governance sections)*.

---

## 3. Evidence Evolution

Each layer produces a standardized, named evidence package, occupying the same architectural role at its layer — each successive package builds on, rather than overwrites, the one before it:

| Layer | Evidence Package | Components |
|---|---|---|
| Discovery | **Discovery Evidence** *(RDR-003, Section 7)* | Gene set composition, stability profile, discovery pathway, quality metrics |
| Modeling | **Model Evidence** *(RDR-004, Section 7)* | Predictive model, risk score definition, model evidence (provenance), performance profile, interpretability profile, clinical evaluation profile |
| Validation | **Validation Evidence** *(RDR-005, Section 7)* | Originating Model Candidate, complete validation evidence across six domains (Section 4 below), transparent recommendation |
| Interpretability & Clinical Translation | **Enrichment Evidence** *(RDR-006, Section 7)* | Biological interpretation evidence, model explanation evidence, clinical translation evidence — extends, does not replace, Validation Evidence |

All evidence passes through the Evidence Flow before being treated as final *(RDR-001, "Evidence Flow")*:

```
Evidence → Strategist Review → FACT / INFERENCE / UNKNOWN → Project Coordinator Decision → Governance Lock → Next Module
```

---

## 4. Layer Responsibilities

### 4.1 Discovery Layer *(RDR-003)*

**Objective:** identify robust and reproducible candidate biomarkers, not merely statistically significant genes.

**Internal architecture:**
```
QC / Preprocessing → Statistical Discovery → Multiple Testing / Filtering → Cross-Cohort Integration → Candidate Gene Set
```

**Success criteria** (jointly evaluated, none dominant): predictive capability, robustness, reproducibility.

**Biological knowledge strategy:** data-first; biology is supporting evidence, not the primary driver.

**Interface to Modeling:** Candidate Gene Set + Discovery Evidence crosses the boundary; no predictive index, classifier, or risk group originates in Discovery.

### 4.2 Modeling Layer *(RDR-004)*

**Objective:** robust predictive models jointly optimizing predictive performance, robustness, reproducibility, clinical translatability (a design objective, not clinical deployment).

**Internal architecture:**
```
Discovery Candidate → Representation → Prediction → Risk Estimation → Model Candidate
```

**Success criteria** (jointly evaluated, none dominant): predictive capability, robustness, reproducibility, interpretability, parsimony, support for downstream clinical evaluation.

**Model complexity philosophy:** when two candidates are comparable, prefer the simpler model.

**Candidate philosophy:** Model Candidates represent competing scientific hypotheses, not competing implementations. Selection is NOT performed in Modeling — it belongs to Validation.

**Interface to Validation:** Model Candidate(s) + full evidence crosses the boundary; no selection among candidates occurs here.

### 4.3 Validation Layer *(RDR-005)*

**Objective:** determine which Model Candidates have accumulated sufficient evidence to become Validated Candidates — an evidence-integration process, not a single performance assessment.

**Internal architecture:**
```
Model Candidate → Internal Evidence Assembly → External Evidence Assembly → Multi-Criteria Evidence Integration → Validated Candidate + Recommendation
```

**Success criteria / evidence domains** (no single metric sufficient alone): discrimination, calibration, robustness, external robustness, clinical utility, reproducibility.

**Output:** Validated Candidate(s) + a transparent, criteria-scoped recommendation (why preferred, under which criteria, for which context, under which performance profile) — distinct from, and an input to, the later Framework-Wide Recommendation.

**Layer boundary:** Validation Layer → RDR-006 (Interpretability & Clinical Translation) → Framework Integration. Framework-wide recommendation and end-to-end benchmarking are explicitly out of scope here.

### 4.4 Interpretability & Clinical Translation Layer *(RDR-006)*

**Objective:** enrich Validated Candidates with biological interpretation, model explanation, and clinical translation, enabling transparent understanding and appropriate downstream use. Does NOT create a new candidate type; does NOT perform framework-wide reporting, recommendation, or integration.

**Internal architecture:**
```
Validated Candidate → Biological Interpretation → Model Explanation → Clinical Translation → Validated Candidate (together with Enrichment Evidence)
```

**Scope:** three domains — biological interpretation, model explanation, clinical translation. Interpretability is inherently multi-dimensional; no single dimension dominates.

**Clinical Translation definition:** any methodology that translates framework outputs into meaningful clinical context — a general architectural concept, not a specific methodology.

**Governance note:** no layer-specific candidate governance section exists here, by deliberate design — because no new candidate type is created, RDR-005's Validated Candidate Governance already applies in full.

### 4.5 Framework Integration Stage *(Framework Integration Philosophy; FRAMEWORK_INTEGRATION.md)*

**Objective:** synthesize complete framework outputs into a coherent, transparent, end-to-end representation. A synthesis stage, not a methodology-development stage.

**Inputs:** Validated Candidate(s), Validation Evidence, Validation Recommendation(s), Enrichment Evidence, framework metadata. Does not directly consume Discovery Evidence or Model Evidence independently of validated outputs already assembled upstream.

**Outputs (three categories):**
1. Governance Artifacts — the Framework-Wide Recommendation.
2. Framework / Repository Artifacts — Framework Integration synthesis, Final Framework Benchmark, framework/repository documentation assets.
3. Publication Support Artifacts — figures, tables, supplementary materials.

**Framework-Wide Recommendation:** context-dependent, not ranking-based; identifies the most appropriate candidate(s) per context/objective/application, not one universally superior candidate.

**End-to-End Benchmark:** synthesizes historical-vs-modern comparison, Discovery/Modeling/Validation benchmark summaries, framework-objective assessment, scientific contribution synthesis — complements, does not replace, component-level benchmarks.

**Scientific Narrative:** a reusable source for downstream documentation (repository docs, future manuscripts) — not itself a manuscript.

**Status at time of writing:** architecture locked; execution explicitly deferred under Option A (Framework-first) — see Section 9.

---

## 5. Framework Principles

### 5.1 Design Principles *(RDR-000, "Design Principles"; PROJECT_GOVERNANCE_PROMPT_v4.5.1, "Framework Design Principles")*

Scientific rigor before complexity · Reproducibility by design · Evidence before methodology · Stability before performance · Interpretability whenever possible · Clinical translatability · Generalizable architecture · Transparent governance.

### 5.2 Framework Philosophy *(RDR-000)*

The framework maximizes robustness, reproducibility, stability, and transparency — not predictive accuracy alone. Methodology choices in every RDR are evaluated against this philosophy, not the reverse.

### 5.3 Framework > Signature *(RDR-000, "Central Scientific Message")*

The reusable framework — not any resulting gastric cancer signature — is the project's primary contribution. The demonstration signature is a secondary, illustrative output.

### 5.4 Disease-Agnostic / Generalizable Design *(RDR-000, "Framework Generalizability")*

The framework's architecture is intentionally independent of the specific disease, dataset, or demonstration case used to develop it, so it may later be adapted (e.g., other cancers, other omics modalities) without redesign — an architectural expectation, not a demonstrated application.

### 5.5 Negative Results Are Scientifically Valid *(RDR-002, "Negative Results"; PROJECT_GOVERNANCE_PROMPT_v4.5.1)*

Equivalence, partial improvement, or justified retention of historical methodology are acceptable scientific conclusions on equal footing with clear improvement. The objective is rigorous benchmarking, not forced superiority.

---

## 6. Methodology Governance Philosophy

### 6.1 Component-Wise, Evidence-Constrained Modernization *(RDR-002, Sections 4–5)*

Each historical component is evaluated independently (component-wise); modernization is never assumed and must pass:

```
Evidence Review → Feasibility Assessment → Decision
```

Retaining historical methodology with documented justification is an equally valid outcome.

### 6.2 Methodology Decision Layer *(RDR-002, "Methodology Decision Layer")*

```
Computational Outputs → Evidence → Methodology Decision Layer → Locked Methodology
```

Resolves to one of four outcomes, all equally valid when evidence-supported: **Adopt Modernization · Retain Historical Methodology · Defer Decision · Reject Modernization.** Modernization is never the preferred or default outcome.

### 6.3 Candidate Signature Governance *(RDR-002, Section 9)*

No candidate may be silently discarded; every candidate is evaluated against performance, robustness, stability, interpretability, clinical utility, reproducibility, and tracked (optionally) via the Candidate Register.

### 6.4 Framework Objective: Multi-Objective Optimization *(RDR-002, Section 8)*

The framework simultaneously evaluates: predictive performance, robustness, stability, interpretability, clinical utility, reproducibility. No single objective dominates.

---

## 7. Benchmarking Philosophy

### 7.1 Project-Level Benchmark Philosophy *(RDR-000, Section 10)*

Held constant across the entire project: biological question, datasets, endpoint, validation cohorts. Only methodology may vary — this is what allows any observed difference to be attributed to methodology rather than a shifted problem.

### 7.2 Component-Level Benchmarking *(RDR-002, Section 7)*

Each historical component (Section 4 above) must remain directly executable *within* the framework's own internal architecture for its layer — never as an external comparison computed outside the framework. This is what makes benchmarking genuinely component-level: any modernized stage instantiation is benchmarked against the historical instantiation of that same stage, holding others fixed.

| Layer | Historical Pathway (one governed instantiation) |
|---|---|
| Discovery | Random-variance t-test discovery statistics, fixed-threshold filtering, hard cross-cohort intersection |
| Modeling | PCA-based predictive index, SVM classification, median-split risk grouping |
| Validation | Training-cohort KM/log-rank/ROC-AUC; external-cohort KM/log-rank/Cox analysis |
| Interpretability & Clinical Translation | Nomogram, calibration, Decision Curve Analysis, bootstrap |

In every case, historical methodology remains one governed pathway among others — never a baseline that must be replaced *(RDR-002 through RDR-006, Motivation for Modernization sections)*.

### 7.3 End-to-End Benchmarking *(Framework Integration Philosophy, Locked Statement 6)*

Reserved for Framework Integration execution; synthesizes, but does not replace, the component-level benchmarks above. Explicitly deferred under the project's current Option A phase.

---

## 8. Interfaces

The fixed contract crossing each layer boundary — what crosses, what does not, and the consumer of each artifact:

| Boundary | Crosses | Does Not Cross |
|---|---|---|
| Discovery → Modeling | Candidate Gene Set + Discovery Evidence | Predictive index, classifier, risk group (Modeling-only outputs) |
| Modeling → Validation | Model Candidate(s) + full Model Evidence | Selection among Model Candidates (Validation-only function) |
| Validation → Interpretability & Clinical Translation | Validated Candidate(s) + Validation Evidence + Validation Recommendation(s) | Framework-wide recommendation, end-to-end benchmarking |
| Interpretability & Clinical Translation → Framework Integration | Validated Candidate(s), together with Enrichment Evidence | Framework-Wide Recommendation, framework-wide reporting, end-to-end presentation |

Source: RDR-001 Section 6 (Framework Interfaces), RDR-003 Section 9, RDR-004 Section 9, RDR-005 Section 9, RDR-006 Section 9.

---

## 9. Document Relationships and Current Governance State

### 9.1 Document Map

```
PROJECT_GOVERNANCE_PROMPT_v4.5.1.md  (canonical governance rules)
        │
        ├─ RDR-000_Project_Foundation.md                              [LOCKED]
        ├─ RDR-001_Modern_Framework_Architecture.md                   [LOCKED]
        ├─ RDR-002_Modern_Methodology_Architecture.md (+ CLOSURE)     [LOCKED]
        ├─ RDR-003_Discovery_Methodology.md (+ CLOSURE)               [LOCKED]
        ├─ RDR-004_Modeling_Methodology.md (+ CLOSURE)                [LOCKED]
        ├─ RDR-005_Validation_and_Benchmark_Methodology.md (+ CLOSURE)[LOCKED]
        ├─ RDR-006_Interpretability_and_Clinical_Translation_Methodology.md (+ CLOSURE) [LOCKED]
        ├─ FRAMEWORK_INTEGRATION.md (+ CLOSURE)                       [LOCKED — architecture only]
        └─ FRAMEWORK_SPEC.md (this document)                          [SYNTHESIS — no new decisions]
```

### 9.2 Authority Rule

The RDR series (RDR-000–RDR-006) remains the authoritative historical decision record *(Framework Integration Philosophy, Locked Statement 9)*. This specification synthesizes those decisions; it does not replace, modify, or supersede them. Any conflict is resolved in favor of the locked RDR or philosophy document.

### 9.3 Current Project Phase

The project has adopted **Option A (Framework-first)**: the framework's architecture and this consolidated specification are completed before any Framework Integration execution (Framework-Wide Recommendation, Final Framework Benchmark, Scientific Narrative) or instantiation on the historical Part 1 dataset. The current and next active phase is **Framework Packaging and Documentation** (this document, followed by Repository Packaging), not Framework Execution. See PROJECT_STATUS.md for the live tracking dashboard.

### 9.4 What Remains Open (By Design)

Consistent with every Methodology Boundaries section across RDR-003 through RDR-006, this specification does not resolve, and defers to future, separately governed Methodology Decision Layer proposals:

- Which specific method instantiates any internal stage in any layer.
- Any hyperparameter, software package, or implementation detail.
- The content of the eventual Framework-Wide Recommendation, Final Framework Benchmark, or Scientific Narrative.
- Repository-facing assets (README, figures, examples) — reserved for the Repository Packaging phase.

---

## 10. Governance Status

**Status:** TECHNICAL SPECIFICATION — synthesis of already-locked decisions only; introduces no new architectural, methodological, or governance decision.

**Implementation:** NOT PERMITTED.

**Next Step:**
With FRAMEWORK_SPEC.md complete, the project reaches the **Framework v1.0 — Design Complete** milestone: the framework's architecture, methodology, and consolidated technical specification are finished. Both of the following remain reserved for future, separately authorized phases:

1. **Repository Packaging** (README, figures, examples, repository assets) — deferred until repository publication is authorized and/or until after future framework instantiation.
2. **Framework Integration execution** (Framework-Wide Recommendation, Final Framework Benchmark, Scientific Narrative) and any historical Part 1 instantiation — deferred under Option A (Framework-first) until separately authorized.

No further action proceeds automatically from this document; either deferred phase requires explicit authorization before work begins.
