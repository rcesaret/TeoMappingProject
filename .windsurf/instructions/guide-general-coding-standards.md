# General Coding Guidelines & Protocol

This document provides a comprehensive and unified set of guidelines, protocols, and best practices for software development. It synthesizes all project rules into a single, authoritative guide covering engineering philosophy, AI workflow, coding standards, testing, and more.

## I. Core Engineering Philosophy

These high-level principles guide all development decisions and represent the foundation of our engineering culture.

-   **Simplicity First (SF):** Always choose the simplest viable solution. Favor elegant, maintainable solutions over verbose code. Avoid clever tricks or excessive abstraction that obscures intent. Complex patterns or architectures require explicit justification. Keep functions focused on a single responsibility (SRP) and minimize nesting (e.g., a maximum of two levels for conditionals).
-   **Readability & Maintainability Priority (RP):** Code must be written to be immediately understandable by human developers. It should be clean, simple, and self-documenting where possible. The goal is to facilitate adding new features without requiring major rewrites.
-   **Don't Repeat Yourself (DRY)**: Abstract common logic into reusable, well-defined components (functions, classes, modules). Avoid duplicating code to improve maintainability and reduce errors.
-   **Robustness & Reliability**: Code must be resilient and handle failures gracefully. Validate all external and user-provided inputs. Implement sensible, comprehensive error handling for all operations that can fail (e.g., I/O, API calls), ensuring clear error messages and safe fallback paths. Explicitly handle edge cases.
-   **Security by Design**: Security is a primary consideration at every stage of development. Treat all external input as untrusted. Follow the principle of least privilege. Sanitize inputs and use parameterized queries to prevent injection attacks. Manage secrets and sensitive data securely.
-   **Testability by Design**: All code must be designed from the outset to be easily testable. Favor pure functions, dependency injection, and clear interfaces to facilitate effective unit testing.
-   **Dependency Minimalism (DM)**: Do not introduce new third-party libraries or frameworks without a compelling, documented justification and explicit approval.
-   **Consistency is Key**: Strictly adhere to the coding styles, patterns, and architectural principles defined in this document and other project-level guides (`architecture.md`, `technical.md`).
-   **Documentation**: Documentation should explain the "why," not the "what." The code itself should be self-documenting. Use comments and docstrings to explain the rationale behind complex algorithms, non-obvious logic, or workarounds. Document all public APIs clearly.
-   **Efficiency**: Be mindful of algorithmic complexity. Prefer solutions with better algorithmic / Big-O efficiency where performance is critical.
-   **Scalability:** Structure the codebase to facilitate adding new features and functionalities without requiring major rewrites.
-   **Industry Standards Adherence (ISA):** Follow established, language-idiomatic conventions for the relevant language and technology stack.
-   **Code Preservation:** Never delete, overwrite, or break existing functional code unless explicitly instructed to do so as part of a confirmed task. Propose changes conservatively to maintain codebase integrity.

## II. AI Assistant Workflow & Protocol

This section outlines the mandatory operational workflow for AI assistants engaged in development tasks.

### A. Information Gathering & Context Integration

Before any planning or coding, the AI assistant must gather and synthesize all relevant context.

1.  **Understand the Task**: Thoroughly analyze the specific task (e.g., from a ticket or user request), including its requirements, acceptance criteria, and any provided context.
2.  **Scan the Memory Bank**: Actively search all relevant project memory files for constraints, standards, and history pertinent to the task. This includes:
    *   `architecture.md`: For component boundaries, dependencies, and interaction patterns.
    *   `technical.md`: For approved technologies, libraries, and design patterns.
    *   `tasks_plan.md`: For related task statuses and dependencies.
    *   `active_context.md`: For recent changes that may cause conflicts.
    *   `lessons-learned.md` & `error-documentation.md`: For relevant past experiences.
3.  **Existing Codebase Analysis:** Analyze the affected areas of the codebase to understand established patterns, styles, and integration points. Proposed changes must align with or explicitly justify deviations from existing patterns.
4.  **External Resource Usage (If Necessary):** Only use external resources (e.g., web search, official documentation) when internal context is insufficient.
    *   Critically evaluate external information and rigorously adapt it to fit project standards, security requirements, and architecture.
    *   Never include proprietary code, internal identifiers, or sensitive information in external queries.
5.  **Synthesize & State Findings**: Begin any significant work (e.g., a plan) by explicitly stating the key constraints, requirements, and patterns derived from the context-gathering phase. If any proposed change must deviate from established standards, it must be highlighted and justified.

### B. Implementation & Coding Workflow

This step-by-step process must be followed for all code generation and modification tasks.

1.  **Acknowledge Plan**: Confirm understanding of the approved implementation plan and reiterate the primary objective.
2.  **Execute Incrementally**: Implement the plan one logical step or feature at a time. For each step:
    a.  **Pre-Change Safety Check**: Identify target files and perform a focused check against `architecture.md` and `technical.md` to ensure the planned change is compliant. **HALT** if a conflict is found that was not approved in the plan.
    b.  **Implement the Change**: Write or modify code precisely as specified, applying all project standards. Prioritize reusing existing code and respecting architectural boundaries.
    c.  **Mental Walkthrough**: Mentally trace the execution of the new code, considering its impact and potential edge cases. If unexpected side effects are found, **HALT**, revert the change, and enter a debugging phase.
3.  **Develop Comprehensive Tests**: After implementing a feature, write new unit tests or update existing ones.
    *   Follow the project's testing strategies and file structure conventions.
    *   Implement tests covering the scenarios from the plan (happy path, edge cases, failure cases).
    *   Run all new and relevant existing tests. If any test fails, **HALT** and initiate debugging.
4.  **Document as You Code**: Add docstrings and comments as specified by project standards while the context is fresh. Focus on explaining the "why" behind complex or non-obvious code.
5.  **Finalize and Report**: Upon successful completion of all steps and tests:
    *   Run all pre-commit hooks (`pre-commit run --all-files`) and ensure they pass.
    *   Report task completion.
    *   Propose specific, concise updates to project memory files (`tasks_plan.md`, `active_context.md`, etc.) to reflect the new state of the codebase.

### C. Problem-Solving & Debugging

When encountering complex issues, bugs, or test failures:

1.  **Reflect**: Step back and analyze the problem's root cause instead of attempting superficial fixes.
2.  **Distill**: Formulate a hypothesis about the most likely cause.
3.  **Verify**: Suggest a clear, minimal way to verify the hypothesis (e.g., a specific log statement, a targeted test, or a debugger check) before proposing a solution.

## III. General Software Engineering Standards

These rules apply to all code regardless of language.

### A. Code Quality & Readability

*   **Naming Conventions**: Use meaningful, descriptive, and consistent names for variables, functions, classes, and modules that clearly reflect their purpose. Follow language-specific conventions (see Section VI).
*   **Clarity Over Cleverness**: Write straightforward code. Avoid clever tricks or excessive abstraction that obscures the code's intent.
*   **Function Design**: Keep functions short and focused on a single responsibility (Single Responsibility Principle).
*   **Nesting**: Minimize logical nesting (e.g., `if`/`for` blocks). A nesting depth greater than two levels should be refactored.
*   **No Magic Values**: Do not use unnamed, hardcoded numbers or strings. Define them as `UPPER_SNAKE_CASE` constants at the top of the module with an explanatory comment.
*   **Formatting**: Strictly adhere to project-specified automated formatters (e.g., Black, Prettier). Maintain uniform formatting across the entire codebase.

### B. Architecture & Modularity

*   **Architectural Context**: Frame solutions within the project's broader architecture. When appropriate, suggest design alternatives that align with long-term goals.
*   **Component Design**: Design components to be as independent as possible, using well-defined interfaces or abstraction layers to reduce coupling.
*   **Modularity**: Group related logic into self-contained modules or classes, organized by feature or responsibility.
*   **Reusability (DRY)**: Refactor repetitive code into shared, reusable utilities or functions.

### C. Documentation & Comments

*   **Language**: All documentation, comments, variable names, and log messages must be in English.
*   **Docstrings**: All public modules, functions, classes, and methods must have comprehensive docstrings explaining their purpose, parameters, return values, and any exceptions they might raise.
*   **Inline Comments**: Use inline comments sparingly. The code should be self-documenting. Reserve comments for:
    *   Explaining the **"why"** behind a complex or non-obvious algorithm.
    *   Documenting workarounds for known issues in libraries or data.
    *   `TODO` or `FIXME` markers with a clear description of the pending work.

### D. Robustness & Error Handling

*   **Input Validation**: Treat all external input (from users, APIs, files) as untrusted. Validate inputs rigorously at the boundaries of your system.
*   **Error Handling**: Implement robust error handling for all operations that can fail (e.g., I/O, network requests, database calls). Provide clear error messages and safe fallback paths.
*   **Resource Management**: Ensure all external resources (files, network connections, database sessions) are properly managed and released, using constructs like Python's `with` statement.

### E. Security

*   **Secrets Management**: Never hardcode sensitive information (API keys, passwords, tokens) in source code, comments, or logs. Use environment variables and a secure secrets management system.
*   **Secure Coding**: Sanitize all inputs to prevent injection attacks (e.g., use parameterized queries for SQL). Adhere to the principle of least privilege.
*   **Version Control**: Never commit sensitive files (like `.env` or private keys) to version control. Use a `.gitignore` file to prevent accidental commits. Maintain a `.env.example` file with placeholder values.

### F. Performance

*   **Algorithmic Efficiency**: Be mindful of algorithmic complexity (Big-O). Choose data structures and algorithms that are efficient and scale appropriately for the problem domain.
*   **Targeted Optimization**: Avoid premature optimization. Write clear, correct code first. Address performance bottlenecks only after they have been identified through proper profiling.
*   **Awareness**: Highlight potential performance implications of new code and suggest optimization opportunities where relevant.

## IV. Testing & Reliability

*   **Mandatory Unit Tests**: All new features (functions, classes, routes, etc.) must be accompanied by `pytest` unit tests.
*   **Test Maintenance**: If logic is updated, corresponding tests must be updated to reflect the new behavior.
*   **Test Location**: Tests must reside in a top-level `/tests` directory that mirrors the main application's structure.
*   **Test Case Coverage**: For each new unit, provide at least three tests:
    1.  **Expected Use**: A test for the primary, "happy path" scenario.
    2.  **Edge Case**: A test for a known or plausible edge case.
    3.  **Failure Case**: A test that verifies correct error handling when inputs are invalid or an operation fails.
*   **Pre-commit Hooks**: The project uses pre-commit hooks for quality assurance (`black`, `isort`, `ruff`, `detect-secrets`, etc.). All code must pass these checks before a task is considered complete.

## V. Version Control

*   **Atomic Commits**: Make small, self-contained commits that represent a single logical change. Avoid broad, exploratory edits in a single commit.
*   **Commit Messages**: Use the Conventional Commits specification. The format is:
    ```
    type(scope): concise description

    [optional body with details]

    [optional footer with breaking changes/issue references]
    ```
    *   **Types**: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`.

## VII. Strict Prohibitions

The following actions are strictly forbidden.

*   **No Hallucination**: Never invent or guess libraries, functions, methods, or file paths. Only use known, verified entities that exist within the project or its declared dependencies.
*   **No Unsolicited Deletion**: Never delete or overwrite existing code unless explicitly instructed to do so as part of an approved task.
*   **No Hardcoded Secrets or Paths**: Never place sensitive data (keys, tokens) or absolute file paths directly in the code.
*   **No Committing Secrets**: Never commit sensitive files (e.g., `.env`, `*.pem`, `credentials.json`) to version control.
*   **Code Size Limits (Guidelines for Refactoring)**: Proactively identify and suggest refactoring for:
    *   Functions exceeding 30 lines.
    *   Python files exceeding 500 lines or general files exceeding 300 lines.
    *   Classes with more than 5 public methods.
