# Frequently Asked Questions

> Part of the **Modernized Biomarker Discovery Framework** documentation set.
> Return to the [README](../README.md) at any time for navigation.

---

## General

### What is the Modernized Biomarker Discovery Framework?

A reusable, governance-driven R framework that separates project governance, scientific methodology, software implementation, and clinical translation into independent architectural layers, supporting the complete biomarker discovery lifecycle from data processing to clinical deployment. See [Framework Overview](FRAMEWORK_OVERVIEW.md).

### Is this a gastric cancer prediction tool?

No. The 12-gene gastric cancer signature is a **demonstration case** used to validate the framework's architecture. The framework itself is disease-agnostic and methodology-independent — it can be applied to other diseases, biomarkers, or analytical methodologies. See [Framework Overview — Demonstration Case](FRAMEWORK_OVERVIEW.md#5-demonstration-case-12-gene-gastric-cancer-signature).

### How does this relate to "Part 1" of the project?

Part 1 is a separate, historical reconstruction of a published 12-gene biomarker discovery pipeline using classical methodology. Part 2 (this framework) generalizes the structure of that work into a reusable architecture using contemporary methodology. Part 1 is immutable and independent of Part 2.

---

## Installation

### What R version do I need?

R ≥ 4.3 is recommended. See the [Installation Guide](INSTALLATION.md).

### Do I have to use `renv`?

`renv` is recommended for reproducibility, since it locks exact dependency versions via `renv.lock`. If you do not use `renv`, you can install the dependencies declared in `DESCRIPTION` manually.

### `devtools::install()` fails to compile — what should I check first?

Confirm your R version and that development build tools are installed for your OS (Rtools / Xcode Command Line Tools / `build-essential`). See [Installation Guide — Troubleshooting](INSTALLATION.md#7-troubleshooting).

---

## Usage

### Does the package include statistical or ML algorithms out of the box?

No. The package intentionally avoids embedding domain-specific statistical or biological algorithms. Methodology is supplied through callback extension points (`trainer`, `validator`, `benchmarker`, `selector`, `interpreter`, `integrator`, `translator`). See [Architecture Overview — Extension Points](ARCHITECTURE_OVERVIEW.md#4-extension-points).

### How do I add my own methodology?

Implement the relevant callback for the domain you are extending (e.g. a custom `trainer` for Modeling) and supply it at the appropriate construction or execution step. The framework's contracts, workflows, and boundaries remain unchanged. See [Quick Start](QUICK_START.md) and [Examples](EXAMPLES.md).

### Why don't Workflow objects call executors directly?

This is an intentional architectural separation: the Workflow layer performs orchestration only, and the Execution layer performs the actual processing. This keeps orchestration logic stable even as execution implementations evolve. See [Architecture Overview — Orchestration / Execution Separation](ARCHITECTURE_OVERVIEW.md#orchestration--execution-separation).

### What is a "Framework Artifact"?

A verified, immutable, contract-conformant object that crosses a domain boundary (e.g. a Model Candidate, Validation Evidence, or Clinical Translation Package). Framework Artifacts are distinct from internal implementation objects, which remain private to the domain that produced them. See [Architecture Overview — Domain Pattern](ARCHITECTURE_OVERVIEW.md#domain-pattern-workflow--executor--implementation-object--framework-artifact).

### How is lineage preserved between stages?

Each downstream Framework Artifact embeds the implementation object that produced it, rather than copying or discarding it, so the full chain of evidence from Discovery through Clinical Translation is always programmatically recoverable. See [Architecture Overview — Lineage and Composition](ARCHITECTURE_OVERVIEW.md#3-lineage-and-composition).

---

## Contributing and Extending

### Can I modify the core framework architecture?

The Governance Framework, Coding Framework, and Methodology Framework are locked and should not be redesigned. Extensions should be additive — new methodology supplied through existing extension points. See [Contributing Guide](CONTRIBUTING.md).

### Where do I report a bug or ask a question?

Through GitHub Issues or repository Discussions.

---

## Citation

### How do I cite this work?

See the [Citation](CITATION.md) page for current citation guidance.

---

## Still Have Questions?

If your question is not answered here, please open a GitHub Issue or start a Discussion in the repository.

---

## Next Steps

* [Quick Start](QUICK_START.md)
* [Architecture Overview](ARCHITECTURE_OVERVIEW.md)
* [Contributing Guide](CONTRIBUTING.md)

Return to [README](../README.md).
