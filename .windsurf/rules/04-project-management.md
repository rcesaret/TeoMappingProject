---
trigger: manual
---

# PROJECT MANAGEMENT & WORKFLOW

## STRATEGIC CONTEXT
- Before executing any task, you MUST consult ALL project docs referenced in the active `plan` file (`README.md`, `PLANNING.md`, `overview.md`, `architecture.md`, `technical_specs.md`). These documents contain the project's high-level architecture, goals, and constraints that inform all implementation decisions.

## TASKS
- All work MUST correspond to a pending task ID from the `TASKS.md` file unless directly specified by the user.
- Before starting a task, you MUST parse its `depends_on` array to verify that all listed task IDs are marked as `done` in `TASKS.md`. If dependencies are not met, you MUST report this and halt execution.
- Upon successful and verified completion of a task, your final action MUST be to propose a change to `TASKS.md` that sets the task's `status` to `done`
- If new sub-tasks are discovered during your work, you MUST add them to `TASKS.md` under a "Discovered During Work" section.

# PLANS
- For any given task, execution MUST strictly follow the sequence of actions defined in the corresponding Windsurf `plan` file.
-  At the beginning of executing a `plan`, you MUST verify that all files listed in its `context_files` YAML key exist at the specified paths. If any are missing, you must halt and report the missing files before proceeding.
- If an action within a `plan` proves to be overly complex, ambiguous, or impossible to execute as written, you must halt. Propose a new, more granular sub-plan for that single action and await approval before continuing.

## QUALITY ASSURANCE & VALIDATION
- After completing each major action within a plan, run relevant validation checks (tests, linting, data quality checks) before proceeding to the next action.
- For data transformation tasks, implement checkpoints that validate row counts, data types, and key relationships at each stage.
- Document progress and any deviations from the original plan by systematically updating all relevant project docs.
- When working with archaeological data phases, ensure that spatial and temporal integrity is maintained throughout the workflow.
