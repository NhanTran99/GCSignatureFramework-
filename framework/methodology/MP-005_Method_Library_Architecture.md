# MP-005_Method_Library_Architecture.md

**Project:** Modernized Biomarker Discovery Framework

**Document Type:** Methodology Framework Design Document

**Governed by:** PROJECT_GOVERNANCE_PROMPT_v4.6; FRAMEWORK_SPEC.md; CODING_FRAMEWORK_INTEGRATION.md; MP-000_Methodology_Framework_Foundation.md; MP-001_Method_Taxonomy.md; MP-002_Method_Object_Specification.md; MP-003_Evidence_and_Benchmark_Framework.md; MP-004_Methodology_Registry.md

**Status:** DESIGN DOCUMENT — Implementation Mapping Architecture

**Purpose:** Define the conceptual architecture connecting scientific methodologies to reusable software implementations.

**Implementation:** NOT PERMITTED

---

# 1. Introduction

## 1.1 Purpose

The Method Library Architecture establishes the conceptual bridge between the scientific methodologies defined by the Methodology Framework and their reusable software implementations.

Its purpose is to enable multiple implementations of the same scientific methodology while preserving implementation independence, scientific consistency, and long-term maintainability.

The Method Library defines implementation architecture.

It does not contain executable software.

---

## 1.2 Scope

The Method Library governs:

* implementation identity
* implementation mapping
* implementation lifecycle
* reusable implementation organization
* callback resolution

Scientific methodology remains outside the responsibility of the Method Library.

---

# 2. Library Philosophy

The Method Library is an implementation architecture rather than a source code repository.

Its responsibility is to organize reusable implementations corresponding to Method Objects.

Scientific methodology and software implementation remain independent architectural layers.

Method Objects describe scientific methodologies.

Method Libraries realize those methodologies through reusable implementations.

---

# 3. Method-to-Implementation Mapping

Each Method Object may reference one or more reusable implementations.

```text id="a1qg2d"
Method Object
      │
      ▼
Implementation IDs
      │
      ├── LIB-001
      ├── LIB-002
      └── LIB-003
```

Implementation IDs identify implementations.

Method Objects do not contain implementation details.

This architecture allows multiple implementations of the same scientific methodology without modifying the Method Object.

---

# 4. Library Responsibilities

The Method Library is responsible for:

* maintaining reusable implementations
* resolving Implementation IDs
* managing implementation lifecycle
* preserving callback compatibility
* supporting multiple implementation technologies

The Method Library does not evaluate methodologies.

The Method Library does not manage Method Objects.

The Method Library does not organize scientific taxonomy.

---

# 5. Implementation Lifecycle

Scientific methodology and software implementation evolve independently.

Consequently, each implementation possesses its own lifecycle.

Implementation lifecycle may differ from Method Object lifecycle.

An approved Method Object may correspond to multiple implementations with different implementation maturity.

Implementation approval therefore remains independent of methodology approval.

---

# 6. Relationship to the Coding Framework

The Method Library connects the Methodology Framework to the Coding Framework.

```text id="md0x7k"
Method Object
      │
      ▼
Implementation IDs
      │
      ▼
Method Library
      │
      ▼
Callback Resolution
      │
      ▼
Coding Framework
```

The Coding Framework executes callbacks.

The Method Library resolves which implementation should satisfy those callbacks.

---

# 7. Architectural Principles

The Method Library follows the following principles.

---

## 7.1 Separation of Methodology and Implementation

Scientific methodology and implementation remain independent.

Implementation changes shall not modify Method Objects.

---

## 7.2 Multiple Implementations

One Method Object may correspond to multiple reusable implementations.

This supports different programming languages, software frameworks, optimization strategies, or future implementations.

---

## 7.3 Implementation Independence

Implementations may evolve independently.

Deprecated implementations do not imply deprecated methodologies.

Likewise, newly introduced implementations do not alter scientific methodology.

---

## 7.4 Callback Compatibility

Every implementation shall remain compatible with the callback architecture defined by the Coding Framework.

The Method Library bridges methodology and callback execution without modifying either framework.

---

# 8. Overall Assessment

The Method Library Architecture establishes the implementation layer of the Methodology Framework.

Together with previous Methodology Planning documents, the framework now distinguishes five independent architectural responsibilities:

* scientific foundation;
* methodology organization;
* methodology representation;
* scientific evaluation;
* implementation architecture.

The Method Library therefore completes the bridge between scientific methodology and software execution while preserving clear ownership boundaries.

---

# 9. Governance Status

**Status:** DESIGN DOCUMENT

This document defines the conceptual architecture of the Method Library.

It introduces no executable implementation, programming interface, callback implementation, or software repository structure.

Future framework documents shall reference the Method Library as the canonical implementation architecture of the Methodology Framework.

---

**End of MP-005_Method_Library_Architecture.md**
