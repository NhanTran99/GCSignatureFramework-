# MODULE_TAXONOMY.md

## Document Information

**Document:** MODULE_TAXONOMY.md

**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework

**Document Type:** Canonical Module Taxonomy

**Governed by:**

* PROJECT_GOVERNANCE_PROMPT_v4.6
* FRAMEWORK_SPEC.md (LOCKED)
* IMPLEMENTATION_PHILOSOPHY_IDS_PHASE.md (LOCKED)
* IDS-001 through IDS-006 (LOCKED)

**Status:** LOCKED

---

# Purpose

MODULE_TAXONOMY defines the canonical decomposition of the locked Implementation Design Specifications (IDS) into executable Coding Modules.

Its purpose is to establish a stable execution partition for the Coding Phase.

MODULE_TAXONOMY introduces:

* no new framework architecture;
* no new implementation contracts;
* no new governance decisions.

It provides only the canonical mapping between IDS documents and Coding Modules.

---

# 1. Authority Hierarchy

The execution hierarchy is:

FRAMEWORK_SPEC

↓

Implementation Design Specifications (IDS)

↓

MODULE_TAXONOMY

↓

IMPLEMENTATION_MASTER_PLAN

↓

Coding Modules

↓

Implementation Results

Each layer specializes, but never redefines, the layer above.

---

# 2. Canonical Module Mapping

## IDS-001 — Framework Implementation

### Module 01

**Repository Bootstrap**

Purpose:

Prepare the repository execution environment and project structure.

---

### Module 02

**Framework Contracts**

Purpose:

Implement the framework-wide contracts defined by IDS-001.

---

## IDS-002 — Discovery

### Module 03

**Discovery Inputs**

Purpose:

Implement Discovery artifact ingestion.

---

### Module 04

**Discovery Processing**

Purpose:

Produce Discovery contractual artifacts.

---

### Module 05

**Discovery Outputs**

Purpose:

Verify Discovery artifacts and expose contracted Discovery outputs.

---

## IDS-003 — Modeling

### Module 06

**Model Construction**

Purpose:

Consume Discovery artifacts and produce Model Candidates.

---

### Module 07

**Model Management**

Purpose:

Implement internal Modeling responsibilities.

---

### Module 08

**Model Outputs**

Purpose:

Verify Modeling artifacts and expose contracted Modeling outputs.

---

## IDS-004 — Validation & Benchmark

### Module 09

**Validation**

Purpose:

Implement Validation responsibilities.

---

### Module 10

**Benchmark**

Purpose:

Implement Benchmark responsibilities.

---

### Module 11

**Candidate Selection**

Purpose:

Produce Validated Candidates while preserving contractual lineage.

---

## IDS-005 — Interpretability

### Module 12

**Scientific Interpretation**

Purpose:

Implement scientific interpretation responsibilities.

---

### Module 13

**Interpretation Outputs**

Purpose:

Produce the Interpretation Package and expose contracted Interpretability outputs.

---

## IDS-006 — Clinical Translation

### Module 14

**Clinical Translation**

Purpose:

Implement Clinical Translation responsibilities.

---

### Module 15

**Clinical Outputs**

Purpose:

Produce the Clinical Translation Package and expose clinically consumable outputs.

---

# 3. Canonical Execution Order

The canonical execution order is:

Module 01

↓

Module 02

↓

Module 03

↓

Module 04

↓

Module 05

↓

Module 06

↓

Module 07

↓

Module 08

↓

Module 09

↓

Module 10

↓

Module 11

↓

Module 12

↓

Module 13

↓

Module 14

↓

Module 15

Modules shall execute in this order unless a future governance decision explicitly authorizes a different orchestration strategy.

---

# 4. Module Lock Rules

The following rules are authoritative.

### Rule 001

Every Coding Module belongs to exactly one IDS.

---

### Rule 002

Every Coding Module has exactly one implementation responsibility.

---

### Rule 003

Every Coding Module produces only contracted artifacts defined by its governing IDS.

---

### Rule 004

Every Coding Module shall pass its verification checkpoint before downstream execution is permitted.

---

### Rule 005

Coding Modules shall never redefine framework-wide contracts.

---

### Rule 006

Coding Modules shall never redefine IDS contracts.

---

### Rule 007

Coding Modules implement.

IDS specify.

IMPLEMENTATION_MASTER_PLAN orchestrates.

---

# 5. Execution Traceability Principle

Execution shall remain completely traceable.

FRAMEWORK_SPEC

↓

IDS

↓

Coding Module

↓

Implementation Code

↓

Produced Artifact

↓

Verification Evidence

Every implementation component shall be traceable through this complete chain.

---

# 6. Governance Outcome

MODULE_TAXONOMY is the canonical decomposition of the Framework-Level Implementation Architecture into executable Coding Modules.

Future Coding Modules shall inherit this taxonomy.

Any modification to:

* module identities;
* module ownership;
* module responsibilities;
* module ordering;

requires formal governance.

---

# 7. Project Handoff

The next governed document is:

**IMPLEMENTATION_MASTER_PLAN.md**

IMPLEMENTATION_MASTER_PLAN shall orchestrate the execution of the locked Coding Modules.

It shall introduce no new framework architecture, implementation contracts, or module taxonomy.

Its responsibility is orchestration only.
