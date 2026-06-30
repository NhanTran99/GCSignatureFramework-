# RDR-004_PREPARATION.md

**Status:** PHASE A — MODELING PHILOSOPHY LOCKED

**Project:** 12-Gene Gastric Cancer Signature — Part 2: Modernized Biomarker Discovery Framework

## Purpose

This document records the Modeling Philosophy that has already been discussed and officially locked by the Project Coordinator during Phase A.

It is **not** a discussion document.

It is **not** a governance artifact.

It serves as the authoritative Phase A handoff to the Technical Writer (Claude) for drafting **RDR-004_Modeling_Methodology.md**.

---

# Locked Modeling Philosophy

## 1. Modeling Objective

The Modeling Layer exists to develop robust predictive models that jointly optimize:

* Predictive performance
* Robustness
* Reproducibility
* Clinical translatability

Clinical translatability is treated as a design objective rather than clinical deployment.

---

## 2. Modeling Input

The Modeling Layer receives one or more **Discovery Candidates**.

A Discovery Candidate consists of:

* Gene set
* Evidence
* Stability profile
* Discovery pathway
* Quality metrics

The Modeling Layer does **not** receive raw genes alone.

---

## 3. Modeling Output

The Modeling Layer produces one or more **Model Candidates**.

A Model Candidate consists of:

* Predictive model
* Risk score definition
* Model evidence
* Performance profile
* Interpretability profile
* Clinical evaluation profile

These Model Candidates become the input to the Validation Layer.

The Modeling Layer does **not** determine the final recommended model.

---

## 4. Modeling Success Criteria

Model quality is jointly evaluated using:

* Predictive capability
* Robustness
* Reproducibility
* Interpretability
* Parsimony
* Support for downstream clinical evaluation

No single criterion dominates the others.

---

## 5. Model Complexity Philosophy

When two candidate models demonstrate comparable overall performance,

the framework prefers the simpler model.

The objective is to encourage robustness, interpretability, and applicability in resource-constrained settings.

---

## 6. Model Candidate Governance

The Modeling Layer never assumes that only one modeling strategy exists.

Instead, multiple Model Candidates may coexist.

Example:

Discovery Candidate A

↓

Model Candidate A

Discovery Candidate B

↓

Model Candidate B

Selection is **not** performed in the Modeling Layer.

Selection belongs to the Validation Layer.

---

## 7. Historical Modeling Benchmark

Historical modeling is executed inside the same framework.

Historical and modern modeling must operate under identical datasets and endpoints.

Component-level benchmarking is mandatory.

End-to-end benchmarking belongs to the final integrated framework and is outside the scope of RDR-004.

---

## 8. Modeling Boundary

The Modeling Layer begins with:

Discovery Candidate

↓

Representation

↓

Prediction

↓

Risk Estimation

↓

Model Candidate

The Validation Layer begins immediately after the production of Model Candidates.

---

## 9. Motivation for Modernization

The purpose of RDR-004 is **not** to replace historical methodologies.

Historical PCA → Predictive Index → Median Split → SVM remains a valid historical modeling pathway.

The limitation of the historical pipeline is that it provides only one modeling pathway and lacks governance for evaluating multiple modeling strategies.

Modernization therefore introduces **Model Candidate Governance**, not the rejection of historical methodology.

Historical methodology becomes one governed candidate within a transparent evidence-based framework.

---

# Scientific Positioning

The Modeling Layer preserves the framework philosophy established by previous RDRs:

* Framework > Signature
* Component-wise Modernization
* Evidence-Constrained Modernization
* Methodology Decision Layer
* Candidate Governance
* Disease-agnostic Framework

---

# Scope Constraints

RDR-004 shall:

* specialize only the Modeling Layer;
* remain methodology-focused;
* remain implementation-independent;
* avoid software packages;
* avoid implementation details;
* avoid IDS content;
* avoid redesigning Discovery or Validation;
* avoid discussing Framework Integration.

---

# Expected Phase B Outcome

Claude shall draft:

**RDR-004_Modeling_Methodology.md**

as the conceptual specialization of the Modeling Layer, maintaining consistency with every previously locked RDR and preserving the project philosophy:

**Framework > Signature**

**Evidence-governed Candidate Evolution**

Discovery Candidates

↓

Model Candidates

↓

Validated Candidates

↓

Recommended Signature
