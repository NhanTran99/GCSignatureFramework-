# RDR-004 — CLOSURE

**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework
**Closes:** RDR-004_Modeling_Methodology.md
**Status at closure:** LOCKED (APPROVED — Project Coordinator confirmed)

---

## Executive Summary

RDR-004 specializes the framework's architecture and methodology governance (RDR-001, RDR-002) for the Modeling Layer, building on the already-locked Modeling Philosophy (Phase A) and on RDR-003's Discovery Layer specification. It defines the Modeling Layer's internal four-stage architecture (Discovery Candidate → Representation → Prediction → Risk Estimation → Model Candidate), the six required components of a complete Model Candidate, benchmarking philosophy against Part 1's historical modeling pathway, candidate governance specific to Modeling, conceptual provenance tracing, and the interface to the Validation Layer. No algorithm, statistical model, or implementation detail was named. The document passed one revision cycle (three targeted refinements, no redesign) and is now locked as-is.

---

## Locked Decisions

- The Modeling Layer's internal architecture is fixed as a four-stage sequence: Discovery Candidate → Representation → Prediction → Risk Estimation → Model Candidate — generalizing the locked Modeling Boundary (Modeling Philosophy item 8) in algorithm-agnostic terms.
- This four-stage sequence is itself subject to component-wise, evidence-constrained modernization (RDR-002); each stage may be independently modernized, retained, deferred, or rejected once a specific methodology proposal is brought forward.
- **Model Candidate** is locked as six required components: predictive model, risk score definition, model evidence, performance profile, interpretability profile, clinical evaluation profile — directly operationalizing the locked Modeling Output statement (item 3). A Model Candidate is not complete until all six are documented.
- **Modeling Input traceability:** every Model Candidate must remain traceable to exactly one originating Discovery Candidate, preserving lineages of the form Discovery Candidate A → Model Candidate A.
- **Modeling Provenance** (new subsection): the stage-by-stage lineage Discovery Candidate → Representation → Prediction → Risk Estimation → Model Candidate must remain fully traceable and reconstructable from documented evidence — conceptual only, no implementation mechanism specified.
- **Benchmarking Philosophy:** the historical Part 1 modeling pathway (PCA-based predictive index, SVM classification, median-split risk grouping) must remain directly executable *within* the Modeling Layer's four-stage architecture, enabling genuine stage-level benchmarking; modernization is evaluated *relative to* the historical pathway, not as a mandate to replace it — historical methodology remains one governed candidate among others.
- **Model Candidate Governance:** multiplicity of Model Candidates is the expected default; no selection occurs within the Modeling Layer (selection belongs exclusively to Validation); historical methodology stands on equal governance footing with modernized alternatives.
- **Model Candidates represent competing scientific hypotheses, not competing implementations** — their standing in the framework is scientific (a defensible hypothesis about endpoint–biology relationship), reinforcing Framework > Signature at the Modeling Layer specifically.
- The Modeling → Validation interface is confirmed: Model Candidate(s) plus full evidence is the only artifact crossing the boundary; selection among Model Candidates is explicitly a Validation Layer function, not a Modeling Layer function.

---

## Newly Approved Concepts

- The Modeling Layer's internal four-stage architecture (Section 5), specializing RDR-001's anticipated Modeling boundary into algorithm-agnostic stage roles.
- The Model Candidate Definition as six named, required components (Section 7) — the Modeling-Layer analogue of RDR-003's Discovery Candidate definition.
- **Modeling Provenance** (Section 6 subsection) — a conceptual lineage-traceability requirement, added during the single revision cycle.
- Explicit "Model Candidates as competing scientific hypotheses" framing (Section 10), added during the revision cycle to reinforce Framework > Signature.
- Strengthened benchmarking language (Section 8) clarifying modernization-relative-to, not replacement-of, historical methodology.

---

## Remaining Open Questions

Explicitly deferred to a future, separately governed methodology proposal (per RDR-004 Section 11), and NOT resolved by this document:

- Which specific method instantiates Representation, Prediction, or Risk Estimation.
- Any hyperparameter, software package, or implementation detail.
- The precise quantitative definitions used within the performance, interpretability, or clinical evaluation profiles.
- How selection among multiple Model Candidates is ultimately performed — explicitly reserved for RDR-005 (Validation Layer).

No architectural ideas were flagged as out-of-scope during this revision cycle (unlike RDR-003); the three requested revisions were incorporated directly into the locked document rather than deferred.

---

## Downstream Documents Affected

- **RDR-005_Validation_and_Benchmark_Methodology.md** (future RDR, not yet drafted) — must treat the Model Candidate(s) + full evidence interface (RDR-004 Section 9) as its fixed starting input, and must define the selection function among Model Candidates that RDR-004 explicitly excluded from the Modeling Layer.
- RDR-005 Phase A (Validation Philosophy Discussion) is the next active work, to be conducted directly between the Project Coordinator and the Framework Architect (ChatGPT), outside formal governance documents — mirroring how RDR-004 Phase A preceded this document.
- Any future methodology proposal for Modeling's four internal stages must be evaluated through the Methodology Decision Layer (RDR-002) and is downstream of, not a revision to, this document.

---

## Governance Status

**Status:** LOCKED (APPROVED)
**Implementation:** NOT PERMITTED

---

## Next Step

1. RDR-005 Phase A (Validation Philosophy Discussion) — conducted directly between Project Coordinator and Framework Architect (ChatGPT); not yet a governance artifact
2. Validation Philosophy to be explicitly locked as the outcome of that discussion
3. Draft RDR-005_Validation_and_Benchmark_Methodology.md only after Validation Philosophy is locked

---

## Handoff Notes

For any future thread continuing this project: RDR-000, RDR-001, RDR-002 (+ CLOSURE), RDR-003 (+ CLOSURE), and now RDR-004 (+ this closure) form the complete locked governance chain, all under PROJECT_GOVERNANCE_PROMPT_v4.5.1.md. No algorithm has been named anywhere in the chain. The Modeling Layer's internal architecture (four stages), its Model Candidate definition (six components), and its Modeling Provenance requirement are now locked and must be treated as fixed inputs to RDR-005. RDR-005 Phase A (Validation Philosophy Discussion) is currently being conducted directly between the Project Coordinator and the Framework Architect (ChatGPT), outside of formal governance documents — note this is a different collaborator role than the Strategist AI / Coding Agent split used for RDR-003/RDR-004; any resulting working notes are temporary and not governance artifacts until an explicit Validation Philosophy lock occurs. Per explicit instruction, no RDR-005_PREPARATION.md has been generated for this phase. RDR-005 itself must not be drafted until the Validation Philosophy emerging from that discussion is explicitly locked, mirroring the same precondition that governed RDR-003 and RDR-004.
