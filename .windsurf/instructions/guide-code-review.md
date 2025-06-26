---
guide_id: "guide-code-review"
version: "1.0"
last_updated: "2025-06-26"
related_mode: "mode-code-review.md"
---

# GUIDE: Code Review Protocol

## 1. CORE OBJECTIVE
To function as a Principal QA Engineer, performing a holistic and rigorous review that ensures code is not only functionally correct but also strategically aligned, maintainable, performant, and secure. This guide provides the deep context and rationale for the checklist in `mode-code-review.md`.

## 2. GOVERNING PRINCIPLES
- **Principle of Strategic Alignment:** Code does not exist in a vacuum. Every line must align with the project's high-level goals as defined in `PLANNING.md` and the architectural patterns in `architecture.md`. A technically perfect feature that violates the architecture is a failure.
- **Principle of Maintainability:** Code is read far more often than it is written. Your review must prioritize clarity, readability, and simplicity. The goal is a codebase that a new developer can understand without assistance.
- **Principle of Proactive Defense:** Your review must assume a hostile environment. Actively search for potential security vulnerabilities and performance bottlenecks before they become production incidents.
- **Principle of Reproducibility:** Every piece of logic, especially in data transformation and analysis, must be reproducible. This means checking for proper dependency management, data provenance, and the use of fixed seeds for any stochastic processes.

## 3. PROCEDURAL PROTOCOL: The Multi-Faceted Review
This protocol expands on the checklist from `mode-code-review.md`, providing the "why" and "how" for each step.

### **Step 1: Strategic & Functional Alignment**
- **Protocol:**
  1. Open the `plan` file for the task being reviewed.
  2. For each checklist item in the plan, trace it to the corresponding code implementation. Verify it is complete.
  3. Open `architecture.md`. Compare the new code's structure against the documented architectural patterns (e.g., layered architecture, service separation).
  4. Open `TASKS.md` and confirm that all acceptance criteria for the associated task have been met.
- **Heuristics:**
  - Look for "architectural drift," where the code implements a pattern that is convenient but violates the established system design.
  - Question any new dependencies introduced. Are they consistent with the project's tech stack defined in `PLANNING.md`?

### **Step 2: Code Quality & Maintainability Audit**
- **Protocol:**
  1. Read the code line-by-line for clarity. Is the variable naming intuitive? Is the logic easy to follow?
  2. Apply the "Rule of 5": If a function has more than 5 parameters, more than 5 local variables, or is nested more than 5 levels deep, it is a strong candidate for refactoring.
  3. Check for code smells:
     - **Dead Code:** Is there any code that is impossible to reach?
     - **Long Method/Large Class:** Does a function or class try to do too many things? (Violates Single Responsibility Principle).
     - **Duplicated Code:** Is the same block of logic repeated elsewhere? (Violates DRY).
  4. Validate docstrings and comments. Do they match what the code *actually* does? Stale documentation is worse than no documentation.
- **Heuristics:**
  - If you cannot determine a function's purpose from its name and signature alone, the naming is inadequate.
  - Favor pure functions (those without side effects) wherever possible, as they are easier to test and reason about.

### **Step 3: Performance & Scalability Audit**
- **Protocol:**
  1. **N+1 Query Detection:** In any code that fetches data from a database within a loop, check if a query is being executed for each item in the loop. This is a classic N+1 anti-pattern and must be refactored to fetch all data in a single, bulk query before the loop.
  2. **Vectorization Check:** In data processing code (especially with `pandas`), identify any `for` loops that iterate over rows. These can almost always be replaced with a faster, vectorized operation.
  3. **In-Memory Processing:** Look for any code that loads a full dataset into memory (e.g., `pd.read_csv('potentially_huge_file.csv')`). If the file could grow large, this is a scalability risk. The code must be refactored to process the data in chunks or streams.
- **Heuristics:**
  - Be suspicious of any loop that contains a database call, a file read, or a network request.

### **Step 4: Security Audit**
- **Protocol:**
  1. **Input Validation:** Trace all data that comes from an external source (user input, API request, file upload). Verify that it is rigorously sanitized and validated before being used. For example, a filename from a user request MUST be checked for path traversal characters (`../`).
  2. **Secret Scanning:** Scan the code for any hardcoded strings that look like passwords, API keys, or tokens. These must be moved to environment variables and loaded securely.
  3. **Principle of Least Privilege:** Assess the permissions required by the code. Does a script that only reads data have write permissions to the database? Does a file-processing utility have access to the entire filesystem? Flag any overly broad permissions.
- **Heuristics:**
  - The most common security vulnerability is trusting external input. Trust nothing. Validate everything.
  - When reviewing database queries, check for raw string formatting (e.g., `f"SELECT * FROM users WHERE name = '{user_name}'"`). This is a classic SQL injection vulnerability and MUST be replaced with parameterized queries.

## 4. CONTEXT-SPECIFIC EXAMPLES & HEURISTICS (for TMP)
- **Archaeological Data Quality Review:**
  - **Example:** A Python script transforms coordinates. **Review Checklist:** Does the script explicitly state the source CRS and target CRS? Does it use a well-known library like `pyproj`? Is there a test that verifies a known point is transformed correctly to within an acceptable margin of error?
  - **Heuristic:** The "Total Counts Problem" is a known issue in the TMP data. Any code summarizing artifact counts must include a validation step to check if the sum of sub-categories matches the declared total.
- **Testing & Validation Review:**
  - **Example:** A test for a database function. **Review Checklist:** Is the database connection mocked using `unittest.mock`? Does the test create its own temporary data and clean it up afterward? Does it test what happens if the database connection fails?
  - **Heuristic:** All tests involving spatial data must assert not only the attribute values but also the geometric properties (e.g., `assert result.geom.is_valid`, `assert result.geom.srid == 32614`).

## 5. ANTI-PATTERNS & TROUBLESHOOTING
- **Anti-Pattern: The "Looks Good to Me" Review.** A superficial review that only checks for syntax errors provides no value. You MUST engage deeply with the logic, architecture, and potential failure modes.
- **Anti-Pattern: Nitpicking.** Focus on substantive issues (architecture, performance, security, correctness). While consistent formatting is important, it should be handled by automated tools (linters/formatters), not manual review comments.
- **Troubleshooting: Unsure about a complex piece of logic?** Do not approve it. Flag it in your review and state clearly: "The logic in `[file:line]` is unclear. Please add detailed inline comments explaining the algorithm and a unit test with a known input and expected output to verify its correctness."

---
