# IDS-003_Modeling_Implementation.md

**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework
**Document Type:** Implementation Design Specification (Domain-Level — Modeling)
**Governed by (authoritative, immutable, in precedence order):** FRAMEWORK_SPEC.md → IMPLEMENTATION_PHILOSOPHY_IDS_PHASE.md → IDS-001_Framework_Implementation.md (LOCKED) → IDS-002_Discovery_Implementation.md (LOCKED) → IDS-003_PREPARATION.md (LOCKED, Design Lock)
**Status:** LOCKED
**Implementation:** NOT PERMITTED (this document specifies contracts, not code)

---

## 1. Document Purpose

IDS-003 is the domain-specific Implementation Design Specification for the **Modeling implementation domain**, as identified in IDS-001, Section 3.1. It translates the Modeling Layer already locked in FRAMEWORK_SPEC.md into implementation contracts.

IDS-003 inherits every framework-wide contract fixed by IDS-001 (Artifact, Interface, Dependency, Verification contracts; Cross-Cutting Implementation Principles; Implementation Boundaries) without redefinition, and consumes the Discovery contractual outputs fixed by IDS-002 without modifying them. It specializes both for the Modeling domain only. Where this document does not state otherwise, the governing contract of IDS-001 or IDS-002 applies unchanged; this document does not restate their content beyond what is necessary to anchor each specialization.

In the event of apparent conflict, governance precedence is: FRAMEWORK_SPEC.md → IMPLEMENTATION_PHILOSOPHY_IDS_PHASE.md → IDS-001 → IDS-002 → IDS-003. IDS-003 is corrected to match any higher document; it never overrides one.

---

## 2. Scope

IDS-003 defines only the Modeling implementation domain: its internal responsibilities, its contracted artifacts, its consumption of Discovery artifacts, its interface to Validation & Benchmark, its dependencies, its verification categories, and its implementation boundaries.

IDS-003 does not specify Discovery, Validation & Benchmark, Interpretability, or Clinical Translation, except where strictly necessary to state: (a) the Discovery → Modeling interface contract from the consuming side, completing the joint contract whose producing side was fixed by IDS-002 (per IDS-001 Section 5's ownership rule, this consuming side belongs here); and (b) the Modeling → Validation & Benchmark interface contract from the producing side only, whose consuming side is reserved for IDS-004.

---

## 3. Modeling Domain Decomposition

The Modeling domain corresponds to the Modeling decomposition already locked in FRAMEWORK_SPEC.md (RDR-004, Section 5): Discovery Candidate → Representation → Prediction → Risk Estimation → Model Candidate. Consistent with the responsibility-based framing established for Discovery (IDS-002, Section 3), IDS-003 treats these as **Modeling implementation responsibilities** rather than as a fixed coding-module decomposition: each names a coherent unit of contractual responsibility that Modeling must fulfill, not a prescribed sequence of executable components.

Implementation may realize each responsibility in different ways — combined, further subdivided, or restructured at the Coding Module level — provided the contractual responsibilities themselves, and the domain boundary fixed by IDS-001 Section 3.1, remain intact. The contractual responsibilities specified in Section 4 remain stable even if implementation granularity evolves; a change in how many Coding Modules realize these responsibilities, or in their internal sequencing, is an implementation detail and does not require revision of this document.

Per Decision 002 (LOCKED, IDS-003_PREPARATION.md): Modeling may be internally decomposed into multiple implementation responsibilities, provided each remains entirely inside the Modeling domain boundary fixed by IDS-001, Section 3.1. The responsibilities above are recognized as the internal decomposition of contractual responsibility within this domain; each is a unit of responsibility, not an independently externally-contracted sub-domain — no responsibility exposes an artifact or interface to any domain outside Modeling except at the domain's two external boundaries (Sections 6 and 7).

This decomposition is internal-only: it does not create additional governing IDS documents, and it does not subdivide the domain boundary itself, which remains fixed by IDS-001 Section 3.1 and closed for Framework v1.0 per IDS-001 Section 3.4.

---

## 4. Modeling Responsibilities

Within its domain boundary, Modeling is contractually responsible for:

- Consuming Discovery artifacts (Discovery Candidate(s) together with their complete Discovery Evidence) via the Discovery → Modeling interface (Section 6), and producing one or more Model Candidates, per FRAMEWORK_SPEC.md's Modeling Boundary (RDR-004).
- Producing complete Modeling Evidence **for every Model Candidate** it produces, per the Model Candidate Definition already locked in FRAMEWORK_SPEC.md (RDR-004, Section 7) — mirroring the one-to-one relationship between Discovery Candidate and Discovery Evidence already established in IDS-002. No Model Candidate may be exposed without complete, corresponding Modeling Evidence.
- Preserving Model Candidate multiplicity: per FRAMEWORK_SPEC.md (RDR-004, Section 9) and IDS-001 Section 4 (Multiplicity accommodation), multiplicity of Model Candidates is the expected default — Modeling's contractual responsibility includes representing and retaining all such candidates, not selecting among them. Selection among Model Candidates is explicitly excluded from Modeling's responsibility and belongs exclusively to the Validation & Benchmark domain, never to Modeling itself.
- Preserving Modeling Provenance: maintaining the stage-by-stage lineage from the originating Discovery Candidate, through Modeling's internal responsibilities (Section 3), to each resulting Model Candidate, fully traceable and reconstructable from documented evidence, per FRAMEWORK_SPEC.md (RDR-004, Section 6 subsection).
- Verifying its own artifacts against the categories of Section 8 before exposing them.
- Exposing its output only through the single contracted Modeling → Validation & Benchmark interface (Section 7); Modeling holds no other contractual responsibility toward any other domain.

Modeling is not contractually responsible for: any Discovery responsibility (statistical discovery, multiple testing/filtering, cross-cohort integration, or any other Discovery internal responsibility, per IDS-002 Section 3), and any responsibility belonging to Validation & Benchmark, Interpretability, or Clinical Translation, including selection among Model Candidates.

---

## 5. Discovery Artifact Consumption Contract

Modeling's relationship to Discovery's contracted outputs is fixed as follows:

- **Immutable consumption.** Per Decision 005 (LOCKED, IDS-003_PREPARATION.md): Modeling consumes Discovery artifacts without modifying them. This contract has two distinct components, kept explicit rather than conflated: (1) **immutable artifact property** — Discovery artifacts (Discovery Candidate, Discovery Evidence) remain immutable after production, a property of the artifact itself, consistent with the Immutability-after-handoff rule already fixed in IDS-001, Section 4, and restated in IDS-002, Section 5.1–5.2; and (2) **read-only contractual consumption** — Modeling's act of consuming a Discovery artifact is itself read-only: Modeling does not edit, overwrite, annotate into, or otherwise alter any Discovery artifact it consumes, regardless of what the artifact's own immutability would in any case prevent. The artifact's immutability and Modeling's read-only consumption discipline are two separate contractual guarantees, not one.
- **No ownership transfer.** Consuming a Discovery artifact does not transfer producer ownership of that artifact to Modeling, and read-only consumption never permits modification under any circumstance. The Discovery domain remains the sole, permanent producer of record for every Discovery Candidate and its Discovery Evidence, per IDS-002 Section 5's single-producer requirement and IDS-001 Section 4.
- **New artifacts only.** Where Modeling's responsibilities require building upon a Discovery artifact, Modeling produces a new, distinct Modeling artifact (Model Candidate or Modeling Evidence, Section 6) rather than altering the Discovery artifact itself. The new artifact's lineage records which Discovery artifact(s) it derives from (Section 4, Modeling Provenance), but the originating Discovery artifact is unchanged by that act of derivation.
- **Consumption boundary.** Modeling may consume only what crosses the Discovery → Modeling interface (Section 6) — the Discovery Candidate(s) together with their complete Discovery Evidence — and nothing else; Modeling has no access to, and no contractual basis for depending on, any internal, non-exposed detail of how Discovery produced those artifacts.

---

## 6. Discovery → Modeling Interface (Consuming Side)

Per IDS-001 Section 5: there is exactly one contracted interface governing this boundary — **Discovery → Modeling** — jointly defined by Discovery (producer) and Modeling (consumer). IDS-002, Section 6 already fixed the producing-side obligations; this section fixes the consuming-side obligations, completing the joint contract without redefining the producing side.

- Modeling accepts, across this interface, only the Discovery Candidate(s) together with their complete Discovery Evidence, exactly as exposed by Discovery per IDS-002 Section 6. Modeling does not accept, and has no contractual basis for expecting, any other artifact from Discovery.
- Modeling must verify artifact completeness (Section 8) before treating a Discovery Candidate as available for consumption: a Discovery Candidate lacking complete Discovery Evidence is not considered to exist for contractual purposes (IDS-002 Section 5.2) and may not be consumed as if it were complete.
- **Contract-based rejection only.** Modeling may reject a Discovery artifact only because its contractual requirements (Section 8 verification categories) are not satisfied. Modeling shall never reject a Discovery artifact because of scientific preference, biological preference, statistical preference, or any implementation preference. Scientific evaluation of a Discovery artifact's content belongs to later framework domains, not to Modeling's consumption contract.
- Modeling accepts Discovery Candidate multiplicity as received: where Discovery exposes more than one Discovery Candidate, Modeling's consumption contract does not require collapsing that multiplicity before consumption; such Discovery Candidate(s) may be received and processed individually or collectively. **Every consumed Discovery Candidate shall remain contractually traceable throughout the Modeling domain. No Discovery Candidate may disappear from contractual lineage.**
- **No reverse interface.** Modeling supplies no artifact back into Discovery through this or any other channel, consistent with IDS-001 Section 5 (Directionality follows FRAMEWORK_SPEC) and IDS-002 Section 6 (No reverse interface).

---

## 7. Modeling Artifacts and the Modeling → Validation & Benchmark Interface

Per Decision 003 (LOCKED, IDS-003_PREPARATION.md): every Modeling artifact has exactly one contractual purpose; Model Candidate and Modeling Evidence are distinct artifacts; no hybrid artifact is permitted.

### 7.1 Model Candidate

- **Contractual purpose:** represents one candidate output of the Modeling domain, proposed as a Modeling-Layer outcome and associated with a risk score definition. It carries no claim of being validated or selected, and no claim regarding any particular model family or technique.
- **Producer:** the Modeling domain, exclusively. Per Decision 004 (LOCKED) and IDS-001 Section 4 (Single-producer requirement), no other domain may produce or modify a Model Candidate.
- **Consumer:** the Validation & Benchmark domain (IDS-004), via the Modeling → Validation & Benchmark interface below.
- **Contractual dependencies:** depends on exactly one originating Discovery Candidate, per the Modeling Input traceability already locked in FRAMEWORK_SPEC.md (RDR-004, Section 6); has no dependency on any artifact from Validation & Benchmark, Interpretability, or Clinical Translation, consistent with the acyclic dependency requirement of IDS-001 Section 6.
- **Verification requirements:** per Section 8 below.
- **Relationship to FRAMEWORK_SPEC:** traces directly to the Model Candidate concept locked in FRAMEWORK_SPEC.md (RDR-004, Sections 5 and 7).
- **Multiplicity:** represented as a collection, per IDS-001 Section 4; multiplicity of Model Candidates is the expected default (FRAMEWORK_SPEC.md, RDR-004 Section 9) and may not be silently collapsed within Modeling's own execution.

No schema fields are specified here; schema definition is reserved for later implementation, downstream of IDS-003.

### 7.2 Modeling Evidence

- **Contractual purpose:** the standardized evidence package accompanying every Model Candidate, distinct in purpose from the Candidate itself — Modeling Evidence documents how and how reliably a Model Candidate was produced; it is never a substitute for, nor a component folded into, the Candidate artifact.
- **Contractual existence only:** IDS-003 specifies only that Modeling Evidence must exist, as a complete package, for every Model Candidate — not its internal schema. The components that constitute "complete" are already named in FRAMEWORK_SPEC.md (RDR-004, Section 7: predictive model, risk score definition, model evidence, performance profile, interpretability profile, clinical evaluation profile); IDS-003 references that definition rather than re-enumerating, re-deriving, or specializing it. Schema definition is explicitly deferred to later implementation activity, downstream of this document, so that this contract remains independent of future schema evolution.
- **Producer:** the Modeling domain, exclusively — the same domain that produced the corresponding Model Candidate, preserving one-to-one attribution between a Candidate and its Evidence.
- **Consumer:** the Validation & Benchmark domain (IDS-004), via the same Modeling → Validation & Benchmark interface as its corresponding Model Candidate; Modeling Evidence is never transmitted independently of the Candidate it documents.
- **Contractual dependencies:** depends on the completed Model Candidate it documents; cannot exist in advance of, or independently from, that Candidate.
- **Verification requirements:** per Section 8 below; completeness gating (IDS-001 Section 4) applies — a Model Candidate lacking complete Modeling Evidence is not considered to exist for contractual purposes, and may not be passed to Validation & Benchmark.
- **Relationship to FRAMEWORK_SPEC:** traces directly to the Model Evidence definition locked in FRAMEWORK_SPEC.md (RDR-004, Section 7).

No schema fields are specified for any Modeling Evidence component here.

### 7.3 Modeling → Validation & Benchmark Interface (Producing Side)

This document fixes the producing-side contractual obligations of the Modeling → Validation & Benchmark interface; the consuming-side obligations are reserved for IDS-004, per IDS-001 Section 5's ownership rule.

- Modeling exposes, across this interface, the Model Candidate(s) together with their complete Modeling Evidence — and no other artifact.
- Modeling holds no selection authority: per FRAMEWORK_SPEC.md (RDR-004, Section 10), Model Candidates represent competing scientific hypotheses, not competing implementations; selection among them is explicitly a Validation & Benchmark function, never a Modeling function. Modeling exposes all produced Model Candidates, not a pre-selected subset.
- This is Modeling's only externally contracted output interface. Modeling exposes no interface, direct or indirect, to Interpretability or Clinical Translation; any artifact reaching those domains must do so via Validation & Benchmark's own contracted interfaces, per IDS-001 Section 5 (Explicit non-interfaces).
- **No reverse interface.** No domain may supply an input back into Modeling through this or any other channel; Modeling's only domain input is the Discovery → Modeling interface (Section 6). This is consistent with IDS-001 Section 5 (Directionality follows FRAMEWORK_SPEC).
- Per Decision 004 (LOCKED): Validation & Benchmark consumes Modeling artifacts; it never becomes their producer. Modeling's producer ownership over the Model Candidate and Modeling Evidence is exclusive and is not transferred, shared, or reassigned at the point of consumption.

---

## 8. Modeling Dependencies

- Modeling's production depends contractually on exactly one upstream artifact pairing: the completed, complete Discovery Candidate(s) together with their Discovery Evidence, received via Section 6. Modeling has no contractual dependency, of any kind, on Validation & Benchmark, Interpretability, or Clinical Translation, consistent with the acyclic, unidirectional dependency graph fixed by IDS-001 Section 6.
- **Explicit no-dependency statement:** Modeling has no contractual dependency on Validation & Benchmark, Interpretability, or Clinical Translation. This is stated here as an explicit contractual property, not left as an implied consequence of domain ordering, consistent with the explicit no-dependency statement already fixed for Discovery (IDS-002, Section 7).
- **No dependency on Validation outcomes.** Modeling has no contractual dependency upon any Validation & Benchmark decision, including any decision Validation & Benchmark makes when selecting among Model Candidates (Section 7.3). Validation outcomes shall never influence Modeling's contractual responsibilities, its artifact contracts (Section 7), or its verification categories (Section 9); Modeling's production is complete and contractually valid independent of whatever Validation & Benchmark subsequently decides.
- Modeling's only internal dependency is on its own internally complete set of contractual responsibilities (Section 3): a Model Candidate may not be exposed across the Section 7 interface until those responsibilities have produced a complete result for that Candidate.
- Per IDS-001 Section 6 (Dependency scope is limited to contracted artifacts): Modeling depends on Discovery satisfying its artifact contract (IDS-002, Section 5) — never on any detail of how Discovery's Coding Module computed that artifact. Modeling's internal responsibilities are not themselves an inter-domain dependency and are not subject to external contractual constraint; they depend only on Modeling's own upstream internal outputs, never on runtime state, execution environment, or undocumented side effects of any tooling.
- Modeling imposes no dependency, in turn, that Discovery must satisfy; Discovery's production proceeds independently of whether or how Modeling consumes its output (IDS-002, Section 7).

---

## 9. Modeling Verification

Per IDS-001 Section 7, the following framework-wide verification categories apply at the Modeling domain's boundaries, specialized as follows:

1. **Contract compliance** — a Model Candidate and its Modeling Evidence each conform to the artifact contracts of Section 7; no hybrid artifact (Decision 003) is permitted to pass this check.
2. **Interface compliance** — inbound: the artifact Modeling consumes arrived only via the Discovery → Modeling interface (Section 6); outbound: the artifact Modeling exposes reaches Validation & Benchmark only via the Modeling → Validation & Benchmark interface (Section 7.3); no side-channel passage in either direction is compliant.
3. **Artifact completeness** — Modeling Evidence is complete, per the components already defined in FRAMEWORK_SPEC.md (RDR-004, Section 7), for every Model Candidate before that Candidate is considered to exist contractually (Section 7.2); inbound, Modeling treats a Discovery Candidate as available only once its Discovery Evidence is itself complete (Section 6).
4. **Traceability compliance** — every Model Candidate and its Modeling Evidence are traceable to exactly one originating Discovery Candidate (Modeling Provenance, Section 4), and to the Model Candidate / Model Evidence definitions of FRAMEWORK_SPEC.md (RDR-004, Sections 5 and 7).
5. **Downstream compatibility (downstream readiness)** — Model Candidates and their Evidence are structurally usable by Validation & Benchmark without requiring undocumented transformation; multiplicity (Section 4) is preserved intact, with no candidate silently discarded prior to handoff.
6. **Lineage preservation** — verification shall explicitly verify that artifact lineage is preserved throughout the Modeling domain: every consumed Discovery Candidate remains contractually traceable through Modeling's internal responsibilities (Section 3) to its resulting Model Candidate(s) (Modeling Provenance, Section 4), with no Discovery Candidate disappearing from contractual lineage (Section 6). This verification concerns contractual lineage only; it does not verify scientific correctness of the lineage's content.

No verification *procedure* (statistical test, computational check, tool) is specified here; only the categories and completeness/traceability/readiness requirements a procedure must eventually satisfy.

**Verification scope.** Verification performed under IDS-003 verifies implementation contracts, contractual completeness, contractual traceability, and contractual interface compliance — the five categories above. It does not verify scientific validity, biological validity, statistical validity, or methodological correctness of any Modeling result. Those forms of validity belong to the scientific framework (FRAMEWORK_SPEC.md and the RDR chain) rather than to this implementation specification, consistent with the verification-scope principle already fixed for Discovery (IDS-002, Section 8).

---

## 10. Modeling Implementation Boundaries

Inherited unchanged from IDS-001, Section 9, and restated here only as a domain-scoped reminder — not a re-specification:

IDS-003 does not introduce, and no Modeling Coding Module specification may introduce at this design stage:

- Algorithms, statistical methods, or machine learning methods of any kind (e.g., no naming of a specific representation, prediction, or risk-estimation method).
- Software packages, libraries, or frameworks.
- Programming languages or execution environments.
- Executable code of any form.
- Any scientific or methodological decision not already locked in FRAMEWORK_SPEC.md (RDR-004).

These boundaries apply to all Modeling implementation responsibilities of Section 3 equally; no responsibility within Modeling is exempt.

---

## 11. Traceability

| IDS-003 Section | Originating Decision | Framework Authority | Current Modeling Contract |
|---|---|---|---|
| §3 Modeling Domain Decomposition | IDS-003_PREPARATION Decision 002 | FRAMEWORK_SPEC.md (RDR-004 §5, Modeling decomposition) | IDS-001 §3.1, §3.2, §3.4 |
| §4 Modeling Responsibilities | IDS-003_PREPARATION §3 (Scope) | FRAMEWORK_SPEC.md (RDR-004 §5, §6, §7, §9, §10) | IDS-001 §4 (Multiplicity accommodation) |
| §5 Discovery Artifact Consumption | IDS-003_PREPARATION Decision 005 | FRAMEWORK_SPEC.md (RDR-004 §6) | IDS-001 §4 (Immutability after handoff); IDS-002 §5 |
| §6 Discovery → Modeling Interface (consuming side) | IDS-003_PREPARATION §7 | FRAMEWORK_SPEC.md (RDR-003 §9) | IDS-001 §5; IDS-002 §6 (producing side) |
| §7 Modeling Artifacts & Interface | IDS-003_PREPARATION Decisions 003, 004 | FRAMEWORK_SPEC.md (RDR-004 §5, §7, §9, §10) | IDS-001 §4, §5 |
| §8 Modeling Dependencies | IDS-003_PREPARATION §9 | FRAMEWORK_SPEC.md (Candidate Evolution sequencing) | IDS-001 §6 |
| §9 Modeling Verification | IDS-003_PREPARATION §10 | FRAMEWORK_SPEC.md (RDR-004 §7) | IDS-001 §7 |
| §10 Implementation Boundaries | IDS-003_PREPARATION §11 | FRAMEWORK_SPEC.md §1.3 (Architecture Invariants) | IDS-001 §9 |

No section of this document introduces content without an entry in this table.

---

## 12. Governance Status

**Status:** LOCKED.
**Implementation:** NOT PERMITTED.

IDS-003 is now the authoritative implementation specification for the Modeling domain. It inherits the framework-wide contracts established by IDS-001 and the Discovery contracts established by IDS-002, without redefining either. Future revisions to IDS-003 require formal governance review and re-lock.

---

## 13. Exit Criteria

IDS-003 was locked upon confirmation that:

1. Strategist Review confirmed no algorithm, statistical method, technology, or scientific/methodological decision had been introduced.
2. Every framework-wide contract and Discovery contract referenced (Sections 5–9) was confirmed as a specialization, not a redefinition, of IDS-001 or IDS-002.
3. Section 11's traceability table was confirmed complete, with no orphaned content.
4. Project Coordinator granted explicit approval and lock.

With IDS-003 now LOCKED, no IDS-003_CLOSURE.md is generated and no IDS-004 drafting begins as part of this action.
