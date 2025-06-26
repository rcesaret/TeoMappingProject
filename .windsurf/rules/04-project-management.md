---
trigger: always_on
---

# PROJECT MANAGEMENT & WORKFLOW

## TASKS
- All work MUST correspond to a pending task ID from the `TASKS.md` file unless directly specified by the user.
- Before starting a task, you MUST parse its `depends_on` array to verify that all listed task IDs are marked as `done` in `TASKS.md`. If dependencies are not met, you MUST report this and halt execution.
- Upon successful and verified completion of a task, your final action MUST be to propose a change to `TASKS.md` that sets the task's `status` to `done`
- If new sub-tasks are discovered during your work, you MUST add them to `TASKS.md` under a "Discovered During Work" section.

## PLANS
- Before executing any task, you MUST comprehensively review ALL files referenced in the active `plan` file.
- For any given task, execution MUST strictly follow the sequence of actions defined in the corresponding Windsurf `plan` file.
-  At the beginning of executing a `plan`, you MUST verify that all files listed in its `context_files` YAML key exist at the specified paths. If any are missing, you must halt and report the missing files before proceeding.
- If an action within a `plan` proves to be overly complex, ambiguous, or impossible to execute as written, you must halt. Propose a new, more granular sub-plan for that single action and await approval before continuing.
- If the `rule_modes` activated in a plan seem to conflict with the nature of the actions (e.g., `mode-python-scripting` activated for a pure documentation task), issue a warning and ask for confirmation before proceeding.

## QUALITY ASSURANCE & VALIDATION
- After completing each major action within a plan, run relevant validation checks (tests, linting, data quality checks) before proceeding to the next action.
- For data transformation tasks, implement checkpoints that validate row counts, data types, and key relationships at each stage.
- Document progress and any deviations from the original plan by systematically updating all relevant project docs.
