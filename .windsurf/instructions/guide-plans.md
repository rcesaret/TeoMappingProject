---
guide_id: "guide-plans"
version: "1.0"
last_updated: "2025-06-26"
related_mode: "mode-02-tasks-plans.md"
---

# GUIDE: Windsurf Plan Creation

## 1. CORE OBJECTIVE
To master the art and science of authoring Windsurf `plan` files. A plan is the single most critical document for ensuring successful, predictable, and verifiable task execution by the Cascade agent. Your objective is to translate a single, atomic task from `TASKS.md` into a plan that provides the AI with **perfect, unambiguous context** and a precise, sequential action checklist.

## 2. GOVERNING PRINCIPLES
- **Principle of Perfect Context:** A plan is successful if, and only if, the AI can execute it from start to finish without needing to ask a single clarifying question. This means the `context_files` and `rule_modes` you select must be the complete, minimal set of information required for the task.
- **Principle of Atomicity:** A plan corresponds to *one and only one* atomic task from `TASKS.md`. The actions within the plan must also be atomic, representing the smallest possible units of work (e.g., "create a file," "add one function," "run one test command").
- **Principle of Verifiability:** Every significant action in a plan must be followed by a verification step. Implementation is meaningless without immediate validation (e.g., linting, testing, checking file existence).
- **Principle of Protocol Adherence:** The selection of context is not arbitrary. You MUST strictly follow the **Context Selection Protocol** to determine the correct `rule_modes` and `guides`.

## 3. PROCEDURAL PROTOCOL: The Context Selection Protocol
This protocol is the mandatory procedure for populating a plan's YAML frontmatter.

**Step 1: Analyze the Target Task**
- Ingest the single, atomized task entry from `TASKS.md`.
- Identify the primary action verb (e.g., "Implement," "Test," "Refactor," "Debug") and the primary subject noun (e.g., "Python function," "SQL script," "Project Documentation").

**Step 2: Consult the Context Selection Matrix**
- Use the matrix in `.windsurf/plans/README.md` to map the task's primary action/subject to the corresponding primary `rule_mode`.
- Note the required `guide` file associated with that mode.
- Identify all dependent modes listed in the `Dependencies` column.

**Step 3: Consolidate Context & Manage Budget**
- **`rule_modes` List:** Compile the list of the primary mode and all its dependencies.
- **`context_files` List:**
  1. Start by adding the corresponding `guide-*.md` file for *every* mode you selected. This is non-negotiable.
  2. Add all files listed in the `context_files` section of the source task in `TASKS.md`.
  3. Add any other source files that are logically necessary for the AI to understand the full context of the actions in the plan.
- **Character Count Budget:** Sum the character counts of all selected modes (from the matrix) plus the core rules (`00-core.md`, `01-project-management.md`). You MUST ensure this total is safely under the **12,000 character** system limit. If it is too high, your task is likely not atomic enough, and you should return to the tasking phase.

**Step 4: Final Sufficiency Review**
- Before finalizing the plan, perform a mental dry run. Read every action in the plan's checklist. For each action, ask: "Based *only* on the files listed in `context_files`, does the AI have every single piece of information it needs?" If the answer is no, you must add the missing context.

## 4. CONTEXT-SPECIFIC EXAMPLES & HEURISTICS
**Scenario:** The task is to refactor a Python function in `gcp_processor.py` to improve its performance.

**BAD PLAN CONTEXT:**
```yaml
context_files:
  - "phases/04_Georef/src/gcp_processor.py"
rule_modes:
  - "mode-python-scripting.md"
````

**Reasoning:* This is insufficient. It provides the rule for *how* to write Python, but not the guide. It also lacks the rules and guide for performance optimization, which is the core of the task.*

**GOOD PLAN CONTEXT:**

```yaml
context_files:
  - "phases/04_Georef/src/gcp_processor.py"
  - ".windsurf/instructions/guide-python-style.md"
  - ".windsurf/instructions/guide-performance-optimization.md" # Assumed to exist
rule_modes:
  - "mode-python-scripting.md"
  - "mode-performance-optimization.md" # Assumed to exist
```

**Reasoning:* This context is complete. It provides the file to be changed, the rules for Python scripting and performance, and, crucially, the corresponding instructional guides that explain the *rationale* behind those rules.*

## 5\. ANTI-PATTERNS & TROUBLESHOOTING

  - **Anti-Pattern: The "Kitchen Sink" Plan.** Do not list every file in the project in `context_files`. This wastes tokens and confuses the AI. Be surgical.
  - **Anti-Pattern: Bundled Actions.** An action like "- [ ] Implement the database service and write tests" is not atomic. This should be at least 5-10 separate atomic actions. Break it down.
  - **Troubleshooting: AI asks for clarification.** If the AI has to ask a question, your plan has failed. Analyze the question. It will reveal the piece of context you forgot to include in `context_files`. Archive the failed plan and generate a new, more complete one.

<!-- end list -->

---
