# IDS-002_PREPARATION.md

## Document Information

**Document:** IDS-002_PREPARATION.md

**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework

**Document Type:** IDS Preparation (Phase A)

**Governed by:**

* PROJECT_GOVERNANCE_PROMPT_v4.5.1
* FRAMEWORK_SPEC.md (LOCKED)
* IMPLEMENTATION_PHILOSOPHY_IDS_PHASE.md (LOCKED)
* IDS-001_Framework_Implementation.md (LOCKED)

**Status:** Phase A — Preparation (Living Discussion Document)

---

# Purpose

Prepare and lock the implementation philosophy specific to the Discovery domain before drafting the official Discovery Implementation Design Specification.

IDS-002 specializes the framework-wide implementation contracts established by IDS-001.

It introduces no scientific, methodological, framework architectural, or framework-wide implementation decision.

Its responsibility is limited exclusively to the Discovery implementation domain.

---

# 1. Scope of IDS-002

IDS-002 specifies the implementation architecture for the Discovery domain.

Specifically, it defines:

* Discovery implementation responsibilities
* Discovery implementation decomposition
* Discovery artifacts
* Discovery Candidate contracts
* Discovery Evidence contracts
* Discovery interfaces
* Discovery verification
* Discovery implementation boundaries

IDS-002 does not define implementation details belonging to Modeling, Validation & Benchmark, Interpretability, or Clinical Translation.

---

# 2. Relationship to IDS-001

IDS-002 inherits all framework-wide contracts established by IDS-001.

Specifically, IDS-002 inherits without redefinition:

* Framework-wide Artifact Contracts
* Framework-wide Interface Contracts
* Framework-wide Dependency Contracts
* Framework-wide Verification Contracts

IDS-002 specializes these contracts only for the Discovery domain.

---

# 3. Discovery Domain Responsibilities

The Discovery domain is responsible for producing Discovery-specific implementation artifacts.

Its contractual responsibilities include:

* Discovery Candidate production
* Discovery Evidence production
* Discovery artifact verification
* Delivery of contracted outputs to the Modeling domain

Discovery does not perform Modeling responsibilities.

---

# 4. Discovery Artifact Philosophy

The following implementation philosophy is LOCKED for IDS-002.

### Decision 001 (LOCKED)

IDS-002 defines only the Discovery implementation domain.

No downstream domain responsibilities may be introduced.

---

### Decision 002 (LOCKED)

Discovery implementation may be decomposed into multiple implementation responsibilities provided they remain entirely within the Discovery domain boundary established by IDS-001.

---

### Decision 003 (LOCKED)

Every Discovery artifact shall have one and only one contractual purpose.

Examples:

* Discovery Candidate
* Discovery Evidence

are separate contractual artifacts.

---

### Decision 004 (LOCKED)

Every Discovery artifact shall have exactly one producer.

Artifact ownership shall be unambiguous.

Downstream domains consume Discovery artifacts but do not become their producers.

---

# 5. Discovery Candidate Philosophy

Discussion topics:

* contractual role of Discovery Candidate
* relationship to Discovery Evidence
* transition to Modeling
* candidate lineage
* candidate completeness

No implementation technology is discussed.

---

# 6. Discovery Evidence Philosophy

Discussion topics:

* evidence completeness
* evidence traceability
* evidence integrity
* evidence support for Discovery Candidate

Evidence remains distinct from Candidate.

---

# 7. Discovery Interface Philosophy

Discovery shall expose only contracted interfaces.

Discussion topics:

* Discovery → Modeling interface
* contracted outputs
* downstream compatibility
* interface verification

No implementation procedures are defined.

---

# 8. Discovery Verification Philosophy

Discovery verification shall specialize the framework-wide verification contracts established in IDS-001.

Discussion topics:

* candidate verification
* evidence verification
* artifact completeness
* interface compliance
* downstream readiness

---

# 9. Implementation Boundaries

IDS-002 shall not define:

* algorithms
* statistical methods
* feature selection methods
* software packages
* programming languages
* executable code
* implementation technology

Those belong exclusively to the Coding Modules.

---

# 10. Open Decisions

At the conclusion of Phase A, no unresolved implementation philosophy questions remain.

Future discussions shall concern only the formal specification of Discovery implementation contracts.

---

# 11. Design Lock Checklist

Before IDS-002 enters Phase B:

* Discovery scope locked
* Discovery responsibilities locked
* Discovery artifact philosophy locked
* Discovery Candidate philosophy locked
* Discovery Evidence philosophy locked
* Discovery interface philosophy locked
* Discovery verification philosophy locked
* Implementation boundaries locked

---

# Exit Condition

IDS-002_PREPARATION is complete only after explicit Project Coordinator approval.

Only after Design Lock may Claude draft:

**IDS-002_Discovery_Implementation.md**
