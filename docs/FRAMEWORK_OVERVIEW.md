# Framework Overview

> Part of the **Modernized Biomarker Discovery Framework** documentation set.
> Return to the [README](../README.md) at any time for navigation.

This document describes the scientific motivation and conceptual design of the framework. For the software-level architecture, see [Architecture Overview](ARCHITECTURE_OVERVIEW.md).

---

## 1. The Problem

Computational biomarker research commonly faces a structural challenge: scientific methodology, software implementation, and project governance are tightly coupled. A discovery pipeline is often written as a single monolithic script in which statistical choices, modeling code, and project decisions are interleaved.

This coupling makes such pipelines difficult to:

* **reproduce** — re-running the work requires reconstructing implicit assumptions;
* **extend** — introducing a new method requires rewriting pipeline internals;
* **maintain** — changes to one concern risk silently affecting another;
* **review** — it is difficult to audit *why* a methodological choice was made versus *how* it was implemented.

---

## 2. The Framework Response

The Modernized Biomarker Discovery Framework addresses this by introducing a layered architecture that separates these concerns into independent, interoperable components:

```text
Governance Framework
        │
        ▼
Methodology Framework
        │
        ▼
Coding Framework
        │
        ▼
Scientific Execution
```

Each layer answers a distinct question:

| Layer                  | Question it answers                                  |
| ------------------------ | ------------------------------------------------------- |
| Governance              | How does the project make and record decisions?        |
| Methodology             | What scientific methods are available, and why?        |
| Coding (Implementation)  | How are methods executed in reproducible software?     |
| Scientific Execution     | What was actually run, and what evidence did it produce? |

A full description of each layer's internal design is provided in the [Architecture Overview](ARCHITECTURE_OVERVIEW.md).

---

## 3. Why Separation Matters

Because methodology is represented independently from implementation, a scientific method can be evaluated, documented, and revised without touching the software layer. Conversely, the software layer can be extended — new stages, new artifact types — without requiring a methodological decision to be re-litigated.

This separation is what allows the framework to support **long-term methodological evolution** (new statistical methods, new biomarker modalities) on top of a **stable software foundation** (the same contracts, pipelines, and execution boundaries).

---

## 4. Scientific Workflow Narrative

The framework is best understood through the progression it is designed to support:

```text
Problem → Framework → Architecture → Implementation → Usage → Extension → Citation
```

* **Problem** — the reproducibility and extensibility challenge described above.
* **Framework** — this document; the conceptual layering that addresses the problem.
* **Architecture** — the concrete software design ([Architecture Overview](ARCHITECTURE_OVERVIEW.md)).
* **Implementation** — the R package itself (`R/`, documented via `man/`).
* **Usage** — running a workflow end to end ([Quick Start](QUICK_START.md), [Examples](EXAMPLES.md)).
* **Extension** — supplying new methodology through callback extension points.
* **Citation** — referencing this work in academic output ([Citation](CITATION.md)).

---

## 5. Demonstration Case: 12-Gene Gastric Cancer Signature

The framework's design is validated through a complete biomarker discovery workflow demonstrated on a 12-gene gastric cancer recurrence-risk signature. This demonstration:

* exercises every stage of the framework (Discovery through Clinical Translation);
* shows that a disease-specific project can be implemented entirely through the framework's extension mechanisms;
* serves as a worked reference for future projects targeting other diseases or biomarker modalities.

The gastric cancer case study is a **demonstration of the framework**, not the framework's primary identity. The framework itself remains disease-agnostic and methodology-independent.

---

## 6. Relationship to Part 1

This framework constitutes Part 2 of a two-part project. Part 1 is a historical, scientifically-faithful reconstruction of a published 12-gene biomarker discovery pipeline using classical methodology. Part 2 takes the lessons and structure of that reconstruction and generalizes them into a reusable, governance-driven framework applying contemporary methodology.

Part 1 remains immutable and independent; Part 2 does not modify or depend on Part 1's implementation.

---

## Next Steps

* [Architecture Overview](ARCHITECTURE_OVERVIEW.md) — software-level design
* [Quick Start](QUICK_START.md) — run the framework
* [Examples](EXAMPLES.md) — worked scenarios
* [Citation](CITATION.md) — citing this work

Return to [README](../README.md).
