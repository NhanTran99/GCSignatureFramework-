# Installation Guide

> Part of the **Modernized Biomarker Discovery Framework** documentation set.
> Return to the [README](../README.md) at any time for navigation.

This guide covers environment requirements and installation steps for the framework.

---

## 1. Requirements

The framework is implemented as an R package and requires:

* **R** (≥ 4.3 recommended)
* Development tools for compiling R packages (e.g. Rtools on Windows, Xcode Command Line Tools on macOS, `build-essential` on Linux)
* **Git** (recommended for repository management)

Additional package dependencies are declared in the package `DESCRIPTION` file and are resolved automatically through `renv`.
First-time R users may be prompted to select a CRAN mirror and activate the renv project during the initial dependency restoration. These are expected one-time setup steps.
---

## 2. Clone the Repository

```bash
git clone https://github.com/<username>/ModernizedBiomarkerDiscoveryFramework.git
cd ModernizedBiomarkerDiscoveryFramework
```

---

## 3. Open the Project

Open the project in RStudio (recommended) by opening the `.Rproj` file, or open the cloned directory in your preferred R environment.

---

## 4. Restore Dependencies

The project uses `renv` to lock dependency versions for reproducibility.

```r
renv::restore()
```

This reads `renv.lock` and installs the exact package versions used during development.

If `renv` is not used in your environment, install the dependencies declared in `DESCRIPTION` manually using standard R package installation procedures.

---

## 5. Install the Package

```r
devtools::install()
```

This builds and installs the package into your local R library, making it available via:

```r
library(GCSignatureFramework)
```

---

## 6. Verify the Installation

Confirm the package loads and its core API is available:

```r
library(GCSignatureFramework)
ls("package:GCSignatureFramework")
```

Optionally, run the package's automated test suite from the project root:

```r
devtools::test()
```

---

## 7. Troubleshooting

| Symptom                              | Likely Cause                              | Suggested Action                                  |
| ------------------------------------- | ------------------------------------------ | --------------------------------------------------- |
| `renv::restore()` fails to resolve packages | Missing system build tools                | Install Rtools / Xcode CLT / `build-essential`     |
| `devtools::install()` fails to compile | Outdated R version                        | Upgrade to R ≥ 4.3                                  |
| Package loads but functions are missing | Installed from a stale local build        | Re-run `devtools::install()` after `git pull`      |

For issues not covered here, see the [FAQ](FAQ.md) or open a GitHub Issue.

---

## Next Steps

* [Quick Start](QUICK_START.md) — run your first framework workflow
* [Framework Overview](FRAMEWORK_OVERVIEW.md) — scientific motivation and architecture
* [Architecture Overview](ARCHITECTURE_OVERVIEW.md) — software design in depth

Return to [README](../README.md).
