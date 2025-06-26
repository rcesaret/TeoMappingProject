---
task_id: "FRAMEWORK_PLAN_GENERATION_v1.0"
description: "A meta-plan to guide the AI in generating a new, project-compliant .plan.md file for a specified task from TASKS.md."
context_files:
  - "TASKS.md"
  - ".windsurf/plans/README.md"
  - ".windsurf/plans/PLAN.template.md"
  - ".windsurf/instructions/guide-task-planning.md"
rule_modes:
  - "mode-plan-tasking.md"
date_created: "2025-06-25"
last_updated: "2025-06-25"
status: "Active"
---

# Plan: Generate New Windsurf Plan File

## Objectives

- To generate a new, syntactically correct, and logically sound `.plan.md` file for a target task specified by a `task_id`.
- To ensure the generated plan strictly adheres to the structure, naming conventions, and context selection protocols defined in the project's `README.md`.
- To produce a plan with atomic, sequential, and imperative steps that guide the Executor AI to complete the target task successfully and verifiably.

### Stage 1: Context Ingestion & Verification

- [ ] **Global Context Review:** Exhaustively review the following core project files to ensure full alignment with project standards:
    - [ ] `README.md` (root)
    - [ ] `PLANNING.md`
    - [ ] `TASKS.md`
    - [ ] `.windsurf/plans/README.md`
    - [ ] `.windsurf/plans/PLAN.template.md`
- [ ] **Phase-Specific Context Review:** Exhaustively review the following files to understand the present phase and workflow context:
    - [ ] `phases/<current phase>/README.md`
    - [ ] `phases/<current phase>/PLANNING_PHASE<current phase number>.md`
- [ ] **Task-Specific Context Review:** Exhaustively review the following files to understand the specific requirements for **generating a new plan**:
    - [ ] `TASKS.md`: To find and analyze the target task that the new plan will address.
    - [ ] `.windsurf/plans/README.md`: To follow the mandatory "Protocol for AI Plan Generation" and the "Context Selection Protocol".
    - [ ] `.windsurf/plans/PLAN.template.md`: To use as the base structure for the new plan file.
    - [ ] `.windsurf/instructions/guide-task-planning.md`: To understand the nuances of deconstructing tasks into plans.

### Stage 2: Preparation

- [ ] **Identify Target Task:** Identify the `task_id` for which a new plan needs to be created (e.g., `P1.W1.T4.1`).
- [ ] **Locate Task in `TASKS.md`:** Scan `TASKS.md` and locate the full YAML entry for the target `task_id`.
- [ ] **Create Plan File:** Create a new, empty file in the `.windsurf/plans/` directory. The filename MUST be the `task_id` in lowercase with underscores, followed by `.plan.md` (e.g., `p1_w1_t4_1.plan.md`).

### Stage 3: Author YAML Frontmatter

- [ ] **Execute Context Selection Protocol:** Following the protocol in `.windsurf/plans/README.md`, perform the following:
    - [ ] **Analyze Task:** Read the `description` and `Acceptance Criteria` for the target task from `TASKS.md`. Identify the primary verb and subject (e.g., "Implement Python function," "Test SQL script").
    - [ ] **Select Primary Mode & Guide:** Use the "Context Selection Matrix" to find the `rule_mode` that corresponds to the primary verb/subject. Note its corresponding `guide`.
    - [ ] **Add Dependencies:** Check the `Dependencies` column for the selected mode and add any listed dependent modes.
    - [ ] **Verify Character Count:** Sum the character counts for all selected modes plus the core rules (`00-core.md`, `01-project-management.md`) and ensure the total is under the 12,000 character limit.
- [ ] **Populate YAML Fields:** Fill the YAML frontmatter of the new plan file:
    - [ ] `task_id`: The exact ID of the target task (e.g., "P1.W1.T4.1").
    - [ ] `description`: A concise, one-sentence summary of the plan's goal.
    - [ ] `context_files`: Create a complete list containing:
        - All files listed in the `context_files` section of the target task in `TASKS.md`.
        - The corresponding `guide-*.md` file for every `mode-*.md` selected above.
    - [ ] `rule_modes`: Create a list of all modes selected above (primary and dependencies).
    - [ ] `date_created` and `last_updated`: Set to the current date in `YYYY-MM-DD` format.
    - [ ] `status`: Set to `"Draft"`.

### Stage 4: Author Markdown Body

- [ ] **Write Title and Objectives:**
    - [ ] Write a human-readable title for the plan (e.g., `# Plan: Create Pytest Unit Tests for Database Setup Script`).
    - [ ] Write the `## Objectives` section, listing the high-level goals and required deliverables for the target task.
- [ ] **Populate Context Stages:**
    - [ ] Copy the `Global Context Review` and `Phase-Specific Context Review` sections verbatim, updating the phase-specific paths as needed.
    - [ ] Create the `Task-Specific Context Review` section, listing every file from the plan's `context_files` YAML list as a checklist item.
- [ ] **Atomize Execution Steps:**
    - [ ] Create a `## Stage 2: Preparation` section. List any prerequisite actions needed, such as creating empty files at deliverable paths.
    - [ ] Create `## Stage 3: Execution` (and subsequent numbered stages as needed).
    - [ ] Carefully read the target task's `description` and `deliverables`. Break down the entire process into the smallest possible, sequential, and imperative actions (e.g., "Create the file...", "Add the import statement...", "Define the function signature...").
- [ ] **Define Validation Steps:**
    - [ ] Create the `## Final Stage: Validation & Cleanup` section.
    - [ ] For each item in the `validation_steps` list of the target task in `TASKS.md`, create a corresponding, explicit verification step (e.g., "Execute the command `pytest ...` and confirm it passes.").
    - [ ] Add the final, mandatory step: "Propose the required changes to `TASKS.md` to update the status of task `[AGENT-GENERATED: task_id]` to `done`."

### Stage 5 (Final Stage): Self-Correction and Review

- [ ] **Review Generated Plan:** Before finalizing, perform a self-review of the newly generated plan file against project protocols.
    - [ ] **Verify Filename and ID:** Confirm the filename `p1_w1_t4_1.plan.md` exactly matches the `task_id: "P1.W1.T4.1"` in the YAML.
    - [ ] **Verify Context Completeness:** Confirm that for every `mode-*.md` in `rule_modes`, the corresponding `guide-*.md` is present in `context_files`.
    - [ ] **Verify Atomicity:** Read through all execution steps. Ensure each is a single, unambiguous command.
    - [ ] **Verify Validation Coverage:** Confirm that every `validation_step` from `TASKS.md` is explicitly covered in the `Final Stage` of the new plan.
