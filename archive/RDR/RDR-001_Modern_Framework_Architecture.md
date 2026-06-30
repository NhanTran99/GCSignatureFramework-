# RDR-001 — Modern Framework Architecture

**Status:** ARCHITECTURE LOCK CANDIDATE
**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework
**Document Type:** Reconstruction/Research Design Record (Architectural)
**Builds on:** RDR-000_Project_Foundation.md (LOCKED)
**Next Document:** RDR-002_Validation_Architecture.md

---

## 1. Executive Summary

RDR-000 established why this project exists: to develop a reusable, disease-agnostic computational biomarker discovery framework, demonstrated on the gastric cancer recurrence problem already characterized in Part 1, and benchmarked directly against it. This document, RDR-001, answers the next question — what is the framework, structurally, that will carry out that demonstration?

RDR-001 is an architectural specification, not an implementation plan. It defines the layers, modules, responsibilities, inputs, outputs, and evidence the framework must produce, without committing to any algorithm, hyperparameter, or validation protocol detail. Those decisions are explicitly deferred to later RDR documents, consistent with the Decision Escalation Policy and Mandatory Review Cycle of the Project Governance Prompt. The architecture itself, once locked, becomes the structural contract that every subsequent RDR, IDS, and implementation module must conform to.

---

## 2. Relationship to Part 1

The framework defined here extends Part 1 rather than replacing it. Consistent with the Benchmark Philosophy locked in RDR-000, the following remain unchanged from Part 1:

- the biological question (whether transcriptomic biomarkers predict recurrence following fluoropyrimidine-based chemotherapy in gastric cancer)
- the datasets (discovery, training, and external validation cohorts)
- the endpoint (recurrence / disease-free survival)

What changes is the computational methodology by which a candidate signature is discovered, modeled, validated, interpreted, and translated. Where Part 1's pipeline was a fixed, linear sequence of classical statistical steps (random-variance t-test → Cox screening → intersection → PCA predictive index → SVM), the framework defined in this document is organized into explicit, layered responsibilities so that the specific methodology within each layer can be selected, evaluated, and benchmarked independently in later RDRs — without requiring the overall architecture to be redesigned.

---

## 3. Framework Philosophy

The framework inherits and operationalizes the philosophy locked in RDR-000 (Design Principles, Framework Philosophy, Cross-cutting Principles). At the architectural level, this means the framework exists to maximize:

- **Robustness** — conclusions should hold under reasonable perturbation of data and resampling.
- **Reproducibility** — every layer's outputs must be regenerable from documented inputs and locked decisions.
- **Stability** — feature and model selection stability is an architectural concern addressed by a dedicated evidence stream, not an afterthought.
- **Transparency** — every layer must produce evidence that can be independently reviewed, including evidence that is unfavorable to the framework's own outputs.
- **Interpretability** — the architecture reserves an explicit layer for interpretability rather than treating it as optional.
- **Generalizability** — no layer's architecture may assume gastric-cancer-specific or transcriptomics-specific structure that would prevent future adaptation to other diseases or data modalities.

These principles govern how every architectural choice in this document was made, and they will continue to govern which specific methodologies are judged acceptable in later RDRs. Predictive accuracy remains an evaluation criterion produced by the architecture, but it is never the principle the architecture is optimized around.

---

## 4. Overall Framework Architecture

The framework is organized into four conceptual layers, arranged so that scientific intent flows downward into computation, and computational results flow back upward as evidence:

```
Scientific Layer
        ↓
Framework Philosophy
        ↓
Computational Layer
        ↓
Evidence Layer
```

- The **Scientific Layer** carries the biological and scientific questions, the benchmark philosophy, and the design principles into the architecture — it is the layer that gives every downstream computational choice its justification.
- **Framework Philosophy** sits between the scientific intent and the computation itself, acting as the standing evaluation criteria (robustness, reproducibility, stability, transparency, interpretability, generalizability) against which every computational layer's design and eventual methodology choices are judged.
- The **Computational Layer** is where the discovery problem is actually executed, organized into five modules (Section 6).
- The **Evidence Layer** captures what each computational module produces as reviewable scientific evidence, rather than as a final, self-certifying answer (Section 7).

This arrangement ensures that no computational module operates without a traceable line back to the scientific question it serves, and that no computational output is treated as a conclusion until it has passed through the Evidence Layer and the governance review cycle.

### Vertical vs. Horizontal Architecture

The architecture described above — Scientific Layer, Framework Philosophy, Computational Layer, Evidence Layer — is the framework's **vertical architecture**: it describes the sequence through which scientific intent becomes computation, and computation becomes reviewable evidence. Progressing through the vertical architecture is what each module of work does.

Orthogonal to this is the framework's **horizontal architecture** — a set of principles that apply simultaneously, at every point, across all four vertical layers rather than at any single point within them:

```
        Scientific Layer
              ↕
      Framework Philosophy        ←──┐
              ↕                       │  Reproducibility
      Computational Layer            │  Transparency
              ↕                       │  Auditability
        Evidence Layer            ←──┘  Governance
                                        Benchmarkability
                                        Documentation
```

Where the vertical architecture answers "what does the framework do, in what order," the horizontal architecture answers "what must always be true, no matter which layer is currently active." A given module's discovery work, for example, is governed both by its position in the vertical sequence (it follows the Scientific Layer, precedes the Modeling Layer) and by the horizontal requirement that it be reproducible, transparent, auditable, governed, benchmarkable, and documented — independent of which specific discovery methodology is eventually chosen for it. This separation is what allows the framework's vertical structure to remain stable even as the methodology within any given layer changes.

---

## 5. Scientific Layer

The Scientific Layer's architectural role is to anchor every downstream computational decision to a fixed, already-locked scientific basis. It does not redefine any of the following — all are inherited unchanged from RDR-000 — but it is the layer through which they are carried into the framework's computation:

- **Biological question** — whether transcriptomic biomarkers predict recurrence following fluoropyrimidine-based chemotherapy in gastric cancer.
- **Scientific question** — whether contemporary methodology improves robustness, stability, and predictive performance relative to Part 1's classical pipeline, on the identical problem.
- **Benchmark philosophy** — biological question, datasets, endpoint, and validation cohorts held constant; only methodology is permitted to vary.
- **Design principles** — the permanent project-level principles locked in RDR-000 (Section "Design Principles").

Architecturally, the Scientific Layer functions as a constraint surface: any computational or methodological choice proposed in a later RDR must be traceable to, and consistent with, what this layer carries forward. A proposed methodology that would require altering the biological question, datasets, endpoint, or benchmark philosophy is, by construction, out of scope for Part 2 and would require a separate, explicitly governed decision.

---

## 6. Computational Layer

The Computational Layer consists of five modules. Each module is defined here purely in terms of purpose, inputs, outputs, dependencies, and downstream impact. No algorithm, statistical test, or modeling technique is named or implied as a commitment; all such choices are reserved for later RDR documents under the Decision Escalation Policy.

### 6.1 Discovery Layer

**Purpose:** Identify candidate features (genes) from high-dimensional transcriptomic data that are statistically and biologically plausible contributors to the endpoint, using a methodology explicitly evaluated for feature-selection stability under resampling.

**Inputs:** Curated discovery/training cohort expression data and associated endpoint labels (as established in Part 1, subject to re-curation per RDR-000 Section 11).

**Outputs:** A candidate feature set (or a distribution of candidate feature sets across resampling iterations), together with stability evidence describing how consistently each feature is selected.

**Dependencies:** Requires the Scientific Layer's locked endpoint and dataset definitions; requires no prior output from other Computational Layer modules.

**Downstream impact:** Directly determines the feature space available to the Modeling Layer; stability evidence produced here is the architectural counterpart to the Path A / Path B divergence documented in Part 1, and is the primary evidence used to address the Scientific Question.

### 6.2 Modeling Layer

**Purpose:** Fit a predictive model relating the discovered feature set to the endpoint.

**Inputs:** The candidate feature set(s) from the Discovery Layer; training cohort data.

**Outputs:** A fitted model specification (structure and parameters), together with model specification evidence describing how the model relates to the discovered features.

**Dependencies:** Requires Discovery Layer outputs; must respect the same training/validation separation established at the Scientific Layer.

**Downstream impact:** Determines what is passed to the Validation Layer for internal and external evaluation; determines what is available to the Interpretability and Clinical Translation Layers.

### 6.3 Validation Layer

**Purpose:** Evaluate the fitted model's performance and stability under both internal resampling and external validation, in a manner structurally comparable to Part 1's validation stages so that benchmarking remains valid.

**Inputs:** Fitted model specification from the Modeling Layer; internal training-cohort data for internal validation; the same external cohort used in Part 1 for external validation.

**Outputs:** Internal validation performance evidence; external validation performance evidence; benchmark-ready performance metrics comparable to those reported for Path A / Path B in Part 1.

**Dependencies:** Requires Modeling Layer outputs; requires the external validation dataset to remain held out and frozen, consistent with the no-re-fitting-on-validation-data principle established in Part 1.

**Downstream impact:** Produces the principal quantitative basis for the Part 1 vs. Part 2 benchmark; feeds the Clinical Translation Layer.

### 6.4 Interpretability Layer

**Purpose:** Explain the fitted model's behavior — which features drive predictions and how — in a manner appropriate to the model produced by the Modeling Layer, consistent with the "interpretability whenever appropriate" design principle.

**Inputs:** Fitted model specification from the Modeling Layer; validation evidence from the Validation Layer, where relevant to contextualize explanations.

**Outputs:** Explanation evidence describing feature contributions and model behavior, at a level of rigor appropriate to the model type ultimately selected.

**Dependencies:** Requires Modeling Layer outputs; does not require Clinical Translation Layer outputs.

**Downstream impact:** Supports scientific interpretation of the benchmark result and supports the Clinical Translation Layer's framing of the model for clinical audiences.

### 6.5 Clinical Translation Layer

**Purpose:** Assess the practical, clinical-decision relevance of the validated model, structurally comparable to Part 1's Module 10 (nomogram, calibration, Decision Curve Analysis), to support a like-for-like translational benchmark.

**Inputs:** Validated model and performance evidence from the Validation Layer; relevant clinical covariates from the external validation cohort.

**Outputs:** Clinical utility evidence (e.g., calibration behavior, decision-curve behavior, integration with clinical covariates), framed consistently with Part 1's internal, optimism-corrected framing unless a future RDR explicitly revises that framing.

**Dependencies:** Requires Validation Layer outputs; may draw on Interpretability Layer outputs for framing but does not require them structurally.

**Downstream impact:** Produces the translational half of the final Part 1 vs. Part 2 benchmark and informs the project's translational contribution as described in RDR-000.

---

## Framework Interfaces

The following defines the interface between consecutive Computational Layer modules — what crosses the boundary from one module to the next — without specifying how either module produces or consumes it.

| Module | Input | Output | Consumer Module |
|---|---|---|---|
| Discovery | Curated discovery/training cohort data and endpoint labels | Candidate feature set(s) and stability evidence | Modeling |
| Modeling | Candidate feature set(s) from Discovery; training cohort data | Fitted model specification and model specification evidence | Validation |
| Validation | Fitted model specification from Modeling; internal and external cohort data | Internal and external performance evidence | Interpretability; Clinical Translation |
| Interpretability | Fitted model specification from Modeling; performance evidence from Validation | Explanation evidence | Clinical Translation (framing only); Benchmark |
| Clinical Translation | Performance evidence from Validation; clinical covariates from the external cohort | Clinical utility evidence | Benchmark |

Each row describes a contract, not an implementation: any methodology satisfying a module's stated Input and Output types may be substituted for another in a later RDR without altering the interface itself or requiring downstream modules to be redesigned. This is the architectural property that allows the Discovery Layer's methodology, for example, to be selected, evaluated, and even later revised, without requiring the Modeling, Validation, Interpretability, or Clinical Translation layers to change their own interfaces. These contracts are intended to directly inform the Input/Output specifications of future IDS documents.

---

## 7. Evidence Layer

Every Computational Layer module produces evidence, not a self-certifying conclusion. The Evidence Layer is the architectural mechanism by which that evidence is captured, reviewed, and made benchmarkable, consistent with the governance principle that "Coding Agent outputs are evidence... not decisions."

```
Discovery            → feature selection evidence (candidate features, stability under resampling)
        ↓
Modeling              → model specification evidence (structure, fitted parameters, rationale)
        ↓
Validation            → performance evidence (internal and external validation results)
        ↓
Interpretability       → explanation evidence (feature contribution, model behavior)
        ↓
Clinical Translation   → clinical utility evidence (calibration, decision-curve, integration with covariates)
```

The Evidence Layer's architectural role is to ensure that every output crossing from the Computational Layer back toward scientific conclusions passes through Strategist AI review and Project Coordinator approval (per the Mandatory Review Cycle) before it is treated as locked or final. Evidence from one module does not automatically authorize progression in the next; it is reviewed, classified as FACT / INFERENCE / UNKNOWN, and discussed before downstream work is commissioned.

---

## Framework Data Flow

The following describes, conceptually, how information moves through the framework from scientific intent to reusable artifact. This is a data flow, not an implementation sequence — it names what moves between stages, not how any stage computes its output.

```
Scientific Question
        ↓
Dataset
        ↓
Discovery
        ↓
Modeling
        ↓
Validation
        ↓
Interpretation
        ↓
Clinical Translation
        ↓
Benchmark
        ↓
Repository Documentation
        ↓
Reusable Framework
```

Each downward step consumes the output of the step above it: the Scientific Question constrains which Dataset is admissible; the Dataset is what Discovery operates on; Discovery's candidate features are what Modeling fits to; Modeling's fitted specification is what Validation evaluates; Validation's performance evidence is what Interpretation explains and what Clinical Translation builds on; the combined evidence from Validation and Clinical Translation is what the Benchmark compares against Part 1; the Benchmark result, together with every governance document along the way, becomes Repository Documentation; and Repository Documentation, once sufficiently abstracted from the gastric cancer demonstration, becomes the Reusable Framework described in RDR-000. No step in this flow implies a specific algorithm or technique — it describes what is handed forward, not how it is produced.

---

## Evidence Flow

Distinct from the data flow above, the Evidence Flow describes what happens to the output of each computational module before it is allowed to inform the next one. This is the architectural enforcement of the governance principle that computational outputs never directly become scientific conclusions.

```
Evidence
        ↓
Strategist Review
        ↓
FACT / INFERENCE / UNKNOWN
        ↓
Project Coordinator Decision
        ↓
Governance Lock
        ↓
Next Module
```

Every computational module in Section 6 produces evidence (Section 7), not a conclusion. That evidence is first subjected to Strategist Review, which classifies its contents as FACT, INFERENCE, or UNKNOWN rather than allowing inferences to be presented as facts. The Project Coordinator then makes an explicit decision on that classified evidence. Only once that decision is made and recorded does a Governance Lock occur — and only after the Governance Lock is the next module authorized to begin. This flow applies uniformly to every module in the Computational Layer; no module's evidence is exempt from passing through Strategist Review and Project Coordinator Decision before the next module proceeds.

---

## 8. Cross-cutting Principles

The following principles apply uniformly across every layer of the framework, independent of which specific methodology is eventually selected for any given module:

- **Reproducibility** — every layer must be re-runnable from documented inputs to documented outputs.
- **Transparency** — every layer reports its assumptions, limitations, and results — favorable or not — with equal rigor.
- **Leakage Prevention** — the boundary between discovery/training data and external validation data is architecturally enforced across all five Computational Layer modules, not just within any single one.
- **Benchmarkability** — every layer's outputs are structured so they can be directly compared against the corresponding Part 1 stage.
- **Auditability** — every layer's outputs are traceable to a specific, locked governance decision.
- **Documentation** — every layer's work is recorded in a canonical review document before the corresponding module may close.
- **Version Control** — all code, data references, and documentation produced by any layer are tracked under version control.
- **Governance Compliance** — no layer's methodology may be locked or implemented outside the Mandatory Review Cycle.

These principles are framework-wide rather than module-specific because the framework's core claim — that it improves robustness, reproducibility, stability, and transparency relative to Part 1 — would not be credible if any single layer were exempt from them. A framework that is rigorous in discovery but undocumented in validation, for example, would not satisfy the philosophy locked in RDR-000.

---

## Architecture Invariants

The framework distinguishes between components that are architecturally permanent and components that are expected to be replaced as methodology is selected and refined. This distinction is what allows methodology to change in later RDRs without requiring this architecture to be re-locked.

**Invariant components — these do not change regardless of which methodology is eventually selected:**

- Scientific Question
- Benchmark Philosophy
- Cross-cutting Principles
- Governance Workflow
- Evidence Generation (the requirement that every module produce reviewable evidence)
- Reproducibility Requirements

**Replaceable components — these are expected to be specified, and potentially revised, in later RDR and IDS documents:**

- Algorithms
- Statistical models
- Validation procedures
- Hyperparameters
- Software packages

A change to a replaceable component never requires revising this architecture. A proposed change to an invariant component is, by definition, outside the scope of methodology selection and would require a new, explicitly governed foundational decision — not a methodology RDR.

---

## 9. Framework Outputs

The architecture distinguishes between outputs that constitute the framework's principal contribution and outputs that are produced as a consequence of demonstrating it — reinforcing that the framework, not any resulting signature, is the project's primary deliverable.

**Primary Outputs** — the framework's principal contribution:

- The **reusable framework** itself: its architecture, layer interfaces, and governance record, captured in `docs/Framework/Biomarker_Discovery_Framework_v1.md` as a methodological reference independent of the gastric cancer demonstration.
- The full set of **governance documentation** (RDR/IDS series, module reviews, verification logs) recording how every layer's methodology was selected, implemented, and validated.
- The **benchmark** comparing Part 2's framework-derived results against Part 1 across stability, robustness, and predictive performance.
- An updated **GitHub repository**, integrating Part 2 as "Part 2 of 2" alongside Part 1.
- **Manuscript assets** suitable for the publication positioning described in RDR-000.

**Secondary Outputs** — produced by applying the framework to its gastric cancer demonstration case:

- The demonstration **biomarker signature**, an outcome of applying the framework, not its objective.
- **Figures** generated during discovery, validation, interpretability, and clinical translation.
- **Models** (fitted specifications) produced by the Modeling Layer.
- **Tables** of evidence produced across the Computational Layer modules.

This separation exists to keep Framework > Signature explicit at the architectural level: the secondary outputs validate that the framework functions end-to-end, but they are not, by themselves, what Part 2 is for.

---

## Repository Architecture Mapping

The following maps each framework layer to the kind of repository component it conceptually corresponds to. This is a conceptual mapping, not a file specification; exact paths and file names remain an implementation decision for later IDS documents.

```
Computational Layer
        ↓
scripts/, R/, results/

Evidence Layer
        ↓
MODULE_REVIEW documents, verification logs

Framework Documentation
        ↓
Framework/, README

Governance
        ↓
RDR, IDS
```

This mapping preserves the same separation of concerns already established in Part 1's repository structure: code and results live separately from the review/verification record, which in turn lives separately from the framework's own reusable documentation, which in turn lives separately from the governance trail that authorized all of it.

---

## Framework Generalizability

As established in RDR-000, the framework is intentionally designed so that its architecture — not necessarily every methodology choice within it — can be adapted to other diseases or data modalities. The table below describes the kind of adaptation each conceptual case would be expected to require, without claiming that any of these adaptations have been performed or validated:

| Disease / Application | Required Adaptation |
|---|---|
| Gastric cancer | None — this is the architecture's demonstration case |
| Colorectal cancer | Dataset only |
| Breast cancer | Dataset only |
| RNA-seq | Preprocessing adaptation |
| Proteomics | Feature preprocessing adaptation |

These entries describe expected adaptations consistent with the architecture's layered design — for example, a new disease with a comparable transcriptomic data structure would primarily require substituting the Dataset feeding the existing Discovery Layer, while a new data modality would additionally require adapting how that data is preprocessed before it enters the architecture. None of these adaptations are demonstrated applications; they are architectural expectations to be confirmed, if and when such an extension is separately proposed and governed.

---

## Framework Lifecycle

The complete lifecycle of the project, from initial scientific intent to reusable artifact, is described conceptually as follows:

```
Scientific Question
        ↓
Architecture
        ↓
Methodology
        ↓
Implementation
        ↓
Evidence
        ↓
Review
        ↓
Benchmark
        ↓
Publication
        ↓
Reusable Framework
```

This lifecycle situates the present document: RDR-000 established the Scientific Question; this document, RDR-001, establishes the Architecture; Methodology, Implementation, Evidence, and Review will recur iteratively across every Computational Layer module as later RDRs and IDS documents are produced; the Benchmark and Publication stages consolidate that iterative work into the comparison against Part 1 and its public presentation; and the Reusable Framework is the final abstraction of the entire lifecycle into a methodological reference usable beyond this project's specific demonstration case.

---

## 10. Framework Boundaries

This document does not decide, and explicitly defers to future RDR documents, the following:

- Which specific algorithms are used in the Discovery, Modeling, Interpretability, or Clinical Translation layers.
- Any hyperparameters or tuning strategy.
- Validation protocol details (e.g., resampling scheme, number of folds or repetitions, specific performance metrics).
- Feature selection method specifics.
- Model selection criteria or comparison procedure between candidate models.
- Any implementation detail, code structure, or software package choice.

These remain open decisions to be resolved through the standard Mandatory Review Cycle, each presented with alternatives (Option A / B / C, rationale, advantages, risks, expected impact) as required by the Decision Escalation Policy, and locked only with explicit Project Coordinator approval.

---

## 11. Planned Architecture Evolution

Later RDR documents will progressively specialize this architecture without altering its layered structure, following this governance progression:

```
RDR-001 (this document — architecture)
        ↓
RDR-002 (validation architecture)
        ↓
RDR-003 (and subsequent RDRs, as needed — methodology specialization per layer)
        ↓
IDS Documents (implementation specification)
        ↓
Implementation
        ↓
Verification
        ↓
Module Review
```

Each subsequent RDR will specialize one or more of the five Computational Layer modules defined in Section 6, or refine the Evidence Layer's expectations for a given module, without requiring revision of the four-layer architecture itself unless a future, explicitly governed decision determines otherwise. The contents of RDR-002 and beyond are intentionally not defined in this document.

---

## Architectural Vision

The purpose of this architecture is not simply to improve one gastric cancer recurrence signature. It is to establish a reusable computational architecture that separates scientific objectives, computational methodology, evidence generation, and governance into independent but interoperable layers — so that any one of these can be examined, evaluated, or eventually adapted without disturbing the others.

The gastric cancer demonstration exercises every layer of this architecture and produces the secondary outputs (Section 9) that prove it functions end-to-end. But the architecture's value, consistent with RDR-000, lies in this separation of concerns itself: a scientific question that can be stated independently of how it is computed; a computational methodology that can be selected, benchmarked, and revised independently of the scientific question it serves; evidence that is generated and reviewed independently of whether it ultimately favors the framework's own outputs; and a governance process that holds all of the above accountable to documented, locked decisions rather than to implicit assumptions.

This vision — Framework as the separation and interoperability of scientific objectives, methodology, evidence, and governance — is the architectural statement intended to carry forward into the README, the `Biomarker_Discovery_Framework_v1.md` reference document, project discussion, and the GitHub repository's positioning of Part 2.

---

## 12. Governance Status

**Status:** ARCHITECTURE LOCK CANDIDATE

**Implementation:** NOT PERMITTED

**Next Step:**
1. Strategist Review
2. Project Coordinator Discussion
3. Architecture Lock
4. Proceed to RDR-002_Validation_Architecture.md
