# RDR-002 — Modern Methodology Architecture

**Status:** METHODOLOGY ARCHITECTURE LOCK CANDIDATE
**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework
**Document Type:** Reconstruction/Research Design Record (Methodology Architecture)
**Builds on:** RDR-000_Project_Foundation.md (LOCKED), RDR-001_Modern_Framework_Architecture.md (LOCKED)
**Next Document:** RDR-003_Discovery_Methodology.md

---

## 1. Executive Summary

RDR-000 established why this project exists, and RDR-001 established the structural architecture — the layers, interfaces, and evidence flow — through which the framework will operate. This document, RDR-002, answers a narrower and more specific question than either: which components of the historical (Part 1) biomarker discovery pipeline should be modernized, and on what basis?

RDR-002 does not decide how modernization will be implemented. It does not name an algorithm, a statistical technique, or a software package. Its purpose is to establish the philosophy, governance mechanism, and conceptual mapping by which the decision to modernize — or to retain — each historical component will be made, once evidence is available to make that decision. This document introduces a new architectural concept, the Methodology Decision Layer, which formalizes the principle that methodology choices in this project are evidence-driven rather than algorithm-driven.

---

## 2. Historical Pipeline Review

Part 1 implemented a fixed, linear sequence of classical statistical components to discover, validate, and translate a transcriptomic recurrence signature. For the purpose of this document, these components are identified only by their conceptual role — not evaluated, criticized, or redesigned:

- **Gene filtering** — removal of probes/genes failing fold-change and missingness criteria prior to discovery analysis.
- **Discovery statistics** — univariate testing of gene expression against group membership (chemo-response) or survival outcome (disease-free survival) within each discovery cohort, independently.
- **Gene intersection** — combination of independently-derived discovery gene sets via a fixed set-intersection rule across cohorts.
- **Dimensionality reduction and predictive index construction** — projection of the selected gene set into a low-dimensional predictive score.
- **Classification** — assignment of patients to risk groups based on the predictive score, using a fitted classifier.
- **Median-split risk grouping** — dichotomization of the predictive score into risk groups using a fixed cutpoint rule.
- **External validation** — application of frozen, non-retrained parameters (standardization, classifier, predictive index weights) to an independent external cohort.
- **Survival analysis** — Kaplan-Meier and Cox proportional-hazards analysis of risk groups against disease-free survival, in both training and external cohorts.
- **Clinical translation extension** — integration of the signature with clinical covariates into a nomogram, assessed via bootstrap-internal calibration and Decision Curve Analysis.

This list is descriptive only. No component listed here is presumed, by virtue of appearing in this section, to require modernization.

---

## 3. Philosophy of Modernization

Modernization, within this project, is defined as improving robustness, reproducibility, stability, and transparency relative to the corresponding historical component — never as a change to the biological question, the datasets, or the endpoint, each of which remains locked per RDR-000's Benchmark Philosophy.

Modernization is therefore a property of *how* a component is evaluated, not an assumption that newer methodology is inherently superior. A component is only modernized if doing so demonstrably improves one or more of these four properties relative to its historical counterpart, on the same biological question, data, and endpoint. A component that already performs adequately along these dimensions may be retained unmodified, and retaining it is treated as a legitimate, evidence-based methodological decision rather than a missed opportunity.

---

## 4. Evidence-Constrained Modernization

Modernization is never assumed in this project. Every historical component identified in Section 2 must pass through the following sequence before any modernization is adopted:

```
Evidence Review
        ↓
Feasibility Assessment
        ↓
Decision
```

**Evidence Review** examines what is already known about the historical component's behavior — including, where applicable, findings already documented in Part 1 (such as the Discovery-stage instability between Path A and Path B). **Feasibility Assessment** examines whether a proposed modernization is practically applicable to the available data, computational resources, and project timeline. **Decision** is the explicit, governed determination — made by the Project Coordinator on Strategist AI recommendation — of whether the component will be modernized, and if so, under what evaluation criteria.

If evidence is insufficient to justify modernization, the historical methodology for that component may be retained, with that retention explicitly justified and documented rather than left as a silent default. This evidence-constrained principle is permanent and applies to every methodological decision made in Part 2 from this point forward, not only to the initial component-wise evaluation described in Section 5.

---

## 5. Component-wise Modernization Strategy

The project adopts a component-wise modernization strategy: each historical component identified in Section 2 is evaluated independently, rather than the entire pipeline being modernized indiscriminately as a single unit.

This strategy follows directly from the Evidence-Constrained Modernization principle (Section 4): if modernization decisions must be justified by evidence specific to each component, then the unit of decision-making must be the component, not the pipeline as a whole. Different components may therefore reach different modernization outcomes within the same project — one component may be modernized, another retained, and a third modernized only partially — and no uniform outcome is assumed in advance.

---

## 6. Historical Mapping Matrix

The following table maps each historical component to the conceptual basis on which its modernization will eventually be evaluated. Objectives and success criteria are stated conceptually; no implementation method is named.

| Historical Component | Observed Limitation | Modernization Objective | Success Criterion | Responsible Future RDR |
|---|---|---|---|---|
| Gene filtering | Fixed fold-change/missingness thresholds applied uniformly, without a formal stability assessment | Evaluate whether filtering criteria affect downstream feature-selection stability | Demonstrated relationship (or lack thereof) between filtering choice and selection stability | RDR-003 |
| Discovery statistics (univariate testing) | Each gene evaluated independently of others; no joint, correlation-aware selection | Improve selection stability and account for feature correlation structure | Reduced selection variability under resampling, evaluated against Part 1's Path A/B divergence | RDR-003 |
| Gene intersection | Hard, binary intersection rule across cohorts; demonstrated in Part 1 to be highly sensitive to a single cohort | Replace or supplement hard intersection with an evidence-based, joint selection approach | A documented improvement (or a documented justification for retention) in cross-cohort selection agreement | RDR-003 |
| Dimensionality reduction / predictive index | Fixed, unsupervised projection; relationship to outcome not directly optimized | Evaluate whether outcome-aware modeling improves predictive index construction | Demonstrated change (improvement, equivalence, or degradation) in internal/external validation performance | RDR-004 |
| Classification | Fixed classifier with frozen parameters; no formal stability assessment across resampling | Evaluate classifier stability and calibration under resampling | Quantified classification stability metric, benchmarked against Part 1 | RDR-004 |
| Median-split risk grouping | Fixed cutpoint rule; group sizes shown in Part 1 to be mechanically decoupled from log-rank significance | Evaluate whether an alternative risk-grouping approach better aligns group structure with prognostic information | Demonstrated relationship between risk-grouping approach and survival separation | RDR-004 / RDR-005 |
| External validation | Single frozen application to one external cohort; no resampling-based uncertainty quantification | Add a formal internal validation/resampling layer prior to external application | Documented internal validation performance distribution, in addition to the existing external point estimate | RDR-005 |
| Survival analysis | Standard Kaplan-Meier / Cox analysis; not yet assessed for joint multi-metric evaluation | Evaluate survival analysis outputs alongside other framework objectives (Section 8) rather than in isolation | Survival analysis evidence reported jointly with stability and robustness evidence | RDR-005 |
| Clinical translation extension | Internal, optimism-corrected assessment only (as already explicitly documented in Part 1) | Evaluate whether the translation extension's internal-validation framing can be strengthened without overstating clinical utility | Documented translation evidence consistent with TRIPOD-aligned reporting | RDR-006 |

This table is a planning artifact. It does not authorize modernization of any row; each row remains subject to the Evidence Review → Feasibility Assessment → Decision sequence in Section 4 before any change is adopted.

---

## 7. Benchmark Philosophy

Consistent with RDR-000's project-level Benchmark Philosophy, RDR-002 extends benchmarking to the component level: each historical component is benchmarked against its modernized counterpart (where modernization is adopted) individually, rather than relying solely on a single end-to-end comparison of final predictive performance between Part 1 and Part 2.

Module-level benchmarking provides stronger scientific evidence than a single final-performance comparison for three reasons. First, it localizes any observed improvement or degradation to a specific component, rather than leaving the source of an aggregate difference ambiguous. Second, it preserves the diagnostic value Part 1 already demonstrated — the Path A/B divergence was only visible because intermediate, component-level evidence was tracked rather than only the final classification accuracy. Third, it allows the project to report a mixed, transparent outcome (some components improved, others equivalent, others retained) rather than forcing the benchmark into a single binary verdict of "Part 2 is better" or "Part 1 is better," consistent with the Scientific Philosophy locked in RDR-000.

### Negative Results are Scientifically Valid

A failure of any modernized component to outperform its historical counterpart is a scientifically valid framework outcome, not a project failure. The purpose of this framework is rigorous, transparent benchmarking — not demonstrating the superiority of modern methodology at all costs. Equivalence between modernized and historical methodology, partial improvement along only some of the six framework objectives (Section 8), or a fully justified retention of the historical methodology for a given component, are all acceptable scientific conclusions, on equal footing with a clear improvement.

This philosophy is a direct extension of the Scientific Philosophy already locked in RDR-000: Part 2 does not attempt to prove Part 1 wrong, and by the same logic, Part 2 does not need to prove modern methodology categorically better in order to be considered complete and successful. A rigorous, well-evidenced negative or mixed result carries the same scientific and portfolio value as a positive one, because what is being evaluated is the quality of the benchmark itself, not a predetermined desired outcome.

---

## 8. Framework Objective

The framework is defined as a multi-objective optimization framework. It does not optimize for a single dominant metric. It simultaneously evaluates and seeks to improve:

- predictive performance
- robustness
- stability
- interpretability
- clinical utility
- reproducibility

No single one of these objectives is permitted to dominate framework-level decisions at the expense of the others. A methodology that improves predictive performance while degrading stability or reproducibility, for example, does not represent an unambiguous improvement under this framework and must be evaluated against all six objectives jointly before being adopted — consistent with the Framework Philosophy locked in RDR-000 and RDR-001.

---

## 9. Candidate Signature Governance

The framework is explicitly permitted to generate multiple candidate signatures over the course of Part 2 — for example, as a consequence of evaluating multiple discovery methodologies, or as a consequence of the component-wise modernization strategy (Section 5) producing different outcomes across resampling runs or modeling choices.

Every candidate signature must be treated as an independent scientific object, recorded and evaluated rather than informally discarded. Each candidate must eventually be evaluated according to:

- methodology pathway (which components were modernized, and how, to produce it)
- predictive performance
- robustness
- stability
- interpretability
- clinical utility
- reproducibility

The framework must never silently discard a candidate signature. Any decision to set aside a candidate in favor of another must be transparent, documented, and traceable to the evaluation criteria above. This requirement directly extends the Path A/B precedent established in Part 1, where two divergent candidates were carried forward and reported in parallel rather than one being quietly dropped.

### Candidate Signature Registry

To operationalize this requirement, every candidate signature that emerges over the course of Part 2 should eventually be registered with standardized governance metadata, conceptually comparable across candidates regardless of which methodology pathway produced them. A registry entry is expected to conceptually record, at minimum:

- **Candidate Identifier** — a stable reference distinguishing this candidate from all others.
- **Methodology Pathway** — which components were modernized, retained, or otherwise modified to produce this candidate.
- **Scientific Status** — whether the candidate remains under active evaluation, has been finalized, or has been set aside.
- **Evaluation Status** — which of the evaluation criteria in this section (performance, robustness, stability, interpretability, clinical utility, reproducibility) have been assessed for this candidate, and which remain outstanding.
- **Final Governance Decision** — the eventual, explicitly documented decision regarding the candidate's role in the project's conclusions.

This description is conceptual only. No file format, schema, or template for the registry is defined in this document; the registry's concrete form is an implementation decision reserved for a later IDS document.

---

## 10. Decision Criteria

Every modernization proposal raised in a future RDR must explicitly answer the following before it may be adopted:

- **Why modernize?** — the specific limitation in the historical component, as identified in Section 6 or subsequently discovered, that motivates the proposal.
- **Expected benefit** — which of the six framework objectives (Section 8) the proposal is expected to improve, and how.
- **Potential risks** — which framework objectives, if any, the proposal could plausibly degrade.
- **Available evidence** — what evidence (from Part 1, from preliminary investigation, or from the literature) already supports or challenges the proposal.
- **Expected impact** — the anticipated downstream effect on subsequent Computational Layer modules and on the Part 1 vs. Part 2 benchmark.

This structure is consistent with, and operationalizes at the methodology level, the Decision Escalation Policy already defined in the Project Governance Prompt. No modernization proposal is implemented without first being presented in this form and receiving explicit Project Coordinator approval.

---

## Modernization Decision Log

Every future modernization decision reached by the Methodology Decision Layer should eventually be documented through a standardized governance record, conceptually structured as follows:

```
Historical Component
        ↓
Evidence Reviewed
        ↓
Decision
        ↓
Scientific Rationale
        ↓
Expected Downstream Impact
```

Each entry in this log traces a single component's modernization decision from the historical methodology it concerns, through the evidence considered, to the resulting outcome (one of the four Methodology Decision Outcomes), the scientific rationale supporting that outcome, and the anticipated effect on downstream Computational Layer modules and on the Part 1 vs. Part 2 benchmark.

Maintaining this log improves transparency (every decision is visible and traceable rather than implicit), auditability (any decision can later be reviewed against the evidence that justified it), and reproducibility (a future reader, or a future thread continuing this project, can reconstruct why each component reached its outcome without re-deriving the evidence from scratch). As with the Candidate Signature Registry (Section 9), no file format, schema, or template for this log is defined here; its concrete form is reserved for a later IDS document.

---

## 11. Modernization Boundaries

This document does not decide, and explicitly defers to later RDR and IDS documents, the following:

- Algorithms
- Software and software packages
- Hyperparameters
- Specific statistical techniques
- Implementation or coding details
- Validation protocol details (e.g., resampling scheme, number of repetitions, specific performance metrics)

These remain open decisions, to be raised and resolved individually through the Mandatory Review Cycle as each component-specific RDR is produced.

---

## Methodology Decision Layer

RDR-001 defined a four-layer vertical architecture: Scientific Layer, Framework Philosophy, Computational Layer, Evidence Layer. This document introduces a fifth conceptual layer, positioned immediately downstream of the Evidence Layer:

```
Computational Outputs
        ↓
Evidence
        ↓
Methodology Decision Layer
        ↓
Locked Methodology
```

The **Methodology Decision Layer** is responsible for determining whether a proposed methodological modernization is scientifically justified, based on the evidence produced by the Evidence Layer and evaluated against the Decision Criteria in Section 10. It exists as a distinct architectural layer — rather than being folded into the Evidence Layer itself — because evidence review and methodology decision-making are functionally different acts: the Evidence Layer classifies and reports what was observed (FACT / INFERENCE / UNKNOWN, per RDR-001's Evidence Flow), while the Methodology Decision Layer determines what should be done about it. This separation formalizes, at the architectural level, the principle that methodology in this project is evidence-driven rather than algorithm-driven: no methodology is locked because it is fashionable or contemporary, but only because the Methodology Decision Layer has determined, on the basis of reviewed evidence, that it is justified.

The Methodology Decision Layer's output — Locked Methodology — becomes the input to the corresponding component's implementation, and is the governance event that authorizes an IDS document to be written for that component.

### Methodology Decision Outcomes

Every modernization proposal evaluated by the Methodology Decision Layer resolves to one of four conceptual outcomes:

- **Adopt Modernization** — the proposed modernization is supported by sufficient evidence and is locked as the methodology for that component.
- **Retain Historical Methodology** — the evidence does not support modernization for that component; the Part 1 methodology is retained, with the retention explicitly justified and documented.
- **Defer Decision** — available evidence is insufficient to decide either way; the decision is postponed pending further evidence, without defaulting silently to either modernization or retention.
- **Reject Modernization** — the proposed modernization is evaluated and found to degrade one or more framework objectives (Section 8) without sufficient offsetting benefit; it is not adopted.

All four outcomes are equally valid governance results, provided each is supported by evidence reviewed through the sequence described in Section 4. Modernization is not the preferred or default outcome of this process; the Methodology Decision Layer exists precisely so that any of these four outcomes can be reached on its merits, for each component independently.

---

## 12. Governance Progression

```
RDR-002 (this document — methodology architecture)
        ↓
RDR-003 Discovery Methodology
        ↓
RDR-004 Modeling Methodology
        ↓
RDR-005 Validation & Benchmark Methodology
        ↓
RDR-006 Interpretability & Clinical Translation Methodology
        ↓
FRAMEWORK_SPEC.md
        ↓
IDS Documents
        ↓
Implementation
```

`FRAMEWORK_SPEC.md` will become the consolidated methodology reference document after RDR-006 — synthesizing the component-wise decisions made across RDR-003 through RDR-006 into a single, coherent specification of the framework's locked methodology, prior to any IDS document being drafted. The contents of RDR-003 through RDR-006 are not defined in this document.

---

## 13. Governance Status

**Status:** METHODOLOGY ARCHITECTURE LOCK CANDIDATE

**Implementation:** NOT PERMITTED

**Next Step:**
1. Strategist Review
2. Project Coordinator Review
3. Architecture Lock
4. Proceed to RDR-003_Discovery_Methodology.md
