# Module 05 — Discovery Outputs (v2)

---

## Project

**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework

**Coding Module:** Module 05 — Discovery Outputs

**Execution Phase**

---

# Governance

This Coding Module is governed, in precedence order, by:

1. PROJECT_GOVERNANCE_PROMPT_v4.6
2. FRAMEWORK_SPEC.md
3. IMPLEMENTATION_PHILOSOPHY_IDS_PHASE.md
4. IDS-002_Discovery_Implementation.md
5. MODULE_TAXONOMY.md
6. IMPLEMENTATION_MASTER_PLAN.md
7. CODING_PHASE_PHILOSOPHY.md

All governing documents are LOCKED.

No governance document shall be modified or reinterpreted.

---

## Pre-Implementation Decision Record

### Gap Identified

IDS-002 (LOCKED) defines two distinct logical Discovery contractual artifact types: Discovery Candidate and Discovery Evidence. The original Module 05 prompt assumed both already exist, ready to be verified and exported.

In reality, Module 04 (LOCKED) produces exactly **one** `artifact_contract` per pipeline execution (`metadata$framework_layer = "processing"`) — not a Candidate/Evidence pair. Module 05 is explicitly prohibited from generating new Discovery artifacts, so it cannot synthesize a missing artifact to complete the pair.

### Decision

Module 05 SHALL operate generically on whatever collection of Discovery contractual artifacts was actually produced upstream — not on an assumed, hard-coded Candidate+Evidence pair. Module 05 verifies and exports exactly the artifact(s) it receives, preserving their contractual identity unchanged. It does not relabel an artifact as "Candidate" or "Evidence," does not merge or split artifacts, and does not invent missing logical categories from IDS-002's taxonomy. If and when a future, domain-specific Discovery module produces additional logical artifact categories, Module 05's generic verification/export mechanism applies to those too, without modification.

This Coding Prompt has been corrected accordingly (see revised sections below) before implementation began. No Module 01–04 code was modified.

---

# Implementation Note

The current generic framework implementation does not assume that every logical Discovery artifact category defined by IDS-002 has already been instantiated by upstream modules.

Module 05 SHALL operate only on the contractual artifacts actually produced upstream.

Verification and export SHALL preserve those artifacts exactly as received after successful verification.

Instantiation of additional Discovery artifact categories is outside the responsibility of Module 05.

---

# Roles

## Project Coordinator

* executes implementation locally
* performs local verification
* determines Module LOCK

## Coding Agent (Claude)

* implements Discovery Outputs only

## Strategist AI (ChatGPT)

* reviews implementation
* evaluates governance and IDS compliance
* requests revisions if necessary

---

# Module Responsibility

Implement the Discovery Output Boundary Layer.

The objective of this module is to verify Discovery contractual artifacts produced by Module 04 and expose the contracted Discovery → Modeling interface.

This module SHALL NOT perform Discovery processing.

This module SHALL NOT generate new Discovery artifacts.

---

# Architectural Responsibility

Module 05 is the Output Boundary Module of the Discovery domain.

Its responsibilities are limited to:

* verification
* boundary enforcement
* interface compliance
* downstream readiness
* controlled export

The implementation SHALL NOT perform:

* processing
* discovery
* feature selection
* candidate selection
* modelling
* scientific computation

---

# Additive-only Principle

Module 05 extends Modules 01–04.

No locked implementation may be modified.

Only additive implementation is permitted.

---

# Stable API Principle

No public API introduced in Modules 01–04 may change semantics.

In particular, the following APIs SHALL remain unchanged:

* execute_discovery_pipeline()
* create_discovery_pipeline()
* register_discovery_stage()
* validate_discovery_pipeline()
* resolve_pipeline_dependencies()
* run_discovery_pipeline()

Module 05 may consume these APIs but SHALL NOT redefine them.

---

# Contract-first Principle (REVISED)

Module 05 SHALL preserve the contractual artifacts produced by upstream modules.

The Discovery → Modeling boundary SHALL expose only verified Discovery contractual artifacts produced upstream.

Module 05 SHALL:

* preserve contractual identity;
* preserve contractual lineage;
* preserve artifact integrity.

Module 05 SHALL NOT:

* reinterpret artifact semantics;
* relabel artifacts;
* merge artifacts;
* split artifacts;
* generate new Discovery artifact types;
* modify the Framework Contract schema.

If upstream modules produce only a subset of the logical Discovery artifact taxonomy defined by IDS-002, Module 05 SHALL verify and expose only that subset.

Module 05 SHALL NOT invent missing logical artifact categories.

---

# Discovery Output Philosophy

Module 05 is responsible for boundary verification only.

Verification SHALL precede export.

Only successfully verified Discovery artifacts may be exposed to downstream modules.

---

# Verification Architecture

Implement a single verification entry point:

`DiscoveryOutputVerifier`

This verifier is the canonical verification component of Module 05.

Its internal implementation SHALL perform:

* contract verification
* interface verification
* completeness verification
* traceability verification
* downstream compatibility verification

These verification components are implementation details only.

They SHALL NOT become independent public APIs.

---

# Verification Failure Policy

Verification SHALL follow a collect-all policy.

The verifier SHALL evaluate every verification category before returning.

The implementation SHALL report all detected failures within a single execution.

Fail-fast behaviour SHALL NOT be implemented.

---

# Verification Report

Verification SHALL produce:

`VerificationReport`

VerificationReport is an implementation object only.

It is NOT:

* a Discovery artifact
* a Framework artifact
* an IDS artifact
* a Discovery → Modeling interface object

VerificationReport exists solely to record Module 05 verification results.

It SHALL NOT be exported downstream.

---

# Output Immutability Principle

Discovery artifacts successfully passing verification SHALL be exposed as read-only outputs.

Module 05 SHALL NOT modify Discovery artifacts after successful verification.

Any change to Discovery artifacts requires re-execution of upstream processing.

---

# Export Architecture (REVISED)

Implement a single export component:

`DiscoveryOutputExporter`

This component SHALL:

* accept one or more Discovery contractual artifacts produced by upstream modules;
* preserve contractual lineage;
* preserve interface semantics.

The exporter SHALL preserve the original artifact collection exactly as received after successful verification.

No additional artifact categorization SHALL be introduced.

No wrapper object representing Discovery outputs shall be introduced.

---

# Public API

Public API shall remain minimal.

Only boundary-level operations shall be exported.

Verification helper functions SHALL remain internal.

---

# Downstream Interface (REVISED)

The Discovery → Modeling boundary SHALL expose only verified Discovery contractual artifacts produced by upstream modules.

Module 05 SHALL preserve the contractual identity of every artifact.

The boundary SHALL NOT reinterpret, relabel, merge, split, or synthesize Discovery artifacts.

VerificationReport SHALL NOT cross the Discovery → Modeling boundary.

No implementation-specific object shall become part of the downstream contract.

---

# Package Dependencies

Do not introduce:

* machine learning frameworks
* statistical modelling packages
* biological knowledge packages
* domain-specific dependencies

Only generic infrastructure may be used.

---

# Documentation

Document all exported APIs using roxygen2.

Documentation shall describe:

* purpose
* arguments
* return values
* verification semantics
* export semantics

Do not document downstream modelling behaviour.

---

# Tests

Test:

* contract verification
* interface verification
* completeness verification
* traceability verification
* downstream readiness verification
* collect-all verification behaviour
* VerificationReport generation
* Discovery output export
* output immutability
* contractual lineage preservation

Do NOT test:

* feature selection
* biomarker discovery
* processing algorithms
* machine learning
* modelling
* biological interpretation

---

# Execution History

Create:

Execution/

Module_05/

* Prompt.md
* Artifacts.md
* Execution_Log.md
* Review.md
* LOCK.md

Artifacts.md shall follow the standardized structure established in Module 01.

---

# In Scope (REVISED)

This module SHALL:

* implement Discovery Output verification
* implement DiscoveryOutputVerifier
* implement VerificationReport
* implement DiscoveryOutputExporter
* verify Discovery contractual artifacts
* verify Discovery → Modeling interface compliance
* verify contractual lineage
* verify downstream readiness
* expose verified Discovery contractual artifacts produced upstream
* preserve read-only outputs

---

# Out of Scope

This module SHALL NOT implement:

* Discovery processing
* QC
* normalization
* filtering
* feature selection
* biomarker discovery
* statistical analysis
* machine learning
* modelling
* validation
* benchmarking
* interpretation
* clinical translation
* biological assumptions
* new Discovery artifact types

---

# Success Criteria (REVISED)

Verification succeeds.

VerificationReport is generated.

Collect-all verification behaviour is implemented.

Discovery contractual artifacts remain unchanged.

Verified Discovery contractual artifacts are correctly exposed without modification.

Contractual lineage is preserved.

Public API remains minimal.

Repository remains additive relative to Module 04.

---

# Definition of Done (REVISED)

Module 05 is complete only if:

1. Discovery Output Boundary Layer implemented.
2. DiscoveryOutputVerifier implemented.
3. Verification follows collect-all policy.
4. VerificationReport implemented.
5. VerificationReport remains implementation-only.
6. DiscoveryOutputExporter implemented.
7. Discovery → Modeling interface correctly exposed.
8. Verified Discovery contractual artifacts exposed without modification.
9. Original contractual identity preserved throughout export.
10. No wrapper Discovery artifact introduced.
11. Read-only output principle respected.
12. Contract-first implementation maintained.
13. Documentation generated successfully.
14. Tests pass.
15. Local execution succeeds.
16. `devtools::check()` reports **0 ERROR** and **0 WARNING**.
17. Governance compliance passes.
18. IDS compliance passes.
19. Repository remains additive.
20. Execution history updated.
21. Strategist Review passes.
22. Project Coordinator approves Module LOCK.

---

# Constraints

Do not redesign Modules 01–04.

Do not modify any existing public API.

Do not modify Discovery Processing.

Do not duplicate orchestration logic.

Do not duplicate processing logic.

Do not introduce scientific algorithms.

Do not introduce new Discovery artifact types.

Do not expose VerificationReport through the Discovery → Modeling interface.

Implement the Discovery Output Boundary Layer only.

---

# Deliverables (REVISED)

* DiscoveryOutputVerifier
* VerificationReport
* DiscoveryOutputExporter
* Discovery Output verification framework
* Verified Discovery contractual artifact interface
* Contract-preserving export mechanism
* Documentation
* Test Suite
* Execution history templates

No additional functionality shall be introduced.

---

End of Module 05 Coding Prompt (v2).
