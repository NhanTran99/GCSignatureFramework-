# MP-004_Methodology_Registry.md

**Project:** Modernized Biomarker Discovery Framework

**Document Type:** Methodology Framework Design Document

**Governed by:** PROJECT_GOVERNANCE_PROMPT_v4.6; FRAMEWORK_SPEC.md; CODING_FRAMEWORK_INTEGRATION.md; MP-000_Methodology_Framework_Foundation.md; MP-001_Method_Taxonomy.md; MP-002_Method_Object_Specification.md; MP-003_Evidence_and_Benchmark_Framework.md

**Status:** DESIGN DOCUMENT — Registry Architecture

**Purpose:** Define the conceptual architecture of the Methodology Registry.

**Implementation:** NOT PERMITTED

---

# 1. Introduction

## 1.1 Purpose

The Methodology Registry provides the canonical catalogue of all Method Objects managed within the Methodology Framework.

Its purpose is to support methodology discovery, indexing, traceability, and navigation while preserving the separation of responsibilities established by previous Methodology Planning documents.

The Registry is an architectural component of the Methodology Framework.

It is not a software database, storage engine, or implementation technology.

---

## 1.2 Scope

The Methodology Registry governs:

* methodology identification
* methodology indexing
* metadata management
* relationship navigation
* framework traceability

The Registry does not own scientific methodologies or their evaluation records.

Instead, it provides the organizational layer through which Method Objects can be located and referenced.

---

# 2. Registry Philosophy

The Registry functions as the discovery layer of the Methodology Framework.

Its responsibility is not to contain scientific knowledge.

Its responsibility is to make scientific knowledge discoverable.

Accordingly, the Registry maintains references to Method Objects and their associated framework components without duplicating their contents.

This architecture preserves a single source of truth for each conceptual responsibility while enabling efficient navigation throughout the framework.

---

# 3. Registry Responsibilities

The Methodology Registry is responsible for:

* maintaining the catalogue of Method Objects
* assigning Registry entries to Method IDs
* organizing entries according to the canonical taxonomy
* supporting framework navigation
* preserving methodology traceability
* maintaining relationships between architectural components

The Registry does not evaluate methodologies.

The Registry does not implement methodologies.

The Registry does not compose scientific pipelines.

---

# 4. Registry Architecture

The Registry is organized around Method Objects.

Each Registry Entry corresponds to exactly one Method Object.

```text
Method Object
       │
       ▼
Registry Entry
       │
       ├── Method Object Reference
       ├── Identity Metadata
       ├── Taxonomy Reference
       ├── Lifecycle Status
       └── Navigation Metadata
```

Registry Entries function as navigational records.

Referenced information remains owned by its respective framework component.

---

# 5. Registry Entry

A Registry Entry is the canonical catalogue record corresponding to one Method Object.

The Registry Entry does not duplicate scientific content.

Instead, it aggregates references that allow every architectural component to locate and interpret the Method Object consistently.

Each Registry Entry therefore serves as the primary navigation point for a methodology throughout the Methodology Framework.

---

# 6. Registry Metadata

Each Registry Entry maintains only metadata required for identification and navigation.

Typical metadata includes:

* Method ID
* canonical method name
* taxonomy position
* current lifecycle status
* registry version
* creation information
* update history

Metadata should remain lightweight.

Scientific knowledge remains outside the Registry.

---

# 7. Registry Relationships

The Registry maintains relationships with every major architectural component of the Methodology Framework.

---

## 7.1 Relationship to Method Objects

Method Objects remain the canonical scientific entities.

Registry Entries reference Method Objects.

Registry Entries never replace Method Objects.

---

## 7.2 Relationship to the Evaluation Framework

Evidence, Benchmark, Recommendation, and Lifecycle information remain governed by the Scientific Evaluation Framework.

The Registry stores references to these records rather than duplicating them.

---

## 7.3 Relationship to Method Libraries

Relationship to Method Libraries

The Registry maintains no direct relationship with Method Libraries.

Method Libraries are reached indirectly through the Implementation Mapping maintained by each Method Object.

This separation preserves a single source of truth for implementation relationships while maintaining Registry independence.
---

## 7.4 Relationship to Project Pipelines

Project Pipelines consume approved Method Objects.

Registry Entries may reference pipeline usage for traceability.

Pipeline composition remains outside Registry responsibility.

---

# 8. Registry Principles

The Registry follows the following architectural principles.

---

## 8.1 Single Source of Truth

Each architectural responsibility maintains its own canonical owner.

The Registry references these owners.

It does not duplicate them.

---

## 8.2 Reference-Based Architecture

Registry Entries are reference-oriented.

Registry Entries reference Method Objects as the canonical scientific entities of the Methodology Framework.

Additional architectural information—including evaluation records and implementation mappings—is accessed through the owning framework component rather than duplicated within the Registry.

This preserves clear ownership boundaries and a single source of truth throughout the framework.
---

## 8.3 Discoverability

Every approved Method Object should be discoverable through the Registry.

Navigation should remain independent of implementation technology.

---

## 8.4 Traceability

Registry Entries preserve relationships among Method Objects, evaluation history, implementation mappings, and project usage.

These relationships support scientific reproducibility and long-term framework maintenance.

---

## 8.5 Extensibility

Future framework components may be connected to the Registry through additional references without modifying existing Registry architecture.

The Registry therefore evolves through extension rather than redesign.

---

# 9. Overall Assessment

The Methodology Registry establishes the navigational architecture of the Methodology Framework.

Previous documents define:

* why methodologies exist (MP-000),
* how they are organized (MP-001),
* how they are represented (MP-002),
* how they are evaluated (MP-003).

The Registry enables these architectural components to function together through a unified reference system while preserving clear ownership boundaries.

The Registry therefore serves as the discovery and navigation layer of the Methodology Framework.

---

# 10. Governance Status

**Status:** DESIGN DOCUMENT

This document defines the conceptual architecture of the Methodology Registry.

It introduces no implementation technology, database schema, storage mechanism, indexing algorithm, or software interface.

Future Methodology Planning documents shall reference the Registry as the canonical catalogue and navigation component of the Methodology Framework.

---

**End of MP-004_Methodology_Registry.md**
