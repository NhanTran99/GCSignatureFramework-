# Examples

> Part of the **Modernized Biomarker Discovery Framework** documentation set.
> Return to the [README](../README.md) at any time for navigation.

This page collects practical usage scenarios for the framework. For a guided first run, see [Quick Start](QUICK_START.md).

---

## 1. Current Release Scope

This release establishes a stable framework architecture: contracts, domain workflows, execution boundaries, and extension points are complete and locked. Worked, fully-executable examples that supply concrete methodology through the framework's extension points are planned as part of ongoing documentation expansion.

This page will be populated incrementally as worked examples are completed, without requiring changes to the framework architecture itself.

---

## 1A. Available Now: Installation Smoke Test

A minimal, deterministic example is already available in the repository: `inst/examples/smoke_test.R`. It loads the package, constructs a minimal Artifact Contract via `create_artifact_contract()`, and verifies the returned object against its expected class — without running any pipeline stage, benchmark, or external dataset.

```r
source(system.file("examples", "smoke_test.R", package = "GCSignatureFramework"))
```

This script is intentionally minimal: its purpose is to confirm that the package is installed and reproducible, not to demonstrate scientific usage. For a conceptual walkthrough of a full workflow, see [Quick Start](QUICK_START.md).

---

## 2. Planned Example Coverage

Future examples will demonstrate the following scenarios end to end:

* **Discovery workflow construction** — registering processing stages and producing verified Discovery output.
* **Model development** — constructing a Model Specification, training via a custom `trainer` callback, and producing a Model Candidate.
* **Validation and benchmarking** — supplying `validator` and `benchmarker` callbacks to produce Validation Evidence and a Validated Candidate.
* **Interpretation** — supplying an `interpreter` callback to produce an Interpretation Package.
* **Clinical translation** — supplying `integrator` and `translator` callbacks to produce a Clinical Translation Package.
* **Methodology extension** — adding a new scientific method to an existing domain purely through its callback extension point, without modifying the framework.

---

## 3. Reference Implementation

The framework's design is validated through a complete biomarker discovery demonstration using a 12-gene gastric cancer recurrence-risk signature, which exercises every domain from Discovery through Clinical Translation. See [Framework Overview](FRAMEWORK_OVERVIEW.md#5-demonstration-case-12-gene-gastric-cancer-signature) for context on this demonstration case.

---

## 4. In the Meantime

Until dedicated worked examples are published here:

* The [installation smoke test](#1a-available-now-installation-smoke-test) above confirms your environment is set up correctly.
* [Quick Start](QUICK_START.md) walks through the conceptual shape of a workflow stage by stage.
* The function reference for each constructor and executor (e.g. `?create_discovery_pipeline`, `?train_model`, `?create_validation_evidence`) documents the current parameter contract directly.
* [Architecture Overview](ARCHITECTURE_OVERVIEW.md) explains how the Workflow → Executor → Implementation Object → Framework Artifact pattern applies uniformly across domains, which generalizes across whatever example you are trying to construct.

---

## Next Steps

* [Quick Start](QUICK_START.md) — guided first run
* [Architecture Overview](ARCHITECTURE_OVERVIEW.md) — the pattern every example follows
* [FAQ](FAQ.md) — common questions
* [Citation](CITATION.md) — citing this work

Return to [README](../README.md).
