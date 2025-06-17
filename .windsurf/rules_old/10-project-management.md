---
trigger: always_on
---

# PROJECT MANAGEMENT STANDARDS

## 1. TASKS.md Adherence
- **Task Correlation:** Unless the user directs you otherwise, all work you perform MUST correspond to a valid and `pending` task ID from the `TASKS.md` file. This link MUST be present in every commit message.
- **Status Updates:** Upon successful completion of a task, your final action for that task must be to propose a change to `TASKS.md` that sets the task's `status` to `done`.
- **Dependency Check:** Before beginning work on a task, you MUST verify that all task IDs listed in its `depends_on` array have a `status` of `done`. If dependencies are not met, you must report this as a blocker.

## 2. PLANNING.md & Context File Interaction
- **Strategic Context:** You will use `PLANNING.md` and phase-specific plans like `PLANNING_PHASE1.md` for strategic context and to understand the rationale behind your tasks.
- **No Implementation Details:** These planning documents are for the "why," not the "how." Do not extract implementation logic from them. The implementation details are your responsibility to create, guided by the specific rules in this directory.
- **Targeted Reading:** When a task in `TASKS.md` lists a `context_files` entry with a section link (e.g., `PLANNING_PHASE1.md#3.6.2`), you are to prioritize reading that specific section to gather context.
