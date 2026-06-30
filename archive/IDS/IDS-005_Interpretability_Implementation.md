# IDS-005_Interpretability_Implementation.md

**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework
**Document Type:** Implementation Design Specification (Domain-Level — Interpretability)
**Governed by (authoritative, immutable, in precedence order):** FRAMEWORK_SPEC.md → IMPLEMENTATION_PHILOSOPHY_IDS_PHASE.md → IDS-001_Framework_Implementation.md (LOCKED) → IDS-002_Discovery_Implementation.md (LOCKED) → IDS-003_Modeling_Implementation.md (LOCKED) → IDS-004_Validation_Benchmark_Implementation.md (LOCKED) → IDS-005_PREPARATION.md (LOCKED, Design Lock)
**Status:** DRAFT — Phase B, pending Strategist Review
**Implementation:** NOT PERMITTED (this document specifies contracts, not code)

---

## 1. Document Purpose

IDS-005 is the domain-specific Implementation Design Specification for the **Interpretability implementation domain**, as identified in IDS-001, Section 3.1. It translates the scientific-interpretation scope of the Interpretability & Clinical Translation Layer already locked in FRAMEWORK_SPEC.md (RDR-006) into implementation contracts, covering the Biological Interpretation and Model Explanation responsibilities. The Clinical Translation responsibility of that same Layer is out of scope here and reserved for IDS-006.

IDS-005 inherits every framework-wide contract fixed by IDS-001 (Artifact, Interface, Dependency, Verification contracts; Cross-Cutting Implementation Principles; Implementation Boundaries) without redefinition, and consumes the Validation & Benchmark contractual outputs fixed by IDS-004 without modifying them. It specializes both for the Interpretability domain only. Where this document does not state otherwise, the governing contract of IDS-001 or IDS-004 applies unchanged; this document does not restate their content beyond what is necessary to anchor each specialization.

In the event of apparent conflict, governance precedence is: FRAMEWORK_SPEC.md → IMPLEMENTATION_PHILOSOPHY_IDS_PHASE.md → IDS-001 → IDS-002 → IDS-003 → IDS-004 → IDS-005. IDS-005 is corrected to match any higher document; it never overrides one.

---

## 2. Scope

IDS-005 defines only the Interpretability implementation domain: its internal responsibilities, its contracted artifacts, its consumption of Validation & Benchmark artifacts, its interface to Clinical Translation, its dependencies, its verification categories, and its implementation boundaries.

IDS-005 does not specify Discovery, Modeling, Validation & Benchmark, or Clinical Translation, except where strictly necessary to state: (a) the Validation & Benchmark → Interpretability interface contract from the consuming side, completing the joint contract whose producing side was fixed by IDS-004 (per IDS-001 Section 5's ownership rule, this consuming side belongs here); and (b) the Interpretability → Clinical Translation interface contract from the producing side only, whose consuming side is reserved for IDS-006.

---

## 3. Interpretability Domain Decomposition

The Interpretability domain corresponds to the Biological Interpretation and Model Explanation responsibilities of the three-stage architecture already locked in FRAMEWORK_SPEC.md (RDR-006, Section 5): Biological Interpretation → Model Explanation → Clinical Translation. The Clinical Translation responsibility of that same architecture belongs to the Clinical Translation domain (IDS-006), per the locked domain roadmap (IDS-001, Section 3.1); it is not part of this domain's decomposition.

Consistent with the responsibility-based framing already established for Discovery (IDS-002, Section 3), Modeling (IDS-003, Section 3), and Validation & Benchmark (IDS-004, Section 3), IDS-005 treats Biological Interpretation and Model Explanation as **Interpretability implementation responsibilities** rather than as a fixed coding-module decomposition: each names a coherent unit of contractual responsibility that this domain must fulfill, not a prescribed sequence of executable components. Per the Scientific Interpretation Scope fixed in IDS-005_PREPARATION.md, this domain's responsibilities are further named at the level of: model explanation, feature interpretation, biological interpretation, and evidence integration — each a specialization within the Biological Interpretation / Model Explanation pairing, not an additional stage beyond what FRAMEWORK_SPEC.md already locks.

Implementation may realize each responsibility in different ways — combined, further subdivided, or restructured at the Coding Module level — provided the contractual responsibilities themselves, and the domain boundary fixed by IDS-001 Section 3.1, remain intact. The contractual responsibilities specified in Section 4 remain stable even if implementation granularity evolves.

Per Decision 002 (LOCKED, IDS-005_PREPARATION.md): Interpretability may be internally decomposed into multiple implementation responsibilities, provided each remains entirely inside the domain boundary fixed by IDS-001, Section 3.1. The responsibilities above are recognized as the internal decomposition of contractual responsibility within this domain; each is a unit of responsibility, not an independently externally-contracted sub-domain — no responsibility exposes an artifact or interface to any domain outside Interpretability except at the domain's two external boundaries (Sections 6 and 7).

This decomposition is internal-only: it does not create additional governing IDS documents, and it does not subdivide the domain boundary itself, which remains fixed by IDS-001 Section 3.1 and closed for Framework v1.0 per IDS-001 Section 3.4.

---

## 4. Interpretability Responsibilities

Within its domain boundary, Interpretability is contractually responsible for:

- Consuming Validated Candidates together with their complete Validation Evidence (and Benchmark Evidence, where produced), via the Validation & Benchmark → Interpretability interface (Section 6).
- Performing **biological interpretation**: producing Interpretation Evidence components that document the biological interpretation of a consumed Validated Candidate, per the Biological Interpretation responsibility already locked in FRAMEWORK_SPEC.md (RDR-006, Section 5).
- Performing **model explanation**: producing Interpretation Evidence components that document the model-explanation aspects of a consumed Validated Candidate, including feature interpretation, per the Model Explanation responsibility already locked in FRAMEWORK_SPEC.md (RDR-006, Section 5).
- Performing **evidence integration**: assembling the biological interpretation and model explanation components into a complete Interpretation Evidence package, and producing the Interpretation Package (Section 7) that carries the Validated Candidate forward together with that evidence.
- Preserving the locked governance principle that no new candidate type is created: per FRAMEWORK_SPEC.md (RDR-006, "No new candidate type is created"), the Validated Candidate this domain consumes and the Validated Candidate it carries forward (within the Interpretation Package) remain scientifically and architecturally the same Validated Candidate; this domain's responsibilities enrich it with evidence, never replace or supersede it.
- Preserving complete contractual lineage from every consumed Validation & Benchmark artifact, per Decision 008 (Section 8).
- Verifying its own artifacts against the categories of Section 9 before exposing them.
- Exposing its output only through the single contracted Interpretability → Clinical Translation interface (Section 7); Interpretability holds no other contractual responsibility toward any other domain.

Interpretability is not contractually responsible for: any Discovery responsibility (per IDS-002 Section 3), any Modeling responsibility (per IDS-003 Section 3), any Validation & Benchmark responsibility, **including candidate selection** (per Decision 006, LOCKED — candidate selection is completed exclusively within the Validation & Benchmark domain and is never performed, repeated, or revisited here), or any Clinical Translation responsibility (per IDS-006, reserved).

---

## 5. Validation & Benchmark Artifact Consumption Contract

Interpretability's relationship to Validation & Benchmark's contracted outputs is fixed as follows:

- **Immutable artifact property and read-only contractual consumption.** Per Decision 005 (LOCKED, IDS-005_PREPARATION.md): Interpretability consumes Validation & Benchmark artifacts without modifying them. As established for the Modeling → Validation & Benchmark boundary (IDS-004, Section 5), this contract has two distinct, separately held components: (1) Validation & Benchmark artifacts (Validated Candidate, Validation Evidence, Benchmark Evidence) remain immutable after production, a property of the artifact itself, per IDS-001 Section 4 and IDS-004 Section 7; and (2) Interpretability's act of consuming such an artifact is itself read-only — it does not edit, overwrite, annotate into, or otherwise alter any Validation & Benchmark artifact it consumes.
- **No ownership transfer.** Consuming a Validation & Benchmark artifact does not transfer producer ownership of that artifact to Interpretability. The Validation & Benchmark domain remains the sole, permanent producer of record for every Validated Candidate, its Validation Evidence, and its Benchmark Evidence, per IDS-004 Section 7's single-producer requirement and IDS-001 Section 4.
- **New artifacts only.** Where Interpretability's responsibilities require building upon a Validation & Benchmark artifact, it produces new, distinct Interpretability artifacts (Interpretation Evidence, Interpretation Package; Section 7) rather than altering the Validation & Benchmark artifact itself. Per Decision 007 (LOCKED): interpretation produces new contractual artifacts rather than modifying Validation & Benchmark artifacts.
- **No candidate selection.** Per Decision 006 (LOCKED): Interpretability does not perform candidate selection. It does not revisit, re-evaluate, or re-decide which Validated Candidate(s) were carried forward by Validation & Benchmark; it consumes whatever Validated Candidate(s) it receives and enriches them, without altering the selection outcome that produced them.
- **Consumption boundary.** Interpretability may consume only what crosses the Validation & Benchmark → Interpretability interface (Section 6) — the Validated Candidate(s) together with their complete Validation Evidence (and Benchmark Evidence, where produced) — and nothing else; it has no access to, and no contractual basis for depending on, any internal, non-exposed detail of how Validation & Benchmark produced those artifacts.

---

## 6. Validation & Benchmark → Interpretability Interface (Consuming Side)

Per IDS-001 Section 5: there is exactly one contracted interface governing this boundary — **Validation & Benchmark → Interpretability** — jointly defined by Validation & Benchmark (producer) and Interpretability (consumer). IDS-004, Section 7.4 already fixed the producing-side obligations; this section fixes the consuming-side obligations, completing the joint contract without redefining the producing side.

- Interpretability accepts, across this interface, only the Validated Candidate(s) together with their complete Validation Evidence (and Benchmark Evidence, where produced), exactly as exposed by Validation & Benchmark per IDS-004 Section 7.4. It does not accept, and has no contractual basis for expecting, any other artifact from Validation & Benchmark.
- Interpretability must verify artifact completeness (Section 9) before treating a Validated Candidate as available for consumption: a Validated Candidate lacking complete Validation Evidence is not considered to exist for contractual purposes (IDS-004 Section 7.3) and may not be consumed as if it were complete.
- **Contract-based rejection only.** Consistent with the principle already fixed for the Discovery → Modeling and Modeling → Validation & Benchmark boundaries (IDS-003 Section 6; IDS-004 Section 6): Interpretability may reject a Validated Candidate at the point of consumption only because its contractual requirements (Section 9 verification categories) are not satisfied — never because of scientific, biological, statistical, or implementation preference.
- Interpretability accepts Validated Candidate multiplicity as received: where Validation & Benchmark exposes more than one Validated Candidate, this consumption contract does not require collapsing that multiplicity before consumption. Every consumed Validated Candidate shall remain contractually traceable throughout the Interpretability domain; no Validated Candidate may disappear from contractual lineage (Section 8).
- **No reverse interface.** Interpretability supplies no artifact back into Validation & Benchmark through this or any other channel, consistent with IDS-001 Section 5 (Directionality follows FRAMEWORK_SPEC) and IDS-004 Section 7.4 (No reverse interface).

---

## 7. Interpretability Artifacts and the Interpretability → Clinical Translation Interface

Per Decision 003 (LOCKED, IDS-005_PREPARATION.md): every Interpretability artifact has exactly one contractual purpose; Interpretation Evidence and Interpretation Package are distinct artifacts; no hybrid artifact is permitted.

### 7.1 Interpretation Evidence

- **Contractual purpose:** the standardized evidence package documenting the biological interpretation and model explanation (including feature interpretation) of a consumed Validated Candidate, assembled through this domain's evidence-integration responsibility (Section 4). Interpretation Evidence is the Interpretability-domain component of the Enrichment Evidence already locked in FRAMEWORK_SPEC.md (RDR-006, Section 7); it extends, rather than replaces or duplicates, the Validation Evidence it builds upon, consistent with the locked principle that Enrichment Evidence extends rather than replaces Validation Evidence (RDR-006).
- **Contractual existence only:** IDS-005 specifies only that Interpretation Evidence must exist, as a complete package, for every Validated Candidate this domain processes — not its internal schema. The components that constitute "complete" (biological interpretation evidence, model explanation evidence) are already named in FRAMEWORK_SPEC.md (RDR-006, Section 7); IDS-005 references that definition rather than re-enumerating, re-deriving, or specializing it. Schema definition is explicitly deferred to later implementation activity, downstream of this document.
- **Producer:** the Interpretability domain, exclusively.
- **Consumer:** the Clinical Translation domain (IDS-006), via the Interpretability → Clinical Translation interface below, as part of the Interpretation Package.
- **Contractual dependencies:** depends on the completed Validated Candidate and its Validation Evidence; cannot exist in advance of, or independently from, that Candidate.
- **Verification requirements:** per Section 9 below.
- **Relationship to FRAMEWORK_SPEC:** traces directly to the Enrichment Evidence definition locked in FRAMEWORK_SPEC.md (RDR-006, Section 7), restricted to its biological interpretation and model explanation components.

### 7.2 Interpretation Package

- **Contractual purpose:** carries the consumed Validated Candidate forward together with its complete Interpretation Evidence. Per FRAMEWORK_SPEC.md (RDR-006, "No new candidate type is created"), the Interpretation Package does not constitute a new candidate type: the Validated Candidate inside it remains scientifically and architecturally the same Validated Candidate that entered this domain, with its Model Candidate and Discovery Candidate lineage unchanged and fully traceable. The Interpretation Package is the contractual unit by which this domain exposes its work; it is not itself a Candidate.
- **Producer:** the Interpretability domain, exclusively. Per Decision 004 (LOCKED) and IDS-001 Section 4 (Single-producer requirement), no other domain may produce or modify an Interpretation Package.
- **Consumer:** the Clinical Translation domain (IDS-006), via the Interpretability → Clinical Translation interface below.
- **Contractual dependencies:** depends on exactly one originating Validated Candidate and its complete Interpretation Evidence; has no dependency on any artifact from Clinical Translation, consistent with the acyclic dependency requirement of IDS-001 Section 6.
- **Verification requirements:** per Section 9 below.
- **Relationship to FRAMEWORK_SPEC:** traces directly to the Validated Candidate together with Enrichment Evidence, as locked in FRAMEWORK_SPEC.md (RDR-006, Sections 5 and 7).
- **Multiplicity:** represented as a collection, per IDS-001 Section 4; multiplicity received from Validation & Benchmark (Section 6) is preserved and not collapsed by this domain.

No schema fields are specified for any artifact in this section; schema definition is reserved for later implementation, downstream of IDS-005.

### 7.3 Interpretability → Clinical Translation Interface (Producing Side)

This document fixes the producing-side contractual obligations of the Interpretability → Clinical Translation interface; the consuming-side obligations are reserved for IDS-006, per IDS-001 Section 5's ownership rule.

- Interpretability exposes, across this interface, the Interpretation Package(s) (Section 7.2) — and no other artifact.
- This is Interpretability's only externally contracted output interface. It exposes no interface, direct or indirect, to any domain other than Clinical Translation.
- **No reverse interface.** No domain may supply an input back into Interpretability through this or any other channel; this domain's only domain input is the Validation & Benchmark → Interpretability interface (Section 6). This is consistent with IDS-001 Section 5 (Directionality follows FRAMEWORK_SPEC).
- Per Decision 004 (LOCKED): Clinical Translation consumes Interpretability artifacts; it never becomes their producer. This domain's producer ownership over the Interpretation Evidence and Interpretation Package is exclusive and is not transferred, shared, or reassigned at the point of consumption.

---

## 8. Lineage Preservation Across the Interpretability Domain

Per Decision 008 (LOCKED, IDS-005_PREPARATION.md): interpretation shall preserve complete contractual lineage from every consumed Validation & Benchmark artifact. Specifically:

- Every Validated Candidate consumed via Section 6 must remain contractually traceable through this domain's responsibilities (Section 4) to its resulting Interpretation Package (Section 7.2), consistent with the lineage-preservation principle already fixed for Modeling (IDS-003, Section 9) and Validation & Benchmark (IDS-004, Section 10).
- No Validated Candidate may disappear from contractual lineage within this domain. Where a Validated Candidate is consumed, a corresponding, traceable Interpretation Package outcome is required.
- This lineage requirement preserves, without re-deriving, the full lineage chain already established upstream: Discovery Candidate → Model Candidate → Validated Candidate, now extended through this domain to the Interpretation Package, per FRAMEWORK_SPEC.md's Candidate Evolution chain.
- This is a contractual lineage requirement only; it does not verify or assert the scientific correctness of any interpretation produced.

---

## 9. Interpretability Verification

Per IDS-001 Section 7, the following framework-wide verification categories apply at this domain's boundaries, specialized as follows:

1. **Contract compliance** — an Interpretation Evidence package and its Interpretation Package each conform to the artifact contracts of Section 7; no hybrid artifact (Decision 003) is permitted to pass this check.
2. **Interface compliance** — inbound: the artifact this domain consumes arrived only via the Validation & Benchmark → Interpretability interface (Section 6); outbound: the artifact it exposes reaches Clinical Translation only via the Interpretability → Clinical Translation interface (Section 7.3); no side-channel passage in either direction is compliant.
3. **Artifact completeness** — Interpretation Evidence is complete, per the biological interpretation and model explanation components already defined in FRAMEWORK_SPEC.md (RDR-006, Section 7), for every Validated Candidate processed, before a corresponding Interpretation Package is considered to exist contractually (Section 7.2); inbound, this domain treats a Validated Candidate as available only once its Validation Evidence is itself complete (Section 6).
4. **Traceability compliance** — every Interpretation Package and its Interpretation Evidence are traceable to exactly one originating Validated Candidate, and to the Enrichment Evidence definition of FRAMEWORK_SPEC.md (RDR-006, Sections 5 and 7).
5. **Downstream compatibility (downstream readiness)** — Interpretation Packages and their evidence are structurally usable by Clinical Translation without requiring undocumented transformation.
6. **Lineage preservation** — consistent with the principle already fixed for Modeling (IDS-003, Section 9) and Validation & Benchmark (IDS-004, Section 10): verification shall explicitly verify that artifact lineage is preserved throughout this domain (Section 8); no Validated Candidate consumed via Section 6 may disappear from contractual lineage. This verification concerns contractual lineage only; it does not verify scientific correctness of the lineage's content.

No verification *procedure* (statistical test, computational check, explainability method, pathway analysis method, enrichment method) is specified here; only the categories and completeness/traceability/readiness requirements a procedure must eventually satisfy.

**Verification scope.** Verification performed under IDS-005 verifies implementation contracts, contractual completeness, contractual traceability, and contractual interface compliance — the six categories above. It does not verify scientific validity, biological validity, statistical validity, or methodological correctness of any interpretation produced. Those forms of validity belong to the scientific framework (FRAMEWORK_SPEC.md and the RDR chain) rather than to this implementation specification, consistent with the verification-scope principle already fixed for Discovery (IDS-002, Section 8), Modeling (IDS-003, Section 9), and Validation & Benchmark (IDS-004, Section 10).

---

## 10. Interpretability Implementation Boundaries

Inherited unchanged from IDS-001, Section 9, and restated here only as a domain-scoped reminder — not a re-specification:

IDS-005 does not introduce, and no Interpretability Coding Module specification may introduce at this design stage:

- Algorithms, explainability methods, pathway analysis methods, or enrichment methods of any kind.
- Biological interpretation methodology, statistical interpretation procedures, or implementation workflows.
- Software packages, libraries, or frameworks.
- Programming languages or execution environments.
- Executable code of any form.
- Any scientific or methodological decision not already locked in FRAMEWORK_SPEC.md (RDR-006).

These boundaries apply to all Interpretability implementation responsibilities of Section 3 equally, including evidence integration (Section 4); no responsibility within this domain is exempt.

---

## 11. Interpretability Dependencies

- Interpretability's production depends contractually on exactly one upstream artifact pairing: the completed, complete Validated Candidate(s) together with their Validation Evidence (and Benchmark Evidence, where produced), received via Section 6. It has no contractual dependency, of any kind, on Clinical Translation, consistent with the acyclic, unidirectional dependency graph fixed by IDS-001 Section 6.
- **Explicit no-dependency statement:** Interpretability has no contractual dependency on Clinical Translation. This is stated here as an explicit contractual property, not left as an implied consequence of domain ordering, consistent with the explicit no-dependency statements already fixed for Discovery (IDS-002, Section 7), Modeling (IDS-003, Section 8), and Validation & Benchmark (IDS-004, Section 9).
- **No dependency on downstream decisions.** Interpretability has no contractual dependency upon any Clinical Translation decision. Clinical Translation's outcomes shall never influence Interpretability's contractual responsibilities, its artifact contracts (Section 7), or its verification categories (Section 9); this domain's production is complete and contractually valid independent of whatever Clinical Translation subsequently produces.
- Interpretability's only internal dependency is on its own internally complete set of contractual responsibilities (Section 4): an Interpretation Package may not be exposed across the Section 7.3 interface until those responsibilities have produced a complete result for the corresponding Validated Candidate.
- Per IDS-001 Section 6 (Dependency scope is limited to contracted artifacts): Interpretability depends on Validation & Benchmark satisfying its artifact contract (IDS-004, Section 7) — never on any detail of how Validation & Benchmark's Coding Module computed that artifact, including how candidate selection was performed. This domain's internal responsibilities are not themselves an inter-domain dependency and are not subject to external contractual constraint; they depend only on this domain's own upstream internal outputs, never on runtime state, execution environment, or undocumented side effects of any tooling.
- Interpretability imposes no dependency, in turn, that Validation & Benchmark must satisfy; Validation & Benchmark's production proceeds independently of whether or how Interpretability consumes its output (IDS-004, Section 9).

---

## 12. Traceability

| IDS-005 Section | Originating Decision | Framework Authority | Current Interpretability Contract |
|---|---|---|---|
| §3 Domain Decomposition | IDS-005_PREPARATION Decision 002 | FRAMEWORK_SPEC.md (RDR-006 §5, three-stage architecture, Interpretability scope) | IDS-001 §3.1, §3.2, §3.4 |
| §4 Responsibilities | IDS-005_PREPARATION (Scientific Interpretation Scope) | FRAMEWORK_SPEC.md (RDR-006 §5, §7, "No new candidate type") | IDS-001 §4 |
| §5 Validation Artifact Consumption | IDS-005_PREPARATION Decisions 005, 006, 007 | FRAMEWORK_SPEC.md (RDR-006 §7) | IDS-001 §4; IDS-004 §5, §7 |
| §6 Validation → Interpretability Interface (consuming side) | IDS-005_PREPARATION Decision 005 | FRAMEWORK_SPEC.md (RDR-005 §9) | IDS-001 §5; IDS-004 §7.4 (producing side) |
| §7 Artifacts & Interface | IDS-005_PREPARATION Decisions 003, 004, 007 | FRAMEWORK_SPEC.md (RDR-006 §5, §7) | IDS-001 §4, §5 |
| §8 Lineage Preservation | IDS-005_PREPARATION Decision 008 | FRAMEWORK_SPEC.md (Candidate Evolution chain) | IDS-003 §9; IDS-004 §10 |
| §9 Verification | IDS-005_PREPARATION (Interpretability Verification) | FRAMEWORK_SPEC.md (RDR-006 §7) | IDS-001 §7 |
| §10 Implementation Boundaries | IDS-005_PREPARATION (Implementation Boundaries) | FRAMEWORK_SPEC.md §1.3 (Architecture Invariants) | IDS-001 §9 |
| §11 Dependencies | IDS-005_PREPARATION (Scope) | FRAMEWORK_SPEC.md (Candidate Evolution sequencing) | IDS-001 §6 |

No section of this document introduces content without an entry in this table.

---

## 13. Governance Status

**Status:** DRAFT — Phase B, pending Strategist Review and Project Coordinator approval/lock.
**Implementation:** NOT PERMITTED.

This document does not become a binding specialization of IDS-001's and IDS-004's contracts until it is explicitly locked.

---

## 14. Exit Criteria

IDS-005 may be locked only when:

1. Strategist Review confirms no algorithm, explainability method, pathway analysis method, enrichment method, technology, or scientific/methodological decision has been introduced.
2. Every framework-wide contract and Validation & Benchmark contract referenced (Sections 5–9) is confirmed as a specialization, not a redefinition, of IDS-001 or IDS-004.
3. Section 12's traceability table is confirmed complete, with no orphaned content.
4. Project Coordinator grants explicit approval and lock.

This document is returned for Strategist Review only. No IDS-005_CLOSURE.md is generated and no IDS-006 drafting begins as part of this action.
