## Version Control Rules & Protocols

### 1. Preamble & Context

These rules govern all version control activities for the Digital TMP project. They are designed to support the project's foundational principles of **reproducibility, traceability, and modularity**. Given the project's division into eight distinct phases and its reliance on an AI-driven, task-based workflow managed in `TASKS.md`, these protocols are mandatory to ensure a clean, understandable, and verifiable project history.

### 2. Guiding Principles

These principles inform our technical protocols and should guide all development decisions.

- **Atomic Commits:** Each commit must represent a single, logical, and complete change. This is crucial for isolating changes, reviewing code, and tracing the project's evolution.
- **Provenance and Traceability:** Every change committed to the repository *must* be traceable to a specific work item. Git history is not just a log; it is a critical piece of the project's scientific documentation.
- **Branching Hygiene:** Keep branches focused, descriptive, and short-lived. A clean branch history is essential for managing a complex, multi-phase project.
- **Meaningful History:** Commit messages must be structured and informative, explaining the *what* and *why* of a change. A linear and readable history on the `main` branch is the goal.
- **Never Commit Secrets:** Passwords, API keys, or other credentials must never be committed. Use environment variables (`.env` file) and ensure the `.gitignore` is comprehensive.
- **`.gitignore` Discipline:** The `.gitignore` file must be diligently maintained to exclude generated files, dependencies (e.g., `node_modules`), system files, logs, and sensitive information from the repository.

### 3. Core Version Control Protocol

This is the strict, machine-enforceable protocol for all Git operations.

#### 3.1. Branching Model & Naming Convention

All work must be performed on a feature branch. Direct commits to `main` are strictly prohibited. Branch names **MUST** follow this convention:

**`<phase-directory>/<type>/<short-description>`**

- **`<phase-directory>`**: The name of the phase directory the work pertains to.
    - Examples: `phase1`, `phase2`, `phase8`
- **`<type>`**: The nature of the work.
    - `feat`: A new feature, script, or capability.
    - `fix`: A bug fix or correction.
    - `docs`: Documentation changes.
    - `refactor`: Code refactoring without changing external behavior.
    - `test`: Adding or improving tests.
- **`<short-description>`**: A 2-5 word, kebab-case summary of the task.

**Correct Branch Name Examples:**
- `phase1/feat/database-profiling-script`
- `phase2/fix/resolve-data-type-mismatch`
- `phase4/refactor/optimize-gdal-warp-call`
- `docs/update-architecture-diagram`

#### 3.2. Commit Message Structure

All commit messages **MUST** strictly adhere to the **Conventional Commits** specification, prefixed with the relevant `TASK_ID`.

**`[TASK_ID] <type>(scope): <subject>`**

- **`[TASK_ID]`**: The full, exact ID of the task from `TASKS.md` that the commit addresses (e.g., `P1.W2.T1`).
- **`<type>`**: Must be one of:
    - `feat`: A new feature.
    - `fix`: A bug fix.
    - `docs`: Documentation changes only.
    - `style`: Code style changes (linting, whitespace).
    - `refactor`: Code changes that neither fix a bug nor add a feature.
    - `test`: Adding or refactoring tests.
    - `chore`: Changes to the build process, tooling, or environment.
- **`(scope)`**: (Optional) The module or phase affected (e.g., `(db_profiling)`, `(georef)`, `(qgis)`).
- **`<subject>`**: A concise, imperative-mood description of the change (e.g., "Add function to calculate table cardinality").

**Correct Commit Message Examples:**
- `[P1.W2.T3] feat(profiling): Implement raw metric generation for DF9`
- `[P2.W1.T2] fix(etl): Correctly handle null values in DF10 text fields`
- `[P6.W3.T1] docs(tdar): Draft tutorial for rejoining CSVs in QGIS`
- `[P7.W3.T1] chore: Add pg_dump utility script to Docker container`

#### 3.3. Pull Request (PR) Protocol

1.  **Requirement:** All branches must be merged into `main` via a Pull Request.
2.  **Template:** PRs **MUST** use the template defined in `PULL_REQUEST_TEMPLATE.md`.
3.  **Title:** The PR title **MUST** follow the commit message structure (e.g., `[P1.W2.T3] feat(profiling): Implement raw metric generation`).
4.  **Task Linkage:** The PR body **MUST** contain a direct link to the task in `TASKS.md` and a clear description of the work completed.
5.  **Validation:** The "Validation Steps" section must be filled with specific, actionable instructions for a human reviewer to verify the changes.
6.  **Clean History:** Before a PR is ready for final review, the author **MUST** rebase their branch onto the latest `main` branch to maintain a clean, linear project history. This resolves conflicts before the review process. `git pull --rebase origin main`.

### 4. AI Agent Rules

As the project's AI assistant, you are required to follow these rules without deviation.

- **Branch Creation:** When instructed to begin a new task, you **MUST** create and switch to a new branch using the naming convention defined in section 3.1.
- **Commit Message Generation:** Your generated commit messages **MUST** conform to the structure in section 3.2. You will derive the `[TASK_ID]`, `type`, and `subject` from the active task in `TASKS.md`.
- **Atomic Changes:** You must generate code, documentation, or other file modifications as small, logical units that align with a single task and can be wrapped in an atomic commit.
- **`.gitignore` Suggestions:** When new technologies or files are introduced, you are responsible for suggesting appropriate additions to the `.gitignore` file (e.g., for Python `__pycache__`, Jupyter `.ipynb_checkpoints`, temporary QGIS files, Docker build contexts, etc.).
- **Secret Detection:** You **MUST** actively scan for and flag any potential secrets (API keys, passwords, private tokens) in code or configuration files you generate. You must recommend their immediate removal and replacement with environment variables.

---
