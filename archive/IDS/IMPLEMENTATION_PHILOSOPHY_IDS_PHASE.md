# IMPLEMENTATION_PHILOSOPHY_IDS_PHASE.md

**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework
**Document Type:** Implementation Philosophy (governs the IDS Phase)
**Governed by:** PROJECT_GOVERNANCE_PROMPT_v4.5.1.md
**Synthesizes:** FRAMEWORK_SPEC.md (the single implementation reference; introduces nothing beyond it)
**Status:** LOCKED
**Implementation:** NOT PERMITTED (this document is a philosophy, not an IDS)

---

## How to Read This Document

This document does not extend, reinterpret, or add to the locked governance chain (RDR-000 through RDR-006, Framework Integration Philosophy, FRAMEWORK_SPEC.md). It introduces no scientific, methodological, or architectural decision. Its sole purpose is to formalize, as a standing reference, the implementation philosophy that the Project Coordinator has already articulated: that a new implementation-design layer exists between the locked FRAMEWORK_SPEC and any future Coding Module, and that this layer — the IDS Phase — is design activity, not execution.

Where this document appears to touch on framework content, FRAMEWORK_SPEC.md and the RDR chain remain authoritative. If any discrepancy is later found, this document is corrected to match them, never the reverse.

This document is written to be reusable: a future framework-oriented project, substituting its own FRAMEWORK_SPEC, should be able to adopt this philosophy with the project name changed and nothing else.

---

## 1. Purpose of the IDS Phase

The IDS Phase exists to translate an already-locked, technology-agnostic, algorithm-agnostic FRAMEWORK_SPEC into a set of implementation-ready contracts, without performing the implementation itself.

A FRAMEWORK_SPEC describes *what the framework is*: its layers, its candidate evolution, its evidence packages, its boundaries. It deliberately does not describe *what someone must build* in order to produce that evidence in practice. The gap between "what the framework is" and "what must be built" is real, non-trivial, and — if left unmanaged — is exactly where unreviewed implementation decisions tend to enter a project disguised as engineering detail.

The IDS Phase exists to close that gap explicitly and reviewably, before a single line of executable code is written. Each IDS document (IDS-001 through IDS-00N, one per implementation domain) answers a narrow question: *given this locked layer/component, what must any compliant implementation receive, produce, and guarantee?* It does not answer *how* — that is left to the Coding Module that will later be built against the contract.

The IDS Phase is therefore implementation **design**, not implementation **execution**, and not Framework **execution** or **instantiation**. No Discovery, Modeling, Validation, Interpretability, or Clinical Translation work is performed during this phase, and no result of any kind is produced.

---

## 2. Relationship Between FRAMEWORK_SPEC, IDS, IMPLEMENTATION_MASTER_PLAN, Coding Modules, and Results

| Document / Activity | Answers | Does NOT answer |
|---|---|---|
| **FRAMEWORK_SPEC.md** | What is the framework? (layers, candidate evolution, evidence packages, boundaries) | What must be built? How is it sequenced? What technology is used? |
| **IDS-NNN** (per implementation domain) | What contract must a compliant implementation satisfy for this domain? (inputs, outputs, schemas, verification, boundaries) | How is the contract fulfilled? In what order are domains built? What language/package is used? |
| **IMPLEMENTATION_MASTER_PLAN.md** | In what order are Coding Modules built? What are the dependencies and milestones across all locked IDS contracts? | What does any individual contract require? What scientific/methodological decision underlies it? |
| **Coding Modules** | How is a given IDS contract actually fulfilled, in working code? | Whether the contract itself is correct — that question was closed when its IDS was locked. |
| **Results** | What did a given Coding Module, run against real or validation data, actually produce? | Nothing further — results are downstream evidence, not a re-opening of any document above. |

Each layer in this table is strictly downstream of the one above it. An IDS document is drafted only after the corresponding portion of FRAMEWORK_SPEC is locked; the IMPLEMENTATION_MASTER_PLAN is drafted only after **all** required IDS documents are locked; Coding Modules begin only after the IMPLEMENTATION_MASTER_PLAN is approved. No stage may be entered out of order, and no stage may modify the one above it.

---

## 3. Implementation Decomposition Philosophy

- **IDS defines implementation domains.** An implementation domain is a coherent unit of contractual responsibility — typically, though not necessarily one-to-one, aligned with a FRAMEWORK_SPEC layer or a clearly bounded sub-component of one (e.g., a single stage within a layer's internal architecture). A domain is defined by what crosses its boundary, not by what algorithm might eventually run inside it.
- **Coding Modules are executable implementation units.** A Coding Module is the eventual, concrete piece of code that fulfills one or more IDS contracts. The mapping between IDS documents and Coding Modules is not assumed to be one-to-one; that mapping is itself a decision reserved for the IMPLEMENTATION_MASTER_PLAN, not for any individual IDS.
- Decomposition into domains exists to make each contract independently reviewable, independently versionable, and independently replaceable — consistent with the framework's already-locked component-wise, evidence-constrained modernization philosophy (RDR-002), now extended one level down into implementation.
- **Decomposition is driven by implementation cohesion and interface boundaries, not by scientific governance granularity alone.** A domain boundary is drawn where a contract can be stated cleanly and independently verified — where the artifacts crossing a boundary are well-defined and the producer/consumer relationship is unambiguous — not merely where the RDR series happened to draw a layer boundary. Scientific governance and implementation cohesion are two different organizing concerns, and they are permitted to disagree.
- **This is why the IDS hierarchy may legitimately become more granular than the RDR hierarchy without creating a governance inconsistency.** A single RDR-defined layer may, on implementation grounds, decompose into more than one IDS domain (and, in principle, the reverse), because the RDR series organizes scientific and methodological decisions while the IDS series organizes implementation contracts. Additional IDS granularity reflects a finer implementation-cohesion partition of an already-fixed scientific architecture; it does not add, remove, or reinterpret any RDR-level decision, and it never requires reopening the RDR it specializes.

---

## 4. Contract-First Philosophy

An IDS document specifies a **contract**, not a solution. A contract is implementation-agnostic by construction: it can be satisfied by more than one technical approach, and satisfying it says nothing about which approach was chosen.

Every IDS document specifies, at minimum:

- **Artifacts** — the named inputs and outputs crossing the domain's boundary (consistent with the candidate and evidence definitions already locked in FRAMEWORK_SPEC; an IDS may not invent a new artifact type).
- **Producers** — which upstream domain or document is responsible for supplying each input artifact.
- **Consumers** — which downstream domain or document is entitled to rely on each output artifact, and under what conditions.
- **Schemas** — the structural shape each artifact must take (fields, types, required vs. optional content) sufficient for a producer and consumer to agree without either having seen the other's code.
- **Verification requirements** — what must be checked, by whom, before an artifact is considered to satisfy the contract (e.g., completeness checks, traceability checks, consistency with the locked candidate/evidence definitions) — stated as requirements, not as named statistical tests or procedures.
- **Implementation boundaries** — what is explicitly inside versus outside the domain's responsibility, so that no two IDS documents silently claim, or silently abandon, the same ground.

An IDS document that specifies *how* to compute something, rather than *what* must be true of the result, has exceeded its mandate and must be revised before lock.

**Framework-wide contracts are locked exactly once, in IDS-001.** Among the contract types listed above, those that hold across the entire framework — Artifact Contracts, Interface Contracts, Dependency Contracts, and Verification Contracts at framework scope — are defined exclusively in IDS-001, the framework-level implementation specification. This is a philosophy, not an incidental drafting choice: a contract that applies uniformly across every implementation domain belongs at the level that precedes all domains, so that it is stated once, reviewed once, and inherited everywhere, rather than risking drift through repeated restatement. IDS-002 through IDS-006 (and any subsequent domain-specific IDS) inherit these framework-wide contracts as fixed input, specialize them as needed for their own implementation domain, and must not redefine, duplicate, or override what IDS-001 has already locked at framework scope. A domain-specific IDS may add domain-scoped contracts of its own; it may not restate or alter a framework-wide one.

---

## 5. Technology-Agnostic Principle

No IDS document may name, require, recommend, or imply a specific programming language, software package, library, workflow engine, file format beyond what is strictly necessary for schema definition, or computational environment.

Technology selection is an implementation decision, made later, that must satisfy the IDS contract — it is never the reverse. A Coding Module is free to choose any technology capable of fulfilling its governing IDS contract; the contract does not change because the technology changes, and a technology change alone never requires reopening a locked IDS.

This principle directly extends the algorithm-agnostic posture already locked throughout RDR-000 through RDR-006 and FRAMEWORK_SPEC.md one level further, into the implementation-design layer, rather than relaxing it.

---

## 6. Preferred Project Workflow

The IDS Phase operates under the same role separation already established by PROJECT_GOVERNANCE_PROMPT_v4.5.1.md, specialized as follows for this project's stated working pattern:

1. **Coding Agent** drafts IDS documents and, later, the R scripts that implement locked contracts, as the project's stated implementation preference.
2. **Project Coordinator** executes implementation locally and retains final approval authority over every document and artifact.
3. **Strategist AI** reviews resulting outputs against three references, in this order: the locked governance chain, FRAMEWORK_SPEC.md, and the governing IDS document — never against unstated expectations.
4. **Coding Agent** revises the implementation, not the governing IDS, if review finds a contract violation — unless the Project Coordinator explicitly determines the contract itself requires revision, in which case that revision follows ordinary IDS governance, not an ad hoc code fix.

This workflow preserves the same strict separation between scientific/architectural authority (Strategist AI, Project Coordinator) and production work (Coding Agent) that governs every other phase of this project.

---

## 7. Authority Hierarchy

```
Governance
    ↓
FRAMEWORK_SPEC
    ↓
IDS
    ↓
IMPLEMENTATION_MASTER_PLAN
    ↓
Coding Modules
    ↓
Results
```

Authority flows strictly downward. A document at any level may constrain the levels below it; no document may modify, override, or retroactively reinterpret a document above it. A conflict discovered at a lower level is resolved by correcting the lower-level document to match the higher one, or by escalating to the Project Coordinator for a new, separately governed decision — never by silent reinterpretation.

---

## 8. Guiding Principles

- **Design before code.** Every implementation domain is fully specified as a contract before any executable code addressing it is written.
- **Contracts, not solutions.** An IDS constrains what crosses a boundary; it never constrains what happens inside it.
- **Traceability is mandatory.** Every IDS artifact must be traceable to a specific, named element of FRAMEWORK_SPEC (a layer, a candidate type, an evidence package, or a boundary already locked there). An IDS may not introduce an artifact with no FRAMEWORK_SPEC ancestor.
- **Multiplicity and non-discard apply here too.** Where FRAMEWORK_SPEC permits multiple candidates at a layer, the corresponding IDS contract must accommodate that multiplicity rather than silently assuming a single instance.
- **Reversibility of technology, irreversibility of contract.** Technology choices made under an IDS may be revisited freely; the contract itself changes only through governed revision.
- **One contract, one lock event.** Each IDS is reviewed and locked individually; locking one IDS does not retroactively lock, validate, or constrain any other not-yet-locked IDS.
- **Framework-wide contracts sit one level above domain contracts, and each is locked only once:**

  ```
  Framework-wide contracts
          ↓
      IDS-001
          ↓
  Domain contracts
          ↓
  IDS-002 through IDS-006
  ```

  Framework-wide contracts (Artifact, Interface, Dependency, Verification — at framework scope) are locked a single time, in IDS-001. Downstream domain-specific IDS documents (IDS-002 through IDS-006) do not re-lock or re-derive them; they specialize the inherited framework-wide contract for their own domain's particular artifacts and interfaces, while leaving the framework-wide contract itself untouched. "One contract, one lock event" therefore applies at two nested scopes simultaneously: once for the framework-wide contract at IDS-001, and once more for each domain's own specialization at its governing IDS — neither lock event substitutes for or reopens the other.

---

## 9. Scope and Non-Scope

**In scope for the IDS Phase:**

- Defining implementation domains and their boundaries.
- Specifying artifacts, producers, consumers, schemas, verification requirements, and implementation constraints for each domain.
- Identifying interfaces between domains, consistent with the layer boundaries already fixed in FRAMEWORK_SPEC.

**Out of scope for the IDS Phase (reserved for later, separately governed activity):**

- Selecting or naming any algorithm, statistical procedure, software package, or technology.
- Producing the IMPLEMENTATION_MASTER_PLAN (sequencing, dependency ordering, milestones across domains) — this begins only after all required IDS documents are locked.
- Writing, running, or reviewing any Coding Module.
- Generating any result, score, model, or figure.
- Executing, instantiating, or in any way running the Discovery, Modeling, Validation, or Interpretability & Clinical Translation layers, or Framework Integration. The project remains under **Option A (Framework-first)**; the IDS Phase is implementation design layered on top of the already-locked framework, and does not constitute, trigger, or substitute for Framework Execution.
- Modifying any locked RDR, Philosophy, or FRAMEWORK_SPEC content.

---

## 10. Exit Criteria Before Entering the Coding Phase

The IDS Phase is considered complete, and the project may proceed to draft IMPLEMENTATION_MASTER_PLAN.md, only when all of the following hold:

1. Every implementation domain required to realize FRAMEWORK_SPEC's locked layers and evidence packages has a corresponding IDS document.
2. Every such IDS document is individually reviewed and locked (Strategist AI review, Project Coordinator approval) — partial or majority completion is not sufficient.
3. Every locked IDS document's artifacts are traceable to a named FRAMEWORK_SPEC element, with no orphaned or invented artifact types.
4. No locked IDS document names an algorithm, statistical procedure, software package, or specific technology.
5. No open contract conflicts exist between adjacent IDS documents (i.e., every producer/consumer pairing across a domain boundary is mutually consistent).

Only once all five conditions hold does the project draft IMPLEMENTATION_MASTER_PLAN.md. Coding Modules may not begin before the IMPLEMENTATION_MASTER_PLAN itself is reviewed and approved by the Project Coordinator.

---

## Governance Status

**Status:** LOCKED (APPROVED — Project Coordinator confirmed; Strategist Review incorporated as Revisions 1–3).
**Implementation:** NOT PERMITTED.

---

## Handoff Notes

This document, once locked, becomes the standing reference governing every IDS document drafted for this project (IDS-001 through IDS-00N, covering the Discovery, Modeling, Validation, and Interpretability & Clinical Translation implementation domains, mapped from FRAMEWORK_SPEC.md). It does not itself begin IDS-001; drafting of the first domain-specific IDS document is a separate, subsequent action to be taken only after this philosophy is explicitly locked. No content in this document may be treated as authoritative over FRAMEWORK_SPEC.md or the RDR-000–006 chain; in any apparent conflict, this document yields.
