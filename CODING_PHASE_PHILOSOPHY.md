# CODING_PHASE_PHILOSOPHY.md

## Document Information

**Document:** CODING_PHASE_PHILOSOPHY.md

**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework

**Document Type:** Coding Governance Philosophy

**Status:** LOCKED

---

# Purpose

This document defines the canonical workflow for the Coding Phase.

It establishes collaboration principles.

It introduces:

* no implementation contracts;
* no framework decisions;
* no execution architecture.

---

# 1. Project Roles

## Project Coordinator

Responsibilities:

* initiate Coding Modules;
* execute code locally;
* collect implementation outputs;
* determine module approval.

---

## Coding Agent (Claude)

Responsibilities:

* implement the assigned Coding Module;
* follow FRAMEWORK_SPEC, IDS, MODULE_TAXONOMY, and IMPLEMENTATION_MASTER_PLAN;
* produce implementation code only;
* revise implementation following Strategist Review.

---

## Strategist AI (ChatGPT)

Responsibilities:

* review implementation consistency;
* verify governance compliance;
* review artifacts;
* identify required revisions;
* evaluate downstream readiness.

Strategist AI does not replace the Coding Agent.

Strategist AI does not execute implementation.

---

# 2. Canonical Coding Workflow

Each Coding Module shall follow:

Module Selection
        ↓
Discussion
        ↓
Coding Prompt
        ↓
Consistency Check (if required)
        ↓
Claude Implementation
        ↓
Project Coordinator Local Execution
        ↓
Strategist Review
        ↓
Revision (if required)
        ↓
Module LOCK
        ↓
Next Module

# 2A. Coding Prompt Consistency Check

Before implementation begins, every Coding Prompt shall undergo a consistency check against all previously LOCKED Coding Modules.

The objective is to ensure that newly proposed implementation does not conflict with previously established public APIs, implementation semantics, or architectural responsibilities.

The Coding Prompt shall remain the implementation specification for the current module, while all previously LOCKED implementations remain authoritative for their respective responsibilities.

The consistency workflow shall be:

Discussion

↓

Draft Coding Prompt

↓

Consistency Check

(against all previously LOCKED modules)

↓

If no conflict exists

↓

Final Coding Prompt

↓

Implementation

If a conflict is identified:

Discussion

↓

Draft Coding Prompt

↓

Consistency Check

↓

Pre-Implementation Decision Record

↓

Prompt Revision

↓

Final Coding Prompt

↓

Implementation

---

## Conflict Resolution Principles

When a conflict is identified between a new Coding Prompt and a previously LOCKED implementation, the following principles shall apply.

### 1. Locked Implementation Takes Precedence

Previously LOCKED implementations remain authoritative.

A Coding Prompt shall be revised to conform to the locked implementation.

Previously LOCKED modules shall not be modified.

---

### 2. Stable API Preservation

Public APIs established by previously LOCKED modules shall retain:

* function names;
* parameter semantics;
* return semantics;
* implementation responsibilities.

New modules may extend functionality but shall not redefine existing APIs.

---

### 3. Additive Conflict Resolution

Conflicts shall be resolved through additive implementation.

Examples include:

* introducing a new API;
* introducing a wrapper;
* introducing a new execution layer.

Previously LOCKED implementation shall remain unchanged.

---

### 4. Prompt as the Single Source of Truth

If a Pre-Implementation Decision Record is required, the Coding Prompt shall be updated before implementation begins.

The revised Coding Prompt becomes the single implementation specification for the Coding Agent.

Implementation shall not rely on external clarification messages once the Prompt has been finalized.


---

# 3. Review Philosophy

Review evaluates:

* governance compliance;
* IDS compliance;
* artifact compliance;
* downstream readiness;
* execution quality.

Review does not redesign the framework.

---

# 4. Revision Philosophy

Revisions shall be minimal.

Only identified issues shall be revised.

Approved implementation shall not be redesigned.

---

# 5. Module Lock

A module may be LOCKED only after:

* successful local execution;
* Strategist approval;
* governance compliance;
* contracted artifacts verified.

---

# 6. Execution Philosophy

Implementation shall remain fully traceable.

FRAMEWORK_SPEC

↓

IDS

↓

Coding Module

↓

Implementation Code

↓

Implementation Artifact

↓

Verification

Every implementation component shall remain traceable through the complete chain.

---

# 7. Transition

This document governs the Coding Phase beginning with:

**Module 01 — Repository Bootstrap**

Future workflow modifications require formal governance.
