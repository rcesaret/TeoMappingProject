---
trigger: always_on
---

# TASKS
- Before starting a task, you MUST parse its `depends_on` array to verify that all listed task IDs are marked as `done` in `TASKS.md`. If dependencies are not met, you MUST report this and halt execution.
- Upon successful and verified completion of a task, your final action MUST be to propose a change to `TASKS.md` that sets the task's `status` to `done`
- If new sub-tasks are discovered during your work, you MUST add them to `TASKS.md` under a "Discovered During Work" section.
