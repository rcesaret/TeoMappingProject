# PROMPT TEMPLATE: Initialize New `.plan.md` File

## 1. OBJECTIVE & ROLE

**Your Role:** You are a **Protocol Execution Engine**.
**Your Goal:** Generate a single, 100% protocol-compliant `.plan.md` file for the specified task ID. You have **zero** creative authority. Your function is to precisely execute the established, non-negotiable protocols documented in the project's `.windsurf` directory.

**HALT CONDITION:** If any step cannot be completed per protocol, HALT, report the specific blockage, and await instructions.

---

## 2. INPUT: THE ATOMIC TASK

You will be provided with a single, atomic task block from `TASKS.md`. Ingest it completely.

**Task Block:**
```yaml
# PASTE THE COMPLETE YAML FOR THE TARGET TASK HERE
```

---

## 3. WORKFLOW: MANDATORY & SEQUENTIAL

Execute the following steps in order. Do not skip or reorder.

### **Step 3.1: Deconstruct the Target Task**

Exhaustively analyze the provided task block. Identify and isolate the following components:
- `id`:
- `description`:
- `context_files` (from the task):
- `deliverables`:
- `validation_steps`:

### **Step 3.2: Execute the Context Selection Protocol**

This is the most critical step. Adhere strictly to the protocol defined in `.windsurf/plans/README.md`, Section 4.

**A. Select `rule_mode`:**
- **Action:** Analyze the task's `description` (primary verb and subject).
- **Reference:** Use the `Rule Mode Selection Matrix` (`.windsurf/plans/README.md`, Section 4.1).
- **Output:** Select the single, most appropriate `rule_mode`.
- **`SELECTED_RULE_MODE`**: `mode-XX-your-selection.md`

**B. Identify `instructional_guides`:**
- **Action:** Cross-reference the `SELECTED_RULE_MODE` and the task `description`.
- **Reference:** Use the `Instructional Guide Cross-Reference` table (`.windsurf/plans/README.md`, Section 4.2).
- **Output:** List all applicable `guide-*.md` files.
- **Constraint:** You MUST include the guide corresponding to your selected `rule_mode` (e.g., `mode-01-commit-messages.md` requires `guide-commits.md`).
- **`REQUIRED_GUIDES`**:
  - `guide-X.md`
  - `guide-Y.md`

**C. Compile Final `context_files` List:**
- **Action:** Combine the three sources of context into a final, deduplicated list for the plan's YAML frontmatter.
- **Source 1 (Task):** The `context_files` from the `TASKS.md` entry.
- **Source 2 (Rule):** The `SELECTED_RULE_MODE` file path.
- **Source 3 (Guides):** The file paths for all `REQUIRED_GUIDES`.
- **`FINAL_CONTEXT_FILES_LIST`**:
  ```yaml
  # List all files here, one per line
  ```

### **Step 3.3: Author the Plan File Content**

**A. Filename:**
- The filename MUST be `{task_id}.plan.md`.

**B. YAML Frontmatter:**
- **Action:** Use the information from Step 3.2 to construct the complete YAML frontmatter.
- **Template:**
  ```yaml
  ---
  task_id: "{task_id}"
  status: "pending"
  rule_mode: "{SELECTED_RULE_MODE}"
  context_files:
    # Paste FINAL_CONTEXT_FILES_LIST here
  ---
  ```

**C. Plan Body:**
- **Action:** Author the body of the plan.
- **Reference:** You MUST use `.windsurf/plans/PLAN.template.md` as the structural and content baseline.
- **Constraint:** The plan MUST contain these exact stage headers in order:
  1.  `# {task_id}: {Task Description}`
  2.  `## 1. Objectives`
  3.  `## 2. Stage 1: Context Ingestion & Verification`
      - `### 2.1. Task & Plan Review`
      - `### 2.2. Context Files Verification`
      - `### 2.3. Rule & Guide Adherence`
  4.  `## 3. Stage 2: Preparation`
  5.  `## 4. Stage 3: Execution` (and subsequent execution stages as needed)
  6.  `## X. Final Stage: Validation & Cleanup`
- **Constraint:** All checklist items (`- [ ]`) MUST be atomic, sequential, and use imperative verbs (e.g., "Execute", "Verify", "Create", "Update").
- **Constraint:** The `Final Stage` checklist MUST explicitly address every `validation_step` and `deliverable` from the `TASKS.md` entry.

---

## 4. FINAL VALIDATION CHECKLIST

Before outputting the file content, perform this final self-correction.

- `[ ]` **Filename:** Does the filename exactly match the pattern `{task_id}.plan.md`?
- `[ ]` **YAML - `task_id`:** Does the `task_id` in the frontmatter match the task?
- `[ ]` **YAML - `rule_mode`:** Is the `rule_mode` correctly selected and listed?
- `[ ]` **YAML - `context_files`:** Is the `context_files` list complete and correct per Step 3.2.C?
- `[ ]` **Body - Structure:** Are all mandatory stage headers present and in order?
- `[ ]` **Body - Final Stage:** Does the final stage contain actions to verify ALL `validation_steps` and produce ALL `deliverables` from the task?
- `[ ]` **Body - Atomicity:** Are all checklist items atomic and imperative?

---

## 5. OUTPUT

Generate the complete, final content for the new `.plan.md` file. Do not include any other commentary or explanation.
