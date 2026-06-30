# METHODOLOGY_WORKFLOW.md

**Project:** Modernized Biomarker Discovery Framework

**Status:** Canonical Workflow

**Purpose:** Standard Operating Procedure (SOP) for developing and maintaining the Methodology Framework.

---

# 1. Purpose

This document defines the standard workflow for developing the Methodology Framework.

The Methodology Framework is responsible for describing, organizing, evaluating, benchmarking, and managing scientific methodologies independently of their software implementation.

This document governs **how methodology documents are developed**.

It does **not** define scientific methods themselves.

---

# 2. Scope

The Methodology Framework covers the complete scientific lifecycle, including:

* Data Preparation
* Quality Control
* Normalization
* Feature Engineering
* Discovery
* Modeling
* Validation
* Benchmarking
* Interpretation
* Clinical Translation

Implementation remains the responsibility of the locked Coding Framework.

Governance remains the responsibility of the Project Governance Framework.

---

# 3. Design Philosophy

The Methodology Framework follows the following principles:

* Methodology before implementation
* Evidence before recommendation
* Component-wise methodology planning
* Reuse before reinvention
* Additive evolution
* Transparent benchmarking
* Separation of methodology from implementation

The Methodology Framework extends the Coding Framework without modifying it.

---

# 4. Team Responsibilities

## Project Coordinator

* defines scientific objectives
* approves methodology decisions
* approves document locks

## Strategist

* designs methodology architecture
* reviews methodology documents
* ensures consistency with Governance and Coding Framework

## Coding Agent

* implements approved methodologies when requested
* does not redesign methodology independently

---

# 5. Canonical Workflow

Every Methodology document follows the same workflow.

```
Discussion

↓

Draft

↓

Strategist Review

↓

Revision (if required)

↓

LOCK

↓

Next Document
```

Discussion continues until the Project Coordinator confirms that the proposed design is sufficiently mature.

Multiple revision cycles are permitted before LOCK.

---

# 6. Decision Escalation

If a methodology decision cannot be resolved from existing locked documents, the work shall pause.

The unresolved question shall be discussed before development continues.

Typical examples include:

* methodology ownership
* document responsibility
* architectural boundaries
* terminology conflicts
* component classification

No architectural assumption shall be silently introduced.

---

# 7. Definition of Done

A Methodology document is considered complete when:

* objectives are achieved
* document scope is satisfied
* terminology is internally consistent
* Strategist Review is completed
* Project Coordinator approves the document
* document status becomes LOCKED

---

# 8. Relationship Between Frameworks

The Methodology Framework operates between the Coding Framework and scientific applications.

```
Governance Framework

↓

Coding Framework

↓

Methodology Framework

↓

Method Libraries

↓

Scientific Projects
```

Responsibilities remain separated across all layers.

---

# 9. Relationship Between Methodology Documents

Methodology documents collectively define the Methodology Framework.

Each document has a single responsibility.

Documents may reference one another but should avoid duplication.

The Integration document serves as the final synthesis of the completed Methodology Framework.

---

# 10. Future Evolution

The Methodology Framework evolves through additive development.

Previously locked documents remain authoritative unless explicitly reopened.

Future documents should extend the framework rather than redesign existing architecture.

Architectural changes require explicit discussion and Project Coordinator approval before adoption.

---

# Workflow Summary

```
Discussion
        ↓
Draft
        ↓
Review
        ↓
Revision (if required)
        ↓
LOCK
        ↓
Next Document
```

This workflow is the canonical operating procedure for all Methodology Framework documents.
