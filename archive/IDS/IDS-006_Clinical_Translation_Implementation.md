# IDS-006_Clinical_Translation_Implementation.md

**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework
**Document Type:** Implementation Design Specification (Domain-Level — Clinical Translation)
**Governed by (authoritative, immutable, in precedence order):** FRAMEWORK_SPEC.md → IMPLEMENTATION_PHILOSOPHY_IDS_PHASE.md → IDS-001_Framework_Implementation.md (LOCKED) → IDS-002_Discovery_Implementation.md (LOCKED) → IDS-003_Modeling_Implementation.md (LOCKED) → IDS-004_Validation_Benchmark_Implementation.md (LOCKED) → IDS-005_Interpretability_Implementation.md (LOCKED) → IDS-006_PREPARATION.md (LOCKED, Design Lock)
**Status:** DRAFT — Phase B, pending Strategist Review
**Implementation:** NOT PERMITTED (this document specifies contracts, not code)

---

## 1. Document Purpose

IDS-006 is the domain-specific Implementation Design Specification for the **Clinical Translation implementation domain**, as identified in IDS-001, Section 3.1. It translates the Clinical Translation responsibility of the Interpretability & Clinical Translation Layer already locked in FRAMEWORK_SPEC.md (RDR-006) into implementation contracts. The Biological Interpretation and Model Explanation responsibilities of that same Layer are out of scope here and were already specified by IDS-005.

IDS-006 inherits every framework-wide contract fixed by IDS-001 (Artifact, Interface, Dependency, Verification contracts; Cross-Cutting Implementation Principles; Implementation Boundaries) without redefinition, and consumes the Interpretability contractual outputs fixed by IDS-005 without modifying them. It specializes both for the Clinical Translation domain only. Where this document does not state otherwise, the governing contract of IDS-001 or IDS-005 applies unchanged; this document does not restate their content beyond what is necessary to anchor each specialization.

In the event of apparent conflict, governance precedence is: FRAMEWORK_SPEC.md → IMPLEMENTATION_PHILOSOPHY_IDS_PHASE.md → IDS-001 → IDS-002 → IDS-003 → IDS-004 → IDS-005 → IDS-006. IDS-006 is corrected to match any higher document; it never overrides one.

**Terminal domain.** Per the locked domain roadmap (IDS-001, Section 3.1), Clinical Translation is the terminal implementation domain of the framework. Unlike IDS-002 through IDS-005, IDS-006 defines no producing-side output interface and no downstream consuming IDS document; Section 7 of this document accordingly defines only the consuming side of its single boundary.

---

## 2. Scope

IDS-006 defines only the Clinical Translation implementation domain: its internal responsibilities, its single contracted artifact, its consumption of Interpretability artifacts, its dependencies, its verification categories, and its implementation boundaries.

IDS-006 does not specify Discovery, Modeling, Validation & Benchmark, or Interpretability, except where strictly necessary to state the Interpretability → Clinical Translation interface contract from the consuming side, completing the joint contract whose producing side was fixed by IDS-005 (per IDS-001 Section 5's ownership rule, this consuming side belongs here).

---

## 3. Clinical Translation Domain Decomposition

The Clinical Translation domain corresponds to the Clinical Translation responsibility of the three-stage architecture already locked in FRAMEWORK_SPEC.md (RDR-006, Section 5): Biological Interpretation → Model Explanation → **Clinical Translation**. The Biological Interpretation and Model Explanation responsibilities of that same architecture belong to the Interpretability domain (IDS-005), per the locked domain roadmap (IDS-001, Section 3.1); they are not part of this domain's decomposition.

Consistent with the responsibility-based framing already established for Discovery (IDS-002, Section 3), Modeling (IDS-003, Section 3), Validation & Benchmark (IDS-004, Section 3), and Interpretability (IDS-005, Section 3), IDS-006 treats Clinical Translation as a set of **Clinical Translation implementation responsibilities** rather than as a fixed coding-module decomposition. Per the Clinical Translation Scope fixed in IDS-006_PREPARATION.md, this domain's responsibilities are named at the level of: clinical risk representation, clinical reporting, clinical communication, and clinical decision-support packaging — each a specialization within the Clinical Translation stage, not an additional stage beyond what FRAMEWORK_SPEC.md already locks. These responsibilities are implementation responsibilities only; per Decision 010 (LOCKED), they are not independent contractual artifacts.

Implementation may realize each responsibility in different ways — combined, further subdivided, or restructured at the Coding Module level — provided the contractual responsibilities themselves, and the domain boundary fixed by IDS-001 Section 3.1, remain intact. The contractual responsibilities specified in Section 4 remain stable even if implementation granularity evolves.

Per Decision 002 (LOCKED, IDS-006_PREPARATION.md): Clinical Translation may be internally decomposed into multiple implementation responsibilities, provided each remains entirely inside the domain boundary fixed by IDS-001, Section 3.1. The responsibilities above are recognized as the internal decomposition of contractual responsibility within this domain; each is a unit of responsibility, not an independently externally-contracted sub-domain — no responsibility exposes an artifact or interface to any domain outside Clinical Translation except at the domain's single external boundary (Section 7).

This decomposition is internal-only: it does not create additional governing IDS documents, and it does not subdivide the domain boundary itself, which remains fixed by IDS-001 Section 3.1 and closed for Framework v1.0 per IDS-001 Section 3.4.

---

## 4. Clinical Translation Responsibilities

Within its domain boundary, Clinical Translation is contractually responsible for:

- Consuming Interpretation Package(s) together with their complete Interpretation Evidence, via the Interpretability → Clinical Translation interface (Section 7).
- Performing **clinical risk representation**: rendering a consumed Interpretation Package's evidence into a form suitable for clinical consumption (e.g., risk representation deliverables such as those historically realized as a nomogram, calibration, or decision curve analysis, per FRAMEWORK_SPEC.md's Benchmarking Philosophy for this layer, RDR-006 Section 8) — as an implementation responsibility, not as separately contracted artifacts (Decision 010).
- Performing **clinical reporting**: assembling the outputs of this domain's responsibilities into the form that constitutes the Clinical Translation Package (Section 6).
- Performing **clinical communication**: ensuring the Clinical Translation Package is structured for downstream clinical consumption, consistent with FRAMEWORK_SPEC.md's treatment of clinical translatability as a design objective.
- Performing **clinical decision-support packaging**: integrating the above responsibilities into the single, complete Clinical Translation Package this domain produces.
- Per Decision 009 (LOCKED): producing clinically consumable outputs only — Clinical Translation does not generate new scientific evidence. Its responsibilities translate and package evidence already produced upstream; they do not assert, revise, or extend any scientific claim.
- Preserving complete contractual lineage from every consumed Interpretability artifact, per Decision 008 (Section 8).
- Verifying its own artifact against the categories of Section 9 before exposing it.

Clinical Translation is not contractually responsible for: any Discovery responsibility (per IDS-002 Section 3), any Modeling responsibility (per IDS-003 Section 3), any Validation & Benchmark responsibility, including candidate selection, or any Interpretability responsibility, **including scientific interpretation** (per Decision 006, LOCKED — scientific interpretation is completed exclusively within the Interpretability domain and is never performed, repeated, or revisited here).

---

## 5. Interpretability Artifact Consumption Contract

Clinical Translation's relationship to Interpretability's contracted outputs is fixed as follows:

- **Immutable artifact property and read-only contractual consumption.** Per Decision 005 (LOCKED, IDS-006_PREPARATION.md): Clinical Translation consumes Interpretability artifacts without modifying them. As established for the Validation & Benchmark → Interpretability boundary (IDS-005, Section 5), this contract has two distinct, separately held components: (1) Interpretability artifacts (Interpretation Evidence, Interpretation Package) remain immutable after production, a property of the artifact itself, per IDS-001 Section 4 and IDS-005 Section 7; and (2) Clinical Translation's act of consuming such an artifact is itself read-only — it does not edit, overwrite, annotate into, or otherwise alter any Interpretability artifact it consumes.
- **No ownership transfer.** Consuming an Interpretability artifact does not transfer producer ownership of that artifact to Clinical Translation. The Interpretability domain remains the sole, permanent producer of record for every Interpretation Evidence package and Interpretation Package, per IDS-005 Section 7's single-producer requirement and IDS-001 Section 4.
- **New artifact only.** Where Clinical Translation's responsibilities require building upon an Interpretability artifact, it produces the Clinical Translation Package (Section 6) — a new, distinct artifact — rather than altering the Interpretability artifact itself. Per Decision 007 (LOCKED): Clinical Translation produces new contractual artifacts rather than modifying Interpretability artifacts.
- **No scientific interpretation.** Per Decision 006 (LOCKED): Clinical Translation does not perform scientific interpretation. It does not revisit, re-derive, or re-decide the biological interpretation or model explanation content it receives; it consumes whatever Interpretation Package(s) it receives and translates them for clinical consumption, without altering their scientific content.
- **Consumption boundary.** Clinical Translation may consume only what crosses the Interpretability → Clinical Translation interface (Section 7) — the Interpretation Package(s) — and nothing else; it has no access to, and no contractual basis for depending on, any internal, non-exposed detail of how Interpretability produced those artifacts.

---

## 6. Clinical Translation Package

Per Decision 003 (LOCKED, IDS-006_PREPARATION.md): every Clinical Translation artifact has exactly one contractual purpose, and the authoritative contractual artifact of this domain is the **Clinical Translation Package**. Per Decision 010 (LOCKED): the clinical outputs named in Section 4 (risk representation, reporting, communication, decision-support packaging, and the deliverables historically associated with them) are responsibilities realized within this single artifact; they are not independent contractual artifacts in their own right.

- **Contractual purpose:** carries the consumed Interpretation Package's evidence forward in a form structured for clinical consumption. The Clinical Translation Package does not constitute new scientific evidence (Decision 009); it is the packaged, clinically consumable realization of evidence already produced upstream. It carries no claim of clinical deployment, regulatory clearance, or independent validation beyond what the framework's upstream domains have already established.
- **Producer:** the Clinical Translation domain, exclusively. Per Decision 004 (LOCKED) and IDS-001 Section 4 (Single-producer requirement), no other domain may produce or modify a Clinical Translation Package.
- **Consumer:** none within the scope of this document. Per the terminal-domain status fixed in Section 1, no downstream implementation domain consumes the Clinical Translation Package; its consumption by any party outside the IDS-governed implementation chain (e.g., a future Framework Integration activity, deferred under Option A) is outside the scope of this contract.
- **Contractual dependencies:** depends on exactly one originating Interpretation Package and its complete Interpretation Evidence; has no dependency on any artifact from any domain other than Interpretability, consistent with the acyclic dependency requirement of IDS-001 Section 6.
- **Verification requirements:** per Section 9 below.
- **Relationship to FRAMEWORK_SPEC:** traces directly to the Clinical Translation responsibility of the Interpretability & Clinical Translation Layer locked in FRAMEWORK_SPEC.md (RDR-006, Section 5), and to the historical Clinical Translation Extension's benchmarking scope (RDR-006, Section 8), without naming any specific deliverable as a separate artifact.
- **Multiplicity:** represented as a collection where multiple Interpretation Packages are consumed, per IDS-001 Section 4; multiplicity received from Interpretability (Section 7) is preserved and not collapsed by this domain except as an outcome of this domain's own packaging responsibility, which must remain traceable per Section 8.

No schema fields are specified here; schema definition is reserved for later implementation, downstream of IDS-006.

---

## 7. Interpretability → Clinical Translation Interface (Consuming Side)

Per IDS-001 Section 5: there is exactly one contracted interface governing this boundary — **Interpretability → Clinical Translation** — jointly defined by Interpretability (producer) and Clinical Translation (consumer). IDS-005, Section 7.3 already fixed the producing-side obligations; this section fixes the consuming-side obligations, completing the joint contract without redefining the producing side.

- Clinical Translation accepts, across this interface, only the Interpretation Package(s), exactly as exposed by Interpretability per IDS-005 Section 7.3. It does not accept, and has no contractual basis for expecting, any other artifact from Interpretability.
- Clinical Translation must verify artifact completeness (Section 9) before treating an Interpretation Package as available for consumption: an Interpretation Package lacking complete Interpretation Evidence is not considered to exist for contractual purposes (IDS-005 Section 7.2) and may not be consumed as if it were complete.
- **Contract-based rejection only.** Consistent with the principle already fixed for every prior domain boundary (IDS-003 Section 6; IDS-004 Section 6; IDS-005 Section 6): Clinical Translation may reject an Interpretation Package at the point of consumption only because its contractual requirements (Section 9 verification categories) are not satisfied — never because of scientific, biological, statistical, or implementation preference.
- Clinical Translation accepts Interpretation Package multiplicity as received: where Interpretability exposes more than one Interpretation Package, this consumption contract does not require collapsing that multiplicity before consumption. Every consumed Interpretation Package shall remain contractually traceable throughout the Clinical Translation domain; no Interpretation Package may disappear from contractual lineage (Section 8).
- **No reverse interface.** Clinical Translation supplies no artifact back into Interpretability through this or any other channel, consistent with IDS-001 Section 5 (Directionality follows FRAMEWORK_SPEC) and IDS-005 Section 7.3 (No reverse interface).
- **No downstream output interface.** Consistent with Section 1's terminal-domain statement: this document defines no producing-side interface, because Clinical Translation has no contracted consumer within the IDS-governed implementation chain. No future IDS document inherits an output contract from this domain.

---

## 8. Lineage Preservation Across the Clinical Translation Domain

Per Decision 008 (LOCKED, IDS-006_PREPARATION.md): Clinical Translation shall preserve complete contractual lineage from every consumed Interpretability artifact. Specifically:

- Every Interpretation Package consumed via Section 7 must remain contractually traceable through this domain's responsibilities (Section 4) to its resulting Clinical Translation Package (Section 6), consistent with the lineage-preservation principle already fixed for Modeling (IDS-003, Section 9), Validation & Benchmark (IDS-004, Section 10), and Interpretability (IDS-005, Section 8).
- No Interpretation Package may disappear from contractual lineage within this domain. Where an Interpretation Package is consumed, a corresponding, traceable Clinical Translation Package outcome is required.
- This lineage requirement preserves, without re-deriving, the full lineage chain already established upstream: Discovery Candidate → Model Candidate → Validated Candidate → Interpretation Package, now extended through this domain to the Clinical Translation Package, per FRAMEWORK_SPEC.md's Candidate Evolution chain.
- This is a contractual lineage requirement only; it does not verify or assert the scientific or clinical correctness of any translation produced.

---

## 9. Clinical Translation Verification

Per IDS-001 Section 7, the following framework-wide verification categories apply at this domain's boundary, specialized as follows:

1. **Contract compliance** — a Clinical Translation Package conforms to the artifact contract of Section 6; per Decision 003, no separate artifact (risk score, nomogram, calibration output, decision-curve output, or any other deliverable named in Section 4) is permitted to be exposed as if it were an independent contractual artifact.
2. **Interface compliance** — the artifact this domain consumes arrived only via the Interpretability → Clinical Translation interface (Section 7); no side-channel passage is compliant. As the terminal domain, there is no outbound interface compliance category to satisfy.
3. **Artifact completeness** — the Clinical Translation Package is complete, encompassing the clinical risk representation, clinical reporting, clinical communication, and clinical decision-support packaging responsibilities of Section 4, before it is considered to exist contractually (Section 6); inbound, this domain treats an Interpretation Package as available only once its Interpretation Evidence is itself complete (Section 7).
4. **Traceability compliance** — every Clinical Translation Package is traceable to exactly one originating Interpretation Package, and to the Clinical Translation responsibility of FRAMEWORK_SPEC.md (RDR-006, Section 5).
5. **Readiness for clinical consumption** — in place of the downstream-compatibility category used by prior domains (which presumes a consuming domain), this terminal category requires that the Clinical Translation Package be structurally complete and self-contained for clinical consumption, without requiring undocumented transformation by any party that subsequently uses it.
6. **Lineage preservation** — consistent with the principle already fixed for Modeling (IDS-003, Section 9), Validation & Benchmark (IDS-004, Section 10), and Interpretability (IDS-005, Section 9): verification shall explicitly verify that artifact lineage is preserved throughout this domain (Section 8); no Interpretation Package consumed via Section 7 may disappear from contractual lineage. This verification concerns contractual lineage only; it does not verify scientific correctness of the lineage's content.

No verification *procedure* (statistical method, nomogram construction method, calibration procedure, decision curve analysis procedure) is specified here; only the categories and completeness/traceability/readiness requirements a procedure must eventually satisfy.

**Verification scope.** Verification performed under IDS-006 verifies implementation contracts, contractual completeness, contractual traceability, and contractual interface compliance — the six categories above. It does not verify scientific validity, biological validity, statistical validity, clinical validity, or methodological correctness of any Clinical Translation output. Those forms of validity belong to the scientific framework (FRAMEWORK_SPEC.md and the RDR chain) rather than to this implementation specification, consistent with the verification-scope principle already fixed for Discovery (IDS-002, Section 8), Modeling (IDS-003, Section 9), Validation & Benchmark (IDS-004, Section 10), and Interpretability (IDS-005, Section 9).

---

## 10. Clinical Translation Implementation Boundaries

Inherited unchanged from IDS-001, Section 9, and restated here only as a domain-scoped reminder — not a re-specification:

IDS-006 does not introduce, and no Clinical Translation Coding Module specification may introduce at this design stage:

- Algorithms, statistical methods, nomogram construction methods, calibration procedures, or decision curve analysis procedures of any kind.
- Risk score computation methods, risk stratification algorithms, or reporting templates.
- Software packages, libraries, or frameworks.
- Programming languages or execution environments.
- Executable code of any form.
- Any scientific or methodological decision not already locked in FRAMEWORK_SPEC.md (RDR-006).

These boundaries apply to all Clinical Translation implementation responsibilities of Section 4 equally; no responsibility within this domain is exempt.

---

## 11. Clinical Translation Dependencies

- Clinical Translation's production depends contractually on exactly one upstream artifact: the completed, complete Interpretation Package(s), received via Section 7. As the terminal domain, it has no contractual dependency on any domain downstream of itself, because no such domain exists within the IDS-governed implementation chain.
- Clinical Translation's only internal dependency is on its own internally complete set of contractual responsibilities (Section 4): a Clinical Translation Package may not be considered to exist until those responsibilities have produced a complete result for the corresponding Interpretation Package.
- Per IDS-001 Section 6 (Dependency scope is limited to contracted artifacts): Clinical Translation depends on Interpretability satisfying its artifact contract (IDS-005, Section 7) — never on any detail of how Interpretability's Coding Module performed biological interpretation or model explanation. This domain's internal responsibilities are not themselves an inter-domain dependency and are not subject to external contractual constraint; they depend only on this domain's own upstream internal outputs, never on runtime state, execution environment, or undocumented side effects of any tooling.
- Clinical Translation imposes no dependency, in turn, that Interpretability must satisfy; Interpretability's production proceeds independently of whether or how Clinical Translation consumes its output (IDS-005, Section 11).

---

## 12. Traceability

| IDS-006 Section | Originating Decision | Framework Authority | Current Clinical Translation Contract |
|---|---|---|---|
| §3 Domain Decomposition | IDS-006_PREPARATION Decisions 002, 010 | FRAMEWORK_SPEC.md (RDR-006 §5, Clinical Translation scope) | IDS-001 §3.1, §3.2, §3.4 |
| §4 Responsibilities | IDS-006_PREPARATION (Clinical Translation Scope); Decision 009 | FRAMEWORK_SPEC.md (RDR-006 §5, §8) | IDS-001 §4 |
| §5 Interpretability Artifact Consumption | IDS-006_PREPARATION Decisions 005, 006, 007 | FRAMEWORK_SPEC.md (RDR-006 §7) | IDS-001 §4; IDS-005 §5, §7 |
| §6 Clinical Translation Package | IDS-006_PREPARATION Decisions 003, 010 | FRAMEWORK_SPEC.md (RDR-006 §5, §8) | IDS-001 §4 |
| §7 Interpretability → Clinical Translation Interface (consuming side) | IDS-006_PREPARATION Decision 005 | FRAMEWORK_SPEC.md (RDR-006 §6, layer boundary) | IDS-001 §5; IDS-005 §7.3 (producing side) |
| §8 Lineage Preservation | IDS-006_PREPARATION Decision 008 | FRAMEWORK_SPEC.md (Candidate Evolution chain) | IDS-003 §9; IDS-004 §10; IDS-005 §8 |
| §9 Verification | IDS-006_PREPARATION (Clinical Translation Verification) | FRAMEWORK_SPEC.md (RDR-006 §7) | IDS-001 §7 |
| §10 Implementation Boundaries | IDS-006_PREPARATION (Implementation Boundaries) | FRAMEWORK_SPEC.md §1.3 (Architecture Invariants) | IDS-001 §9 |
| §11 Dependencies | IDS-006_PREPARATION (Scope) | FRAMEWORK_SPEC.md (Candidate Evolution sequencing) | IDS-001 §6 |

No section of this document introduces content without an entry in this table.

---

## 13. Governance Status

**Status:** DRAFT — Phase B, pending Strategist Review and Project Coordinator approval/lock.
**Implementation:** NOT PERMITTED.

This document does not become a binding specialization of IDS-001's and IDS-005's contracts until it is explicitly locked.

---

## 14. Exit Criteria

IDS-006 may be locked only when:

1. Strategist Review confirms no algorithm, statistical method, nomogram/calibration/decision-curve procedure, technology, or scientific/methodological decision has been introduced.
2. Every framework-wide contract and Interpretability contract referenced (Sections 5–9) is confirmed as a specialization, not a redefinition, of IDS-001 or IDS-005.
3. Section 12's traceability table is confirmed complete, with no orphaned content.
4. Project Coordinator grants explicit approval and lock.

This document is returned for Strategist Review only. No IDS-006_CLOSURE.md is generated and no IMPLEMENTATION_MASTER_PLAN.md drafting begins as part of this action.
