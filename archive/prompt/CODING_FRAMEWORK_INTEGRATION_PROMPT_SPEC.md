# CODING_FRAMEWORK_INTEGRATION_PROMPT_SPEC.md

---

# Document

**Coding Framework Integration**

Governed by:

* PROJECT_GOVERNANCE_PROMPT_v4.6
* FRAMEWORK_SPEC.md
* IMPLEMENTATION_MASTER_PLAN.md
* CODING_PHASE_PHILOSOPHY.md
* IDS-003 through IDS-006
* Discovery Checkpoint
* Modeling Checkpoint
* Validation Checkpoint
* Interpretation Checkpoint
* Clinical Translation Checkpoint

Status:

**DESIGN LOCK**

This document specifies the synthesis requirements for the Coding Framework Integration.

Coding Framework Integration is **not** a Coding Module.

It introduces:

* no implementation;
* no governance changes;
* no framework contract changes;
* no API changes.

Its purpose is to synthesize the completed Coding Phase (Modules 01–15) into a single canonical Coding Framework document.

---

# 1. Purpose

Produce one canonical document:

`CODING_FRAMEWORK_INTEGRATION.md`

This document shall synthesize the complete Coding Phase.

It SHALL NOT:

* implement new functionality;
* redesign architecture;
* modify Governance;
* modify IDS;
* reinterpret LOCKED modules;
* introduce methodology.

The Integration document is a synthesis artifact only.

---

# 2. Inputs

Claude shall synthesize information from:

* Modules 01–15
* all Module Reviews
* all Module LOCK records
* all five Checkpoints
* Framework Specification
* Implementation Master Plan
* Coding Phase Philosophy

No external information shall be introduced.

---

# 3. Required Structure

The document shall contain exactly the following sections.

---

## Section 1

Coding Phase Summary

Summarize:

* overall objectives;
* scope;
* IDS domains covered;
* implementation boundaries;
* completion status.

---

## Section 2

Overall Execution Architecture

Describe the execution architecture established throughout the Coding Phase.

Required diagram:

Workflow

↓

Executor

↓

Implementation Object

↓

Framework Artifact

Explain:

* orchestration;
* execution separation;
* implementation state;
* framework contracts.

Do not introduce alternative architectures.

---

## Section 3

Implementation Object Hierarchy

Summarize every implementation object produced during the Coding Phase.

Present the complete hierarchy.

Explain the responsibility of each object.

No implementation details.

---

## Section 4

Framework Artifact Hierarchy

Summarize every Framework artifact.

Present the complete artifact lineage.

Explain downstream responsibilities.

No new artifacts shall be introduced.

---

## Section 5

Callback Execution Architecture

Summarize the callback pattern established throughout the Coding Phase.

Include:

* trainer
* validator
* benchmarker
* selector
* interpreter
* integrator
* translator
* output_generator

Explain:

* why callbacks were adopted;
* generic execution;
* future extensibility.

No new callback types.

---

## Section 6

framework_layer Taxonomy

Summarize the complete framework_layer taxonomy.

Explain:

* purpose;
* consistency;
* domain progression.

Do not modify taxonomy.

---

## Section 7

artifact_role Taxonomy

Summarize the complete artifact_role taxonomy.

Explain:

* contractual responsibilities;
* downstream relationships;
* implementation/framework separation.

Do not introduce additional roles.

---

## Section 8

Verified Design Principles

Summarize only principles that were demonstrated by implementation.

Include:

* Zero/Generic Implementation Principle
* Additive-only Principle
* Stable Public API
* Callback Extensibility
* One-hop Artifact Consumption
* Read-only Upstream Artifacts
* Workflow Separation
* Implementation / Framework Separation
* Complete Lineage Preservation

Do not introduce new principles.

---

## Section 9

Retrospective Design Lessons

Summarize lessons learned from implementation.

Include:

Object Maturity Principle

as a retrospective design lesson only.

Clearly state:

This lesson is NOT Governance.

This lesson does NOT modify Framework rules.

Additional retrospective observations may be included if directly supported by completed implementation.

---

## Section 10

Relationship Between Documentation Layers

Explain the relationship among:

Modules

↓

Strategist Reviews

↓

Checkpoints

↓

Coding Framework Integration

Clarify the role of each layer.

Emphasize:

Modules are implementation history.

Reviews verify implementation quality.

Checkpoints synthesize completed phases.

Coding Framework Integration is the canonical synthesis of the entire Coding Phase.

---

## Section 11

Overall Assessment

Provide a synthesis of the completed Coding Phase.

Summarize:

* architectural maturity;
* implementation consistency;
* framework readiness;
* downstream readiness.

Do not propose new implementation.

---

# 4. Writing Style

Write as an architectural synthesis document.

Avoid repeating module-by-module implementation details unless necessary for synthesis.

Prefer identifying recurring patterns over listing chronology.

The objective is explanation, not historical narration.

---

# 5. Explicit Exclusions

The Integration document SHALL NOT:

* modify Governance;
* modify Framework Specification;
* modify IDS;
* modify Modules;
* modify APIs;
* introduce new artifacts;
* introduce new workflows;
* introduce methodology;
* redesign architecture;
* recommend implementation changes.

---

# 6. Quality Requirements

The completed document shall:

* accurately synthesize Modules 01–15;
* accurately synthesize all five Checkpoints;
* remain fully consistent with Governance v4.6;
* contain no implementation instructions;
* contain no unresolved architectural inconsistencies.

---

# 7. Deliverable

Produce:

`CODING_FRAMEWORK_INTEGRATION.md`

No other files shall be created.

---

# 8. Definition of Done

The Integration document is complete only when:

* all required sections are present;
* every architectural statement is traceable to completed implementation;
* no new Governance decisions are introduced;
* no implementation changes are proposed;
* all completed Coding Phase patterns are synthesized consistently;
* the document is suitable to serve as the canonical Coding Framework reference.

---

End of CODING_FRAMEWORK_INTEGRATION_PROMPT_SPEC.md
