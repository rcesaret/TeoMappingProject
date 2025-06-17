---
trigger: manual
---

# GIT WORKFLOW STANDARDS

## 1. Commit Message Structure
All commit messages MUST strictly adhere to the following template:

`[TASK_ID] <type>: <subject>`

- **`[TASK_ID]`**: The full ID of the task from `TASKS.md` that this commit primarily addresses (e.g., `P1.W2.T1.1`).
- **`<type>`**: MUST be one of the following:
    - `feat`: A new feature or script.
    - `fix`: A bug fix or correction.
    - `docs`: Documentation changes only.
    - `style`: Formatting, linting, whitespace changes.
    - `refactor`: Code changes that neither fix a bug nor add a feature.
    - `test`: Adding missing tests or refactoring existing tests.
    - `chore`: Build process, tooling, or environment changes.
- **`<subject>`**: A concise, imperative-mood description of the change (e.g., "Implement database connection pooling").

## 2. Pull Request Protocol
All pull requests MUST use the template defined in `PULL_REQUEST_TEMPLATE.md`. Before submitting a PR for review, you must confirm that:
1.  The PR title follows the commit message structure.
2.  The "Task Description" section contains a valid link to the `TASKS.md` entry.
3.  The "Validation Steps" section is filled with clear, specific instructions for how a human can verify the changes.
