# IDS-004_PREPARATION.md

## Document Information

**Document:** IDS-004_PREPARATION.md

**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework

**Document Type:** IDS Preparation (Phase A)

**Governed by:**

* PROJECT_GOVERNANCE_PROMPT_v4.5.1
* FRAMEWORK_SPEC.md (LOCKED)
* IMPLEMENTATION_PHILOSOPHY_IDS_PHASE.md (LOCKED)
* IDS-001_Framework_Implementation.md (LOCKED)
* IDS-002_Discovery_Implementation.md (LOCKED)
* IDS-003_Modeling_Implementation.md (LOCKED)

**Status:** Phase A — Preparation (Living Discussion Document)

---

# Purpose

Prepare and lock the implementation philosophy specific to the Validation & Benchmark domain before drafting the official Validation & Benchmark Implementation Design Specification.

IDS-004 specializes the framework-wide implementation contracts established by IDS-001 and builds upon the Modeling domain contracts established by IDS-003.

It introduces no scientific, methodological, framework architectural, or framework-wide implementation decision.

Its responsibility is limited exclusively to the Validation & Benchmark implementation domain.

---

# 1. Scope of IDS-004

IDS-004 specifies the implementation architecture for the Validation & Benchmark domain.

Specifically, it defines:

* Validation implementation responsibilities
* Validation implementation decomposition
* Validation Evidence contracts
* Benchmark Evidence contracts
* Selected Candidate contracts
* Modeling → Validation consumption philosophy
* Validation interfaces
* Validation dependencies
* Validation verification
* Validation implementation boundaries

IDS-004 does not define implementation details belonging to Modeling, Interpretability, or Clinical Translation.

---

# 2. Relationship to Previous IDS Documents

IDS-004 inherits all framework-wide contracts established by IDS-001.

IDS-004 consumes the Modeling contracts established by IDS-003 without modifying them.

Framework-wide contracts remain governed exclusively by IDS-001.

Modeling contracts remain governed exclusively by IDS-003.

IDS-004 specializes these contracts only for the Validation & Benchmark domain.

---

# 3. Validation Artifact Philosophy

The following implementation philosophy is LOCKED for IDS-004.

### Decision 001 (LOCKED)

IDS-004 defines only the Validation & Benchmark implementation domain.

---

### Decision 002 (LOCKED)

Validation & Benchmark implementation may be internally decomposed into multiple implementation responsibilities provided they remain entirely within the Validation & Benchmark domain boundary established by IDS-001.

---

### Decision 003 (LOCKED)

Every Validation artifact shall have one and only one contractual purpose.

---

### Decision 004 (LOCKED)

Every Validation artifact shall have exactly one producer.

---

### Decision 005 (LOCKED)

Validation shall consume Modeling artifacts without modifying them.

---

### Decision 006 (LOCKED)

Validation & Benchmark is the first implementation domain authorized to perform contractual candidate selection.

---

### Decision 007 (LOCKED)

Candidate selection shall produce a new contractual artifact.

No Modeling artifact shall be modified.

---

### Decision 008 (LOCKED)

Rejected candidates shall remain contractually traceable.

No candidate shall disappear from contractual lineage.

---

# 4. Design Lock Checklist

* Validation scope locked
* Artifact philosophy locked
* Candidate selection philosophy locked
* Validation interfaces locked
* Validation verification philosophy locked
* Implementation boundaries locked

---

# Exit Condition

IDS-004_PREPARATION is complete only after explicit Project Coordinator approval.

Only after Design Lock may Claude draft:

**IDS-004_Validation_Benchmark_Implementation.md**
