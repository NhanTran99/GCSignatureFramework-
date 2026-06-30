# Architecture Overview

> Part of the **Modernized Biomarker Discovery Framework** documentation set.
> Return to the [README](../README.md) at any time for navigation.

This document describes the software-level architecture of the framework. For the scientific motivation behind this design, see [Framework Overview](FRAMEWORK_OVERVIEW.md).

---

## 1. The Four Architectural Layers

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

Each layer has a single responsibility and depends only on the layer above it.

### Governance Framework

Defines project rules, architectural decisions, review workflow, and long-term project consistency. Governance determines **how the project evolves**, but never performs scientific computation.

### Methodology Framework

Represents scientific methodologies independently from software implementation. Methods are evaluated, organized, and composed before implementation decisions are made.

### Coding Framework

Provides a reusable R package architecture implementing generic workflows, contracts, execution pipelines, and extension points. The package intentionally avoids embedding domain-specific statistical or biological algorithms, instead providing stable interfaces through which future methodologies can be integrated.

### Scientific Execution

Scientific analyses are performed by supplying validated methodologies to the framework through its predefined extension mechanisms. This separation allows new algorithms and workflows to be introduced without modifying the underlying framework architecture.

---

## 2. The Coding Framework in Detail

The Coding Framework — the R package itself — is organized around a five-domain execution architecture:

```text
Repository Foundation
        │
        ▼
Framework Contracts
        │
        ▼
Discovery Domain
        │
        ▼
Modeling Domain
        │
        ▼
Validation Domain
        │
        ▼
Interpretation Domain
        │
        ▼
Clinical Translation Domain
```

### Framework Contracts

A stable contract layer (`create_artifact_contract()`, `create_interface_contract()`, `create_dependency_contract()`, `create_verification_contract()`) provides the typed, validated objects that every domain builds on. Contracts are the single point of truth for what constitutes a valid Framework Artifact.

### Domain Pattern: Workflow → Executor → Implementation Object → Framework Artifact

From the Discovery domain onward, every domain follows the same architectural pattern:

| Step                     | Responsibility                                                          |
| -------------------------- | --------------------------------------------------------------------------- |
| **Workflow**               | Orchestration only — defines *what* runs and in *what* order.              |
| **Executor**                | Generic execution engine — performs the actual processing.                |
| **Implementation Object**   | Internal, mutable working object produced during execution (not a Framework Artifact). |
| **Framework Artifact**      | Verified, immutable, contract-conformant output that crosses a domain boundary. |

This pattern is consistent across Discovery, Modeling, Validation, Interpretation, and Clinical Translation, and is the architectural backbone that keeps the five domains interchangeable in structure despite differing in scientific content.

### Orchestration / Execution Separation

Within each domain, the Workflow layer and the Execution layer are intentionally separated:

* the **Workflow** layer performs orchestration only and does not invoke executors directly;
* the **Execution** layer performs the actual processing.

This separation allows the orchestration logic to remain stable even as execution implementations evolve.

### Domain Output Boundaries

Each domain produces Framework Artifacts at a verified output boundary before handing off to the next domain:

| Domain                 | Framework Artifacts Produced                                  |
| ------------------------ | ----------------------------------------------------------------- |
| Discovery                | Verified, exported Discovery output                              |
| Modeling                 | `model_candidate`, `modeling_evidence`                            |
| Validation                | `validation_evidence`, `validated_candidate`                      |
| Interpretation            | `interpretation_evidence`, `interpretation_package`               |
| Clinical Translation       | `clinical_translation_evidence`, `clinical_translation_package`   |

Only verified artifacts cross a domain boundary; intermediate implementation objects (e.g. Training Objects, Verification Reports) remain internal to their domain.

---

## 3. Lineage and Composition

Every downstream Framework Artifact preserves complete lineage by **embedding** the implementation object that produced it, rather than copying or discarding it. For example, a `model_candidate` embeds the originating Training Object, which itself was constructed from an immutable Model Object.

This composition-based lineage means that, from any Clinical Translation artifact, the complete chain of evidence back to the original Discovery output is always programmatically recoverable.

---

## 4. Extension Points

The framework avoids embedding domain-specific algorithms. Instead, each execution layer accepts methodology through callback extension points:

| Domain                | Extension Point(s)        |
| ------------------------ | ---------------------------- |
| Discovery                | processing stage callbacks  |
| Modeling                  | `trainer`                   |
| Validation                 | `validator`, `benchmarker` |
| Interpretation              | `interpreter`              |
| Clinical Translation         | `integrator`, `translator` |
| Candidate Selection          | `selector`                |

New scientific methods are introduced by supplying new callback implementations — the framework's contracts, workflows, and boundaries do not change.

---

## 5. Metadata Conventions

Framework Artifacts are tagged with two metadata fields used consistently across all domains:

* `metadata$framework_layer` — identifies which architectural layer produced the artifact.
* `metadata$artifact_role` — identifies the artifact's role within its domain (e.g. `"modeling_evidence"`, `"validation_evidence"`, `"interpretation_package"`, `"clinical_translation_evidence"`).

This tagging convention allows artifacts to be introspected and routed generically, without the framework needing to know about specific scientific content.

---

## 6. Why This Architecture Is Stable

The architecture is designed so that future work extends it through **addition**, not modification:

* new methodologies plug into existing callback extension points;
* new artifact types compose with the existing contract layer;
* new domains, if ever needed, would follow the same Workflow → Executor → Implementation Object → Framework Artifact pattern already established.

This is what allows the Coding Framework to remain LOCKED while the Methodology Framework continues to evolve independently.

---

## Next Steps

* [Quick Start](QUICK_START.md) — run the framework end to end
* [Examples](EXAMPLES.md) — worked scenarios
* [Framework Overview](FRAMEWORK_OVERVIEW.md) — scientific motivation

Return to [README](../README.md).
