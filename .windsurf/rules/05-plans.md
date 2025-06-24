---
trigger: always_on
---

# PLANS
- For any given task, execution MUST strictly follow the sequence of actions defined in the corresponding Windsurf `plan` file.
-  At the beginning of executing a `plan`, you MUST verify that all files listed in its `context_files` YAML key exist at the specified paths. If any are missing, you must halt and report the missing files before proceeding.
- If an action within a `plan` proves to be overly complex, ambiguous, or impossible to execute as written, you must halt. Propose a new, more granular sub-plan for that single action and await approval before continuing.
