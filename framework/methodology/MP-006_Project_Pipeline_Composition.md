# MP-006_Project_Pipeline_Composition.md

**Project:** Modernized Biomarker Discovery Framework

**Document Type:** Methodology Framework Design Document

**Governed by:** PROJECT_GOVERNANCE_PROMPT_v4.6; FRAMEWORK_SPEC.md; CODING_FRAMEWORK_INTEGRATION.md; MP-000_Methodology_Framework_Foundation.md; MP-001_Method_Taxonomy.md; MP-002_Method_Object_Specification.md; MP-003_Evidence_and_Benchmark_Framework.md; MP-004_Methodology_Registry.md; MP-005_Method_Library_Architecture.md

**Status:** DESIGN DOCUMENT — Project Composition Architecture

**Purpose:** Define the conceptual architecture by which scientific projects compose approved methodologies into reproducible analytical pipelines.

**Implementation:** NOT PERMITTED

---

# 1. Introduction

## 1.1 Purpose

The Project Pipeline Composition defines how scientific projects assemble approved methodologies into coherent analytical workflows.

Rather than introducing new methodologies, the Project Pipeline provides a structured mechanism for selecting, arranging, and combining existing Method Objects to satisfy project-specific scientific objectives.

The Pipeline represents scientific composition.

It does not represent software execution.

---

## 1.2 Scope

The Project Pipeline governs:

* methodology selection
* methodology composition
* project-specific analytical design
* pipeline specification
* composition traceability

The Pipeline does not evaluate methodologies, manage implementations, or execute software.

---

# 2. Pipeline Philosophy

A Project Pipeline is a composition of approved Method Objects.

Each pipeline represents a scientific design describing how reusable methodologies are combined to accomplish the objectives of a specific scientific project.

Methodologies remain independent scientific assets.

The Pipeline defines only their composition.

Consequently, modifying a Pipeline does not modify any Method Object contained within it.

---

# 3. Pipeline Architecture

The Project Pipeline is organized around Approved Method Objects.

```text
Scientific Project
        │
        ▼
Pipeline Specification
        │
        ▼
Approved Method Objects
        │
        ▼
Method Library Resolution
        │
        ▼
Coding Framework Execution
```

Each architectural layer maintains an independent responsibility.

The Pipeline specifies *what* methodologies should be used.

The Method Library resolves *which implementations* satisfy those methodologies.

The Coding Framework determines *how* those implementations are executed.

---

# 4. Pipeline Composition

Pipeline composition consists of selecting and arranging Approved Method Objects according to project objectives.

Method Objects remain reusable across multiple pipelines.

A scientific project may therefore compose different pipelines while relying upon the same underlying Method Objects.

Typical examples include:

* discovery pipelines
* model development pipelines
* validation pipelines
* interpretation pipelines
* clinical translation pipelines

The Methodology Framework intentionally imposes no restriction on the number of pipelines associated with a project.

---

# 5. Pipeline Independence

Project Pipelines remain independent of both methodology ownership and implementation technology.

Pipelines shall not:

* modify Method Objects;
* alter methodology evaluation;
* change taxonomy organization;
* redefine implementation mappings.

Instead, Pipelines consume the outputs produced by previous Methodology Framework components.

This separation preserves framework stability while enabling flexible project design.

---

# 6. Pipeline Specification

Pipeline Specification represents the conceptual description of a scientific workflow.

A Pipeline Specification defines:

* project objective;
* participating Method Objects;
* methodological sequence;
* methodological dependencies;
* expected scientific outputs.

Pipeline Specifications remain implementation-independent.

They describe scientific design rather than computational execution.

---

# 7. Relationship to the Method Library

Pipelines reference Method Objects exclusively.

They do not reference programming languages, software libraries, or executable implementations.

Implementation resolution is delegated to the Method Library through the Implementation Mapping maintained by each Method Object.

This architecture preserves implementation independence while supporting multiple implementations of the same methodology.

---

# 8. Relationship to the Coding Framework

The Coding Framework executes Pipeline Specifications.

Execution occurs only after the Method Library resolves Implementation IDs into compatible callback implementations.

Consequently:

* the Methodology Framework specifies scientific composition;
* the Method Library resolves implementation;
* the Coding Framework performs execution.

These responsibilities remain independent throughout the project lifecycle.

---

# 9. Architectural Principles

The Project Pipeline follows the following principles.

---

## 9.1 Composition over Ownership

Pipelines compose Method Objects.

They never own Method Objects.

---

## 9.2 Reuse before Reinvention

Approved Method Objects should be reused whenever scientifically appropriate.

Pipeline construction should prioritize reuse over creating project-specific methodology variants.

---

## 9.3 Implementation Independence

Pipeline Specifications remain independent of programming language, software framework, execution platform, and implementation technology.

---

## 9.4 Project Flexibility

Different projects may legitimately assemble different pipelines while remaining fully compatible with the same Methodology Framework.

---

## 9.5 Traceable Composition

Every Method Object included within a Pipeline should remain identifiable through its Method ID.

Pipeline Specifications should therefore remain fully traceable and reproducible.

---

# 10. Overall Assessment

The Project Pipeline Composition establishes the application layer of the Methodology Framework.

The preceding Methodology Planning documents define:

* conceptual foundation (MP-000);
* methodology organization (MP-001);
* methodology representation (MP-002);
* scientific evaluation (MP-003);
* methodology management (MP-004);
* implementation architecture (MP-005).

The Project Pipeline composes these architectural components into project-specific scientific designs while preserving the independence of each framework responsibility.

---

# 11. Governance Status

**Status:** DESIGN DOCUMENT

This document defines the conceptual architecture of Project Pipeline Composition.

It introduces no executable workflow, software orchestration mechanism, workflow engine, or project implementation.

Future scientific projects shall reference this document when designing methodology-driven analytical pipelines compatible with the Methodology Framework.

---

**End of MP-006_Project_Pipeline_Composition.md**
