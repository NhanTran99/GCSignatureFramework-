# IDS-004_CLOSURE.md

## 1. Document Information

**Document:** IDS-004_CLOSURE.md
**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework
**Closes:** IDS-004_Validation_Benchmark_Implementation.md
**Governing documents:** PROJECT_GOVERNANCE_PROMPT_v4.6; FRAMEWORK_SPEC.md (LOCKED); IMPLEMENTATION_PHILOSOPHY_IDS_PHASE.md (LOCKED); IDS-001_Framework_Implementation.md (LOCKED); IDS-002_Discovery_Implementation.md (LOCKED); IDS-003_Modeling_Implementation.md (LOCKED); IDS-004_PREPARATION.md (LOCKED)
**Status:** LOCKED

---

## 2. Purpose

IDS-004_CLOSURE.md records the officially locked implementation specification for the Validation & Benchmark domain, as fixed in IDS-004_Validation_Benchmark_Implementation.md. No additional implementation guidance, interpretation, or decision is introduced here. This is an immutable governance snapshot only.

---

## 3. Scope Locked

IDS-004 officially locked:

- Validation & Benchmark implementation responsibilities
- Validation domain decomposition
- Modeling artifact consumption contract
- Validation Evidence contract
- Benchmark Evidence contract
- Validated Candidate contract
- Candidate selection contract
- Modeling → Validation interface (consuming side)
- Validation → Interpretability interface (producing side)
- Validation dependency contract
- Validation verification contract
- Validation implementation boundaries

---

## 4. Locked Decisions

The following are now authoritative, as fixed in IDS-004:

- **Validation domain specialization** — IDS-004 specializes, without redefining, the framework-wide contracts established by IDS-001 and the Modeling contracts established by IDS-003, scoped exclusively to the Validation & Benchmark implementation domain.
- **Internal implementation responsibilities** — Validation & Benchmark's contractual responsibilities correspond to the Validation decomposition already locked in FRAMEWORK_SPEC.md, treated as implementation responsibilities rather than a fixed coding-module decomposition; implementation may realize each responsibility differently while the responsibilities themselves remain stable.
- **One contractual purpose per Validation artifact** — Validation Evidence, Benchmark Evidence, and Validated Candidate are distinct contractual artifacts; no hybrid artifact is permitted.
- **Single producer requirement** — every Validation artifact has exactly one producer, the Validation & Benchmark domain; Interpretability consumes Validation & Benchmark artifacts and never becomes their producer.
- **Read-only consumption of Modeling artifacts** — Validation & Benchmark consumes Modeling artifacts without modifying them; immutable artifact property and read-only contractual consumption are two distinct, explicit contractual guarantees, and consumption never transfers Modeling's producer ownership to Validation & Benchmark.
- **Validation as the first contractual candidate-selection authority** — Validation & Benchmark is the first implementation domain authorized to perform contractual candidate selection; no upstream domain holds this authority.
- **Candidate selection produces new contractual artifacts** — selection produces the Validated Candidate as a new, distinct artifact; Model Candidates and Modeling Evidence remain immutable throughout selection.
- **Preservation of complete contractual lineage** — rejected candidates remain contractually traceable; no candidate, selected or non-selected, may disappear from contractual lineage.
- **Contract-only verification philosophy** — verification under IDS-004 verifies implementation contracts, contractual completeness, contractual traceability, contractual interface compliance, and contractual lineage preservation; it does not verify scientific, biological, statistical, or methodological validity, including the substantive correctness of any candidate-selection outcome.

These decisions are recorded as locked; they are not reinterpreted here.

---

## 5. Inheritance

IDS-004 inherits, without redefinition, from IDS-001:

- Framework-wide Artifact Contracts
- Framework-wide Interface Contracts
- Framework-wide Dependency Contracts
- Framework-wide Verification Contracts

IDS-004 inherits, without redefinition, Modeling contractual outputs from IDS-003.

---

## 6. Traceability

Every Validation & Benchmark implementation contract fixed in IDS-004 remains traceable to:

- FRAMEWORK_SPEC.md
- IMPLEMENTATION_PHILOSOPHY_IDS_PHASE.md
- IDS-001_Framework_Implementation.md
- IDS-003_Modeling_Implementation.md

---

## 7. Governance Outcome

- IDS-004 is officially LOCKED.
- Future revisions require formal governance.
- Validation & Benchmark implementation is now governed by IDS-004.
- No implementation code is authorized by this document.

---

## 8. Handoff

**Next governed activity:** IDS-005_PREPARATION.md

IDS-005 itself is not generated as part of this closure.

---

**Status:** LOCKED — immutable.
