# IDS-001_Framework_Implementation.md

**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework
**Document Type:** Implementation Design Specification (Framework-Level)
**Governed by:** PROJECT_GOVERNANCE_PROMPT_v4.5.1.md; FRAMEWORK_SPEC.md (LOCKED); IMPLEMENTATION_PHILOSOPHY_IDS_PHASE.md (LOCKED); IDS-001_PREPARATION.md (LOCKED, Phase A)
**Status:** LOCKED
**Implementation:** NOT PERMITTED (this document specifies contracts, not code)

---

## 1. Document Purpose

IDS-001 is the framework-level Implementation Design Specification. Its sole responsibility is to translate the already-locked FRAMEWORK_SPEC.md into the implementation architecture and framework-wide contracts that every subsequent, domain-specific IDS document (IDS-002 through IDS-006) must inherit and specialize.

IDS-001 introduces no scientific, methodological, or framework-architectural decision. It introduces no algorithm, statistical procedure, software package, programming language, or executable code. It exists entirely within the implementation-design layer fixed by IMPLEMENTATION_PHILOSOPHY_IDS_PHASE.md, between FRAMEWORK_SPEC.md and IMPLEMENTATION_MASTER_PLAN.md.

Per IDS-001_PREPARATION.md, Decision 001 (LOCKED): framework-wide implementation contracts are defined exclusively in this document. No downstream IDS document may redefine them.

---

## 2. Relationship to FRAMEWORK_SPEC

IDS-001 takes FRAMEWORK_SPEC.md as fixed, authoritative input and does not restate its scientific content beyond what is necessary to anchor each contract. Specifically, IDS-001 treats the following FRAMEWORK_SPEC elements as given and non-negotiable:

- The four-layer vertical architecture (Scientific → Framework Philosophy → Computational → Evidence) and the eight horizontal cross-cutting principles.
- The Candidate Evolution chain (Discovery Candidate → Model Candidate → Validated Candidate, together with Enrichment Evidence → Framework-Wide Recommendation → Recommended Signature).
- The named Evidence packages (Discovery Evidence, Model Evidence, Validation Evidence, Enrichment Evidence) and their required components.
- The Stage vs. Layer distinction (Discovery, Modeling, Validation, Interpretability & Clinical Translation as artifact-transforming Layers; Framework Integration as a non-transforming Stage).
- The Architecture Invariants vs. Replaceable Components distinction (Section 1.3 of FRAMEWORK_SPEC.md).

IDS-001 does not reproduce FRAMEWORK_SPEC.md's content; it specifies, for the elements above, what an implementation must structurally honor in order to remain compliant. Where IDS-001 and FRAMEWORK_SPEC.md appear to diverge, FRAMEWORK_SPEC.md governs and IDS-001 must be corrected.

---

## 3. Framework-Level Implementation Architecture

The implementation architecture decomposes the framework into **implementation domains**, each corresponding to a coherent, independently verifiable unit of contractual responsibility (per IMPLEMENTATION_PHILOSOPHY_IDS_PHASE.md, Section 3).

### 3.1 Domain Identification

Six implementation domains are identified at this framework level:

| Domain | Governing IDS | Corresponding FRAMEWORK_SPEC element |
|---|---|---|
| Framework-Level Implementation Architecture (this domain) | IDS-001 — Framework Implementation | Cross-cutting architecture; framework-wide contracts |
| Discovery | IDS-002 — Discovery Implementation | Discovery Layer; Discovery Candidate; Discovery Evidence |
| Modeling | IDS-003 — Modeling Implementation | Modeling Layer; Model Candidate; Model Evidence |
| Validation & Benchmark | IDS-004 — Validation & Benchmark Implementation | Validation Layer; Validated Candidate; Validation Evidence |
| Interpretability | IDS-005 — Interpretability Implementation | Interpretability & Clinical Translation Layer (interpretability scope); Enrichment Evidence (biological interpretation, model explanation components) |
| Clinical Translation | IDS-006 — Clinical Translation Implementation | Interpretability & Clinical Translation Layer (clinical translation scope); Enrichment Evidence (clinical translation component) |

This table fixes domain identity and numbering only. It does not authorize drafting of IDS-002 through IDS-006; each remains subject to its own Phase A preparation and lock, per IMPLEMENTATION_PHILOSOPHY_IDS_PHASE.md.

Framework Integration remains a separate, deferred project stage under Option A (Framework-first), per FRAMEWORK_SPEC.md and FRAMEWORK_INTEGRATION_CLOSURE.md. It is not represented by, and does not correspond to, any IDS document in this roadmap.

### 3.2 Domain Boundary Principle

A domain boundary is drawn where an artifact crossing it can be given a stable schema and an unambiguous producer/consumer pairing, independent of what algorithm or method eventually executes inside the domain (IMPLEMENTATION_PHILOSOPHY_IDS_PHASE.md, Section 3). Domain boundaries in this table align with FRAMEWORK_SPEC.md's Layer boundaries at this framework level; a downstream domain-specific IDS may further subdivide its own domain into finer implementation-cohesion units without requiring revision of this table, provided the finer units remain entirely inside the domain's boundary as fixed here.

### 3.3 Implementation Independence Between Domains

Domains are implementation-independent: a compliant implementation of one domain must not require knowledge of, or dependency on, the internal implementation of another domain — only on the contracted artifacts crossing the boundary between them. This preserves the Discovery/Modeling/Validation/Interpretability/Clinical Translation interface boundaries already fixed in FRAMEWORK_SPEC.md (Sections 9 of RDR-003 through RDR-005, and the Interpretability & Clinical Translation Layer boundary of RDR-006) at the implementation level.

### 3.4 Extensibility

The implementation-domain architecture fixed in Section 3.1 (IDS-001 through IDS-006) is considered **complete for Framework v1.0**. No additional implementation domain may be introduced under the current framework version. Introducing an additional implementation domain — whether to subdivide an existing domain further at this framework level, or to represent a new domain not listed in Section 3.1 — requires explicit future governance approval through a separately governed decision, and is outside the scope of the current framework version. This closes, rather than leaves open, the domain set that downstream IDS-002 through IDS-006 specialize.

### 3.5 Repository-Level Organization

At the repository level, implementation artifacts are organized so that each domain's contracted inputs, outputs, and verification records are locatable independently of every other domain's. This document does not fix directory names, file formats, or storage technology (Section 9, Implementation Boundaries) — it fixes only the requirement that domain separation visible in Section 3.1 must be reflected in how implementation artifacts are organized, however that organization is technically realized.

---

## 4. Framework-Wide Artifact Contracts

An **artifact**, at framework level, is any named object that crosses a domain boundary and that FRAMEWORK_SPEC.md already recognizes as a Candidate or an Evidence package (Section 2 above). IDS-001 fixes the framework-wide rules governing all such artifacts; it does not enumerate domain-specific artifact instances, which belong to IDS-002 through IDS-006.

Framework-wide rules:

- **Named-ancestor requirement.** Every artifact crossing a domain boundary must be traceable to a specific Candidate type or Evidence package already named in FRAMEWORK_SPEC.md. No domain-specific IDS may introduce an artifact with no such ancestor.
- **Single-producer requirement.** Every artifact has exactly one domain or document responsible for producing it. Joint or ambiguous production is not permitted; where a downstream domain modifies an artifact (e.g., Enrichment Evidence extending Validation Evidence, RDR-006), the extension is itself treated as a distinct, separately attributed artifact layered on the original, not a rewrite of it.
- **Immutability after handoff.** Once an artifact has crossed a domain boundary and been accepted by its consumer, the producing domain may not silently mutate it. A correction requires a new, versioned artifact instance, not an in-place edit.
- **Multiplicity accommodation.** Where FRAMEWORK_SPEC.md permits multiplicity of a Candidate type (e.g., multiple Discovery Candidates, RDR-003 Section 7), the artifact contract for that Candidate type must represent a collection, not assume a singleton, and must not silently discard any member.
- **Completeness gating.** An artifact is not considered to exist, for contractual purposes, until all required components of its corresponding Evidence package (as named in FRAMEWORK_SPEC.md Section 3) are present. A partially populated artifact may not be passed to a consumer domain as if complete.

Concrete schemas (field names, types, required/optional structure) for each artifact are domain-specific content and are reserved for IDS-002 through IDS-006.

---

## 5. Framework-Wide Interface Contracts

An **interface** is the boundary between two domains across which one or more artifacts pass. IDS-001 fixes the framework-wide rules governing every such boundary.

**Participation vs. ownership.** An interface contract is *jointly defined* by the producing domain and the consuming domain — both must agree on what artifact crosses the boundary and in what shape, since neither domain alone can determine compliance. However, the interface contract is *owned and formally specified* by the consuming domain's governing IDS document. Participation describes who must agree to the contract's content; ownership describes which document is the authoritative, single place where that agreed content is formally written down and locked. The producing domain participates in defining the contract but does not hold a competing, independent specification of it elsewhere.

- **One contracted interface per domain pair.** Each ordered pair of adjacent domains (e.g., Discovery → Modeling) has exactly one governing interface contract, specified in the consuming domain's IDS document (e.g., the Discovery → Modeling interface is specified where IDS-003 defines its required inputs), and that contract is the only legitimate channel by which artifacts may pass between those two domains.
- **No side-channel passage.** An artifact may not reach a consuming domain by any path other than its contracted interface — informal, undocumented, or convenience pathways between domains are not compliant, regardless of technical feasibility.
- **Directionality follows FRAMEWORK_SPEC.** Interface directionality mirrors the Candidate Evolution chain and Layer sequencing already fixed in FRAMEWORK_SPEC.md (Discovery → Modeling → Validation & Benchmark → Interpretability → Clinical Translation, with Framework Integration following as a separate, deferred project stage rather than an IDS-governed domain). No domain-specific IDS may introduce a reverse-direction interface (e.g., Validation & Benchmark supplying an input back into Discovery) without a separately governed architectural decision upstream of IDS-001.
- **Interface stability.** An interface contract, once locked in its governing IDS, may be specialized (e.g., additional optional fields) but not narrowed or redirected without a governed revision to that IDS — a Coding Module's technology choice never justifies an interface change.
- **Explicit non-interfaces.** Any two non-adjacent domains (e.g., Discovery and Interpretability, or Discovery and Clinical Translation) have no direct interface; any artifact reaching a non-adjacent domain must do so by passing through the intermediate domains' contracted interfaces in sequence, consistent with FRAMEWORK_SPEC.md's Layer sequencing.

---

## 6. Framework-Wide Dependency Contracts

A **dependency**, at framework level, is a requirement that one domain's artifact be available and complete before another domain may begin producing its own.

- **Sequential dependency by default.** Each domain's production depends on the completed, complete artifact(s) of its immediate upstream domain(s), per the Candidate Evolution chain. A domain may not begin production against an incomplete or provisional upstream artifact.
- **No circular dependency.** The dependency graph among the six domains of Section 3.1 must remain acyclic, consistent with FRAMEWORK_SPEC.md's unidirectional Layer sequencing and the explicit exclusion of reverse interfaces (Section 5 above).
- **Dependency is on contracts, not on implementations.** A downstream domain depends on its upstream domain satisfying the relevant artifact contract (Section 4) — never on any detail of how the upstream domain's Coding Module computed that artifact. This preserves technology independence between domains.
- **Sequencing across domains is reserved for IMPLEMENTATION_MASTER_PLAN.md.** IDS-001 fixes that dependencies are acyclic and contract-based; it does not fix build order, scheduling, or milestone sequencing across Coding Modules — those are IMPLEMENTATION_MASTER_PLAN responsibilities (IMPLEMENTATION_PHILOSOPHY_IDS_PHASE.md, Section 2).
- **Dependency scope is limited to contracted artifacts.** A dependency contract may depend only on contracted artifacts. It must never depend on implementation details, runtime state, execution environment, or any undocumented side effects of how an upstream domain's Coding Module operates. If a downstream domain finds itself needing something an upstream artifact contract does not already provide, the correct response is to propose a governed revision to that artifact contract — never to depend informally on whatever the current implementation happens to expose.

---

## 7. Framework-Wide Verification Contracts

**Verification**, at framework level, is the set of checks an artifact or interface must pass before it may be treated as contract-compliant. IDS-001 fixes the categories of verification required everywhere in the framework; domain-specific verification procedures (what is actually checked, and how) are specified in IDS-002 through IDS-006.

Framework-wide verification categories, required at every domain boundary:

1. **Contract compliance** — the artifact conforms to its framework-wide and domain-specific artifact contract (Section 4; corresponding domain IDS).
2. **Interface compliance** — the artifact arrived through its single contracted interface (Section 5), not a side channel.
3. **Artifact completeness** — all required Evidence components are present (Section 4, completeness gating).
4. **Traceability compliance** — the artifact's ancestry to a named FRAMEWORK_SPEC element, and (where applicable) its Candidate lineage (e.g., Model Candidate → exactly one originating Discovery Candidate, per RDR-004 Section 6), is intact and documented.
5. **Downstream compatibility** — the artifact, as produced, is structurally usable by its declared consumer(s) without requiring undocumented transformation.

A verification gate failing any of the five categories blocks progression to the consuming domain; it does not block, alter, or reopen any other already-completed domain's artifacts.

Verification responsibility follows the role separation already fixed in IMPLEMENTATION_PHILOSOPHY_IDS_PHASE.md, Section 6: the Coding Agent produces artifacts and a first-pass compliance check; the Strategist AI reviews against the governing IDS, FRAMEWORK_SPEC.md, and the locked governance chain; the Project Coordinator retains final approval.

---

## 8. Cross-Cutting Implementation Principles

The following principles apply uniformly across every implementation domain and are not subject to domain-specific override:

- **Artifact lineage.** Every artifact must carry a record of which domain produced it, from which upstream artifact(s) it was derived, and at what point in the Candidate Evolution chain it sits.
- **Metadata consistency.** Every artifact is accompanied by metadata sufficient to identify its producing domain, its governing IDS contract, and its version, in a structurally consistent form across all domains (the specific metadata schema is domain-specific content, reserved for IDS-002 through IDS-006).
- **Implementation traceability.** It must be possible to trace, for any artifact, the full chain of contracts it satisfied, back to the FRAMEWORK_SPEC element it ultimately implements.
- **Reproducibility.** Any artifact must be regenerable from its declared upstream inputs and a record of the process used, consistent with FRAMEWORK_SPEC.md's horizontal Reproducibility principle (Section 1.2) — without this requirement naming any specific reproducibility mechanism or tool.
- **Configuration philosophy.** Where an implementation requires configurable parameters, the existence and role of such configuration is acknowledged at the contract level (an artifact's schema may depend on declared configuration), but no configuration value, format, or mechanism is fixed here.
- **Version compatibility.** A change to any artifact's schema is itself versioned; a consuming domain's contract specifies which artifact version(s) it accepts, so that schema evolution does not silently break an existing interface.
- **Implementation independence.** Restated from Section 3.3 as a cross-cutting principle: no domain's Coding Module may depend on another domain's internal implementation, only on its contracted artifacts.
- **Contract Stability.** Framework-wide contracts established by IDS-001 remain stable throughout implementation. Coding Modules may evolve. Implementation technologies may evolve. Implementation strategies may evolve. Framework-wide contracts evolve only through governed revision of IDS-001 — never as a side effect of a Coding Module change, a technology change, or a strategy change at any domain.

---

## 9. Implementation Boundaries

IDS-001 does not specify, and no future revision of IDS-001 may introduce, any of the following:

- Algorithms or statistical procedures of any kind.
- Machine learning methods, model families, or model selection criteria.
- Software packages, libraries, or frameworks.
- Programming languages or execution environments.
- Executable code of any form.
- File formats, storage technologies, or workflow engines, beyond what is strictly necessary to describe a schema's structural shape in domain-specific IDS documents.
- Any scientific, methodological, or framework-architectural decision not already locked in FRAMEWORK_SPEC.md.

These boundaries are inherited unchanged by IDS-002 through IDS-006; no downstream IDS document may relax them.

---

## 10. Downstream Responsibilities of IDS-002 through IDS-006

Each domain-specific IDS document (IDS-002 Discovery Implementation, IDS-003 Modeling Implementation, IDS-004 Validation & Benchmark Implementation, IDS-005 Interpretability Implementation, IDS-006 Clinical Translation Implementation) must:

- Inherit, without redefinition, every framework-wide contract fixed in this document (Sections 4–7).
- Specialize those framework-wide contracts for its own domain: naming its specific artifacts (with FRAMEWORK_SPEC ancestry), its specific interfaces to adjacent domains, its specific dependency requirements, and its specific verification procedures.
- Respect the implementation boundaries of Section 9 in full; a domain-specific IDS has no greater license to name technology or algorithms than IDS-001 does.
- Undergo its own Phase A (Preparation) and Phase B (drafting) sequence, with its own Strategist Review and Project Coordinator lock, independent of any other domain-specific IDS's review status.
- Declare explicitly, at the point of its own lock, that it has not redefined any framework-wide contract — a compliance statement reviewable against this document.

No domain-specific IDS may be locked while in conflict with this document. A conflict discovered after a domain-specific IDS is locked is resolved by revising the domain-specific IDS to match IDS-001, never the reverse, unless the Project Coordinator separately determines that IDS-001 itself requires governed revision.

---

## 11. Traceability Requirements

Every contract, principle, and boundary fixed in this document must be traceable to a named element of FRAMEWORK_SPEC.md or to a locked statement of IMPLEMENTATION_PHILOSOPHY_IDS_PHASE.md or IDS-001_PREPARATION.md. The table below records this traceability at the section level:

| IDS-001 Section | Traces to |
|---|---|
| §3 Framework-Level Implementation Architecture | FRAMEWORK_SPEC §1 (Vertical/Horizontal Architecture, Stage vs. Layer); IMPLEMENTATION_PHILOSOPHY §3 |
| §4 Artifact Contracts | FRAMEWORK_SPEC §2–3 (Candidate Evolution, Evidence Evolution); IMPLEMENTATION_PHILOSOPHY §4; IDS-001_PREPARATION §8 Decision 001 |
| §5 Interface Contracts | FRAMEWORK_SPEC layer interface sections (RDR-003 §9, RDR-004 §9, RDR-005 §9); IDS-001_PREPARATION §8 Decision 001 |
| §6 Dependency Contracts | FRAMEWORK_SPEC Candidate Evolution sequencing; IMPLEMENTATION_PHILOSOPHY §2 |
| §7 Verification Contracts | FRAMEWORK_SPEC §1.2 horizontal principles (Auditability, Reproducibility); IMPLEMENTATION_PHILOSOPHY §6 |
| §8 Cross-Cutting Principles | FRAMEWORK_SPEC §1.2 (Horizontal Architecture) |
| §9 Implementation Boundaries | FRAMEWORK_SPEC §1.3 (Architecture Invariants vs. Replaceable Components); IMPLEMENTATION_PHILOSOPHY §5 |
| §10 Downstream Responsibilities | IDS-001_PREPARATION §2; IMPLEMENTATION_PHILOSOPHY §3 (Revision 1), §4 (Revision 2), §8 (Revision 3) |

No section of this document introduces content without an entry in this table.

---

## 12. Governance Status

**Status:** LOCKED.
**Implementation:** NOT PERMITTED.

IDS-001 is now the authoritative framework-level implementation specification. IDS-002 through IDS-006 inherit its framework-wide contracts (Sections 4–7) and must specialize, not redefine, them. Any revision to IDS-001 requires formal governance review and re-lock; it may not be revised informally or as a side effect of drafting any downstream IDS document.

---

## 13. Exit Criteria

IDS-001 was locked upon confirmation that all of the following held:

1. Strategist Review confirmed no scientific, methodological, framework-architectural, or technology decision had been introduced.
2. Every contract in Sections 4–7 is stated as a requirement on artifacts/interfaces/dependencies/verification, not as a procedure for satisfying them.
3. Every section's content is traceable per the Section 11 table, with no orphaned content.
4. The Implementation Boundaries of Section 9 are confirmed unviolated throughout the document.
5. Project Coordinator granted explicit approval and lock.

With IDS-001 now LOCKED, Phase A preparation may begin for IDS-002 (Discovery Implementation). No IDS-001_CLOSURE.md is generated and no IDS-002 drafting begins as part of this action.
