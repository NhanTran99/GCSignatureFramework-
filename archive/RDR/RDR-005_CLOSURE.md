# RDR-005 — CLOSURE

**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework
**Closes:** RDR-005_Validation_and_Benchmark_Methodology.md
**Status at closure:** LOCKED (APPROVED — Project Coordinator confirmed)

---

## Executive Summary

RDR-005 specializes the framework's architecture and methodology governance (RDR-001, RDR-002) for the Validation Layer, building on the already-locked Validation Philosophy (Phase A) and on RDR-004's Modeling Layer specification. It defines the Validation Layer's internal four-stage architecture (Model Candidate → Internal Evidence Assembly → External Evidence Assembly → Multi-Criteria Evidence Integration → Validated Candidate + Recommendation), the Validated Candidate's standardized Validation Evidence package, benchmarking philosophy against Part 1's historical validation pathway, candidate governance specific to Validation, the Validation Layer's boundary and downstream progression, and a harmonized governance interpretation distinguishing the Validation Layer's own recommendation from the framework-wide Recommended Signature. The document passed one revision cycle (three targeted refinements, no redesign) and is now locked as-is, with no further revision permitted.

---

## Locked Decisions

- The Validation Layer's internal architecture is fixed as a four-stage sequence: Model Candidate → Internal Evidence Assembly → External Evidence Assembly → Multi-Criteria Evidence Integration → Validated Candidate + Recommendation — generalizing the locked Historical Validation Benchmark (Validation Philosophy item 5) into algorithm-agnostic stage roles.
- This four-stage sequence is itself subject to component-wise, evidence-constrained modernization (RDR-002); each stage may be independently modernized, retained, deferred, or rejected once a specific methodology proposal is brought forward.
- **Validation Evidence** is locked as the Validation Layer's standardized evidence package — the originating Model Candidate, complete validation evidence across the six locked evaluation domains, and a transparent recommendation — explicitly named symmetric with Discovery Evidence (RDR-003) and Model Evidence (RDR-004), with no new required component introduced beyond what was already locked in Phase A.
- **Validated Candidate traceability:** every Validated Candidate must remain traceable to exactly one originating Model Candidate, extending the Discovery Candidate → Model Candidate lineage (RDR-004) one step further to Model Candidate → Validated Candidate.
- **Benchmarking Philosophy:** the historical Part 1 validation pathway (training-cohort KM/log-rank/ROC-AUC; external-cohort KM/log-rank/Cox) must remain directly executable *within* the Validation Layer's four-stage architecture, enabling genuine stage-level benchmarking; historical validation remains one governed pathway, not a baseline to be replaced; end-to-end framework benchmarking is explicitly out of scope, reserved for Framework Integration.
- **Validation Layer Boundary and downstream progression** is fixed as: Validation Layer → RDR-006 (Interpretability & Clinical Translation) → Framework Integration. The Clinical Translation Extension (nomogram, calibration, DCA, bootstrap) is explicitly excluded from Validation's own internal architecture and reserved for RDR-006.
- **Validated Candidate Governance:** multiplicity of Validated Candidates may persist; Validation does not collapse multiplicity by itself; Validated Candidates represent the framework's most evidence-complete scientific conclusions to this point, not final clinical decisions; historical methodology remains one governed Validated Candidate pathway among others.
- **Harmonized terminology (governance interpretation, not a new architectural concept):** the **Framework-Wide Recommendation** is the process, reserved for Framework Integration, by which Validated Candidates across the entire framework are weighed against each other to produce the **Recommended Signature** (the resulting artifact). The Validation Layer's own recommendation (Section 7) is a narrower, criteria-scoped input to that eventual process — it is not itself the Framework-Wide Recommendation, and RDR-005 does not produce a Recommended Signature.

---

## Newly Approved Concepts

No new architectural concepts were introduced during this RDR's revision cycle. The single revision cycle applied three targeted refinements that clarified and harmonized terminology already implicit in the locked Validation Philosophy and in prior RDRs, without expanding the architecture:

- Explicit naming of "Validation Evidence" as the standardized evidence package (Section 7), making explicit a symmetry with Discovery Evidence and Model Evidence that was already implicit in the framework's design.
- A single, fixed governance interpretation distinguishing "Framework-Wide Recommendation" (process, Framework Integration) from "Recommended Signature" (artifact), resolving prior terminological ambiguity without altering any boundary or responsibility.
- An explicit three-step downstream progression diagram (Validation Layer → RDR-006 → Framework Integration) in Section 9, restating existing boundaries in sequence rather than introducing new ones.

---

## Remaining Open Questions

Explicitly deferred to a future, separately governed methodology proposal (per RDR-005 Section 11), and NOT resolved by this document:

- Which specific statistical procedures instantiate Internal Evidence Assembly or External Evidence Assembly.
- Which specific quantitative definitions are used for discrimination, calibration, robustness, external robustness, clinical utility, or reproducibility.
- The specific procedure by which the transparent recommendation is generated from integrated evidence.
- Any hyperparameter, software package, or implementation detail.
- Interpretability and Clinical Translation methodology — explicitly reserved for RDR-006.
- Framework-wide recommendation, integration, and end-to-end benchmarking — explicitly reserved for the final Framework Integration stage.

No architectural ideas were flagged as out-of-scope during this revision cycle; the three requested refinements were incorporated directly into the locked document.

---

## Downstream Documents Affected

- **RDR-006_Interpretability_and_Clinical_Translation_Methodology.md** (future RDR, not yet drafted) — must treat Validated Candidates and their Validation Evidence (RDR-005 Section 7) as fixed starting input, and must scope Interpretability and Clinical Translation methodology (including the historical Clinical Translation Extension) without redrawing the Validation Layer's boundary fixed here.
- RDR-006 Phase A (Interpretability & Clinical Translation Philosophy Discussion) is the next active work.
- The eventual Framework Integration stage must respect the Framework-Wide Recommendation / Recommended Signature distinction fixed in this document.
- Any future methodology proposal for Validation's four internal stages must be evaluated through the Methodology Decision Layer (RDR-002) and is downstream of, not a revision to, this document.

---

## Governance Status

**Status:** LOCKED (APPROVED) — no further revision cycles permitted; RDR-005 is immutable.
**Implementation:** NOT PERMITTED

---

## Next Step

1. RDR-006 Phase A (Interpretability & Clinical Translation Philosophy Discussion)
2. Lock the Phase A philosophy
3. Draft RDR-006_Interpretability_and_Clinical_Translation_Methodology.md only after the philosophy is locked

---

## Handoff Notes

For any future thread continuing this project: RDR-000, RDR-001, RDR-002 (+ CLOSURE), RDR-003 (+ CLOSURE), RDR-004 (+ CLOSURE), and now RDR-005 (+ this closure) form the complete locked governance chain, all under PROJECT_GOVERNANCE_PROMPT_v4.5.1.md. No algorithm, statistical test, software package, or implementation detail has been named anywhere in the chain. The Validation Layer's internal architecture (four stages), its Validation Evidence package, and the Framework-Wide Recommendation / Recommended Signature distinction are now locked and must be treated as fixed inputs to RDR-006. RDR-006 Phase A (Interpretability & Clinical Translation Philosophy Discussion) is the next active work, expected to follow the same pattern already used for RDR-003 and RDR-004's Phase A discussions, converging on an explicitly locked Interpretability & Clinical Translation Philosophy before any RDR-006 draft is produced. RDR-005 itself is now immutable; no further revision cycles are permitted, and any future architectural evolution touching Validation must occur through a subsequent RDR, never through reopening this one.
