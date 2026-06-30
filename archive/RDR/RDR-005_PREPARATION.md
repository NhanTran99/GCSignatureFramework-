# RDR-005_PREPARATION.md

**Status:** PHASE A — VALIDATION PHILOSOPHY LOCKED

**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework

**Purpose**

This document records the Validation Philosophy that has already been discussed and officially locked by the Project Coordinator during Phase A.

It is **not** a discussion document.

It is **not** a governance artifact.

It serves as the authoritative Phase A handoff to the Technical Writer (Claude) for drafting **RDR-005_Validation_and_Benchmark_Methodology.md**.

---

# Locked Validation Philosophy

## 1. Validation Objective

The Validation Layer exists to determine which Model Candidates have accumulated sufficient evidence to become **Validated Candidates**.

Validation is therefore an evidence-integration process rather than a single performance assessment.

---

## 2. Validation Input

The Validation Layer receives one or more **Model Candidates**.

Each Model Candidate consists of:

* Predictive model
* Risk score definition
* Model evidence
* Performance profile
* Interpretability profile
* Clinical evaluation profile

The Validation Layer does not receive raw prediction outputs alone.

---

## 3. Validation Output

The Validation Layer produces one or more **Validated Candidates**.

Each Validated Candidate represents a Model Candidate that has successfully completed the framework's validation requirements together with its complete validation evidence.

Validation also provides a transparent recommendation identifying the most appropriate candidate under clearly stated evaluation criteria.

The recommendation must explain:

* why the candidate is preferred,
* under which evaluation criteria,
* for which intended context or population,
* and under which performance profile.

---

## 4. Validation Success Criteria

Validation jointly evaluates Model Candidates using multiple complementary evidence domains.

Examples include (without limiting future methodology):

* Discrimination
* Calibration
* Robustness
* External robustness
* Clinical utility
* Reproducibility

No single metric is sufficient on its own.

Validation remains evidence-driven rather than metric-driven.

---

## 5. Historical Validation Benchmark

Historical validation is reconstructed within the same framework using identical datasets and endpoints.

The historical validation pathway is conceptually represented as:

Model Candidate

↓

Risk Groups

↓

Training Cohort

* Kaplan–Meier
* Log-rank
* ROC / AUC

↓

External Validation Cohort

* Kaplan–Meier
* Log-rank
* Cox analysis

↓

Clinical Translation Extension

* Nomogram
* Calibration
* Decision Curve Analysis
* Bootstrap

Historical methodology remains one governed validation pathway rather than a baseline that must be replaced.

---

## 6. Motivation for Modernization

Historical validation provides one predefined validation pathway.

Its principal limitations are:

* Single validation pathway.
* Limited assessment of external robustness.
* Limited multi-criteria benchmarking across competing candidates.

Modernization therefore focuses on **Validation Candidate Governance**, rather than replacing historical validation methodology.

Historical validation becomes one governed validation pathway inside the framework.

---

## 7. Validation Governance

Validation does not simply score Model Candidates.

Validation determines whether Model Candidates accumulate sufficient evidence to become **Validated Candidates**.

Multiple Validated Candidates may coexist.

Validation provides transparent recommendations while preserving all supporting evidence.

---

## 8. Benchmarking Philosophy

Component-level benchmarking remains mandatory within the Validation Layer.

Historical and modern validation methodologies are benchmarked under identical datasets, endpoints, and evaluation objectives.

End-to-end benchmarking of the complete framework is explicitly outside the scope of RDR-005 and is reserved for the final Framework Integration stage.

---

## 9. Validation Boundary

The Validation Layer begins immediately after the production of one or more Model Candidates.

Its responsibility ends after producing Validated Candidates together with transparent evidence-based recommendations.

Framework-wide recommendation, integration, and end-to-end benchmarking remain outside the scope of RDR-005.

---

# Scope Constraints

RDR-005 shall:

* specialize only the Validation Layer,
* remain methodology-focused,
* remain implementation-independent,
* avoid software packages,
* avoid implementation details,
* avoid IDS content,
* avoid redesigning Discovery or Modeling,
* avoid discussing framework integration beyond the Validation boundary.

---

# Expected Phase B Outcome

Claude should draft:

**RDR-005_Validation_and_Benchmark_Methodology.md**

as the conceptual specialization of the Validation Layer, maintaining consistency with every previously locked RDR and preserving the project philosophy:

**Framework > Signature**

**Evidence-governed Candidate Evolution**

Discovery Candidates

↓

Model Candidates

↓

Validated Candidates

↓

Recommended Signature
