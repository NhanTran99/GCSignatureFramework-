# MP-001_Method_Taxonomy.md

**Project:** Modernized Biomarker Discovery Framework

**Document Type:** Methodology Framework Design Document

**Governed by:** PROJECT_GOVERNANCE_PROMPT_v4.6; FRAMEWORK_SPEC.md; CODING_FRAMEWORK_INTEGRATION.md; MP-000_Methodology_Framework_Foundation.md

**Status:** DESIGN DOCUMENT — Taxonomy Architecture

**Purpose:** Define the canonical organizational taxonomy of the Methodology Framework.

**Implementation:** NOT PERMITTED

---

# 1. Introduction

## 1.1 Purpose

This document establishes the canonical taxonomy used throughout the Methodology Framework.

The taxonomy provides a stable organizational structure for describing, classifying, and managing scientific methodologies independently of implementation.

Rather than cataloguing individual methodologies, this document defines the organizational schema within which methodologies are represented.

This taxonomy serves as the common structural language for all subsequent Methodology Planning documents.

---

## 1.2 Scope

The taxonomy applies to every scientific methodology represented within the Methodology Framework.

It provides a consistent organizational hierarchy for:

* methodology planning
* methodology evaluation
* benchmark organization
* methodology governance
* methodology reuse

The taxonomy does not prescribe scientific methodologies.

Nor does it define implementation, software architecture, or project-specific workflows.

---

# 2. Taxonomy Design Objectives

The taxonomy is designed to satisfy five architectural objectives.

---

## 2.1 Organizational Consistency

Every methodology should occupy a well-defined position within the Methodology Framework.

Equivalent methodologies should be classified consistently regardless of implementation.

---

## 2.2 Scientific Clarity

Classification should reflect scientific purpose rather than computational implementation.

Scientific intent provides a more stable organizational principle than implementation technology.

---

## 2.3 Long-Term Scalability

The taxonomy should remain stable as additional methodologies are introduced.

Framework growth should occur primarily through new Candidate Methods rather than restructuring higher organizational levels.

---

## 2.4 Reusability

A single taxonomy should support multiple architectural components, including:

* Method Object Specification
* Methodology Registry
* Method Library
* Project Pipeline Composition

No independent taxonomy should be created by these documents.

---

## 2.5 Architectural Stability

The taxonomy represents a structural framework rather than a catalogue of current methodologies.

Consequently, organizational stability is preferred over frequent structural revision.

---

# 3. Taxonomy Philosophy

The Methodology Framework classifies methodologies according to their scientific role within the biomarker discovery process.

The taxonomy therefore answers:

> *What scientific purpose does a methodology serve?*

rather than:

> *How is the methodology implemented?*

Scientific purpose provides a stable architectural principle that remains valid across changing computational technologies and implementation strategies.

This philosophy ensures that the taxonomy remains reusable, implementation-independent, and scientifically meaningful.

---

# 4. Canonical Taxonomy

The Methodology Framework adopts a four-level hierarchical taxonomy.

```text
Scientific Domain
        ↓
Scientific Component
        ↓
Method Family
        ↓
Candidate Method
```

Each level has a distinct architectural responsibility.

---

## 4.1 Scientific Domain

The highest organizational level.

Domains represent major scientific phases within the overall biomarker discovery lifecycle.

Domains organize the framework at a strategic level.

---

## 4.2 Scientific Component

Components divide each Domain into independent scientific responsibilities.

Each Component addresses one clearly defined scientific objective.

Components represent the primary unit of methodology planning.

---

## 4.3 Method Family

Method Families group conceptually related methodologies that pursue the same scientific objective through similar scientific principles.

Method Families organize methodologies conceptually rather than computationally.

---

## 4.4 Candidate Method

Candidate Methods represent individual scientific methodologies eligible for evaluation within the Methodology Framework.

Candidate Methods constitute the leaf nodes of the taxonomy.

Framework growth primarily occurs at this level.

---

# End of Part 1

Part 1 establishes the conceptual architecture of the Method Taxonomy.

Subsequent sections define the rules governing taxonomy organization, classification, stability, and integration with the remaining Methodology Framework documents.


# MP-001_Method_Taxonomy.md

## Part 2 — Taxonomy Rules and Classification Principles

---

# 5. Taxonomy Rules

The Methodology Framework adopts a single canonical taxonomy.

All methodology documents shall organize scientific methodologies according to this taxonomy.

Alternative organizational structures may exist for specific analytical purposes, but they shall not replace the canonical taxonomy established by this document.

---

## 5.1 Hierarchical Organization

The taxonomy follows a strict hierarchical organization.

```text
Scientific Domain
        ↓
Scientific Component
        ↓
Method Family
        ↓
Candidate Method
```

Each level refines the level immediately above it.

Lower levels inherit the scientific context established by higher levels.

No level may bypass or replace another level.

---

## 5.2 Scientific-Purpose Classification

Methodologies shall be classified according to their primary scientific objective.

Classification shall not depend upon:

* programming language
* software package
* computational framework
* implementation technology
* historical popularity

Scientific purpose provides the primary organizational criterion.

Implementation characteristics remain secondary.

---

## 5.3 Tree Architecture

The canonical taxonomy is organized as a tree.

Each node has one direct parent.

The tree represents the primary organizational structure of the Methodology Framework.

Additional conceptual relationships may exist between methodologies but shall not modify the canonical hierarchy.

Cross-document references may describe these relationships where appropriate.

---

## 5.4 One Primary Parent Principle

Every Candidate Method shall have one and only one primary position within the taxonomy.

The primary position represents the methodology's principal scientific role.

If a methodology is applicable to multiple scientific contexts, additional relationships shall be represented through cross-references rather than duplicate taxonomy entries.

This principle preserves taxonomy consistency while supporting scientific reuse.

---

## 5.5 Stable Taxonomy Principle

The taxonomy is intended to remain structurally stable.

Framework evolution should occur primarily through the addition of new Candidate Methods.

Higher organizational levels should remain unchanged unless fundamental scientific restructuring becomes necessary.

Structural modifications to Domains, Components, or Method Families should therefore remain exceptional.

---

# 6. Naming Convention

A consistent naming convention promotes readability, traceability, and long-term maintainability.

Each taxonomy level follows a distinct naming principle.

---

## 6.1 Scientific Domain

Domains represent major phases of the scientific workflow.

Names should be concise and represent broad scientific responsibilities.

Examples are intentionally omitted from this design document.

---

## 6.2 Scientific Component

Components represent specific scientific objectives.

Names should describe the scientific task rather than the implementation approach.

Component names should remain implementation-independent.

---

## 6.3 Method Family

Method Family names should represent a shared scientific concept or methodological philosophy.

Family names should avoid references to individual algorithms whenever possible.

---

## 6.4 Candidate Method

Candidate Methods represent individual scientific methodologies.

Method names should correspond to the accepted scientific terminology used within the relevant research community.

Alternative software-specific names should not replace canonical scientific terminology.

---

# 7. Taxonomy Stability

The taxonomy is intended to serve as a long-term architectural foundation.

Consequently, different taxonomy levels evolve at different rates.

---

## 7.1 Stable Organizational Levels

The following levels are expected to remain relatively stable:

* Scientific Domain
* Scientific Component

These levels define the conceptual architecture of the framework.

---

## 7.2 Moderately Evolving Levels

Method Families may evolve gradually as scientific methodologies mature.

New Method Families may be introduced when they represent genuinely distinct scientific concepts.

Existing families should not be fragmented unnecessarily.

---

## 7.3 Dynamic Levels

Candidate Methods constitute the most dynamic layer of the taxonomy.

New methodologies are expected to enter this level continuously as scientific knowledge evolves.

Retired methodologies remain part of the historical record through the Methodology Registry.

---

# 8. Architectural Consequences

The canonical taxonomy provides the organizational foundation for all subsequent Methodology Planning documents.

Specifically:

* MP-002 defines Method Objects using this taxonomy.
* MP-003 evaluates methodologies organized within this taxonomy.
* MP-004 manages taxonomy entries through the Methodology Registry.
* MP-005 maps approved methodologies to reusable implementations.
* MP-006 composes project-specific pipelines using approved Candidate Methods.

Accordingly, this taxonomy functions as the shared organizational schema of the entire Methodology Framework.

No subsequent document shall redefine or replace it.

---

# End of Part 2

Part 2 establishes the governing principles of the Method Taxonomy, including classification rules, naming conventions, stability principles, and its role as the shared organizational schema for the Methodology Framework.

# MP-001_Method_Taxonomy.md

## Part 3 — Framework Integration and Taxonomy Governance

---

# 9. Relationship to the Methodology Framework

The Method Taxonomy provides the common organizational structure for the entire Methodology Framework.

Every methodology-related artifact shall reference the taxonomy defined by this document.

The taxonomy therefore serves as the shared conceptual schema connecting all subsequent Methodology Planning documents.

It does not replace the responsibilities of those documents.

Instead, it provides the organizational framework within which they operate.

---

## 9.1 Relationship to MP-000

MP-000 establishes the conceptual foundation of the Methodology Framework.

This document transforms those concepts into an organizational structure.

MP-001 therefore extends, but does not redefine, the concepts introduced by MP-000.

---

## 9.2 Relationship to MP-002

MP-002 specifies how a Method Object is represented.

Every Method Object shall occupy exactly one position within the taxonomy defined by this document.

Taxonomy determines organizational identity.

Method Object Specification determines structural representation.

---

## 9.3 Relationship to MP-003

MP-003 defines methodology evaluation, benchmarking, and lifecycle management.

Benchmark results are associated with Candidate Methods identified by this taxonomy.

The taxonomy provides organizational context for methodology evaluation.

It does not determine benchmark outcomes.

---

## 9.4 Relationship to MP-004

The Methodology Registry manages the operational catalogue of methodologies.

The Registry stores entries classified according to this taxonomy.

Registry entries may expand over time.

The taxonomy itself remains the stable organizational reference.

---

## 9.5 Relationship to MP-005

Method Libraries provide reusable implementations of approved methodologies.

Implementation mappings originate from Candidate Methods defined within this taxonomy.

The taxonomy organizes scientific methodologies.

Method Libraries organize software implementations.

These responsibilities remain independent.

---

## 9.6 Relationship to MP-006

Project Pipelines compose approved methodologies into project-specific analytical workflows.

Pipeline composition selects Candidate Methods from the taxonomy.

Pipeline design does not modify taxonomy organization.

---

## 9.7 Relationship to MP-007

MP-007 integrates the complete Methodology Framework.

The Method Taxonomy provides one of the architectural foundations summarized within the Integration document.

---

# 10. Taxonomy Governance

The Method Taxonomy is intended to remain stable throughout the lifetime of the Methodology Framework.

Accordingly, taxonomy evolution follows explicit governance principles.

---

## 10.1 Stability

Higher organizational levels should remain stable.

Scientific Domains and Scientific Components define the conceptual architecture of the framework and should not change routinely.

---

## 10.2 Controlled Expansion

Framework growth primarily occurs through the addition of Candidate Methods.

New Method Families should only be introduced when they represent genuinely distinct scientific concepts.

Expansion should preserve conceptual consistency.

---

## 10.3 Traceability

Changes to taxonomy entries should remain traceable.

Historical methodology organization should remain understandable even as the framework expands.

No methodology should lose its organizational identity through undocumented restructuring.

---

## 10.4 Backward Compatibility

Future Methodology Planning documents should remain compatible with this taxonomy.

New concepts should extend the taxonomy rather than replace it.

If substantial taxonomy redesign ever becomes necessary, the redesign shall be governed as a new architectural decision rather than an implicit document revision.

---

# 11. Overall Assessment

The Method Taxonomy establishes the canonical organizational schema of the Methodology Framework.

Rather than cataloguing methodologies, it defines the structure within which methodologies are represented, evaluated, benchmarked, implemented, and reused.

This organizational separation enables different framework components to evolve independently while preserving a shared conceptual language.

The taxonomy therefore functions as a long-term architectural asset rather than a temporary organizational aid.

---

# 12. Governance Status

**Status:** DESIGN DOCUMENT

This document defines the canonical organizational taxonomy of the Methodology Framework.

It introduces no scientific methodology, implementation detail, software architecture, or governance modification.

Subsequent Methodology Planning documents shall organize methodologies according to the taxonomy established by this document.

The taxonomy becomes the canonical organizational reference for the Methodology Framework.

---

**End of MP-001_Method_Taxonomy.md**
