# MP-000_Methodology_Framework_Foundation.md

**Project:** Modernized Biomarker Discovery Framework

**Document Type:** Methodology Framework Foundation

**Governed by:** PROJECT_GOVERNANCE_PROMPT_v4.6; FRAMEWORK_SPEC.md; CODING_FRAMEWORK_INTEGRATION.md; METHODOLOGY_WORKFLOW.md

**Status:** FOUNDATION DOCUMENT — Design Architecture Only

**Purpose:** Establish the conceptual foundation of the Methodology Framework.

**Implementation:** NOT PERMITTED

---

# 1. Introduction

## 1.1 Purpose

This document establishes the conceptual foundation of the Methodology Framework.

The Methodology Framework provides a structured architecture for describing, organizing, evaluating, benchmarking, and managing scientific methodologies independently of software implementation.

Its purpose is to bridge the architectural gap between the completed Coding Framework and future scientific methodology development.

This document defines the principles, terminology, responsibilities, and conceptual boundaries that govern all subsequent Methodology Planning documents (MP-001 through MP-007).

It introduces no scientific methodology, implementation, software package, algorithm, or statistical procedure.

---

## 1.2 Scope

The Methodology Framework covers the complete scientific lifecycle supported by the project, including:

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

The framework defines how methodologies are represented, evaluated, compared, documented, and managed.

It does not specify which methodology should be used for any scientific task.

Implementation remains outside the scope of this framework.

---

## 1.3 Relationship to Existing Frameworks

The Methodology Framework extends the overall project architecture without modifying previously locked frameworks.

Responsibilities remain separated across three independent layers:

* **Governance Framework** establishes decision-making authority, project governance, and documentation workflow.
* **Coding Framework** provides the implementation architecture, callback interfaces, object contracts, and software extensibility.
* **Methodology Framework** defines the scientific methodology architecture, including methodology representation, evaluation, benchmarking, lifecycle management, and reuse.

Each framework addresses a different architectural concern.

None replaces or supersedes another.

---

# 2. Why a Methodology Framework?

The completed Coding Framework intentionally provides a methodology-independent implementation architecture.

It defines stable interfaces, callback mechanisms, object contracts, artifact lineage, and implementation boundaries while deliberately avoiding scientific methodology.

This separation enables future methodologies to be introduced without modifying the underlying implementation framework.

However, implementation architecture alone does not answer important scientific questions such as:

* How should candidate methodologies be organized?
* How should methodologies be compared?
* What evidence is required before recommending a methodology?
* How should benchmark results be documented?
* How should methodologies evolve throughout the lifetime of the framework?

These questions belong neither to Governance nor to the Coding Framework.

They define a separate architectural concern.

The Methodology Framework fills this gap by introducing a reusable methodology architecture that remains independent of implementation details while providing a consistent structure for scientific decision-making.

Conceptually, the project architecture becomes:

```text
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

Within this architecture:

* Governance controls decisions.
* Coding controls implementation.
* Methodology controls scientific methods.
* Method Libraries contain reusable implementations.
* Scientific Projects compose approved methods into project-specific workflows.

The separation of these responsibilities enables each layer to evolve independently while preserving architectural stability.

---

# 3. Design Philosophy

The Methodology Framework follows the same scientific philosophy established throughout the Modernized Biomarker Discovery Framework while introducing methodology-specific design principles.

## 3.1 Methodology Before Implementation

Scientific methodology shall be defined independently of implementation.

Implementation should realize a methodology rather than define it.

Consequently, implementation changes should not require redesign of methodology, and methodology evolution should not require modification of the locked Coding Framework.

---

## 3.2 Evidence Before Recommendation

Methodology recommendations shall be supported by documented scientific evidence.

Recommendations should arise from transparent evaluation, benchmarking, and review rather than preference or implementation convenience.

---

## 3.3 Component-wise Methodology Planning

Scientific methodologies shall be evaluated within clearly defined scientific components.

Methodologies belonging to one component should not implicitly determine decisions made within unrelated components.

This modular organization promotes flexibility, reuse, and independent scientific evolution.

---

## 3.4 Reuse Before Reinvention

Existing methodologies should be evaluated before introducing new approaches.

Whenever appropriate, approved methodologies should be reused through the Method Library rather than recreated independently.

---

## 3.5 Additive Evolution

The Methodology Framework evolves through additive development.

Previously approved methodology documents remain authoritative unless explicitly revised through the established governance process.

Future methodology development should extend existing architecture rather than redesign previously accepted foundations.

---

## 3.6 Separation of Methodology and Implementation

Scientific methodology and software implementation represent different architectural responsibilities.

Methodology defines scientific intent.

Implementation realizes scientific intent.

Neither should replace the responsibility of the other.

This separation preserves long-term maintainability, implementation flexibility, and methodological transparency.

---

# End of Part 1

Part 1 establishes the conceptual motivation and philosophical foundation of the Methodology Framework.

Subsequent sections introduce the terminology, conceptual boundaries, responsibility model, and document architecture that complete the foundation document.

# MP-000_Methodology_Framework_Foundation.md

## Part 2 — Core Concepts and Framework Responsibilities

---

# 4. Core Terminology

This section establishes the canonical terminology used throughout the Methodology Framework.

The definitions provided here are conceptual rather than technical. Detailed specifications are deferred to subsequent Methodology Planning documents.

---

## 4.1 Method

A **Method** is a scientific approach used to accomplish a well-defined objective within a scientific component.

A Method describes *what scientific strategy is applied*, independent of software implementation.

Examples of methods are intentionally omitted from this foundation document.

---

## 4.2 Method Family

A **Method Family** is a collection of methods sharing a common scientific objective or conceptual approach.

Method Families provide organizational structure rather than implementation hierarchy.

Individual methods belonging to the same family may differ substantially in implementation while pursuing similar scientific goals.

---

## 4.3 Candidate Method

A **Candidate Method** is a methodology that has been identified for scientific evaluation.

Candidate Methods represent possible solutions rather than approved recommendations.

Multiple Candidate Methods may legitimately coexist for the same scientific component.

The Methodology Framework assumes comparison rather than premature selection.

---

## 4.4 Approved Method

An **Approved Method** is a Candidate Method that has accumulated sufficient evidence to support its use within the Methodology Framework.

Approval reflects documented evaluation rather than universal superiority.

Approval is therefore context-dependent.

---

## 4.5 Deprecated Method

A **Deprecated Method** is an Approved Method that is no longer recommended for future projects while remaining part of the historical framework record.

Deprecation preserves reproducibility and historical traceability without requiring removal from the framework.

---

## 4.6 Method Object

A **Method Object** is the conceptual representation of a methodology within the Methodology Framework.

It captures the identity and scientific description of a method.

The Method Object is a planning artifact.

It is **not** an implementation object, runtime object, callback object, or software component.

Its detailed specification is defined separately within the Method Object Specification.

---

## 4.7 Methodology Registry

The **Methodology Registry** is the canonical catalogue of methodologies managed by the Methodology Framework.

The Registry maintains methodology identity, status, evidence relationships, benchmark history, and governance information.

It does not contain software implementation.

---

## 4.8 Method Library

The **Method Library** contains reusable implementations of approved methodologies.

Method Libraries belong to the implementation layer rather than the methodology layer.

Their responsibility is software realization of approved scientific methodologies.

---

## 4.9 Project Pipeline

A **Project Pipeline** is a project-specific composition of approved methodologies selected from the Method Library.

Different scientific projects may assemble different pipelines while remaining compatible with the same Methodology Framework.

---

# 5. Framework Boundaries

The Methodology Framework occupies a distinct architectural responsibility within the overall project.

Its purpose is to organize scientific methodologies rather than govern projects or implement software.

Accordingly, clear boundaries are maintained between adjacent frameworks.

---

## 5.1 Relationship to Governance

Governance determines:

* decision authority
* review workflow
* document lifecycle
* approval process

The Methodology Framework does not modify governance procedures.

---

## 5.2 Relationship to the Coding Framework

The Coding Framework determines:

* callback architecture
* software contracts
* implementation objects
* framework artifacts
* implementation extensibility

The Methodology Framework defines scientific methodologies independently of these implementation mechanisms.

Implementation details remain outside the responsibility of this framework.

---

## 5.3 Relationship to Scientific Projects

Scientific Projects consume approved methodologies.

Projects may assemble methodologies differently depending on scientific objectives.

Project-specific methodology selection does not modify the Methodology Framework itself.

---

## 5.4 Relationship to Method Libraries

Method Libraries implement methodologies.

The Methodology Framework evaluates and manages methodologies.

Method Libraries execute them.

This separation preserves implementation independence while maintaining methodological consistency.

---

# 6. Responsibility Model

Each architectural layer maintains a single primary responsibility.

---

## Governance Framework

Responsible for:

* governance
* authority
* workflow
* project decisions

---

## Coding Framework

Responsible for:

* implementation architecture
* software contracts
* callback interfaces
* extensibility mechanisms

---

## Methodology Framework

Responsible for:

* methodology organization
* methodology evaluation
* benchmark philosophy
* evidence integration
* methodology lifecycle
* methodology reuse

---

## Methodology Registry

Responsible for:

* methodology catalogue
* methodology status
* benchmark references
* evidence traceability

---

## Method Library

Responsible for:

* reusable implementations
* callback implementations
* implementation documentation

---

## Scientific Projects

Responsible for:

* project objectives
* methodology composition
* scientific execution
* project-specific analysis

---

Collectively, these responsibilities establish a layered architecture in which governance, implementation, methodology, reusable implementations, and scientific applications remain independent yet complementary.

No architectural layer replaces the responsibility of another.

---

# End of Part 2

Part 2 establishes the conceptual vocabulary, architectural boundaries, and responsibility model that provide a common language for all subsequent Methodology Planning documents.


# MP-000_Methodology_Framework_Foundation.md

## Part 3 — Framework Architecture, Guiding Principles and Future Evolution

---

# 7. Methodology Document Architecture

The Methodology Framework is organized as a progressive collection of design documents.

Each document has a single architectural responsibility and progressively refines concepts established by earlier documents.

```
MP-000  Methodology Framework Foundation
        ↓
MP-001  Method Taxonomy
        ↓
MP-002  Method Object Specification
        ↓
MP-003  Evidence and Benchmark Framework
        ↓
MP-004  Methodology Registry
        ↓
MP-005  Method Library Architecture
        ↓
MP-006  Project Pipeline Composition
        ↓
MP-007  Methodology Framework Integration
```

The sequence reflects conceptual dependency rather than implementation order.

Earlier documents establish concepts.

Later documents progressively refine those concepts without redefining them.

---

## 7.1 Responsibility of Each Document

### MP-000 — Methodology Framework Foundation

Establishes the conceptual foundation, terminology, design philosophy, framework boundaries, and guiding principles.

---

### MP-001 — Method Taxonomy

Defines the organizational hierarchy of scientific methodologies.

Introduces the conceptual relationships between scientific domains, components, method families, and candidate methods.

---

### MP-002 — Method Object Specification

Defines the complete conceptual specification of a Method Object.

Standardizes how methodologies are represented throughout the framework.

---

### MP-003 — Evidence and Benchmark Framework

Defines methodology evaluation philosophy, evidence architecture, benchmark organization, recommendation principles, and methodology lifecycle.

---

### MP-004 — Methodology Registry

Defines the architecture responsible for methodology cataloguing, status management, traceability, and governance metadata.

---

### MP-005 — Method Library Architecture

Defines the relationship between approved methodologies and reusable software implementations.

Specifies methodology-to-implementation mapping without modifying the Coding Framework.

---

### MP-006 — Project Pipeline Composition

Defines how scientific projects compose approved methodologies into project-specific analytical pipelines.

Pipeline composition remains independent of methodology governance.

---

### MP-007 — Methodology Framework Integration

Synthesizes the complete Methodology Framework into a unified architectural reference.

This document serves as the canonical integration artifact for the Methodology Planning Phase.

---

# 8. Guiding Principles

All Methodology Planning documents shall remain consistent with the following principles.

---

## 8.1 Single Responsibility

Each Methodology document shall address one architectural concern.

Responsibilities should remain clearly separated.

---

## 8.2 Progressive Refinement

Concepts introduced by earlier documents shall be refined rather than redefined.

Successive documents should increase specificity while preserving conceptual consistency.

---

## 8.3 Minimal Overlap

Concepts should be defined once and referenced thereafter.

Unnecessary duplication between documents should be avoided.

---

## 8.4 Stable References

Earlier documents become canonical references for subsequent documents.

Terminology established in MP-000 should remain stable throughout the Methodology Framework.

---

## 8.5 Traceability

Methodology evolution should remain transparent.

Scientific decisions, benchmark results, recommendation history, and methodology status should remain traceable throughout the framework lifecycle.

---

## 8.6 Modularity

Scientific methodologies should remain modular whenever scientifically appropriate.

Independent methodological evolution should be encouraged without requiring redesign of unrelated framework components.

---

## 8.7 Implementation Independence

Scientific methodology should remain independent of implementation technology.

Changes in implementation should not alter methodology architecture.

---

# 9. Future Evolution

The Methodology Framework is intended to evolve as a long-term reusable scientific framework.

Future development should preserve conceptual stability while allowing scientific methodologies to expand.

Framework evolution should therefore follow three fundamental principles.

---

## 9.1 Additive Development

Future documents should extend existing architecture rather than replace it.

Previously approved foundations remain authoritative unless explicitly revised.

---

## 9.2 Backward Conceptual Compatibility

New methodology concepts should remain compatible with previously established terminology and architectural principles whenever possible.

Architectural redesign should remain exceptional rather than routine.

---

## 9.3 Continuous Scientific Growth

The Methodology Framework is expected to expand as additional scientific methodologies become available.

Expansion should occur through new Method Objects, Registry entries, Method Libraries, and Project Pipelines while preserving the stability of the conceptual framework established by this document.

---

# 10. Overall Assessment

The Methodology Framework establishes the scientific design layer of the Modernized Biomarker Discovery Framework.

Together with the Governance Framework and the Coding Framework, it completes the project's three complementary architectural perspectives:

```
Governance Framework
        ↓
Methodology Framework
        ↓
Coding Framework
        ↓
Scientific Applications
```

Each framework addresses a distinct architectural responsibility.

Collectively they provide a reusable, extensible, and implementation-independent foundation for future biomarker discovery projects.

---

# 11. Governance Status

**Status:** FOUNDATION DOCUMENT

This document establishes the conceptual foundation of the Methodology Framework.

It introduces no implementation, software architecture, statistical methodology, or governance modification.

Subsequent Methodology Planning documents shall build upon this foundation.

Implementation remains governed by the locked Coding Framework.

Project governance remains governed by the Project Governance Framework.

---

**End of MP-000_Methodology_Framework_Foundation.md**


