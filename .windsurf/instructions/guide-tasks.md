---
guide_id: "guide-tasks"
version: 2.0
last_updated: "2025-06-30"
related_mode: "mode-02-tasks-plans.md"
---

# Strategic Guide: Authoring `TASKS.md`

## 1. The Philosophy: Tasks as the Project's DNA

Welcome to the strategic guide for authoring `TASKS.md`. In this project, `TASKS.md` is not merely a to-do list; it is the **canonical, machine-readable blueprint of intent**. Each entry is a gene in the project's DNA, precisely defining a unit of work to ensure that the AI-driven workflow is predictable, verifiable, and robust.

The principles of **Atomicity**, **Verifiability**, and **Explicit Dependency** are not suggestions; they are architectural requirements. Adhering to them is the primary defense against ambiguous execution and the foundation for building a system that can one day operate autonomously.

## 2. Architectural Deep Dive: The `curation_protocol`

The `curation_protocol` within `TASKS.md` is the mandatory, non-negotiable manufacturing process for creating new tasks. Understanding the *why* behind each step is critical for high-fidelity execution.

### **Step 1: Identify High-Level Groups**
- **Goal:** To establish the main organizational units of work.
- **Rationale:** This step ensures that all atomic tasks are nested within a logical, hierarchical structure (e.g., Phase -> Workflow -> Stage). This prevents a flat, unmanageable list of tasks and provides high-level context for any given action. It is the macro-level organization before the micro-level decomposition.
- **Common Pitfall:** Skipping this and going straight to creating leaf-node tasks. This results in "orphan" tasks that lack strategic context, making it difficult to track progress at a workflow level.

### **Step 2: Decompose into Atomic Actions**
- **Goal:** To break down high-level requirements into the smallest possible, verifiable units of work.
- **Rationale:** This is the most critical step for AI success. An AI agent struggles with compound commands like "build the feature." It excels at discrete commands like "create file `x.py`," "add function `y`," "write test for function `y`." Atomicity eliminates ambiguity and makes success for each step a binary state (done/not done).
- **Worked Example:**
    - **High-Level Goal:** "Add a new API endpoint to fetch user details."
    - **INCORRECT (Non-Atomic):** `- id: P5.1, description: "Create the user details endpoint."`
    - **CORRECT (Atomic Decomposition):**
        - `- id: P5.1, description: "**Create Controller File:** Create empty file at '/api/controllers/user_controller.py'."`
        - `- id: P5.2, description: "**Define Route:** In 'user_controller.py', add a GET route for '/users/{user_id}'."`
        - `- id: P5.3, description: "**Implement Service Logic:** In 'services/user_service.py', implement the 'get_user_by_id' function."`
        - `- id: P5.4, description: "**Write Unit Test:** In a new test file, write a unit test for the 'get_user_by_id' service function."`
- **Common Pitfall:** Creating tasks with "and" in the description (e.g., "Implement the function and write the tests"). This is a clear signal that the task is not atomic and must be split.

### **Step 3: Construct Hierarchical Draft**
- **Goal:** To assemble the decomposed atomic actions into the correct YAML format.
- **Rationale:** Structure is not arbitrary. The agent must generate a syntactically perfect YAML draft that conforms to the `task_schema` in `TASKS.md`. This ensures the file remains machine-parsable for dependency checks and status roll-ups.

### **Step 4: Populate Context and Dependencies**
- **Goal:** To create the web of relationships that enables correct execution.
- **Rationale:**
    - `context_files`: This field tells the *next* agent (the plan executor) which files it needs to read. It's the hand-off of information. Omitting a file here guarantees a plan will be executed with incomplete context.
    - `depends_on`: This creates the Directed Acyclic Graph (DAG) of the project. Without it, the agent has no way of knowing the correct execution order. This is the primary mechanism that prevents race conditions and ensures prerequisites are met.

### **Step 5 & 6: Propose for Review & Implement**
- **Goal:** To ensure human oversight and finalize the integration of new tasks.
- **Rationale:** These steps formalize the human-in-the-loop review process, which is critical for building trust and catching architectural errors before they enter the execution phase.

## 3. The Art of the `description` and `validation_steps`

- **`description`:** The format `**Succinct Task Title:** A detailed explanation...` is mandatory. The title gives a human reviewer an instant understanding of the task's purpose. The detail provides the AI with the necessary specifics to avoid ambiguity.
- **`validation_steps`:** These are the task's "Definition of Done." They must be **testable assertions**, not vague goals.
    - **BAD:** `validation_steps: ["Confirm the code works."]`
    - **GOOD:** `validation_steps: ["Run 'pytest tests/p1_w3/test_run_comparison.py' and assert all tests pass."]`
    - **GOOD:** `validation_steps: ["Verify that 'comparison_matrix.csv' is created in the 'outputs/reports' directory."]`

## 4. Visualizing the Workflow: The Task-Plan Dependency

An error in task authoring creates a fatal flaw that cascades through the entire system. Consider this dependency chain, which is enforced by the project's rules:

```mermaid
graph TD
    A[High-Level Goal from PLANNING.md] --> B{TASKS.md Curation};
    B --> C(<b>Atomic Task in TASKS.md</b>);
    C --> D{Plan Generation};
    D --> E(<b>.plan.md File</b>);
    E --> F{Plan Execution};
    F --> G[Deliverable & Validation];

    subgraph "Protocol Violation Point"
        direction LR
        B;
    end

    style B fill:#f9f,stroke:#333,stroke-width:2px;
````

As the diagram shows, a failure to correctly apply the `curation_protocol` at step **(B)** results in a malformed task **(C)**. This guarantees that the subsequent plan **(E)** will be flawed, leading to incorrect execution **(F)** and failed validations **(G)**. Perfecting the task curation process is the most effective way to ensure the health of the entire workflow.

---
