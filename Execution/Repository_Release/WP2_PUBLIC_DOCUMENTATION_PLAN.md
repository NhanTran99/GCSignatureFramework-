# WP2_PUBLIC_DOCUMENTATION_PLAN.md

## Document Information

**Document:** WP2_PUBLIC_DOCUMENTATION_PLAN.md

**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework

**Governed by:**

* PROJECT_GOVERNANCE_PROMPT_v4.6.md
* PROJECT_STATUS.md
* FRAMEWORK_SPEC.md
* CODING_FRAMEWORK_INTEGRATION.md
* MP-007_Methodology_Framework_Integration.md
* REPOSITORY_RELEASE_PLAN.md

**Status:** LOCKED PLANNING DOCUMENT

**Purpose:** Define the public documentation architecture for Repository Release Preparation (WP2).

**Implementation:** NOT PERMITTED

---

# 1. Purpose

WP2 establishes the planning architecture for all public-facing repository documentation.

This document does not generate repository documentation.

Instead, it defines:

* documentation philosophy;
* documentation architecture;
* documentation responsibilities;
* creation order;
* completion criteria.

WP2 follows Repository Cleanup (WP1) and precedes Repository Integration Review (WP3).

---

# 2. Documentation Philosophy

The following principles are LOCKED for all documentation produced during WP2.

## 2.1 Framework-first

The repository presents the **Modernized Biomarker Discovery Framework** as its primary contribution.

The R package represents the implementation of the framework rather than the repository's primary identity.

---

## 2.2 Multi-audience

Documentation shall support:

* Researchers
* Developers
* Reviewers
* PhD / Hiring Committees

Different audiences should be able to locate relevant information quickly without reading the complete repository.

---

## 2.3 Modular Documentation

README is the repository entry point.

Detailed information shall be delegated to dedicated documentation pages.

---

## 2.4 Navigation-first

README functions as the navigation hub.

Documentation should minimize duplication through cross-linking rather than repetition.

---

## 2.5 Scientific Workflow Narrative

Public documentation should present the framework through the following progression:

Problem

↓

Framework

↓

Architecture

↓

Implementation

↓

Usage

↓

Extension

↓

Citation

Historical governance remains available but is not the primary onboarding path.

---

# 3. Documentation Architecture

The planned documentation architecture is:

README

├── Quick Start

├── Installation Guide

├── Framework Overview

├── Architecture Overview

├── Examples

├── FAQ

├── Citation

└── Contributing Guide

This architecture defines relationships only.

No document content is specified here.

---

# 4. Documentation Responsibilities

| Document              | Purpose                                   | Audience               | Priority | Owner | Status  |
| --------------------- | ----------------------------------------- | ---------------------- | -------- | ----- | ------- |
| README                | Repository entry point and navigation hub | Everyone               | Critical | WP2   | Planned |
| Quick Start           | Fast first execution                      | Users                  | Critical | WP2   | Planned |
| Installation Guide    | Installation instructions                 | Users / Developers     | Critical | WP2   | Planned |
| Framework Overview    | Scientific overview                       | Researchers            | High     | WP2   | Planned |
| Architecture Overview | Repository and framework architecture     | Developers / Reviewers | High     | WP2   | Planned |
| Examples              | Practical usage examples                  | Users                  | High     | WP2   | Planned |
| FAQ                   | Frequently asked questions                | Everyone               | Medium   | WP2   | Planned |
| Citation              | Citation information                      | Researchers            | Medium   | WP2   | Planned |
| Contributing Guide    | Contribution workflow                     | Developers             | Medium   | WP2   | Planned |

Future documentation may be added without redesigning this planning architecture.

---

# 5. Documentation Dependency Graph

Recommended dependency sequence:

README

↓

Quick Start

↓

Installation Guide

↓

Examples

Framework Overview

↓

Architecture Overview

↓

Citation

Contributing Guide and FAQ remain independent supporting documents.

---

# 6. Creation Order

Recommended implementation order:

1. README
2. Quick Start
3. Installation Guide
4. Framework Overview
5. Architecture Overview
6. Examples
7. FAQ
8. Citation
9. Contributing Guide

Each document shall be individually reviewed and locked before proceeding to the next document.

---

# 7. Definition of Done

WP2 is complete when:

* all planned public documents exist;
* README serves as the repository navigation hub;
* documentation supports all intended audiences;
* cross-links are complete;
* documentation remains consistent with all locked Governance, Framework, Coding and Methodology documents;
* no governance document is rewritten.

---

# 8. Out of Scope

WP2 shall not:

* redesign the framework;
* redesign the package;
* redesign APIs;
* modify Governance;
* modify Methodology;
* modify Coding Framework;
* introduce implementation changes.

---

# 9. Downstream Dependencies

Completion of WP2 enables:

* WP3 Repository Integration Review
* WP4 Reproducibility & Release
* WP5 Repository QA
* WP6 Release Finalization

---

# 10. Governance Status

**Status:** LOCKED PLANNING DOCUMENT

This document serves as the canonical planning reference for all public documentation generated during Repository Release Preparation.

It introduces no architectural, methodological, implementation, or governance changes.

End of document.
