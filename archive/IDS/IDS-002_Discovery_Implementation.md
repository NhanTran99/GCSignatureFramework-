# IDS-002_Discovery_Implementation.md

**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework
**Document Type:** Implementation Design Specification (Domain-Level — Discovery)
**Governed by (authoritative, immutable, in precedence order):** FRAMEWORK_SPEC.md → IMPLEMENTATION_PHILOSOPHY_IDS_PHASE.md → IDS-001_Framework_Implementation.md (LOCKED) → IDS-002_PREPARATION.md (LOCKED, Design Lock)
**Status:** LOCKED
**Implementation:** NOT PERMITTED (this document specifies contracts, not code)

---

## 1. Document Purpose

IDS-002 is the domain-specific Implementation Design Specification for the **Discovery implementation domain**, as identified in IDS-001, Section 3.1. It translates the Discovery Layer already locked in FRAMEWORK_SPEC.md into implementation contracts.

IDS-002 inherits every framework-wide contract fixed by IDS-001 (Artifact, Interface, Dependency, Verification contracts; Cross-Cutting Implementation Principles; Implementation Boundaries) without redefinition, and specializes them for the Discovery domain only. Where this document does not state otherwise, the framework-wide contract of IDS-001 governs unchanged; this document does not restate IDS-001 content beyond what is necessary to anchor each specialization.

In the event of apparent conflict, governance precedence is: FRAMEWORK_SPEC.md → IMPLEMENTATION_PHILOSOPHY_IDS_PHASE.md → IDS-001 → IDS-002. IDS-002 is corrected to match any higher document; it never overrides one.

---

## 2. Scope

IDS-002 defines only the Discovery implementation domain: its internal responsibilities, its contracted artifacts, its interface to Modeling, its dependencies, its verification categories, and its implementation boundaries.

IDS-002 does not specify Modeling, Validation & Benchmark, Interpretability, or Clinical Translation, except where strictly necessary to state the Discovery → Modeling interface contract (Section 6), which is defined here on the producing side only, per IDS-001 Section 5's joint-participation rule. The Modeling-side consumption of this interface remains the responsibility of IDS-003.

---

## 3. Discovery Domain Decomposition

The Discovery domain corresponds to the Discovery decomposition already locked in FRAMEWORK_SPEC.md (RDR-003, Section 5): QC/Preprocessing, Statistical Discovery, Multiple Testing/Filtering, Cross-Cohort Integration, and Candidate Gene Set. IDS-002 treats these as **Discovery implementation responsibilities** rather than as a fixed coding-module decomposition: each names a coherent unit of contractual responsibility that Discovery must fulfill, not a prescribed sequence of executable components.

Implementation may realize each responsibility in different ways — combined, further subdivided, or restructured at the Coding Module level — provided the contractual responsibilities themselves, and the domain boundary fixed by IDS-001 Section 3.1, remain intact. The contractual responsibilities specified in Section 4 remain stable even if implementation granularity evolves; a change in how many Coding Modules realize these responsibilities, or in their internal sequencing, is an implementation detail and does not require revision of this document.

Per Decision 002 (LOCKED, IDS-002_PREPARATION.md): Discovery may be internally decomposed into multiple implementation responsibilities, provided each remains entirely inside the Discovery domain boundary fixed by IDS-001, Section 3.1. The responsibilities above are recognized as the internal decomposition of contractual responsibility within this domain; each is a unit of responsibility, not an independently externally-contracted sub-domain — no responsibility exposes an artifact or interface to any domain outside Discovery except at the domain's single external boundary (Section 6).

This decomposition is internal-only: it does not create additional governing IDS documents, and it does not subdivide the domain boundary itself, which remains fixed by IDS-001 Section 3.1 and closed for Framework v1.0 per IDS-001 Section 3.4.

---

## 4. Discovery Responsibilities

Within its domain boundary, Discovery is contractually responsible for:

- Receiving contracted Discovery inputs and producing a Candidate Gene Set, per FRAMEWORK_SPEC.md's Discovery Layer Boundary. Discovery's contractual input is defined by what FRAMEWORK_SPEC.md establishes as crossing into the Discovery Layer; no implementation-specific data representation, format, or structure is specified or implied by this responsibility.
- Producing complete Discovery Evidence for every Candidate Gene Set it produces, per the Candidate Definition already locked in FRAMEWORK_SPEC.md.
- Preserving candidate multiplicity: per FRAMEWORK_SPEC.md (RDR-003, Section 10) and IDS-001 Section 4 (Multiplicity accommodation), multiple Discovery Candidates are an expected, normal outcome — Discovery's contractual responsibility includes representing and retaining all such candidates, not selecting among them. Selection is explicitly excluded from Discovery's responsibility and belongs to a later Decision Layer / Validation function, never to Discovery itself.
- Exposing its output only through the single contracted Discovery → Modeling interface (Section 6); Discovery holds no other contractual responsibility toward any other domain.

Discovery is not contractually responsible for: representation/dimensionality reduction, prediction, risk estimation, or any responsibility belonging to Modeling, Validation & Benchmark, Interpretability, or Clinical Translation.

---

## 5. Discovery Artifacts

Per Decision 003 (LOCKED): every Discovery artifact has exactly one contractual purpose; Discovery Candidate and Discovery Evidence are distinct artifacts; no hybrid artifact is permitted.

### 5.1 Discovery Candidate (the Candidate Gene Set)

- **Contractual purpose:** represents one candidate output of Discovery's contractual responsibilities (Section 3) — a gene set proposed as a Discovery-Layer outcome. It carries no claim of being modeled, validated, or selected.
- **Producer:** the Discovery domain, exclusively. Per IDS-001 Section 4 (Single-producer requirement), no other domain may produce or modify a Discovery Candidate.
- **Consumer:** the Modeling domain (IDS-003), via the Discovery → Modeling interface (Section 6) only.
- **Contractual dependencies:** depends only on Discovery's own internal responsibilities (Section 3); has no dependency on any artifact from Modeling, Validation & Benchmark, Interpretability, or Clinical Translation, consistent with the acyclic dependency requirement of IDS-001 Section 6.
- **Verification requirements:** per Section 8 below.
- **Relationship to FRAMEWORK_SPEC:** traces directly to the Candidate Gene Set and Discovery Candidate concepts locked in FRAMEWORK_SPEC.md (RDR-003, Sections 5 and 8).
- **Multiplicity:** represented as a collection, per IDS-001 Section 4; no Discovery Candidate may be silently discarded within the Discovery domain's own execution (FRAMEWORK_SPEC.md, RDR-003 Section 10).

No schema fields (e.g., gene identifiers, set size, file structure) are specified here; schema definition is reserved for later implementation, downstream of IDS-002.

### 5.2 Discovery Evidence

- **Contractual purpose:** the standardized evidence package accompanying every Discovery Candidate, distinct in purpose from the Candidate itself — Discovery Evidence documents how and how reliably a Candidate was produced; it is never a substitute for, nor a component folded into, the Candidate artifact.
- **Contractual existence only:** IDS-002 specifies only that Discovery Evidence must exist, as a complete package, for every Discovery Candidate — not its internal schema. The components that constitute "complete" are already named in FRAMEWORK_SPEC.md (RDR-003, Section 8); IDS-002 references that definition rather than re-enumerating, re-deriving, or specializing it. Schema definition — field-level structure, format, or representation of those components — is explicitly deferred to later implementation activity, downstream of this document, so that this contract remains independent of future schema evolution.
- **Producer:** the Discovery domain, exclusively — the same domain that produced the corresponding Discovery Candidate, preserving one-to-one attribution between a Candidate and its Evidence.
- **Consumer:** the Modeling domain (IDS-003), via the same Discovery → Modeling interface (Section 6) as its corresponding Discovery Candidate; Discovery Evidence is never transmitted independently of the Candidate it documents.
- **Contractual dependencies:** depends on the completed Discovery Candidate it documents; cannot exist in advance of, or independently from, that Candidate.
- **Verification requirements:** per Section 8 below; in particular, completeness gating (IDS-001 Section 4) applies — a Discovery Candidate lacking complete Discovery Evidence, as defined in FRAMEWORK_SPEC.md, is not considered to exist for contractual purposes, and may not be passed to Modeling.
- **Relationship to FRAMEWORK_SPEC:** traces directly to the Discovery Evidence definition locked in FRAMEWORK_SPEC.md (RDR-003, Section 8).

No schema fields are specified for any Discovery Evidence component here.

---

## 6. Discovery Interfaces

Per IDS-001 Section 5: there is exactly one contracted interface for the Discovery domain — **Discovery → Modeling** — jointly defined by Discovery (producer) and Modeling (consumer), owned and formally specified, on the consuming side, by IDS-003.

This document fixes the producing-side contractual obligations of that interface:

- Discovery exposes, across this interface, the Discovery Candidate(s) together with their complete Discovery Evidence — and no other artifact.
- No predictive index, classifier, risk group, or any Modeling-, Validation-, Interpretability-, or Clinical-Translation-layer artifact may originate in, or be exposed by, Discovery — consistent with the Discovery → Modeling Interface already locked in FRAMEWORK_SPEC.md (RDR-003, Section 9).
- This is Discovery's only externally contracted interface. Discovery exposes no interface, direct or indirect, to Validation & Benchmark, Interpretability, or Clinical Translation; any artifact reaching those domains must do so via the intermediate domains' own contracted interfaces, per IDS-001 Section 5 (Explicit non-interfaces).
- **No reverse interface.** No domain may supply an input back into Discovery through this or any other channel; Discovery's only domain input is upstream of the framework's domain architecture (cohort data), not from any other contracted domain. This is consistent with IDS-001 Section 5 (Directionality follows FRAMEWORK_SPEC).
- Per Decision 004 (LOCKED): Modeling consumes Discovery artifacts; it never becomes their producer. Discovery's producer ownership over the Discovery Candidate and Discovery Evidence is exclusive and is not transferred, shared, or reassigned at the point of consumption.

The consuming-side contractual requirements of this same interface (what Modeling must accept, and under what conditions) are specified in IDS-003, not here, per IDS-001 Section 5's ownership rule.

---

## 7. Discovery Dependencies

- Discovery's production has no contractual dependency on any other implementation domain; it is the framework's first domain in the Candidate Evolution sequence, consistent with the acyclic, unidirectional dependency graph fixed by IDS-001 Section 6.
- **Explicit no-dependency statement:** Discovery has no contractual dependency, of any kind, on Modeling, Validation & Benchmark, Interpretability, or Clinical Translation. This is stated here as an explicit contractual property, not left as an implied consequence of domain ordering, because Discovery is the first implementation domain in the framework's domain dependency graph and therefore has no upstream implementation domain to depend on.
- Discovery's only dependency is on its own internally complete set of contractual responsibilities (Section 3): a Discovery Candidate may not be exposed across the Section 6 interface until those responsibilities have produced a complete result for that Candidate.
- Per IDS-001 Section 6 (Dependency scope is limited to contracted artifacts): Discovery's internal responsibilities are not themselves an inter-domain dependency and are not subject to external contractual constraint; they depend only on Discovery's own upstream internal outputs, never on runtime state, execution environment, or undocumented side effects of any tooling.
- Discovery imposes no dependency, in turn, that Modeling or any other domain must satisfy before Discovery may begin production.

---

## 8. Discovery Verification

Per IDS-001 Section 7, the following framework-wide verification categories apply at the Discovery domain boundary, specialized as follows:

1. **Contract compliance** — a Discovery Candidate and its Discovery Evidence each conform to the artifact contracts of Section 5; no hybrid artifact (Decision 003) is permitted to pass this check.
2. **Interface compliance** — the artifact reaches Modeling only via the Discovery → Modeling interface of Section 6; no side-channel exposure of any Discovery-domain artifact is compliant.
3. **Artifact completeness** — Discovery Evidence is complete, per the components already defined in FRAMEWORK_SPEC.md (RDR-003, Section 8), for every Discovery Candidate before that Candidate is considered to exist contractually (Section 5.2).
4. **Traceability compliance** — every Discovery Candidate and its Discovery Evidence are traceable to the Candidate Gene Set / Discovery Candidate / Discovery Evidence definitions of FRAMEWORK_SPEC.md (RDR-003, Sections 5 and 8).
5. **Downstream compatibility (downstream readiness)** — Discovery Candidates and their Evidence are structurally usable by Modeling without requiring undocumented transformation; multiplicity (Section 4) is preserved intact, with no candidate silently discarded prior to handoff.

No verification *procedure* (statistical test, computational check, tool) is specified here; only the categories and completeness/traceability/readiness requirements a procedure must eventually satisfy.

**Verification scope.** Verification performed under IDS-002 verifies implementation contracts, contractual completeness, contractual traceability, and contractual interface compliance — the five categories above. It does not verify scientific validity, biological validity, statistical validity, or methodological correctness of any Discovery result. Those forms of validity belong to the scientific framework (FRAMEWORK_SPEC.md and the RDR chain) rather than to this implementation specification; an artifact may be fully contract-compliant under IDS-002 while its scientific validity remains a separate, unaddressed question for the governing scientific documents.

---

## 9. Discovery Implementation Boundaries

Inherited unchanged from IDS-001, Section 9, and restated here only as a domain-scoped reminder — not a re-specification:

IDS-002 does not introduce, and no Discovery Coding Module specification may introduce at this design stage:

- Algorithms, statistical methods, or feature-selection methods of any kind (e.g., no naming of a specific discovery statistic, multiple-testing procedure, or cross-cohort integration method).
- Machine learning methods or model families.
- Software packages, libraries, or frameworks.
- Programming languages or execution environments.
- Executable code of any form.
- Any scientific or methodological decision not already locked in FRAMEWORK_SPEC.md (RDR-003).

These boundaries apply to all Discovery implementation responsibilities of Section 3 equally; no responsibility within Discovery is exempt.

---

## 10. Traceability

| IDS-002 Section | Originating Decision | Framework Authority | Current Discovery Contract |
|---|---|---|---|
| §3 Discovery Domain Decomposition | IDS-002_PREPARATION Decision 002 | FRAMEWORK_SPEC.md (RDR-003 §5, Discovery decomposition); IDS-001 §3.1, §3.2, §3.4 | Discovery implementation responsibilities, internal-only, domain boundary closed for v1.0 |
| §4 Discovery Responsibilities | IDS-002_PREPARATION §3 (Scope) | FRAMEWORK_SPEC.md (RDR-003 §5, §9, §10) | IDS-001 §4 (Multiplicity accommodation) |
| §5 Discovery Artifacts | IDS-002_PREPARATION Decision 003 | FRAMEWORK_SPEC.md (RDR-003 §5, §8) | IDS-001 §4 (Artifact Contracts) |
| §6 Discovery Interfaces | IDS-002_PREPARATION Decision 004 | FRAMEWORK_SPEC.md (RDR-003 §9) | IDS-001 §5 (Interface Contracts) |
| §7 Discovery Dependencies | IDS-002_PREPARATION §3 (Scope) | FRAMEWORK_SPEC.md (Candidate Evolution sequencing) | IDS-001 §6 (Dependency Contracts) |
| §8 Discovery Verification | IDS-002_PREPARATION §3 (Scope) | FRAMEWORK_SPEC.md (RDR-003 §5, §8) | IDS-001 §7 (Verification Contracts) |
| §9 Implementation Boundaries | IDS-002_PREPARATION §3 (Scope) | FRAMEWORK_SPEC.md §1.3 (Architecture Invariants) | IDS-001 §9 (Implementation Boundaries) |

No section of this document introduces content without an entry in this table. Each row is read as: Originating Decision ↓ Framework Authority ↓ Current Discovery Contract — making every contractual specialization in this document auditable back to the decision and framework source that authorized it.

---

## 11. Governance Status

**Status:** LOCKED.
**Implementation:** NOT PERMITTED.

IDS-002 is now the authoritative implementation specification for the Discovery domain. It inherits the framework-wide contracts established by IDS-001 without redefinition. Future revisions to IDS-002 require formal governance review and re-lock.

---

## 12. Exit Criteria

IDS-002 was locked upon confirmation that:

1. Strategist Review confirmed no algorithm, statistical method, technology, or scientific/methodological decision had been introduced.
2. Every framework-wide contract referenced (Sections 5–8) was confirmed as a specialization, not a redefinition, of IDS-001.
3. Section 10's traceability table was confirmed complete, with no orphaned content.
4. Project Coordinator granted explicit approval and lock.

With IDS-002 now LOCKED, no IDS-002_CLOSURE.md is generated and no IDS-003 drafting begins as part of this action.
