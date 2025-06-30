---
guide_id: "guide-plans"
version: 2.0
last_updated: "2025-06-30"
related_mode: "mode-02-tasks-plans.md"
---

# Strategic Guide: Authoring Windsurf Plan Files

## 1. The Philosophy: A Plan as a "Perfect Context" Package

A Windsurf `.plan.md` file in this project is architected to be more than a simple checklist. It is a **"Perfect Context" Package**: a self-contained, hermetically sealed operational instruction set for the Cascade AI agent.

Its purpose is to provide the agent with *everything* it needs to complete its task, and *nothing* it doesn't. This eliminates ambiguity, prevents hallucination, and makes the AI's behavior deterministic and verifiable. A perfectly authored plan is the cornerstone of a trusted, autonomous execution system.

## 2. Architectural Deep Dive: The Three-Tiered Context Review

The `Stage 1: Context Ingestion & Verification` section of every plan is mandatory and has a precise, three-tiered structure. This structure is designed to load context methodically, moving from the general to the specific.

```mermaid
graph TD
    subgraph "Agent's Understanding"
        A(<b>Global Context</b><br/>Project-wide standards, architecture, and core rules) --> B(<b>Phase-Specific Context</b><br/>The goals and files for the current multi-workflow phase)
        B --> C(<b>Task-Specific Context</b><br/>The exact files and instructions needed for this single, atomic action)
    end
    style A fill:#cde4ff
    style B fill:#a4caff
    style C fill:#7abfff
````

  - **Tier 1: Global Context**

      - **Purpose:** To load the foundational, project-wide principles.
      - **Rationale:** This ensures that every single task, no matter how small, is executed with full awareness of the overall project architecture, glossary, and standards. It prevents "contextual drift" where an agent focused on a small task forgets the bigger picture.

  - **Tier 2: Phase-Specific Context**

      - **Purpose:** To load the context for the current major workflow or phase.
      - **Rationale:** This narrows the agent's focus to the current part of the project (e.g., `PLANNING_PHASE1.md`), ensuring its actions are relevant to the current strategic objectives without needing to re-read all planning documents.

  - **Tier 3: Task-Specific Context**

      - **Purpose:** To load the hyper-specific files and instructions needed for the immediate task.
      - **Rationale:** This is the final and most focused layer. It tells the agent "read these exact files, and these files only, to perform the following checklist." This is a critical optimization that prevents the agent from reading irrelevant files, saving time and tokens.

## 3\. Mastering the `Context Selection Protocol`

The YAML frontmatter is the plan's control panel. Populating it correctly via the **`Context Selection Protocol`** (from `.windsurf/plans/README.md`) is the most important part of authoring a plan.

### 3.1. The Symbiotic Relationship: Why Modes and Guides MUST Be Paired

Think of modes and guides as a **schematic and its corresponding engineering manual**.

  - **`rule_mode` (The Schematic):** Provides the concise, machine-enforceable rules. It's the "what" and "how" in a technical sense (e.g., "Use `ruff` for formatting").
  - **`guide` (The Manual):** Provides the deep strategic context, rationale, examples, and anti-patterns. It's the "why" (e.g., "Here is *why* we use `ruff` and here are examples of good vs. bad formatting in the context of our project's specific needs.").

**Activating a mode without its corresponding guide is a protocol violation.** It is equivalent to giving an engineer a schematic but withholding the manual that explains the tolerances, material specs, and assembly procedures. It invites error.

### 3.2. Worked Example: From Task to Frontmatter

Let's follow the protocol for `task_id: P1.W1.T4.1` from the project's `README.md`.

1.  **Analyze Task:** The description is: "**Implement and Pass Tests for `00_setup_databases.py`**: Create and execute pytest integration tests..."

2.  **Identify Verb/Subject:** The primary action is **Testing** a **Python script**.

3.  **Consult Matrix 1 (Mode Selection):** The `Rule Mode Selection Matrix` in `.windsurf/plans/README.md` clearly maps the verb "test" to `mode-python-testing.md`. This is our `rule_mode`.

4.  **Consult Matrix 2 (Guide Selection):** The `Instructional Guide Cross-Reference` table shows:

      - `mode-python-testing.md` requires `guide-python-testing.md`.
      - All Python modes require `guide-python-style.md`.
      - All coding tasks require `guide-general-coding-standards.md`.

5.  **Assemble Frontmatter:** The result is a perfectly formed, protocol-compliant context definition.

    ```yaml
    ---
    task_id: "P1.W1.T4.1"
    description: "Write comprehensive pytest unit tests for the `00_setup_databases.py` script."
    context_files:
      - "phases/01_LegacyDB/src/00_setup_databases.py"
      - "phases/01_LegacyDB/PLANNING_PHASE1.md"
      - ".windsurf/instructions/guide-python-testing.md"   # Required by mode
      - ".windsurf/instructions/guide-python-style.md"      # Required by Python modes
      - ".windsurf/instructions/guide-general-coding-standards.md" # Required by all coding tasks
    rule_mode:
      - "mode-python-testing.md"
    ---
    ```

### 3.3. Anatomy of a Protocol Violation

The following is an example of **incorrect** frontmatter and constitutes a protocol violation that would trigger a `HALT` condition:

```yaml
# VIOLATION EXAMPLE - DO NOT USE
---
task_id: "P1.W1.T4.1"
description: "Write tests for the database script."
context_files:
  - "phases/01_LegacyDB/src/00_setup_databases.py"
# VIOLATION #1: Missing guide-python-testing.md, which is required by the mode.
# VIOLATION #2: Missing guide-python-style.md and guide-general-coding-standards.md.
rule_mode:
  - "mode-python-testing.md"
---
```

## 4\. The Principle of Atomic Actions in Checklists

Just as tasks must be atomic, the checklist items within a plan must also be atomic.

  - **BAD (Compound Action):** `- [ ] Implement the success path test, including mocking the database and asserting the correct calls.`
  - **GOOD (Atomic Actions):**
      - `- [ ] Create a test function test_setup_databases_success.`
      - `- [ ] Use unittest.mock.patch to mock the psycopg2.connect function.`
      - `- [ ] Configure the mock connection and cursor to return expected values.`
      - `- [ ] Call the main function from 00_setup_databases.py.`
      - `- [ ] Assert that the mock cursor's execute method was called with the expected SQL commands.`

This granularity makes the AI's progress traceable and verifiable at every step.

---
