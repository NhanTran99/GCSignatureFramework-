# RDR-002 — CLOSURE

**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework
**Closes:** RDR-002_Modern_Methodology_Architecture.md
**Status at closure:** METHODOLOGY ARCHITECTURE LOCK CANDIDATE (pending Strategist + Project Coordinator review)

---

## Executive Summary

RDR-002 defines the methodology architecture for Part 2: which components of Part 1's historical pipeline are candidates for modernization, and the governance mechanism by which any modernization decision must be justified. It introduces component-wise, evidence-constrained modernization as the project's permanent decision philosophy, and adds a fifth conceptual layer — the Decision Layer — to RDR-001's architecture, sitting between Evidence and Locked Methodology. No algorithm, statistical technique, or implementation detail was named or implied.

---

## Locked Decisions

- Modernization is defined relative to four properties only: robustness, reproducibility, stability, transparency — never relative to the biological question, datasets, or endpoint (all remain fixed per RDR-000).
- Modernization is **evidence-constrained**: every component must pass Evidence Review → Feasibility Assessment → Decision before being modernized; retaining historical methodology with documented justification is an equally valid outcome.
- Modernization is **component-wise**: each historical component (Section 2 of RDR-002) is evaluated independently; no indiscriminate, whole-pipeline modernization.
- The framework is a **multi-objective optimization framework** across six objectives (predictive performance, robustness, stability, interpretability, clinical utility, reproducibility); no single objective may dominate decisions.
- **Candidate Signature Governance** is mandatory: multiple candidate signatures may emerge; none may be silently discarded; all must be evaluated and documented against the six objectives.
- Benchmarking occurs at the **component level**, not only at final predictive performance, extending RDR-000's project-level Benchmark Philosophy.
- A new architectural layer, the **Decision Layer**, is locked: Computational Outputs → Evidence → Decision Layer → Locked Methodology. It is functionally distinct from the Evidence Layer (RDR-001): Evidence classifies what was observed; the Decision Layer decides what should be done about it.

---

## Newly Approved Concepts

- Historical Mapping Matrix (RDR-002 Section 6) — a conceptual, non-implementational mapping of each Part 1 component to its observed limitation, modernization objective, success criterion, and responsible future RDR. This is a planning artifact only; it does not authorize any modernization.
- Decision Criteria template (Section 10): every future modernization proposal must answer Why modernize / Expected benefit / Potential risks / Available evidence / Expected impact before adoption.
- `FRAMEWORK_SPEC.md` is now a named, planned deliverable — the consolidated methodology reference to be synthesized after RDR-006, prior to any IDS document.

---

## Remaining Open Questions

These are explicitly deferred to later RDRs and are not resolved by RDR-002:

- Which specific discovery methodology will be proposed in RDR-003 (algorithm-agnostic at this stage).
- How modeling, validation/benchmark, and interpretability/clinical-translation methodology will be specified in RDR-004, RDR-005, RDR-006 respectively.
- Exact resampling/validation protocol details (deferred to RDR-005).
- Whether any row of the Historical Mapping Matrix will, on evidence review, result in retention rather than modernization — genuinely undetermined at this stage.

---

## Downstream Documents Affected

- **RDR-003_Discovery_Methodology.md** (next document) — must use the Decision Layer and Decision Criteria (Section 10) to evaluate modernization of: gene filtering, discovery statistics, gene intersection.
- **RDR-004_Modeling_Methodology.md** — dimensionality reduction/predictive index, classification, median-split risk grouping.
- **RDR-005_Validation_and_Benchmark_Methodology.md** — external validation, survival analysis, plus the component-level Benchmark Philosophy (Section 7).
- **RDR-006_Interpretability_and_Clinical_Translation_Methodology.md** — clinical translation extension.
- **FRAMEWORK_SPEC.md** — to be created after RDR-006, consolidating all locked methodology decisions.

---

## Governance Status

**Status:** METHODOLOGY ARCHITECTURE LOCK CANDIDATE
**Implementation:** NOT PERMITTED

---

## Next Step

1. Strategist Review
2. Project Coordinator Review
3. Architecture Lock
4. Proceed to RDR-003_Discovery_Methodology.md

---

## Handoff Notes

For any future thread continuing this project: RDR-000 (foundation), RDR-001 (4-layer architecture: Scientific → Framework Philosophy → Computational → Evidence, plus horizontal principles), and RDR-002 (methodology architecture + Decision Layer) are the complete locked-or-pending governance chain as of this closure. No methodology has been locked. No algorithm has been named anywhere in the chain. The next required action is Strategist Review of RDR-002 before RDR-003 (Discovery Methodology) may begin — and RDR-003 will be the first document permitted to discuss actual discovery methodology candidates (still subject to the Decision Layer/Decision Criteria process, not a free choice).
