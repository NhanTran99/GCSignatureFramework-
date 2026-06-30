# {{MODULE_TITLE}}

---

## Project

**Project:** {{PROJECT_NAME}}

**Coding Module:** {{MODULE_ID}} — {{MODULE_NAME}}

**Execution Phase**

---

# Governance

This Coding Module is governed, in precedence order, by:

1. PROJECT_GOVERNANCE_PROMPT_v4.6
2. FRAMEWORK_SPEC.md
3. IMPLEMENTATION_PHILOSOPHY_IDS_PHASE.md
4. {{PRIMARY_IDS}}
5. MODULE_TAXONOMY.md
6. IMPLEMENTATION_MASTER_PLAN.md
7. CODING_PHASE_PHILOSOPHY.md

All governing documents are LOCKED.

No governance document shall be modified or reinterpreted.

---

{{OPTIONAL_PRE_IMPLEMENTATION_DECISION_RECORD}}

---

# Roles

## Project Coordinator

* executes implementation locally
* performs local verification
* determines Module LOCK

## Coding Agent (Claude)

* implements this Coding Module only

## Strategist AI (ChatGPT)

* reviews implementation
* evaluates governance compliance
* evaluates IDS compliance
* requests revisions if necessary

---

# Module Responsibility

{{MODULE_RESPONSIBILITY}}

---

# Architectural Responsibility

{{ARCHITECTURAL_RESPONSIBILITY}}

---

# Additive-only Principle

This module extends all previously LOCKED Coding Modules.

No locked implementation may be modified.

Only additive implementation is permitted.

---

# Stable API Principle

Previously established public APIs SHALL retain:

* function names
* parameter semantics
* return semantics
* implementation responsibilities

This module may consume existing APIs but SHALL NOT redefine them.

Additional module-specific API constraints are defined in:

MODULE_XX_PROMPT_SPEC.md

---

{{MODULE_SPECIFIC_IMPLEMENTATION_PRINCIPLES}}

---

{{MODULE_SPECIFIC_ARCHITECTURE}}

---

{{MODULE_SPECIFIC_PUBLIC_API}}

---

# Documentation

Document all exported APIs using roxygen2.

Documentation shall describe:

* purpose
* arguments
* return values
* implementation semantics

Do not document downstream behaviour beyond the module contract.

---

# Tests

Implement tests covering all functionality defined in the module specification.

Do NOT test functionality explicitly outside the module scope.

Detailed testing requirements belong to:

MODULE_XX_PROMPT_SPEC.md

---

# Execution History

Create:

Execution/

Module_XX/

* Prompt.md
* Artifacts.md
* Execution_Log.md
* Review.md
* LOCK.md

Artifacts.md shall follow the standardized structure established in Module 01.

---

# In Scope

{{IN_SCOPE}}

---

# Out of Scope

{{OUT_OF_SCOPE}}

---

# Success Criteria

{{SUCCESS_CRITERIA}}

---

# Definition of Done

Module completion requires:

1. Module implementation complete.
2. Documentation generated successfully.
3. Required tests pass.
4. Local execution succeeds.
5. `devtools::check()` reports **0 ERROR** and **0 WARNING**.
6. Governance compliance passes.
7. IDS compliance passes.
8. Repository remains additive.
9. Execution History updated.
10. Strategist Review passes.
11. Project Coordinator approves Module LOCK.

Additional module-specific completion criteria belong to:

MODULE_XX_PROMPT_SPEC.md

---

# Constraints

This module SHALL NOT:

* redesign previously LOCKED modules;
* modify existing public APIs;
* duplicate implementation already owned by previous modules;
* introduce functionality outside the approved module scope.

Additional constraints belong to:

MODULE_XX_PROMPT_SPEC.md

---

# Deliverables

Deliverables defined by this module specification.

At minimum:

* implementation
* documentation
* test suite
* execution history

Module-specific deliverables belong to:

MODULE_XX_PROMPT_SPEC.md

---

End of Coding Prompt Template