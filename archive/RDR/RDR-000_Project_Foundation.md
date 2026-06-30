# RDR-000 — Project Foundation (Part 2)

**Status:** LOCKED FOUNDATION DOCUMENT
**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework
**Document Type:** Reconstruction/Research Design Record (Foundational)
**Supersedes:** None (first RDR of Part 2)
**Depends on:** Part 1 (Modules 01–10, closed)

---

## 1. Executive Summary

Part 1 of this project reconstructed a classical statistical pipeline (random-variance t-test, Cox proportional-hazards screening, intersection-based gene selection, PCA-based predictive index, SVM classification) to identify and externally validate a transcriptomic signature associated with recurrence following fluoropyrimidine-based chemotherapy in gastric cancer. That reconstruction surfaced a concrete instability: independently re-running the discovery-stage statistics recovered only 3 of 12 candidate genes, motivating two parallel models (Path A, Path B) rather than a single committed signature.

Part 2 does not begin a new scientific problem. It continues the same biological question using the same datasets and the same endpoint, while replacing the discovery methodology with a contemporary, regularization-based framework. The purpose is to determine, through direct benchmarking against Part 1's classical pipeline, whether modern methodology yields a more stable and better-validated biomarker signature — and, more fundamentally, to produce a reproducible modern biomarker discovery framework as the project's principal artifact, independent of which specific gene set emerges from it.

This document locks the scientific foundation of Part 2. It does not select, recommend, or discuss any specific algorithm. Methodology design is reserved for subsequent RDR documents.

---

## 2. Project Background

Part 1 ("A 12-Gene Expression Signature for Recurrence Risk Stratification in Gastric Cancer") is closed. Its discovery-to-validation pipeline ran end-to-end in R across ten modules — gene filtering, discovery statistics, gene intersection, PCA-based predictive index, SVM classification, external validation, survival analysis, and a forward-looking clinical translation extension (nomogram, calibration, Decision Curve Analysis).

The central finding that motivates Part 2 is not a failure of Part 1, but a documented instability internal to the classical discovery approach itself: a three-way intersection of independent univariate discovery analyses recovered only 3 of 12 candidate genes, with the bottleneck traced entirely to one discovery cohort. Rather than resolving this by fiat, Part 1 carried both the full 12-gene signature (Path A) and the independently-recovered 3-gene subset (Path B) forward through every downstream stage, reporting where they converge and where they diverge.

Part 2 is the direct continuation of this narrative: having identified that univariate, intersection-based gene selection is sensitive to which discovery cohort is used, the natural next question is whether a discovery method explicitly designed for high-dimensional, correlated, and unstable feature spaces behaves differently on the same problem.

---

## 3. Scientific Motivation

Classical univariate feature selection (t-tests, Cox screening, hard intersection across cohorts) treats each gene independently and applies a binary in/out decision at a fixed significance threshold. This approach has two well-documented limitations in high-dimensional transcriptomic data: it does not account for correlation structure among genes, and it provides no native mechanism for quantifying how sensitive the selected gene set is to resampling of the underlying data — precisely the instability Part 1 exposed empirically rather than by design.

Contemporary biomarker discovery methodology was developed in large part to address these two limitations directly — by selecting features jointly under a regularization constraint, and by formally assessing feature-selection stability and out-of-sample performance through resampling-based validation strategies. Part 2 exists to bring that methodology to bear on the same discovery problem Part 1 already characterized, using Part 1's own findings as the explicit benchmark.

---

## 4. Biological Question

Can transcriptomic biomarkers predict recurrence following fluoropyrimidine-based chemotherapy in gastric cancer?

This biological question is unchanged from Part 1 and is not subject to revision within Part 2.

---

## 5. Scientific Question

Can contemporary machine-learning-based biomarker discovery methodology improve the robustness, stability, and predictive performance of a transcriptomic recurrence signature, relative to a classical statistical discovery pipeline, when applied to the same biological question, the same datasets, and the same endpoint?

---

## 6. Project Objectives

- Continue the scientific narrative established in Part 1 without invalidating it.
- Apply a contemporary, regularization-based discovery methodology to the same discovery problem characterized in Part 1.
- Produce a benchmark comparison between classical (Part 1) and modern (Part 2) methodology, holding the biological question, datasets, and endpoint constant.
- Produce a reproducible, documented, modern biomarker discovery framework as the project's principal deliverable.
- Carry any resulting signature through internal validation, external validation, and a clinical translation extension structurally comparable to Part 1's, to support a like-for-like benchmark.
- Generate a publication-quality and PhD-portfolio-quality record of the entire process, governed under the same RDR/IDS framework used in Part 1.

---

## 7. Scope

- Re-use of the same discovery, training, and external validation datasets established in Part 1 (subject to repeat curation for completeness and reproducibility).
- Design and application of a modern, regularization-based biomarker discovery methodology to the same endpoint as Part 1.
- Internal validation of the resulting model(s).
- External validation on the same external cohort used in Part 1.
- A clinical translation extension (nomogram, calibration, Decision Curve Analysis) structurally comparable to Part 1's Module 10, to support direct benchmarking.
- A final, explicit benchmark of Part 2 methodology and outputs against Part 1.
- Full governance documentation (RDR/IDS series, module reviews) for every stage, following the same standard established in Part 1.

---

## 8. Out of Scope

- Revisiting or re-deriving the biological question.
- Introducing new datasets, cohorts, or endpoints not already used in Part 1, unless a future RDR explicitly proposes and locks such an extension.
- Selecting, comparing, or discussing specific algorithms (e.g., LASSO, Elastic Net, stability selection, nested cross-validation) within this document. Methodology selection is reserved for subsequent RDR documents.
- Declaring Part 1's signature or methodology invalid. Part 2 evaluates measurable advantages; it does not seek to discredit Part 1.
- Treating any interim Part 2 output as locked methodology, authorized implementation, or a final scientific conclusion prior to explicit Project Coordinator approval, per the governance review cycle.

---

## 9. Scientific Philosophy

Part 2 does not attempt to prove the historical (Part 1) methodology wrong. It systematically evaluates whether modern computational methodology offers measurable improvements in robustness, stability, and predictive performance, while keeping the underlying biological problem unchanged. Classical and modern methodology are treated as two legitimate, comparable approaches to the same discovery problem, not as a contest with a presumed winner.

---

# Design Principles

The following are permanent design principles governing Part 2. They are project principles, not implementation decisions, and they constrain how every future methodology choice is evaluated rather than prescribing what that methodology will be.

- **Scientific rigor over algorithmic complexity.** Methodological sophistication is never adopted for its own sake; every methodology choice must be justified by what it contributes to answering the scientific question.
- **Reproducibility by design.** Every stage of the framework must be reproducible end-to-end from documented inputs, code, and locked governance decisions.
- **Stability before predictive performance.** Feature and model stability under resampling is treated as a first-class evaluation criterion, not a secondary diagnostic — directly addressing the instability Part 1 exposed.
- **Transparent benchmarking.** Comparisons against Part 1, and any other benchmark, are reported in full regardless of which side they favor.
- **Interpretability whenever appropriate.** Where interpretability can be preserved without compromising scientific validity, it is preferred over opacity.
- **Clinical translatability.** The framework is designed so that its outputs remain usable in a clinical translation extension (nomogram, calibration, decision-curve assessment), not only as an abstract modeling exercise.
- **Framework generalizability.** The framework's design philosophy is intentionally kept independent of the specific disease, dataset, or biomarker problem used to demonstrate it.

---

# Framework Philosophy

The framework is designed to maximize robustness, reproducibility, stability, and transparency — not to maximize predictive accuracy as a sole or primary objective. Predictive performance remains an important evaluation criterion, but it is evaluated alongside, and never in place of, these four properties.

Methodology choices proposed in future RDR documents must be evaluated explicitly against this philosophy: a methodology that improves predictive performance at the cost of robustness, reproducibility, stability, or transparency requires explicit justification and Project Coordinator approval before it may be adopted.

---

## 10. Benchmark Philosophy

To make the comparison between Part 1 and Part 2 scientifically meaningful, the following are held constant:

- the biological question
- the datasets
- the endpoint
- the validation cohorts

Only the discovery and modeling methodology is permitted to change, and only when scientifically justified through the governance review cycle. This constraint is what allows any observed difference in outcome to be attributed to methodology rather than to a shifted problem definition.

---

## 11. Dataset Philosophy

Part 2 uses the same discovery, training, and external validation datasets established in Part 1. Dataset curation may be repeated in full to ensure completeness, reproducibility, and freedom from any undocumented carry-over assumptions from Part 1's execution environment. No new dataset, cohort, or data source is introduced at this stage. Any future need for additional data must be raised as an explicit, separately governed decision.

---

## 12. Endpoint Definition

Recurrence / Disease-Free Survival following fluoropyrimidine-based chemotherapy in gastric cancer. This endpoint is unchanged from Part 1 and is held constant for the duration of Part 2, consistent with the Benchmark Philosophy (Section 10).

---

## 13. Expected Deliverables

- A documented modern biomarker discovery framework (methodology to be designed in subsequent RDRs).
- Internally validated model(s) resulting from that framework.
- Externally validated performance on the same external cohort used in Part 1.
- A clinical translation extension (nomogram, calibration, Decision Curve Analysis) comparable in structure to Part 1's.
- A final benchmark report comparing Part 2 against Part 1 across stability, robustness, and predictive performance.
- Complete governance documentation: RDR and IDS series, module reviews, verification logs.
- A README and supporting narrative assets suitable for integration into the existing GitHub repository as "Part 2 of 2."
- `docs/Framework/Biomarker_Discovery_Framework_v1.md` — a reusable methodological reference document describing the discovery framework independently of its specific application to gastric cancer, intended to remain useful as a reference for future applications of the framework to other biomarker discovery problems.

---

## 14. Success Criteria

Part 2 will be considered scientifically complete when:

- The modern discovery framework has been fully specified, implemented, and locked through the governance review cycle.
- Internal and external validation have been completed on the same cohorts used in Part 1.
- A documented, evidence-based benchmark comparison against Part 1 exists, addressing stability, robustness, and predictive performance — regardless of which methodology is found to perform better.
- All deliverables in Section 13 exist and have passed module closure requirements under the governance framework.

Success is defined by the completeness and rigor of the benchmark, not by a predetermined expectation that Part 2 must outperform Part 1.

---

## 15. Scientific Contribution

The principal scientific contribution of Part 2 is a reusable, reproducible computational biomarker discovery framework, demonstrated end-to-end using gastric cancer transcriptomic data and benchmarked directly against a classical reconstruction of the same discovery problem. The framework is designed with a disease-agnostic philosophy: gastric cancer recurrence is the demonstration case, not an inherent constraint of the framework's design. Any specific gene signature that results from applying the framework to this demonstration case is an outcome of the framework, not the project's primary objective.

---

## 16. Expected Technical Contribution

Demonstrated, end-to-end implementation of a contemporary biomarker discovery and validation workflow in R, governed under the same documentation-first, gate-controlled process used in Part 1, and benchmarked transparently against a classical alternative on identical data and endpoint.

---

## 17. Expected Translational Contribution

A clinical translation extension structurally comparable to Part 1's, allowing any resulting modern signature to be assessed for nomogram integration, calibration, and clinical decision-curve utility under the same internal, optimism-corrected framing already established in Part 1 — preserving comparability rather than introducing a new translational standard specific to Part 2.

---

## 18. Publication Positioning

Part 2 is positioned along three complementary dimensions, all of which should appear in publication framing:

- **A reusable computational biomarker discovery framework** — the primary methodological artifact, designed to be applicable beyond the specific demonstration case used here.
- **A methodological contribution** — a documented, governed approach to modern biomarker discovery that emphasizes stability and reproducibility as first-class evaluation criteria alongside predictive performance.
- **A benchmark study** — a direct, evidence-based comparison between this modern framework and the classical pipeline reconstructed in Part 1, on identical data and endpoint.

Together, these position the overall project (Part 1 and Part 2) as a methodological case study in biomarker discovery, informative regardless of which discovery paradigm proves more robust on this particular demonstration case.

---

## 19. GitHub Positioning

Part 2 will be documented and published as "Part 2 of 2" within the existing repository, preserving Part 1 in full and extending the existing README narrative rather than replacing it. The repository as a whole is positioned as a demonstration of rigorous, governed, reproducible computational biomarker research spanning both classical and modern methodology.

Although demonstrated using gastric cancer transcriptomic cohorts, the framework is intentionally designed so that future users can adapt it to other cancer types, other transcriptomic datasets, or other high-dimensional biomarker discovery problems without fundamentally redesigning the workflow. This adaptability is a design intention to be reflected in the repository's structure and documentation, not a claim that such adaptation has already been performed or validated.

---

## 20. PhD Portfolio Positioning

Part 2 demonstrates direct competency in contemporary machine-learning-based biomarker discovery, nested validation strategy design, and methodological benchmarking — directly relevant to PhD positions in computational oncology, predictive modeling for patient stratification, and translational health informatics. The two-part structure demonstrates the ability to both reconstruct and critically extend an existing methodology, rather than only applying a single fixed pipeline.

---

# Cross-cutting Principles

The following principles apply across every future module of Part 2, independent of any specific algorithm or methodology choice:

- **Reproducibility** — every module must be re-runnable from documented inputs to documented outputs.
- **Transparency** — assumptions, limitations, and negative or null results are reported with the same rigor as positive results.
- **Leakage prevention** — strict separation between discovery/training data and validation data is maintained at every stage, consistent with the frozen-standardization principle already established in Part 1.
- **Benchmarkability** — every module is designed so its outputs can be meaningfully compared against the corresponding Part 1 module.
- **Auditability** — every scientifically consequential decision is traceable to a locked governance document.
- **Documentation** — every module produces a canonical review document before closure, per the existing governance standard.
- **Version control** — all code, data references, and documentation are tracked under version control.
- **Governance compliance** — no module proceeds without passing through the Mandatory Review Cycle defined in the Project Governance Prompt.

These principles are independent of any specific algorithm and apply regardless of which methodology is ultimately locked in future RDRs.

---

# Framework Generalizability

The framework underlying Part 2 is intentionally designed so that its computational workflow can later be adapted to other cancer types — for example colorectal, breast, lung, or pancreatic cancer — and potentially to other data modalities, including transcriptomics, RNA-seq, microarray, proteomics, or multi-omics data, without changing its underlying design philosophy.

This generalizability is a design intention guiding architectural choices in future RDRs. It is not a claim that such applications have been demonstrated, tested, or validated within this project. Gastric cancer recurrence following fluoropyrimidine-based chemotherapy remains the sole demonstration case for Part 2 unless a future, separately governed decision extends the project's scope.

---

## 21. README Narrative Assets

**One-sentence project description (Part 2):**
A reusable, reproducible computational biomarker discovery framework — designed to generalize beyond a single disease — demonstrated on gastric cancer recurrence and benchmarked directly against a classical statistical reconstruction of the same problem.

**Repository positioning:**
Part 2 of 2 — a reusable computational biomarker discovery framework, demonstrated using the same gastric cancer recurrence problem reconstructed classically in Part 1, and benchmarked directly against it.

**Manuscript positioning:**
A two-part computational case study: Part 1 reconstructs and externally validates a classical transcriptomic discovery pipeline for gastric cancer recurrence; Part 2 introduces a reusable, disease-agnostic biomarker discovery framework, demonstrated on the identical problem, and benchmarks it against Part 1.

**Central scientific message:**
The framework — not any single resulting gene signature — is the primary product of Part 2. Methodology choice measurably shapes biomarker discovery outcomes; this project holds the biological question, data, and endpoint fixed and lets methodology be the only variable, reporting the result as a transparent benchmark rather than presupposing which paradigm should win.

**Contribution statement:**
This project contributes a reusable, reproducible computational biomarker discovery framework — demonstrated end-to-end on a gastric cancer recurrence problem and benchmarked head-to-head against a classical reconstruction of that same problem — together with the demonstration signature itself as one application and validation of the framework, not its objective.

**Framework-over-signature emphasis (for use throughout README drafting):**
Wherever Part 2 is described, the framework is presented as the primary contribution and the resulting gastric cancer signature as a secondary, illustrative application of that framework — never the reverse.

---

## 22. Core Keywords

robustness · reproducibility · stability · transparency · benchmark · computational oncology · machine learning · biomarker discovery · prediction modeling · translational research · external validation · TRIPOD

---

## 23. Planned Downstream RDR Documents

- RDR-001_Modern_Framework_Architecture.md — overall architecture of the modern discovery framework (no algorithm selection in this document).
- Subsequent RDRs covering, as they arise through the governance review cycle: feature selection methodology, validation strategy (e.g., resampling/cross-validation design), model specification, internal validation, external validation, and clinical translation extension — each to be created and locked individually as Part 2 progresses.

---

## 24. Open Questions Reserved for Future RDRs

- Which specific regularization-based or modern discovery methodology will be used (explicitly deferred; not to be discussed in this document).
- Whether feature-selection benchmarking and full pipeline modernization proceed as one combined effort or as sequential, separately gated stages.
- Whether Part 2 reuses the chemo-response / DFS dual-cohort structure of Part 1 or consolidates to a single endpoint structure for modeling purposes.
- Dataset re-curation scope: whether existing Part 1 data files are re-used as-is or re-derived from raw sources for Part 2.
- Validation strategy details (resampling design, performance metrics, calibration approach) — to be specified once methodology architecture is locked.

These questions are explicitly out of scope for this document and are reserved for resolution through the standard Mandatory Review Cycle defined in the Project Governance Prompt.

---

## 25. Governance Status

**Status:** APPROVED FOUNDATION

**Methodology:** NOT YET LOCKED

**Implementation:** NOT PERMITTED

**Next Document:** RDR-001_Modern_Framework_Architecture.md

---

# Governance Roadmap

The following describes the intended governance progression for Part 2. This is a governance roadmap only — it does not authorize, sequence, or imply any specific implementation work.

```
RDR-000 (this document)
        ↓
RDR-001 Framework Architecture
        ↓
RDR-002 Validation Architecture
        ↓
IDS Documents
        ↓
Implementation
        ↓
Verification
        ↓
Module Reviews
        ↓
Framework Documentation
        ↓
Repository Completion
```

Each stage remains subject to the Mandatory Review Cycle and Project Coordinator approval defined in the Project Governance Prompt before progression to the next stage.
