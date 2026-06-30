# Quick Start

> Part of the **Modernized Biomarker Discovery Framework** documentation set.
> Return to the [README](../README.md) at any time for navigation.

This guide demonstrates how the framework's stages fit together. It assumes the package is already installed — see the [Installation Guide](INSTALLATION.md) if you have not yet set up the environment.

---

## 1. The Framework Workflow

A typical workflow follows the architecture of the framework rather than a disease-specific analysis:

```text
Discovery
   │
   ▼
Modeling
   │
   ▼
Validation
   │
   ▼
Interpretation
   │
   ▼
Clinical Translation
```

Each stage produces a well-defined **Framework Artifact** that is consumed by the next stage. Artifacts preserve complete lineage back to their originating inputs, which is what makes the workflow traceable and reproducible.

---

## 2. Loading the Package

```r
library(GCSignatureFramework)
```

---

## 2A. Verifying Your Installation

Before building a workflow, you can confirm the package was installed correctly by running the canonical smoke test shipped with the package. This script loads the package, constructs a minimal Framework Contract, and verifies it against its expected class — without running any pipeline, benchmark, or external dataset.

```r
source(system.file("examples", "smoke_test.R", package = "GCSignatureFramework"))
```

A successful run prints `== WP4 Smoke Test PASSED ==`. If this fails, see the [Installation Guide — Troubleshooting](INSTALLATION.md#7-troubleshooting).

---

## 3. Constructing a Discovery Pipeline

The Discovery layer is orchestration-only: it defines *what* stages run and in *what* order, without performing computation itself.

```r
pipeline <- create_discovery_pipeline(
  # stage registrations supplied via register_discovery_stage()
)
```

Stages are registered using `register_discovery_stage()`, and the pipeline is executed using `execute_discovery_pipeline()` or `run_discovery_pipeline()`. Consult the function reference (`?create_discovery_pipeline`) for the current parameter contract.

---

## 4. Producing Discovery Output

Once executed, Discovery output is verified and exported through the Discovery Output Boundary before being handed to the Modeling stage:

```r
verifier <- DiscoveryOutputVerifier(...)
exporter <- DiscoveryOutputExporter(...)
```

Only verified artifacts cross the Discovery → Modeling boundary.

---

## 5. Building and Training a Model

```r
model_spec   <- create_model_specification(...)
model_object <- create_model_object(model_spec)
training     <- train_model(model_object, ...)
```

The Model Object remains immutable throughout training; the Training Object captures execution metadata and lineage.

---

## 6. Producing Modeling Evidence

```r
candidate <- create_model_candidate(training, ...)
evidence  <- create_modeling_evidence(candidate, ...)
```

`Model Candidate` and `Modeling Evidence` are the Framework artifacts that cross the Modeling → Validation boundary.

---

## 7. Continuing Through Validation, Interpretation, and Clinical Translation

The same pattern — construct, execute, verify, export — repeats through:

* **Validation** (`run_validation`, `create_validation_evidence`)
* **Interpretation** (`run_interpretation`, `create_interpretation_package`)
* **Clinical Translation** (`run_clinical_translation`, `create_clinical_translation_package`)

Each stage's artifacts embed the previous stage's objects, so the complete lineage from raw Discovery input to final Clinical Translation output is always recoverable.

---

## 8. Where Methodology Comes In

The package intentionally ships **no domain-specific statistical or biological algorithms**. Each stage accepts methodology through callback extension points (e.g. `trainer`, `validator`, `benchmarker`, `selector`, `interpreter`, `integrator`, `translator`).

This means the Quick Start workflow above is generic by design — to run a real analysis, supply your own methodology implementations through these callbacks rather than modifying the framework.

---

## Next Steps

* [Installation Guide](INSTALLATION.md) — environment setup
* [Framework Overview](FRAMEWORK_OVERVIEW.md) — scientific motivation and architecture
* [Architecture Overview](ARCHITECTURE_OVERVIEW.md) — software design in depth
* [Examples](EXAMPLES.md) — worked end-to-end scenarios

Return to [README](../README.md).
