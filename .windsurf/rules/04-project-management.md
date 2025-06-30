---
trigger: always_on
---

# PROJECT MANAGEMENT & WORKFLOW

## FOUNDATIONAL PRINCIPLES

### Principle of Protocol Supremacy
- All AI-driven actions MUST strictly adhere to the operational protocols defined within the project's canonical documents. The two primary sources of truth are:
    - `TASKS.md` for task structure and the `curation_protocol`.
    - `.windsurf/plans/README.md` for plan structure and the `Context Selection Protocol`.
- Any ambiguity or conflict in other rules or instructions MUST be resolved by deferring to the explicit text of these two protocol documents. You MUST cite the specific section of the protocol that justifies your chosen action.

### Principle of Task-Plan Unification
- All work MUST correspond to a `pending` leaf-node task ID from `TASKS.md`.
- All work MUST be executed by following the atomic actions in the corresponding `.plan.md` file for that `task_id`.

## TASK MANAGEMENT PROTOCOL ENFORCEMENT (`TASKS.md`)

### Dependency Validation
- Before beginning any task, you MUST parse its `depends_on` array in `TASKS.md`.
- You MUST verify that every listed task ID in the `depends_on` array has a status of `done`. If any dependency is not `done`, you MUST **HALT** execution immediately, report the blocking task ID(s), and await user instruction.

### Task Curation Mandate
- The creation, modification, or refactoring of tasks within `TASKS.md` is a restricted, high-stakes activity.
- This activity **MUST** be exclusively governed by activating `mode-02-tasks-plans.md`. You are explicitly forbidden from altering `TASKS.md` (except for status updates) outside of this mode.

### Task Status Update Protocol
- Upon the successful completion and validation of ALL steps in a plan, your final action MUST be to propose the change to `TASKS.md` that sets the corresponding task's `status` to `done`.
- This proposal MUST come after all validation steps in the plan (e.g., tests, linting) have passed.

## PLAN MANAGEMENT PROTOCOL ENFORCEMENT (`.plan.md`)

### Plan Generation Mandate
- The creation of `.plan.md` files is a restricted activity that dictates the exact execution flow for the AI.
- This activity **MUST** be exclusively governed by activating `mode-02-tasks-plans.md`.

### Plan Execution Protocol
- You MUST follow the action checklist in the plan sequentially and precisely. Do not reorder, skip, or bundle steps. Each `- [ ]` is a distinct operation.

### Plan Context & Protocol Validation
- At the start of executing any plan, you MUST verify that all file paths listed in the `context_files` YAML key exist. If any file is missing, you MUST **HALT** and report the missing file(s).
- As an agent executing a plan, you have a responsibility to validate the plan itself. If you determine that the plan's YAML frontmatter (e.g., its `rule_mode` or `context_files`) violates the `Context Selection Protocol` as defined in `.windsurf/plans/README.md`, you MUST **HALT**, report the specific violation (e.g., "Plan `p1.w1.t1.plan.md` violates protocol: `mode-python-testing.md` is active, but the required `guide-python-testing.md` is missing from `context_files`."), and await user instruction.
