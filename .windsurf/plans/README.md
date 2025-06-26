---
plan_template_version: 3.0.0
last_updated: 2025-06-26
required_context:
  - TASKS.md
  - PLANNING.md
  - docs/architecture.md
  - .windsurf/rules/
  - .windsurf/plans/PLAN.template.md
---

# Windsurf Plan Files

## 1. Overview & Core Purpose

This directory contains all Windsurf Plan files for the Digital TMP project. A "plan" is the central control mechanism for guiding the Cascade AI agent. Its purpose is twofold:

1.  **To provide a precise execution script:** It breaks down a complex task from `TASKS.md` into a sequence of small, unambiguous, and verifiable atomic actions.
2.  **To load a hyper-specific context:** It uses a YAML frontmatter block to dynamically activate specific "workflow modes" from the `.windsurf/rules/` directory and to load all necessary source files and instructional guides.

Using these plans ensures that the AI's execution is predictable, reproducible, and precisely aligned with the specific technical and strategic requirements of the task at hand.

## 2. File Naming Convention

All plan files MUST be named according to the ID of the task they correspond to in `TASKS.md`. This provides a direct and unambiguous link between a task and its execution script.

-   **Format:** `<task_id>.plan.md`
-   **Example:** `p1_w1_t4_1.plan.md`

## 3. Plan File Structure

Every plan file MUST consist of two parts: a YAML Frontmatter block and a Markdown body containing an Action Checklist.

### YAML Frontmatter (The Control Panel)

The frontmatter is enclosed in `---` and contains the metadata that configures the AI's context. The following keys are mandatory:

-   `task_id`: The unique ID from `TASKS.md` that this plan executes.
-   `description`: A concise, one-sentence summary of the plan's overall goal.
-   `context_files`: A YAML list of all files the AI needs to read to have complete context. This MUST include both source code files and relevant instructional guides from `.windsurf/instructions/`.
-   `rule_mode`: The on-demand workflow rule mode to be activated from the `.windsurf/modes/` directory. This is the primary mechanism for controlling the AI's task-/plan- specific behavior.
-   `date_created`: Date of plan mode plan creation in `YYYY-MM-DD` format.
-   `last_updated`: Date of plan mode plan's last update in `YYYY-MM-DD` format.
-   `status`: The current state of the plan. Valid values are `"Draft"`, `"Active"`, or `"Completed"`.

**Canonical Example:**
```yaml
---
task_id: P4.3.1
description: "Refactor the GCP outlier detection to use the IQR method and add database integration tests."
context_files:
  - "phases/04_Georef/src/gcp_processor.py"
  - ".windsurf/instructions/guide-general-coding-standards.md"
  - ".windsurf/instructions/guide-python-style.md"
rule_modes:
  - "mode-python-scripting.md"
date_created: 2025-06-23
last_updated: 2025-06-24
status: Draft
---
```

### Objectives

List the high-level goals of this plan, especially as they relate to outputs required for downstream tasks.

### Stage 1: Context Ingestion & Verification

This is the most critical setup stage. It is divided into three distinct levels of context that the AI must review before beginning any work.

#### Global Context Review:

**This section is standard, universal and *MUST NOT* change.** It lists the core project-wide documents and the complete rule suite. This ensures every task is executed with full awareness of the project's foundational principles.

**Example:**
```markdown
- [ ] **Global Context Review:** Exhaustively review the following core project files to ensure full alignment with project standards:
    - [ ] `README.md` (root)
    - [ ] `PLANNING.md`
    - [ ] `TASKS.md`
	- [ ] `docs/overview.md`
    - [ ] `docs/architecture.md`
	- [ ] `docs/technical_specs.md`
    - [ ] The complete rule suite in the `.windsurf/rules/` directory.
```

#### Phase-Specific Context Review:

This section is **standard for all tasks within a given phase**. It lists documents relevant to the entire phase, such as the phase-specific `README.md` and `PLANNING_PHASE1.md`.

**Example:**
```markdown
- [ ] **Phase-Specific Context Review:** Exhaustively review the following files to understand the present phase and workflow context:
    - [ ] `phases/<current phase>/README.md`
    - [ ] `phases/<current phase>/PLANNING_PHASE<current phase number>.md`
```

#### Task-Specific Context Review:

This section is **unique to each plan** and must be carefully curated. It lists the files, documentation sections (using anchors like `#section-title`), and script outputs that are directly required to execute the specific task at hand.

**Example:**
```markdown
- [ ] **Task-Specific Context Review:** Exhaustively review the following files to understand the specific requirements of task `P1.W1.T4.1`:
    - [ ] The test strategy section of the Phase 1 plan: `phases/01_LegacyDB/PLANNING_PHASE1.md#Testing-Strategy-for-00_setup_databases.py`.
    - [ ] The Python script that is the subject of the tests: `phases/01_LegacyDB/src/00_setup_databases.py`.
```


### Stage 2: Preparation

This stage involves setting up all necessary prerequisites for the core task. Actions in this stage typically include:

-   Defining lists of items to iterate over (e.g., database names, file paths).
-   Identifying source template files and target deliverable paths.
-   Confirming that inputs from previous tasks exist and are accessible.

### Stages 3+: Execution

This is the primary "work" stage of the plan. It contains the detailed, step-by-step instructions for the AI to follow. These steps should be:

-   **Atomic:** Each step should represent a single, clear action.
-   **Sequential:** The order of the steps must reflect the logical flow of the work.
-   **Imperative:** Each step should be a clear command (e.g., "Create the file...", "Execute the script...", "Verify the output...").

### Final Stage: Validation & Cleanup

The final stage ensures the task was completed successfully and integrates the results back into the project's tracking system.

-   Verify that all deliverables specified in `TASKS.md` have been created correctly.
-   Explicitly check all `validation_steps` from `TASKS.md`.
-   Propose the necessary changes to `TASKS.md` to update the task's status to `done`.

---

## 4. Critical Rules for Context Configuration

To ensure the AI operates with full and correct context, the following rules for configuring the YAML frontmatter are MANDATORY:

1.  **Instructional Guide Inclusion:** Most tasks require attaching multiple instructional guides as context files. These are selected using a two-stage process:
    -   **Step 1: Mode-Associated Guides:** Given the specific `mode-*.md` file included for `rule_mode`, the corresponding instructional guide (`guide-*.md`) from the `.windsurf/instructions/` directory MUST be included in the `context_files` list. This provides the AI with the detailed, human-readable instructions necessary to correctly interpret and execute the high-level rules defined in the mode.
        -   **Example:** If `rule_modes` contains `mode-python-testing.md`, then `context_files` MUST contain `.windsurf/instructions/guide-python-testing.md`, as well as `.windsurf/instructions/guide-general-coding-standards.md` (which is required for ALL coding tasks).
	-   **Step 2: Supplementary Guides:** Many tasks involve multi-modal contexts that are not fully covered by the rule mode and its associated instructional guide(s). As such, you MUST identify any other, additional instructional guides that are directly relevant to the task, and include these in the `context_files` list.
        -   **Example:** If a task primarily involves python scripting with `mode-python-scripting.md` as the `rule_mode`, but also involves generating SQL queries within a python-based framework, then `context_files` MUST contain `guide-python-style.md` (the rule-mode-associated instructional guide), `guide-general-coding-standards.md`(required for ALL coding tasks), AND `guide-sql-best-practices.md` (a supplementary instructional guide necessary for adequate guidance on the SQL component).

2.  **The Principle of Direct Relevance:** The `context_files` list must not include files that are only indirectly or tangentially related to the present task. Only include files that are directly relevant to the specific actions outlined in the plan's checklist. Avoid including entire directories or lists of non-essential files.

## 5. Context Selection Protocol

### Purpose

This protocol provides the definitive, systematic methodology for selecting the correct `rule_mode` and 'instructional guides' when authoring a Windsurf `plan` file. This protocol is designed for the "Planner" agent persona, which operates *after* a detailed architectural blueprint and execution plan have been created for a given project phase.

### Core Principles

-   **Atomicity is Prerequisite:** This protocol is only to be applied to **fully atomized tasks** from the `TASKS.md` file—tasks that have been broken down into the smallest possible, verifiable units of work by the architectural planning process. Applying this protocol to coarse-grained tasks will result in context window overruns and mission failure.
-   **Task-Driven Context:** The context selection is dictated by the specific verbs and nouns of the atomized task description. The goal is to create the "perfect context": the most minimal yet complete set of instructions for the Executor AI to succeed without ambiguity.
-   **Symbiotic Relationship:** Rule modes and instructional guides are a symbiotic pair. A `rule_mode` provides the concise, enforceable directives, while 'instructional guides' provide the deep context, rationale, examples, and detailed guidelines and protocols.
-   **Activating a mode without including its corresponding guide in `context_files` is a protocol violation.**
-   **Failure to include all additional instructional guides that are directly relevant to the task/plan in `context_files` is a protocol violation.**

### Context Selection Protocol

The following tables are the key reference tools for selecting the appropriate context. You MUST use these tables to map task requirements to the correct set of files.

#### Table 1: Rule Mode Selection Matrix

**Protocol:** The Planner agent MUST use this matrix to select the required `rule_mode` for a given task's `.plan.md` file. The selection is based on the task's primary objective. The "Always On" core rules are foundational and are not selected here. In all cases, **you must only select one rule mode from the following table** to include under `rule_mode` for the plan/task. As such, **you should select the *most appropriate* / *most directly relevant* rule mode**.

| Mode / Rule File | Character Count | Primary Use Case & Task Verbs |
| :--- | :--- | :--- |
| `mode-01-architecture-planning.md`| 3793 | For high-level architectural planning and generating blueprint documents. (e.g., *design*, *strategize*, *architect*) |
| `mode-02-tasks-plans.md` | 3693 | For deconstructing architectural plans into `TASKS.md` entries and creating `.plan.md` execution files. (e.g., *plan*, *deconstruct*, *itemize*) |
| `mode-code-review.md` | 4815 | For performing a rigorous audit of code against all project standards. A meta-mode. (e.g., *review*, *audit*, *validate*) |
| `mode-project-docs.md` | 4443 | For authoring and maintaining high-level project documentation (`README.md`, `architecture.md`, etc.). (e.g., *document*, *update*, *write*) |
| `mode-georeferencing.md` | 5314 | For tasks involving high-precision georeferencing, custom CRS transformations, and spatial accuracy validation. (e.g., *georeference*, *transform CRS*) |
| `mode-geospatial-scripting.md`| 6047 | For creating or modifying Python scripts that use geospatial libraries (`geopandas`, `shapely`, `pyproj`). (e.g., *process spatial data*, *analyze geometry*) |
| `mode-gis-digitization.md` | 4609 | For tasks involving the manual digitization of features from raster maps using QGIS. (e.g., *digitize*, *trace features*) |
| `mode-postgis-deployment.md` | 5805 | For deploying, managing, and migrating the production PostGIS database. Governs Docker, backups, and security. (e.g., *deploy*, *migrate db*, *backup*) |
| `mode-python-debugging.md`| 4973 | For diagnosing and fixing errors in Python scripts using a systematic protocol. (e.g., *debug*, *fix*, *diagnose*) |
| `mode-python-execution.md`| 3972 | For generating commands to run Python scripts, enforcing the use of the correct conda environment. (e.g., *run*, *execute*) |
| `mode-python-scripting.md`| 5040 | For creating, implementing, or refactoring any Python code. Enforces style and best practices. **(Core dependency for most Python tasks)**. (e.g., *create*, *implement*, *refactor*) |
| `mode-python-testing.md` | 4802 | For writing `pytest` unit and integration tests for Python code, including mocking. (e.g., *test*, *write tests*) |
| `mode-report-writing.md` | 4910 | For analyzing data and writing formal reports or scientific summaries. (e.g., *analyze*, *report*, *summarize*) |
| `mode-sql-scripting.md` | 5925 | For writing or refactoring `.sql` files, enforcing formatting and best practices for SQL queries. (e.g., *query*, *write SQL*) |
| `mode-tdar-packaging.md` | 5116 | For preparing and packaging project datasets and metadata for archival in tDAR. (e.g., *package for archival*, *prepare tDAR*) |


#### Table 2: Instructional Guide Cross-Reference

**Protocol:** After selecting `rule_mode` from Table 1, the Planner agent MUST consult this table to identify ALL instructional guides directly relevant to the present task/plan (there will usually be multiple instructional guides for any given task). To make the appropriate selections, you must follow the two-step process:
1. select all instructional guides that correspond to the selected mode from Table 1.
2. select all additional other instructional guides that are directly relevant to the task/plan.

Every identified guide MUST be added to the `context_files` list in the `.plan.md` file.

| Instructional Guide | Supported Mode(s) | Summary of Provided Strategic Knowledge |
| :--- | :--- | :--- |
| `guide-analysis-reporting.md` | `mode-report-writing.md` | Provides protocols for structuring formal analysis, writing for a dual audience (technical/non-technical), and generating publication-quality figures and tables. |
| `guide-architecture-planning.md`| `mode-01-architecture-planning.md`| Details the process of high-level system design, creating blueprint documents, and translating strategic goals into technical requirements. |
| `guide-code-review.md` | `mode-code-review.md` | Expands on the QA protocol, providing deep context on how to audit for strategic alignment, performance, security, and maintainability. Gives examples of anti-patterns. |
| `guide-general-coding-standards.md`| (**Required for ALL coding tasks**) | A general reference for universal best practices like DRY, SOLID, and defensive coding that apply across different languages. |
| `guide-geospatial-protocols.md`| `mode-geospatial-scripting.md`, `mode-georeferencing.md` | Details the unique challenges of archaeological geospatial data, including CRS transformations, handling distortions, and ensuring spatial integrity. |
| `guide-jupyter-notebooks.md`| (Python modes for any task involving Jupyter notebooks) | Provides best practices for writing clean, reproducible, and well-documented Jupyter Notebooks for data exploration and analysis. |
| `guide-plans.md` | `mode-02-tasks-plans.md`| Provides the deep rationale for the "Context Selection Protocol," explaining how to create perfectly scoped and contextually complete plan files. |
| `guide-postgis-deployment.md` | `mode-postgis-deployment.md`| Explains the "why" behind the strict deployment rules, covering Docker security, the importance of GiST indexing, and versioned migration strategies with `alembic`. |
| `guide-project-docs.md` | `mode-project-docs.md` | Guides the AI on how to write for a dual audience, maintain a consistent project lexicon via the glossary, and use Mermaid diagrams effectively. |
| `guide-python-debugging.md`| `mode-python-debugging.md`| Outlines a systematic approach to debugging, including interpreting tracebacks, forming hypotheses, and using logging for validation. |
| `guide-python-execution.md` | `mode-python-execution.md` | Explains the critical importance of environment purity via `conda`, the technical reasons for using `python -m`, and how to interpret exit codes and tracebacks. |
| `guide-python-style.md` | (All Python & Geospatial Modes) | The canonical guide to Python style for this project, expanding on PEP8, Black, `ruff`, and the use of type hints and docstrings. |
| `guide-python-testing.md` | `mode-python-testing.md` | Details the project's testing philosophy, including the TDD-based approach, use of `pytest`, and the critical role of mocking for external services like databases. |
| `guide-sql-best-practices.md`| `mode-sql-scripting.md` | Provides best practices for writing clean, performant, and maintainable SQL, including formatting, commenting, and avoiding common pitfalls. |
| `guide-tasks.md` | `mode-02-tasks-plans.md`| Explains the philosophy of "task atomicity" and guides the AI in deconstructing large goals into small, verifiable units for `TASKS.md`. |
| `guide-database-design.md` | (No Associated Mode; Select for any task directly involving database design) | Explains the principles of relational and spatial database design, including normalization, indexing strategies, and data typing for the TMP project. |

### Context Selection Protocol

You MUST follow this process when authoring the YAML frontmatter for a `.plan.md` file.

1.  **Analyze the Atomized Task:** Read the `Description` and `Acceptance Criteria` for the single, atomized task from `TASKS.md`. Identify the single primary verb and subject.
2.  **Select the Rule Mode:** Using Table 1, find the row that corresponds to the most directly relevant verb/subject of the task. This gives you the primary `rule_mode`.
3.  **Add Instructional Guides:** Using Table 2, select all instructional guides corresponding to the selected rule mode. Then, using your detailed knowledge of the task you are planning, select any other instructional guides that are *directly* relevant to the task/plan.
4.  **Consolidate Context:**
    -   Populate the `rule_mode` field from the selected rule mode.
    -   Create the `context_files` list, starting with the corresponding guide(s) for all selected modes. Add all other specific source code files mentioned in the task description.

### Workflow Example

-   **Atomized `TASKS.md` Entry (Post-Architectural Planning):**
    -   **Task ID:** P1.2.3
    -   **Description:** Implement the `calculate_basic_metrics` function in `profiling_modules/metrics_basic.py`. This function should take a database connection and table name, and return a dictionary containing the total row count and table size in megabytes.
    -   **Acceptance Criteria:**
        -   `[ ]` The function `calculate_basic_metrics` is created with correct type hints and docstrings.
        -   `[ ]` The function executes two SQL queries: `SELECT COUNT(*)` and `pg_total_relation_size()`.
        -   `[ ]` The function correctly returns a dictionary with keys `total_rows` and `table_size_mb`.

-   **Applying the Protocol:**
    1.  **Deconstruct:** Verbs = "Implement," "calculate." Nouns = "function," "Python," "database connection," "SQL queries."
    2.  **Select Primary Mode:** The primary action is writing a Python function that executes SQL. The most specific mode is `mode-python-scripting.md`.
    3.  **Add Instructional Guides:** The `mode-python-scripting.md` is associated with `guide-python-style.md`, and since the task involves coding, we MUST include `guide-general-coding-standards.md`. Because the task also involves SQL, we must also include `guide-sql-best-practices.md` to guide the SQL query generation.
    4.  **Consolidate Context:**
        -   `rule_mode`: `mode-python-scripting.md`
        -   `guides`: `guide-python-style.md`, `guide-general-coding-standards.md`, `guide-sql-best-practices.md`
    5.  **Sufficiency Check:** The context seems sufficient for this targeted task.

-   **Resulting `plan` Frontmatter:**
    ```yaml
    ---
    task_id: P1.2.3
    description: "Implement the `calculate_basic_metrics` function in `profiling_modules/metrics_basic.py`."
    context_files:
      - "phases/01_LegacyDB/src/profiling_modules/metrics_basic.py"
	  - ".windsurf/instructions/guide-general-coding-standards.md"
      - ".windsurf/instructions/guide-python-style.md"
      - ".windsurf/instructions/guide-sql-best-practices.md"
    rule_mode:
      - "mode-python-scripting.md"
    ---
    ```
This example correctly demonstrates how a single, atomized task maps to a mode and small, highly relevant, and size-constrained set of instructional guides.


## 6. Authoring New Plan Files: A Step-by-Step Guide

Follow this process to create a new plan file for any task.

### Step 1: Identify the Target Task
Locate the `pending` leaf-node task in `TASKS.md` that you need to accomplish. Read its `id`, `description`, `context_files`, `deliverables`, and `validation_steps` carefully.

### Step 2: Create and Name the Plan File
Create a new file in this directory (`.windsurf/plans/`). Name it using the exact `id` of the task. For example, for task `P1.W5.T1.1`, the file will be `p1_w5_t1_1.plan.md`.

### Step 3: Draft the YAML Metadata Header

Start the file with the YAML metadata block.
- Fill in the `task_id` and write a `description` that summarizes the task's goal.
- Conduct meticulous analysis of the following sources to identify and select all appropriate `context_files` for the current plan
  - the task being undertaken in the current plan (e.g. what are the target files??)
  - The current task from `TASKS.md`, as well as immediately upstream/downstream and dependent tasks from `TASKS.md`
  - the 'Phase-Specific Context Review' files (see above) to identify all appropriate Task-Specific Context Review `context_files` for the present plan.
- Carefully follow the 'Context Selection Protocol', above (section 4), to select the correct `rule_mode` and `instructional guides` (instructional guides go under `context_files`) for the current plan
- Finally, add or update the metdata for the following fields as necessary:
  - date_created
  - last_updated
  - status

### Step 4: Populate the Context Stages
Use an existing plan file as a template for this section.
1.  **Global Context:** Copy and paste this section verbatim. **Do not modify it.**
2.  **Phase-Specific Context:** Copy this section from another plan within the same phase.
3.  **Task-Specific Context:** This is the only context section you must edit. List all the files and document sections specified in the `context_files` array for your target task in `TASKS.md`.

### Step 5: Atomize the Execution Steps
Read the `description` and `deliverables` for the task. Break down the work into the smallest possible, sequential actions and list them as checklist items under `## Stage 3: Execution`.
-   **Good (Atomic):** `Create the empty file 'report.md'`.
-   **Bad (Not Atomic):** `Write the report`.
-   **Good (Atomic):** `Add the title 'Final Report' to 'report.md'`. `Add a section header '## Introduction'`.

### Step 6: Define Validation
Under `## Stage 4: Final Validation & Cleanup`, create checklist items that directly correspond to the `validation_steps` listed for the task in `TASKS.md`. Add a final step to propose the status update to the `TASKS.md` file.

### Step 7: Review
Read through your completed plan. Does it flow logically? Is every step a clear, unambiguous command? Does it produce all the required deliverables?

---
## 7. Protocol for AI Plan Generation

This section provides the definitive, operational protocol for an AI Assistant (like Cascade) tasked with generating a `.plan.md` file. The AI MUST follow this sequence precisely to ensure the generated plan is valid, effective, and aligned with project standards.

### Step 1: Deconstruct the Target Task

-   **Action:** Ingest and exhaustively analyze the single, atomized task entry from `TASKS.md`.
-   **Focus On:**
    -   `id`: To be used for the plan's filename and `task_id` metadata.
    -   `description`: To understand the primary goal.
    -   `context_files`: As the initial seed for the plan's context.
    -   `deliverables`: To define the primary outputs of the execution stage.
    -   `validation_steps`: To form the basis of the `Final Stage: Validation & Cleanup`.

### Step 2: Select Context Using the Official Protocol

-   **Action:** Execute the **Context Selection Protocol** as defined in **Section 4** of this document.
-   **Process:**
    1.  Analyze the task's primary verb and subject (e.g., "Implement Python function," "Test SQL script").
    2.  Use the **Context Selection Protocol** to identify the primary `rule_mode`, its corresponding instructional guide(s), and any other directly relevant instructional guides.
    3.  Consolidate all required guides and source files into the `context_files` list in the YAML frontmatter.

### Step 3: Author the Plan Using the Standard Structure

-   **Action:** Generate the plan content, strictly adhering to the multi-stage structure. The plan MUST contain these exact stage headers:
    1.  `Objectives`
    2.  `Stage 1: Context Ingestion & Verification` (with Global, Phase-Specific, and Task-Specific sub-sections)
    3.  `Stage 2: Preparation`
    4.  Stages 3+: (Subsequent numbered stages; could be several for complex tasks)
    5.  `Final Stage: Validation & Cleanup`
-   **Constraint:** All steps within the stages must be **atomic**, **sequential**, and written as **imperative commands**.

### Step 4: Final Review and Self-Correction

-   **Action:** Before finalizing the file, perform a self-review.
-   **Checklist:**
    -   Does the `task_id` in the YAML match the filename?
    -   Is the `context_files` list complete for every action in the plan?
    -   Is the `rule_mode` correctly selected per the protocol?
    -   Does the `Final Stage` include every `validation_step` from `TASKS.md`?
    -   Is every action truly atomic?

## 8. Example: Creating a Plan for a Hypothetical Task

Let's assume the following task exists in `TASKS.md`:


**Hypothetical Task in `TASKS.md`:**
```yaml
- id: P1.W1.T4.1
  description: "Write comprehensive pytest unit tests for the `00_setup_databases.py` script. The tests must mock the database connection and validate both successful execution and failure on invalid configuration."
  status: pending
  depends_on: ["P1.W1.T3.1"]
  context_files:
    - "phases/01_LegacyDB/src/00_setup_databases.py"
    - "phases/01_LegacyDB/PLANNING_PHASE1.md#Testing-Strategy-for-00_setup_databases.py"
  deliverables:
    - "phases/01_LegacyDB/tests/test_00_setup_databases.py"
  validation_steps:
    - "Confirm the test file `test_00_setup_databases.py` is created."
    - "Execute `pytest phases/01_LegacyDB/tests/` and ensure all new tests pass."
    - "Run `ruff check` on the new test file and confirm no errors are reported."
```

---

**Resulting Plan File (`.windsurf/plans/p1_w1_t4_1.plan.md`):**
```markdown
---
task_id: "P1.W1.T4.1"
description: "Write comprehensive pytest unit tests for the `00_setup_databases.py` script, including mocking and validation."
context_files:
  - "phases/01_LegacyDB/src/00_setup_databases.py"
  - "phases/01_LegacyDB/PLANNING_PHASE1.md"
  - ".windsurf/instructions/guide-general-coding-standards.md"
  - ".windsurf/instructions/guide-python-testing.md"
  - ".windsurf/instructions/guide-python-style.md"
rule_mode:
  - "mode-python-testing.md"
date_created: "2025-06-24"
last_updated: "2025-06-24"
status: "Draft"
---

# Plan: Create Pytest Unit Tests for Database Setup Script

## Objectives

- To create a new test suite for the `00_setup_databases.py` script.
- To ensure the script's logic is validated through unit tests, including success and failure scenarios.
- To use mocking to isolate the script from requiring a live database connection during testing.
- To produce a high-quality, linted, and documented test file as a deliverable.

### Stage 1: Context Ingestion & Verification

- [ ] **Global Context Review:** Exhaustively review the following core project files to ensure full alignment with project standards:
    - [ ] `README.md` (root)
    - [ ] `PLANNING.md`
    - [ ] `TASKS.md`
    - [ ] `docs/overview.md`
    - [ ] `docs/architecture.md`
    - [ ] `docs/technical_specs.md`
]- [ ] **Phase-Specific Context Review:** Exhaustively review the following files to understand the present phase and workflow context:
    - [ ] `phases/01_LegacyDB/README.md`
    - [ ] `phases/01_LegacyDB/PLANNING_PHASE1.md`
- [ ] **Task-Specific Context Review:** Exhaustively review the following files to understand the specific requirements of task `P1.W1.T4.1`:
    - [ ] The Python script to be tested: `phases/01_LegacyDB/src/00_setup_databases.py`.
    - [ ] The testing strategy section of the Phase 1 plan: `phases/01_LegacyDB/PLANNING_PHASE1.md#Testing-Strategy-for-00_setup_databases.py`.
    - [ ] The general coding guide: `.windsurf/instructions/guide-general-coding-standards.md`.
	- [ ] The Python coding and style guide: `.windsurf/instructions/guide-python-style.md`.
	- [ ] The Python testing guide: `.windsurf/instructions/guide-python-testing.md`.

### Stage 2: Preparation

- [ ] **Create Test File:** Create a new, empty file at the target deliverable path: `phases/01_LegacyDB/tests/test_00_setup_databases.py`.
- [ ] **Add Initial Imports:** In the new test file, add the necessary initial imports: `pytest`, `unittest.mock` from `unittest`, and the functions to be tested from `src.00_setup_databases`.

### Stage 3: Execution (Test Implementation)

- [ ] **Implement Happy Path Test:** Create a test function `test_setup_databases_success`.
    - [ ] Inside this test, use `unittest.mock.patch` to mock the `psycopg2.connect` function.
    - [ ] Configure the mock connection and cursor objects to return expected values.
    - [ ] Call the main function from `00_setup_databases.py` with a valid mock configuration.
    - [ ] Assert that the mock cursor's `execute` method was called with the expected SQL `CREATE DATABASE` commands.
- [ ] **Implement Failure Path Test:** Create a test function `test_setup_databases_connection_error`.
    - [ ] Inside this test, configure the mock `psycopg2.connect` to raise a `psycopg2.OperationalError`.
    - [ ] Use `pytest.raises` to assert that calling the main function correctly raises the expected custom exception or handles the error gracefully.
- [ ] **Add Docstrings and Type Hinting:** Ensure all new test functions have clear docstrings and all variables and arguments have correct type hints as per `guide-python-style.md`.

### Final Stage: Validation & Cleanup

- [ ] **Execute Tests:** Run the command `pytest phases/01_LegacyDB/tests/test_00_setup_databases.py` and verify that all newly created tests pass successfully.
- [ ] **Lint Code:** Run the command `ruff check --fix phases/01_LegacyDB/tests/test_00_setup_databases.py` and verify that it reports no errors.
- [ ] **Format Code:** Run the command `ruff format phases/01_LegacyDB/tests/test_00_setup_databases.py` to ensure consistent formatting.
- [ ] **Propose Task Update:** Propose the required changes to `TASKS.md` to update the status of task `P1.W1.T4.1` to `done`.
```

---
