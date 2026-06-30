# RDR-003 — CLOSURE

**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework
**Closes:** RDR-003_Discovery_Methodology.md
**Status at closure:** LOCKED (APPROVED — Project Coordinator confirmed)

---

## Executive Summary

RDR-003 specializes the framework's four-layer architecture (RDR-001) and methodology governance (RDR-002) for the Discovery Layer specifically, building directly on the already-locked Discovery Philosophy (Phase A). It defines the Discovery Layer's internal five-stage architecture (QC/Preprocessing → Statistical Discovery → Multiple Testing/Filtering → Cross-Cohort Integration → Candidate Gene Set), its evidence requirements, its benchmarking philosophy against Part 1's historical pathway, its interface to the Modeling Layer, and strengthened candidate governance specific to Discovery. No algorithm, statistical test, or implementation detail was named. The document is locked as-is, with no revisions required.

---

## Locked Decisions

- The Discovery Layer's internal architecture is fixed as a five-stage sequence: QC/Preprocessing → Statistical Discovery → Multiple Testing/Filtering → Cross-Cohort Integration → Candidate Gene Set — directly operationalizing the locked Discovery Layer Boundary (Discovery Philosophy item 7).
- This five-stage sequence is itself subject to component-wise, evidence-constrained modernization (RDR-002); each stage may be independently modernized, retained, deferred, or rejected once a specific methodology proposal is brought forward.
- The architecture is expressed at the level of stage *roles*, deliberately extensible beyond the gene-level unit (to transcript/pathway/module-level discovery) without restructuring the sequence — an extensibility property to be preserved, not a claim of demonstrated extension.
- **Discovery Evidence** is locked as four required components accompanying every candidate gene set: gene set composition, stability profile, discovery pathway, quality metrics — directly operationalizing the locked Candidate Definition (Discovery Philosophy item 8).
- **Benchmarking Philosophy:** the historical Part 1 discovery pathway must remain directly executable *within* the Discovery Layer's five-stage architecture (not as an external comparison), enabling genuine stage-level (not just final-candidate-level) benchmarking against any modernized instantiation.
- **Discovery → Modeling Interface** is confirmed and specialized: the Candidate Gene Set plus full Discovery Evidence is the only artifact crossing the boundary; no predictive index, classifier, or risk group may originate in Discovery.
- **Candidate Governance (Discovery-specific):** multiplicity of candidate gene sets is expected as a normal outcome, not an exception; a candidate is not a complete "Discovery Candidate" until all four Discovery Evidence components are documented; no candidate may be discarded within Discovery's own execution — selection among candidates is a Methodology Decision Layer outcome only.

---

## Newly Approved Concepts

- The Discovery Layer's internal five-stage architecture (Section 5) — a specialization not previously specified at this resolution in RDR-001 or RDR-002.
- Explicit extensibility statement (Section 6) for future feature-level units beyond genes, as a preserved design property.
- The Discovery → Modeling interface table (Section 9), specializing RDR-001's Framework Interfaces specifically for this boundary.

---

## Remaining Open Questions

Explicitly deferred to a future, separately governed methodology proposal (per RDR-003 Section 11), and NOT resolved by this document:

- Which specific method instantiates Statistical Discovery, Multiple Testing/Filtering, or Cross-Cohort Integration.
- Whether a modernized alternative to hard cross-cohort intersection will even be proposed.
- The precise quantitative definition/resampling scheme for the "stability profile" required in Discovery Evidence.
- Any hyperparameter, software package, or implementation detail.

**Acknowledged but explicitly out of locked scope:** architectural ideas raised in post-review discussion — Discovery Candidate as a richer conceptual artifact, Discovery Provenance, and a framework-wide candidate lifecycle — are noted as possible future architectural directions for later RDRs only. They are not part of RDR-003's locked content and have not been retroactively inserted into it.

---

## Downstream Documents Affected

- **RDR-004_Modeling_Methodology.md** (future RDR, not yet drafted) — must treat the Candidate Gene Set + Discovery Evidence interface (RDR-003 Section 9) as its fixed starting input. Drafting is held until the Modeling Philosophy is explicitly locked (see Next Step).
- Any future methodology proposal for Discovery's five internal stages must be evaluated through the Methodology Decision Layer (RDR-002) and is downstream of, not a revision to, this document.

---

## Governance Status

**Status:** LOCKED (APPROVED)
**Implementation:** NOT PERMITTED

---

## Next Step

1. RDR-004 Phase A (Discussion) — conducted directly between Project Coordinator and Strategist AI; not yet a governance artifact
2. Modeling Philosophy to be explicitly locked as the outcome of that discussion
3. Draft RDR-004_Modeling_Methodology.md only after Modeling Philosophy is locked

---

## Handoff Notes

For any future thread continuing this project: RDR-000, RDR-001, RDR-002 (+ RDR-002_CLOSURE), and now RDR-003 (+ this closure) form the complete locked governance chain, all under PROJECT_GOVERNANCE_PROMPT_v4.5.1.md. No algorithm has been named anywhere in the chain. The Discovery Layer's internal architecture (five stages) and its Discovery Evidence requirements (four components) are now locked and must be treated as fixed inputs to RDR-004. Architectural ideas raised after RDR-003's lock (Discovery Candidate enrichment, Discovery Provenance, framework-wide candidate evolution) are acknowledged as future-RDR directions only — they are not part of RDR-003 and must not be retroactively inserted into it. RDR-004 Phase A (Discussion) is currently being conducted directly between the Project Coordinator and Strategist AI, outside of formal governance documents; any working notes from that discussion (including a prior RDR-004_PREPARATION draft) are temporary working material, not governance artifacts, and should not be treated as locked or authoritative. RDR-004 itself must not be drafted until the Modeling Philosophy emerging from that discussion is explicitly locked.
