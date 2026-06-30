# IDS-004_Validation_Benchmark_Implementation.md

**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework
**Document Type:** Implementation Design Specification (Domain-Level — Validation & Benchmark)
**Governed by (authoritative, immutable, in precedence order):** FRAMEWORK_SPEC.md → IMPLEMENTATION_PHILOSOPHY_IDS_PHASE.md → IDS-001_Framework_Implementation.md (LOCKED) → IDS-002_Discovery_Implementation.md (LOCKED) → IDS-003_Modeling_Implementation.md (LOCKED) → IDS-004_PREPARATION.md (LOCKED, Design Lock)
**Status:** DRAFT — Phase B, pending Strategist Review
**Implementation:** NOT PERMITTED (this document specifies contracts, not code)

---

## 1. Document Purpose

IDS-004 is the domain-specific Implementation Design Specification for the **Validation & Benchmark implementation domain**, as identified in IDS-001, Section 3.1. It translates the Validation Layer already locked in FRAMEWORK_SPEC.md into implementation contracts.

IDS-004 inherits every framework-wide contract fixed by IDS-001 (Artifact, Interface, Dependency, Verification contracts; Cross-Cutting Implementation Principles; Implementation Boundaries) without redefinition, and consumes the Modeling contractual outputs fixed by IDS-003 without modifying them. It specializes both for the Validation & Benchmark domain only. Where this document does not state otherwise, the governing contract of IDS-001 or IDS-003 applies unchanged; this document does not restate their content beyond what is necessary to anchor each specialization.

In the event of apparent conflict, governance precedence is: FRAMEWORK_SPEC.md → IMPLEMENTATION_PHILOSOPHY_IDS_PHASE.md → IDS-001 → IDS-002 → IDS-003 → IDS-004. IDS-004 is corrected to match any higher document; it never overrides one.

---

## 2. Scope

IDS-004 defines only the Validation & Benchmark implementation domain: its internal responsibilities, its contracted artifacts, its consumption of Modeling artifacts, its candidate-selection responsibility, its interface to Interpretability, its dependencies, its verification categories, and its implementation boundaries.

IDS-004 does not specify Discovery, Modeling, Interpretability, or Clinical Translation, except where strictly necessary to state: (a) the Modeling → Validation & Benchmark interface contract from the consuming side, completing the joint contract whose producing side was fixed by IDS-003 (per IDS-001 Section 5's ownership rule, this consuming side belongs here); and (b) the Validation & Benchmark → Interpretability interface contract from the producing side only, whose consuming side is reserved for IDS-005.

---

## 3. Validation & Benchmark Domain Decomposition

The Validation & Benchmark domain corresponds to the Validation decomposition already locked in FRAMEWORK_SPEC.md (RDR-005, Section 5): Model Candidate → Internal Evidence Assembly → External Evidence Assembly → Multi-Criteria Evidence Integration → Validated Candidate + Recommendation. Consistent with the responsibility-based framing already established for Discovery (IDS-002, Section 3) and Modeling (IDS-003, Section 3), IDS-004 treats these as **Validation & Benchmark implementation responsibilities** rather than as a fixed coding-module decomposition: each names a coherent unit of contractual responsibility that this domain must fulfill, not a prescribed sequence of executable components.

Implementation may realize each responsibility in different ways — combined, further subdivided, or restructured at the Coding Module level — provided the contractual responsibilities themselves, and the domain boundary fixed by IDS-001 Section 3.1, remain intact. The contractual responsibilities specified in Section 4 remain stable even if implementation granularity evolves.

Per Decision 002 (LOCKED, IDS-004_PREPARATION.md): Validation & Benchmark may be internally decomposed into multiple implementation responsibilities, provided each remains entirely inside the domain boundary fixed by IDS-001, Section 3.1. The responsibilities above are recognized as the internal decomposition of contractual responsibility within this domain; each is a unit of responsibility, not an independently externally-contracted sub-domain — no responsibility exposes an artifact or interface to any domain outside Validation & Benchmark except at the domain's two external boundaries (Sections 6 and 7).

This decomposition is internal-only: it does not create additional governing IDS documents, and it does not subdivide the domain boundary itself, which remains fixed by IDS-001 Section 3.1 and closed for Framework v1.0 per IDS-001 Section 3.4.

---

## 4. Validation & Benchmark Responsibilities

Within its domain boundary, Validation & Benchmark is contractually responsible for:

- Consuming Model Candidates together with their complete Modeling Evidence, via the Modeling → Validation & Benchmark interface (Section 6).
- Assembling Validation Evidence for the Model Candidate(s) it evaluates, per the Validation Evidence package already locked in FRAMEWORK_SPEC.md (RDR-005, Section 7).
- Assembling Benchmark Evidence documenting component-level benchmarking against the historical Part 1 validation pathway, per the Benchmarking Philosophy already locked in FRAMEWORK_SPEC.md (RDR-005, Section 8); end-to-end framework benchmarking is explicitly out of scope for this domain and reserved for the deferred Framework Integration stage.
- Performing candidate selection (Section 8): evaluating Model Candidates and producing Validated Candidate(s) as a new contractual artifact, without altering any Modeling artifact.
- Preserving Validated Candidate traceability: maintaining the lineage from exactly one originating Model Candidate to each resulting Validated Candidate, per FRAMEWORK_SPEC.md (RDR-005, "Validated Candidate traceability").
- Preserving multiplicity and lineage for both selected and non-selected candidates, per Section 8.
- Verifying its own artifacts against the categories of Section 9 before exposing them.
- Exposing its output only through the single contracted Validation & Benchmark → Interpretability interface (Section 7); Validation & Benchmark holds no other contractual responsibility toward any other domain.

Validation & Benchmark is not contractually responsible for: any Discovery responsibility (per IDS-002 Section 3), any Modeling responsibility (per IDS-003 Section 3), or any responsibility belonging to Interpretability or Clinical Translation, including biological interpretation, model explanation, or clinical translation evidence production.

---

## 5. Modeling Artifact Consumption Contract

Validation & Benchmark's relationship to Modeling's contracted outputs is fixed as follows:

- **Immutable artifact property and read-only contractual consumption.** Per Decision 005 (LOCKED, IDS-004_PREPARATION.md): Validation & Benchmark consumes Modeling artifacts without modifying them. As established for the Discovery → Modeling boundary (IDS-003, Section 5), this contract has two distinct, separately held components: (1) Modeling artifacts (Model Candidate, Modeling Evidence) remain immutable after production, a property of the artifact itself, per IDS-001 Section 4 and IDS-003 Sections 7.1–7.2; and (2) Validation & Benchmark's act of consuming a Modeling artifact is itself read-only — it does not edit, overwrite, annotate into, or otherwise alter any Modeling artifact it consumes.
- **No ownership transfer.** Consuming a Modeling artifact does not transfer producer ownership of that artifact to Validation & Benchmark. The Modeling domain remains the sole, permanent producer of record for every Model Candidate and its Modeling Evidence, per IDS-003 Section 7's single-producer requirement and IDS-001 Section 4.
- **New artifacts only.** Where Validation & Benchmark's responsibilities require building upon a Modeling artifact, it produces new, distinct Validation & Benchmark artifacts (Validation Evidence, Benchmark Evidence, Validated Candidate; Section 7) rather than altering the Modeling artifact itself. Per Decision 007 (LOCKED): candidate selection produces a new contractual artifact; Modeling artifacts remain immutable regardless of the outcome of selection.
- **Consumption boundary.** Validation & Benchmark may consume only what crosses the Modeling → Validation & Benchmark interface (Section 6) — the Model Candidate(s) together with their complete Modeling Evidence — and nothing else; it has no access to, and no contractual basis for depending on, any internal, non-exposed detail of how Modeling produced those artifacts.

---

## 6. Modeling → Validation & Benchmark Interface (Consuming Side)

Per IDS-001 Section 5: there is exactly one contracted interface governing this boundary — **Modeling → Validation & Benchmark** — jointly defined by Modeling (producer) and Validation & Benchmark (consumer). IDS-003, Section 7.3 already fixed the producing-side obligations; this section fixes the consuming-side obligations, completing the joint contract without redefining the producing side.

- Validation & Benchmark accepts, across this interface, only the Model Candidate(s) together with their complete Modeling Evidence, exactly as exposed by Modeling per IDS-003 Section 7.3. It does not accept, and has no contractual basis for expecting, any other artifact from Modeling.
- Validation & Benchmark must verify artifact completeness (Section 9) before treating a Model Candidate as available for consumption: a Model Candidate lacking complete Modeling Evidence is not considered to exist for contractual purposes (IDS-003 Section 7.2) and may not be consumed as if it were complete.
- **Contract-based rejection only.** Consistent with the principle already fixed for the Discovery → Modeling boundary (IDS-003, Section 6): Validation & Benchmark may reject a Model Candidate at the point of consumption only because its contractual requirements (Section 9 verification categories) are not satisfied — never because of scientific, biological, statistical, or implementation preference. Substantive evaluation of a Model Candidate's merits occurs through candidate selection (Section 8), not through consumption-time rejection.
- Validation & Benchmark accepts Model Candidate multiplicity as received: where Modeling exposes more than one Model Candidate, this consumption contract does not require collapsing that multiplicity before consumption. Every consumed Model Candidate shall remain contractually traceable throughout the Validation & Benchmark domain; no Model Candidate may disappear from contractual lineage (Section 8).
- **No reverse interface.** Validation & Benchmark supplies no artifact back into Modeling through this or any other channel, consistent with IDS-001 Section 5 (Directionality follows FRAMEWORK_SPEC) and IDS-003 Section 6 (No reverse interface).

---

## 7. Validation & Benchmark Artifacts and the Validation & Benchmark → Interpretability Interface

Per Decision 003 (LOCKED, IDS-004_PREPARATION.md): every Validation & Benchmark artifact has exactly one contractual purpose; Validation Evidence, Benchmark Evidence, and Validated Candidate are distinct artifacts; no hybrid artifact is permitted.

### 7.1 Validation Evidence

- **Contractual purpose:** the standardized evidence package documenting the evaluation of a Model Candidate across the evaluation domains already locked in FRAMEWORK_SPEC.md (RDR-005, Section 7), together with a transparent recommendation. Validation Evidence documents how a Model Candidate was evaluated; it is never a substitute for, nor a component folded into, the Model Candidate, the Benchmark Evidence, or the Validated Candidate.
- **Contractual existence only:** IDS-004 specifies only that Validation Evidence must exist, as a complete package, for every Model Candidate evaluated — not its internal schema. The components that constitute "complete" are already named in FRAMEWORK_SPEC.md (RDR-005, Section 7); IDS-004 references that definition rather than re-enumerating, re-deriving, or specializing it. Schema definition is explicitly deferred to later implementation activity, downstream of this document.
- **Producer:** the Validation & Benchmark domain, exclusively.
- **Consumer:** the Interpretability domain (IDS-005), via the Validation & Benchmark → Interpretability interface below, as part of the Validated Candidate's accompanying evidence.
- **Contractual dependencies:** depends on the completed Model Candidate it evaluates; cannot exist in advance of, or independently from, that Candidate.
- **Verification requirements:** per Section 9 below.
- **Relationship to FRAMEWORK_SPEC:** traces directly to the Validation Evidence definition locked in FRAMEWORK_SPEC.md (RDR-005, Section 7).

### 7.2 Benchmark Evidence

- **Contractual purpose:** the standardized evidence package documenting component-level benchmarking of the Validation & Benchmark domain's evaluation against the historical Part 1 validation pathway, per the Benchmarking Philosophy already locked in FRAMEWORK_SPEC.md (RDR-005, Section 8). Benchmark Evidence is distinct in purpose from Validation Evidence: Validation Evidence documents the evaluation of a Model Candidate; Benchmark Evidence documents how that evaluation compares against the historical pathway, executed within the same domain architecture.
- **Contractual existence only:** IDS-004 specifies only that Benchmark Evidence must exist where component-level benchmarking is performed, not its internal schema or the specific comparison procedure. Schema and procedure are explicitly deferred to later implementation activity.
- **Producer:** the Validation & Benchmark domain, exclusively.
- **Consumer:** the Interpretability domain (IDS-005), via the same interface as the Validated Candidate it accompanies, where produced.
- **Contractual dependencies:** depends on the completed Validation Evidence it benchmarks; does not exist independently of an underlying evaluation.
- **Verification requirements:** per Section 9 below.
- **Relationship to FRAMEWORK_SPEC:** traces directly to the Benchmarking Philosophy locked in FRAMEWORK_SPEC.md (RDR-005, Section 8); explicitly excludes end-to-end framework benchmarking, reserved for the deferred Framework Integration stage.

### 7.3 Validated Candidate

- **Contractual purpose:** represents the outcome of candidate selection (Section 8) — a Model Candidate that has undergone evaluation and been carried forward, together with its Validation Evidence (and Benchmark Evidence, where produced). It carries no claim of being enriched, interpreted, or clinically translated.
- **Producer:** the Validation & Benchmark domain, exclusively. Per Decision 004 (LOCKED) and IDS-001 Section 4 (Single-producer requirement), no other domain may produce or modify a Validated Candidate.
- **Consumer:** the Interpretability domain (IDS-005), via the Validation & Benchmark → Interpretability interface below.
- **Contractual dependencies:** depends on exactly one originating Model Candidate (Validated Candidate traceability, FRAMEWORK_SPEC.md RDR-005), and on that Candidate's complete Validation Evidence; has no dependency on any artifact from Interpretability or Clinical Translation, consistent with the acyclic dependency requirement of IDS-001 Section 6.
- **Verification requirements:** per Section 9 below.
- **Relationship to FRAMEWORK_SPEC:** traces directly to the Validated Candidate concept locked in FRAMEWORK_SPEC.md (RDR-005, Sections 5 and 7).
- **Multiplicity:** represented as a collection, per IDS-001 Section 4 and FRAMEWORK_SPEC.md's Validated Candidate Governance (RDR-005, Section 10): multiplicity of Validated Candidates may persist; this domain does not collapse multiplicity to a single outcome by itself.

No schema fields are specified for any artifact in this section; schema definition is reserved for later implementation, downstream of IDS-004.

### 7.4 Validation & Benchmark → Interpretability Interface (Producing Side)

This document fixes the producing-side contractual obligations of the Validation & Benchmark → Interpretability interface; the consuming-side obligations are reserved for IDS-005, per IDS-001 Section 5's ownership rule.

- Validation & Benchmark exposes, across this interface, the Validated Candidate(s) together with their complete Validation Evidence (and Benchmark Evidence, where produced) — and no other artifact.
- This is Validation & Benchmark's only externally contracted output interface. It exposes no interface, direct or indirect, to Clinical Translation; any artifact reaching that domain must do so via Interpretability's own contracted interface, per IDS-001 Section 5 (Explicit non-interfaces).
- **No reverse interface.** No domain may supply an input back into Validation & Benchmark through this or any other channel; this domain's only domain input is the Modeling → Validation & Benchmark interface (Section 6). This is consistent with IDS-001 Section 5 (Directionality follows FRAMEWORK_SPEC).
- Per Decision 004 (LOCKED): Interpretability consumes Validation & Benchmark artifacts; it never becomes their producer. This domain's producer ownership over the Validated Candidate, Validation Evidence, and Benchmark Evidence is exclusive and is not transferred, shared, or reassigned at the point of consumption.

---

## 8. Candidate Selection

Per Decision 006 (LOCKED, IDS-004_PREPARATION.md): Validation & Benchmark is the first implementation domain authorized to perform contractual candidate selection. This is specified strictly as a contractual responsibility:

- **Consumption:** candidate selection consumes Model Candidates, together with their complete Modeling Evidence, received via Section 6.
- **Evaluation:** candidate selection evaluates Model Candidates, producing Validation Evidence (Section 7.1) and, where applicable, Benchmark Evidence (Section 7.2) for each Candidate evaluated. No evaluation methodology, statistical criterion, ranking algorithm, threshold, or implementation procedure is specified by this contract; IDS-004 fixes only that evaluation must occur and must be documented, not how.
- **Production of a new artifact:** per Decision 007 (LOCKED), candidate selection produces a new contractual artifact — the Validated Candidate (Section 7.3) — representing the selected/validated candidate(s). Model Candidates and Modeling Evidence remain immutable throughout; selection never alters them (Section 5).
- **Complete lineage for both outcomes:** per Decision 008 (LOCKED), rejected candidates shall remain contractually traceable. No candidate — selected or non-selected — may disappear from contractual lineage. Every Model Candidate consumed via Section 6 must have a documented evaluation outcome (carried forward as a Validated Candidate, or not carried forward) that remains traceable; the absence of a Validated Candidate for a given Model Candidate is itself a traceable evaluation outcome, not a silent omission.
- **No selection authority beyond this domain.** Per FRAMEWORK_SPEC.md (RDR-005, Validated Candidate Governance): Validation & Benchmark does not collapse multiplicity by itself, and a Validated Candidate is not a final clinical decision. Candidate selection within this domain produces the framework's most evidence-complete scientific conclusions to this point, not a terminal outcome.

---

## 9. Validation & Benchmark Dependencies

- Validation & Benchmark's production depends contractually on exactly one upstream artifact pairing: the completed, complete Model Candidate(s) together with their Modeling Evidence, received via Section 6. It has no contractual dependency, of any kind, on Interpretability or Clinical Translation, consistent with the acyclic, unidirectional dependency graph fixed by IDS-001 Section 6.
- **Explicit no-dependency statement:** Validation & Benchmark has no contractual dependency on Interpretability or Clinical Translation. This is stated here as an explicit contractual property, not left as an implied consequence of domain ordering, consistent with the explicit no-dependency statements already fixed for Discovery (IDS-002, Section 7) and Modeling (IDS-003, Section 8).
- **No dependency on downstream decisions.** Validation & Benchmark has no contractual dependency upon any Interpretability or Clinical Translation decision. Those domains' outcomes shall never influence Validation & Benchmark's contractual responsibilities, its artifact contracts (Section 7), or its verification categories (Section 10); this domain's production is complete and contractually valid independent of whatever Interpretability or Clinical Translation subsequently produce.
- Validation & Benchmark's only internal dependency is on its own internally complete set of contractual responsibilities (Section 3): a Validated Candidate may not be exposed across the Section 7.4 interface until those responsibilities have produced a complete result for that Candidate.
- Per IDS-001 Section 6 (Dependency scope is limited to contracted artifacts): Validation & Benchmark depends on Modeling satisfying its artifact contract (IDS-003, Section 7) — never on any detail of how Modeling's Coding Module computed that artifact. This domain's internal responsibilities are not themselves an inter-domain dependency and are not subject to external contractual constraint; they depend only on this domain's own upstream internal outputs, never on runtime state, execution environment, or undocumented side effects of any tooling.
- Validation & Benchmark imposes no dependency, in turn, that Modeling must satisfy; Modeling's production proceeds independently of whether or how Validation & Benchmark consumes its output (IDS-003, Section 8).

---

## 10. Validation & Benchmark Verification

Per IDS-001 Section 7, the following framework-wide verification categories apply at this domain's boundaries, specialized as follows:

1. **Contract compliance** — a Validated Candidate, its Validation Evidence, and its Benchmark Evidence (where produced) each conform to the artifact contracts of Section 7; no hybrid artifact (Decision 003) is permitted to pass this check.
2. **Interface compliance** — inbound: the artifact this domain consumes arrived only via the Modeling → Validation & Benchmark interface (Section 6); outbound: the artifact it exposes reaches Interpretability only via the Validation & Benchmark → Interpretability interface (Section 7.4); no side-channel passage in either direction is compliant.
3. **Artifact completeness** — Validation Evidence is complete, per the components already defined in FRAMEWORK_SPEC.md (RDR-005, Section 7), for every Model Candidate evaluated, before a corresponding Validated Candidate is considered to exist contractually (Section 7.3); inbound, this domain treats a Model Candidate as available only once its Modeling Evidence is itself complete (Section 6).
4. **Traceability compliance** — every Validated Candidate, its Validation Evidence, and its Benchmark Evidence are traceable to exactly one originating Model Candidate, and to the Validated Candidate / Validation Evidence definitions of FRAMEWORK_SPEC.md (RDR-005, Sections 5 and 7).
5. **Downstream compatibility (downstream readiness)** — Validated Candidates and their accompanying evidence are structurally usable by Interpretability without requiring undocumented transformation.
6. **Lineage preservation** — consistent with the principle already fixed for Modeling (IDS-003, Section 9): verification shall explicitly verify that artifact lineage is preserved throughout this domain, for both selected and non-selected candidates (Section 8, Decision 008); no Model Candidate consumed via Section 6 may disappear from contractual lineage without a documented, traceable evaluation outcome. This verification concerns contractual lineage only; it does not verify scientific correctness of the lineage's content.

No verification *procedure* (statistical test, computational check, tool, evaluation criterion) is specified here; only the categories and completeness/traceability/readiness requirements a procedure must eventually satisfy.

**Verification scope.** Verification performed under IDS-004 verifies implementation contracts, contractual completeness, contractual traceability, and contractual interface compliance — the six categories above. It does not verify scientific validity, biological validity, statistical validity, or methodological correctness of any Validation & Benchmark result, including the substantive correctness of any candidate-selection outcome. Those forms of validity belong to the scientific framework (FRAMEWORK_SPEC.md and the RDR chain) rather than to this implementation specification, consistent with the verification-scope principle already fixed for Discovery (IDS-002, Section 8) and Modeling (IDS-003, Section 9).

---

## 11. Validation & Benchmark Implementation Boundaries

Inherited unchanged from IDS-001, Section 9, and restated here only as a domain-scoped reminder — not a re-specification:

IDS-004 does not introduce, and no Validation & Benchmark Coding Module specification may introduce at this design stage:

- Algorithms, statistical methods, or benchmark metrics of any kind (e.g., no naming of a specific evaluation criterion, benchmarking statistic, or selection procedure).
- Software packages, libraries, or frameworks.
- Programming languages or execution environments.
- Executable code of any form.
- Any scientific or methodological decision not already locked in FRAMEWORK_SPEC.md (RDR-005).

These boundaries apply to all Validation & Benchmark implementation responsibilities of Section 3 equally, including candidate selection (Section 8); no responsibility within this domain is exempt.

---

## 12. Traceability

| IDS-004 Section | Originating Decision | Framework Authority | Current Validation & Benchmark Contract |
|---|---|---|---|
| §3 Domain Decomposition | IDS-004_PREPARATION Decision 002 | FRAMEWORK_SPEC.md (RDR-005 §5, Validation decomposition) | IDS-001 §3.1, §3.2, §3.4 |
| §4 Responsibilities | IDS-004_PREPARATION §3 (Scope) | FRAMEWORK_SPEC.md (RDR-005 §5, §7, §8, §10) | IDS-001 §4 |
| §5 Modeling Artifact Consumption | IDS-004_PREPARATION Decision 005 | FRAMEWORK_SPEC.md (RDR-005 §6) | IDS-001 §4; IDS-003 §5, §7 |
| §6 Modeling → Validation Interface (consuming side) | IDS-004_PREPARATION Decisions 005, 008 | FRAMEWORK_SPEC.md (RDR-004 §9) | IDS-001 §5; IDS-003 §7.3 (producing side) |
| §7 Artifacts & Interface | IDS-004_PREPARATION Decisions 003, 004, 007 | FRAMEWORK_SPEC.md (RDR-005 §5, §7, §8, §10) | IDS-001 §4, §5 |
| §8 Candidate Selection | IDS-004_PREPARATION Decisions 006, 007, 008 | FRAMEWORK_SPEC.md (RDR-005 §10, Validated Candidate Governance) | IDS-001 §4 |
| §9 Dependencies | IDS-004_PREPARATION §3 (Scope) | FRAMEWORK_SPEC.md (Candidate Evolution sequencing) | IDS-001 §6 |
| §10 Verification | IDS-004_PREPARATION §3 (Scope) | FRAMEWORK_SPEC.md (RDR-005 §7) | IDS-001 §7 |
| §11 Implementation Boundaries | IDS-004_PREPARATION §3 (Scope) | FRAMEWORK_SPEC.md §1.3 (Architecture Invariants) | IDS-001 §9 |

No section of this document introduces content without an entry in this table.

---

## 13. Governance Status

**Status:** DRAFT — Phase B, pending Strategist Review and Project Coordinator approval/lock.
**Implementation:** NOT PERMITTED.

This document does not become a binding specialization of IDS-001's and IDS-003's contracts until it is explicitly locked.

---

## 14. Exit Criteria

IDS-004 may be locked only when:

1. Strategist Review confirms no algorithm, statistical method, technology, or scientific/methodological decision has been introduced.
2. Every framework-wide contract and Modeling contract referenced (Sections 5–10) is confirmed as a specialization, not a redefinition, of IDS-001 or IDS-003.
3. Section 12's traceability table is confirmed complete, with no orphaned content.
4. Project Coordinator grants explicit approval and lock.

This document is returned for Strategist Review only. No IDS-004_CLOSURE.md is generated and no IDS-005 drafting begins as part of this action.
