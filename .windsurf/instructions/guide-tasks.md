---
guide_id: "guide-tasks"
version: "1.0"
last_updated: "2025-06-26"
related_mode: "mode-02-tasks-plans.md"
---

# GUIDE: Task Deconstruction & `TASKS.md` Authoring

## 1. CORE OBJECTIVE
To master the process of deconstructing high-level strategic goals into a series of perfectly **atomic, verifiable, and sequential** tasks within `TASKS.md`. This document is the definitive source of truth for the project's execution backlog. A well-authored `TASKS.md` is the foundation of a predictable AI-driven workflow.

## 2. GOVERNING PRINCIPLES
- **Principle of Atomicity:** A task is atomic if it represents a single, indivisible unit of work that can be completed in one logical session and verified independently. "Implement feature X" is not atomic. "Create file `feature_x.py`" is atomic.
- **Principle of Verifiability:** Every task must have a set of unambiguous, testable `validation_steps`. These steps are the "definition of done." If you cannot write a validation step for a task, it is likely not atomic.
- **Principle of Explicit Dependency:** The workflow is not a guess. Every task MUST explicitly state its prerequisites using the `depends_on` key. This creates a Directed Acyclic Graph (DAG) of work that the AI can follow reliably.
- **Principle of Clarity:** Task descriptions must be written in clear, imperative language (e.g., "Create," "Implement," "Refactor," "Verify"). Avoid vague descriptions that leave room for interpretation.

## 3. PROCEDURAL PROTOCOL: From Goal to `TASKS.md`
**Step 1: Ingest the High-Level Goal**
- Start with a strategic objective from a source like `PLANNING.md` or `architecture.md`. Example: "Develop a data validation module for the legacy database ingestion pipeline."

**Step 2: Deconstruct into Logical Epics**
- Break the high-level goal into major functional blocks or "epics." These are not yet atomic tasks.
- Example Epics:
  - 1. Design Validation Schema
  - 2. Implement Core Validation Logic
  - 3. Implement Reporting for Validation Failures
  - 4. Write Unit & Integration Tests

**Step 3: Decompose Epics into Atomic Tasks**
- For each epic, break it down further into the smallest possible actions. This is the most critical step. Think about every single file creation, function addition, configuration change, and verification step.
- Example Decomposition for Epic 2 ("Implement Core Validation Logic"):
  - `P2.W2.T1`: Create file `phases/02_TransformDB/src/validator.py`.
  - `P2.W2.T2`: In `validator.py`, define class `DataValidator`.
  - `P2.W2.T3`: In `DataValidator`, implement method `validate_row(row: dict) -> bool`.
  - `P2.W2.T4`: In `DataValidator`, implement method `run_validation(data: list) -> dict`.

**Step 4: Define `validation_steps` for Each Atomic Task**
- For each atomic task, define how you will prove it is "done."
- Example Validation for `P2.W2.T1`:
  - `validation_steps:`
    - `- "Confirm file 'phases/02_TransformDB/src/validator.py' exists."`
    - `- "Run 'ruff check --fix' on the new file and confirm no errors."`

**Step 5: Map Dependencies**
- Review your list of atomic tasks. For each task, identify which other tasks must be completed *before* it can start.
- Example Dependency: `P2.W2.T2` (defining the class) `depends_on: ["P2.W2.T1"]` (creating the file).

**Step 6: Author the Final `TASKS.md` Entry**
- Assemble all the pieces into the final YAML format for `TASKS.md`. Ensure all keys (`id`, `description`, `status`, `depends_on`, `context_files`, `deliverables`, `validation_steps`) are correctly populated.

## 4. CONTEXT-SPECIFIC EXAMPLES & HEURISTICS
**Scenario:** A high-level goal is "Add a new API endpoint to fetch user details."

**INCORRECT (NON-ATOMIC) TASK:**
```yaml
- id: P5.1
  description: "Create the user details endpoint."
  validation_steps:
    - "Confirm the endpoint works."
````

**Reasoning:* This is far too broad. "Create the endpoint" involves creating files, adding routes, writing service logic, writing tests, and more. "Confirm it works" is not a testable validation step.*

**CORRECT (ATOMIC) TASK DECOMPOSITION:**

```yaml
- id: P5.1
  description: "Create file '/api/controllers/user_controller.py'."
  deliverables: ["/api/controllers/user_controller.py"]
  validation_steps: ["Confirm file exists and passes linting."]
- id: P5.2
  description: "In 'user_controller.py', add a GET route for '/users/{user_id}'."
  depends_on: ["P5.1"]
  validation_steps: ["Inspect file to confirm route definition exists."]
- id: P5.3
  description: "Implement the service logic in 'services/user_service.py' to fetch a user by ID from the database."
  depends_on: ["P5.1"] # Can be worked on in parallel with P5.2
  validation_steps: ["Confirm 'get_user_by_id' function is present."]
- id: P5.4
  description: "Create test file '/api/tests/test_user_controller.py'."
  depends_on: ["P5.2", "P5.3"]
  validation_steps: ["Confirm test file exists."]
- id: P5.5
  description: "In 'test_user_controller.py', write a unit test for the GET '/users/{user_id}' endpoint, mocking the user_service."
  depends_on: ["P5.4"]
  validation_steps: ["Run 'pytest /api/tests/test_user_controller.py' and confirm it passes."]
```

## 5\. ANTI-PATTERNS & TROUBLESHOOTING

  - **Anti-Pattern: The Vague Verb.** Avoid descriptions like "Manage users" or "Handle data." Use strong, imperative verbs: "Create," "Implement," "Define," "Verify," "Refactor."
  - **Anti-Pattern: Implicit Dependencies.** If `TaskB` needs a file created by `TaskA`, you MUST state `depends_on: ["TaskA"]`. Do not assume the AI will infer the correct order.
  - **Troubleshooting: A task feels too big.** If you are writing a `plan` file for a task and the execution checklist has more than 20-25 steps, it is a strong signal that the original task was not atomic. You must stop, return to `TASKS.md`, and break the parent task down further.

<!-- end list -->

---
