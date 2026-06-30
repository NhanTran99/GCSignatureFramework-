# Contributing Guide

> Part of the **Modernized Biomarker Discovery Framework** documentation set.
> Return to the [README](../README.md) at any time for navigation.

---

## 1. Contribution Philosophy

Contributions that preserve the architectural principles of the framework are welcome. The framework is designed to evolve through **addition rather than modification** — see [Framework Overview](FRAMEWORK_OVERVIEW.md) and [Architecture Overview](ARCHITECTURE_OVERVIEW.md) for the reasoning behind this principle.

---

## 2. What Contributions Should Preserve

Future contributions should:

* preserve the locked Governance Framework;
* preserve the locked Coding Framework architecture;
* preserve the locked Methodology Framework;
* extend functionality through additive methodologies rather than architectural redesign;
* maintain reproducibility and traceability.

---

## 3. What "Additive" Means in Practice

The framework's domains follow a consistent pattern — Workflow → Executor → Implementation Object → Framework Artifact — with methodology supplied through callback extension points (`trainer`, `validator`, `benchmarker`, `selector`, `interpreter`, `integrator`, `translator`). See [Architecture Overview — Extension Points](ARCHITECTURE_OVERVIEW.md#4-extension-points).

In practice, this means:

| Welcome                                                          | Not in scope for ordinary contributions                  |
| -------------------------------------------------------------------- | ------------------------------------------------------------ |
| A new `trainer` implementing a different modeling method            | Changing the Model Construction / Model Management contracts |
| A new `interpreter` for a different interpretability technique       | Changing the Interpretation domain's output boundary         |
| A worked example demonstrating an existing extension point           | Adding a new top-level domain outside the five established ones |
| Documentation improvements, typo fixes, clarified examples           | Rewriting locked Governance, Coding, or Methodology documents |

If you believe a change to the core architecture is genuinely necessary, please open a Discussion first to evaluate it against the framework's design principles before submitting a pull request.

---

## 4. Before You Submit

1. Confirm your change does not modify any locked document (Governance, Coding Framework, Methodology Framework — see [Architecture Overview](ARCHITECTURE_OVERVIEW.md)).
2. Run the package's automated tests locally:
   ```r
   devtools::test()
   devtools::check()
   ```
3. Ensure new functions are documented (roxygen2 + generated `.Rd` files in `man/`).
4. Ensure new functionality, if user-facing, is reflected in the relevant documentation page rather than duplicated across multiple pages — see the [Documentation Map](../README.md#documentation-map) in the README.

---

## 5. Submitting a Contribution

* Open a GitHub Issue or Discussion to propose non-trivial changes before implementation.
* Submit changes via pull request against the repository's default branch.
* Describe which extension point(s) your contribution uses, and which domain it affects.
* Reference any relevant Issue or Discussion in your pull request description.

---

## 6. Reporting Issues

Bug reports, questions, and scientific discussions are welcome through GitHub Issues and repository Discussions. Please include enough detail to reproduce the behavior (R version, package version, minimal reproducible example where possible).

---

## 7. Code of Conduct

Contributors are expected to engage respectfully and constructively, consistent with standard open-source community norms. (A dedicated Code of Conduct document may be added in a future release.)

---

## Next Steps

* [Architecture Overview](ARCHITECTURE_OVERVIEW.md) — understand what you're extending
* [FAQ](FAQ.md) — common questions
* [Citation](CITATION.md) — citing this work

Return to [README](../README.md).
