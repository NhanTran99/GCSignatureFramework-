# MP-002_Method_Object_Specification.md

**Project:** Modernized Biomarker Discovery Framework

**Document Type:** Methodology Framework Design Document

**Governed by:** PROJECT_GOVERNANCE_PROMPT_v4.6; FRAMEWORK_SPEC.md; CODING_FRAMEWORK_INTEGRATION.md; MP-000_Methodology_Framework_Foundation.md; MP-001_Method_Taxonomy.md

**Status:** DESIGN DOCUMENT — Method Representation Architecture

**Purpose:** Define the canonical representation of scientific methodologies within the Methodology Framework.

**Implementation:** NOT PERMITTED

---

# Part 1 — Method Object Foundation

---

# 1. Introduction

## 1.1 Purpose

This document defines the canonical representation of scientific methodologies within the Methodology Framework.

While MP-001 establishes how methodologies are organized, this document specifies how an individual methodology is represented as a reusable conceptual entity.

The Method Object becomes the fundamental unit through which methodologies are evaluated, benchmarked, managed, implemented, and reused throughout the Methodology Framework.

This document defines the conceptual architecture of a Method Object.

It does not define implementation structures, software classes, database schemas, or programming interfaces.

---

## 1.2 Scope

The Method Object represents a single Candidate Method within the Methodology Framework.

Every Candidate Method identified by the Method Taxonomy shall correspond to exactly one Method Object.

Method Objects provide the common representation used by:

* Methodology Registry
* Evidence Framework
* Benchmark Framework
* Method Library
* Project Pipelines

Accordingly, the Method Object serves as the shared conceptual unit connecting all methodology-related components.

---

# 2. Object Philosophy

The Method Object is a conceptual entity.

It represents the scientific identity of a methodology independently of documentation, implementation, or software realization.

A Method Object therefore exists independently of:

* documents
* software implementations
* programming languages
* computational frameworks
* execution environments

Documents describe a Method Object.

Software implements a Method Object.

Neither defines its scientific identity.

This separation preserves methodological stability while allowing implementation technologies to evolve independently.

---

## 2.1 Method Object as the Fundamental Unit

Within the Methodology Framework, the Method Object is the smallest independently managed scientific entity.

All framework activities—including evaluation, benchmarking, lifecycle management, registry management, implementation mapping, and project composition—operate upon Method Objects.

Higher organizational structures group Method Objects.

Lower implementation structures realize Method Objects.

The Method Object therefore functions as the primary bridge between scientific methodology and software implementation.

---

# 3. Object Identity

Every Method Object possesses a permanent scientific identity.

Identity remains stable throughout the entire lifecycle of the object.

Scientific evaluation, benchmark outcomes, implementation improvements, or recommendation status may evolve over time.

Identity does not.

The Method Object therefore represents continuity of scientific knowledge rather than a particular implementation or version.

---

## 3.1 Method ID

Each Method Object shall possess one unique Method ID.

The Method ID constitutes the canonical identifier of the object.

Method names serve descriptive purposes only.

References between Methodology documents, Registry entries, Benchmark records, Method Libraries, and Project Pipelines should rely upon the Method ID rather than the method name.

This approach preserves stable references while allowing descriptive metadata to evolve.

---

## 3.2 Immutable Identity

Once assigned, a Method ID shall never change.

Scientific names may be updated.

Descriptions may improve.

Benchmark evidence may accumulate.

Lifecycle status may evolve.

Implementation mappings may expand.

The Method ID remains immutable throughout the lifetime of the Method Object.

Immutable identity provides long-term traceability across every architectural layer of the Methodology Framework.

---

# 4. Object Granularity

Each Method Object represents exactly one Candidate Method.

Method Families organize conceptually related methodologies.

Scientific Components organize methodological objectives.

Scientific Domains organize the overall scientific workflow.

Only Candidate Methods become Method Objects.

Consequently:

* one Candidate Method corresponds to one Method Object;
* one Method Family may contain multiple Method Objects;
* one Scientific Component may contain multiple Method Families;
* one Scientific Domain may contain multiple Scientific Components.

This one-to-one correspondence ensures that every scientific methodology can be evaluated, benchmarked, implemented, and reused independently while preserving the organizational hierarchy established by the Method Taxonomy.

---

# End of Part 1

Part 1 establishes the conceptual identity of the Method Object.

It defines what a Method Object is, why it exists, how it is identified, and why it represents the fundamental scientific unit of the Methodology Framework.

The internal structure of the Method Object is defined in Part 2.


# MP-002_Method_Object_Specification.md

## Part 2 — Method Object Architecture

---

# 5. Object Architecture

A Method Object is organized into a set of logical sections.

Each section represents one architectural responsibility.

Together, these sections provide a complete conceptual representation of a scientific methodology.

The Method Object architecture is organized as follows:

```text
Method Object
      │
      ├── Identity
      ├── Scientific Definition
      ├── Evidence
      ├── Benchmark
      ├── Lifecycle
      └── Implementation Mapping
```

The logical sections are conceptual responsibilities rather than implementation structures.

Implementation-specific representations remain outside the scope of this document.

---

# 6. Identity

The Identity section establishes the permanent identity of the Method Object.

Its responsibility is stable identification throughout the lifetime of the methodology.

Typical information maintained by this section includes:

* Method ID
* Canonical Method Name
* Scientific Classification
* Taxonomy Position

Identity represents *who the methodology is*.

Identity does not describe scientific performance or implementation.

Identity remains immutable except for descriptive metadata such as display names when scientifically justified.

---

# 7. Scientific Definition

The Scientific Definition section describes the scientific meaning of the methodology.

Its responsibility is conceptual rather than technical.

Typical information maintained by this section includes:

* Scientific objective
* Scientific rationale
* Intended application
* Method assumptions
* Expected strengths
* Known limitations

Scientific Definition explains *what the methodology is intended to accomplish*.

It does not contain benchmark results or implementation details.

---

# 8. Evidence

The Evidence section records the scientific foundation supporting the methodology.

Its purpose is to document why the methodology is considered scientifically credible.

Typical information maintained by this section includes:

* Scientific evidence
* Literature references
* Validation studies
* Supporting rationale
* Evidence summary

Evidence evolves as scientific knowledge expands.

The methodology identity remains unchanged.

---

# 9. Benchmark

The Benchmark section records methodology evaluation within the Methodology Framework.

Benchmark information provides objective evidence regarding methodology performance under defined evaluation settings.

Typical information maintained by this section includes:

* Benchmark history
* Comparative evaluations
* Performance summaries
* Recommendation references

Benchmark results support scientific decision-making.

They do not define methodology identity.

---

# 10. Lifecycle

The Lifecycle section records the current maturity of the Method Object.

Method Objects evolve through a controlled lifecycle.

```text
Candidate
      ↓
Approved
      ↓
Deprecated
      ↓
Archived
```

Lifecycle status reflects the current scientific standing of the methodology.

Changes in lifecycle status do not alter Method ID or conceptual identity.

---

# 11. Implementation Mapping

Implementation Mapping connects the Method Object to reusable software implementations.

Its responsibility is reference rather than implementation.

Typical information maintained by this section includes:

* associated implementation identifiers
* related Method Library entries
* callback mappings
* implementation references

Implementation Mapping does not contain executable software.

Software implementations remain the responsibility of the Method Library Architecture.

---

# 12. Architectural Principles

The Method Object architecture follows the following principles.

---

## 12.1 Separation of Responsibilities

Each logical section addresses one architectural responsibility.

Scientific identity, evidence, benchmark history, lifecycle management, and implementation mapping remain independent.

---

## 12.2 Progressive Enrichment

Method Objects become progressively richer over time.

Evidence accumulates.

Benchmark history expands.

Implementation mappings increase.

The conceptual identity remains stable.

---

## 12.3 Traceability

Every architectural section contributes to long-term scientific traceability.

Historical methodology evolution remains understandable without altering the identity of the Method Object.

---

## 12.4 Implementation Independence

Method Objects describe methodologies rather than software.

Implementation technologies may evolve independently while preserving the Method Object architecture.

---

# End of Part 2

Part 2 defines the internal logical architecture of the Method Object.

It establishes the conceptual sections that collectively represent a scientific methodology while preserving a clear separation between scientific identity, evidence, evaluation, lifecycle management, and implementation.


# MP-002_Method_Object_Specification.md

## Part 3 — Framework Integration and Object Governance

---

# 13. Relationship to the Methodology Framework

The Method Object serves as the canonical scientific entity of the Methodology Framework.

Every methodology-related architectural component operates directly or indirectly upon Method Objects.

The Method Object therefore functions as the common conceptual bridge connecting methodology organization, scientific evaluation, implementation, and project application.

It does not replace the responsibilities of other Methodology Planning documents.

Instead, it provides the common representation shared across them.

---

## 13.1 Relationship to MP-000

MP-000 establishes the conceptual foundation of the Methodology Framework.

The Method Object is a direct realization of the conceptual principles introduced by the Foundation document.

Consequently, every Method Object shall remain consistent with the philosophy, terminology, and framework boundaries established by MP-000.

---

## 13.2 Relationship to MP-001

MP-001 defines the canonical taxonomy of the Methodology Framework.

Every Method Object shall occupy exactly one canonical position within that taxonomy.

The taxonomy defines organizational identity.

The Method Object defines scientific representation.

Neither replaces the other.

---

## 13.3 Relationship to MP-003

MP-003 defines the architecture governing scientific evidence, benchmarking, recommendations, and methodology lifecycle.

The Evidence, Benchmark, and Lifecycle sections of every Method Object shall be managed according to the principles established by MP-003.

MP-003 enriches the Method Object without altering its conceptual identity.

---

## 13.4 Relationship to MP-004

The Methodology Registry maintains the operational catalogue of Method Objects.

Each Registry entry corresponds to one Method Object.

The Registry manages metadata, status, traceability, and historical records.

The Registry does not redefine the Method Object.

---

## 13.5 Relationship to MP-005

Method Libraries provide reusable software implementations corresponding to approved Method Objects.

Implementation Mapping establishes references between Method Objects and their associated implementations.

The Method Object remains implementation-independent.

Software evolution shall not modify Method Object identity.

---

## 13.6 Relationship to MP-006

Project Pipelines compose scientific workflows using approved Method Objects.

Pipelines reference Method Objects as reusable scientific building blocks.

Pipeline composition neither changes Method Object identity nor modifies the Methodology Framework.

---

## 13.7 Relationship to MP-007

MP-007 integrates the complete Methodology Framework.

The Method Object becomes the canonical scientific entity summarized within the Integration document.

Its conceptual architecture remains unchanged throughout framework integration.

---

# 14. Object Governance

The Method Object follows a stable governance model designed to preserve scientific continuity throughout the lifetime of the framework.

---

## 14.1 Identity Preservation

The identity of a Method Object is permanent.

Method ID shall remain unchanged regardless of changes in:

* evidence
* benchmark history
* implementation mapping
* lifecycle status
* descriptive metadata

Stable identity ensures long-term traceability across the Methodology Framework.

---

## 14.2 Controlled Evolution

Method Objects evolve through enrichment rather than replacement.

Scientific knowledge may accumulate over time.

Benchmark evidence may improve.

Implementation mappings may expand.

Lifecycle status may change.

These changes enrich the Method Object while preserving its conceptual identity.

---

## 14.3 Historical Traceability

Method Objects preserve the historical development of scientific methodologies.

Deprecated and Archived methods remain part of the framework as historical scientific assets.

Historical preservation supports reproducibility, transparency, and long-term scientific documentation.

---

## 14.4 Separation of Representation and Implementation

The Method Object represents scientific methodology.

The Method Library represents software implementation.

The Methodology Registry represents methodology management.

Project Pipelines represent scientific application.

These architectural responsibilities remain independent throughout the framework lifecycle.

---

# 15. Overall Assessment

The Method Object establishes the canonical representation of scientific methodologies within the Methodology Framework.

Together with MP-000 and MP-001, it completes the conceptual foundation upon which all subsequent methodology documents are constructed.

The architectural progression is therefore:

```text
MP-000  Foundation
        ↓
MP-001  Organization
        ↓
MP-002  Representation
```

This progression establishes:

* a common conceptual language (MP-000),
* a common organizational schema (MP-001),
* a common scientific entity (MP-002).

Subsequent Methodology Planning documents extend these foundations without redefining them.

---

# 16. Governance Status

**Status:** DESIGN DOCUMENT

This document defines the canonical representation of scientific methodologies within the Methodology Framework.

It introduces no implementation architecture, executable software, database schema, or programming interface.

Future Methodology Planning documents shall reference the Method Object as the canonical scientific representation of every Candidate Method.

---

**End of MP-002_Method_Object_Specification.md**
