---
trigger: manual
---

# PYTHON DEBUGGING

## DIAGNOSTIC PROTOCOL
When an error occurs or a debugging task is initiated, you MUST follow this systematic process without deviation.

### STEP 1: GATHER & ANALYZE CONTEXT
- Ingest the complete error message and the full, unabridged traceback.
- Ingest the full source code of the file where the error occurred, paying close attention to the lines indicated in the traceback.
- Understand the intended behavior by consulting the relevant `plan` file. Compare the intent with the actual outcome described by the error.

### STEP 2: HYPOTHESIZE ROOT CAUSE (REFLECT & DISTILL)
- Perform a detailed analysis of the traceback, identifying the exact line, operation, and variable states that led to the failure. Formulate 3-5 distinct hypotheses for the root cause.
- Categories to consider:
  - **Logic Error:** Flaw in the algorithm or conditional flow.
  - **Data State Issue:** Incorrect, unexpected, or `None` data in a variable.
  - **Incorrect Assumption:** A dependency or external resource did not behave as the code assumed.
  - **Environment/Dependency Issue:** Problem with a library version or environment configuration.
- Evaluate your hypotheses against the evidence. Discard the less likely ones and distill your analysis down to the 1-2 most probable root causes.

### STEP 3: PROPOSE VERIFICATION (VALIDATE)
- You MUST NOT propose a code fix immediately. The immediate next step is to *verify* your primary hypothesis.
- Propose a specific, minimal action to confirm the root cause. This MUST be one of the following:
  1. **Strategic Logging:** Propose adding specific `print()` or `logging` statements to inspect variable states at critical points just before the error line.
  2. **Interactive Debugging:** Propose inserting a `breakpoint()` call immediately before the failing line. Instruct the user to run the script and, once inside the Python Debugger (`pdb`), which variables or expressions to inspect.
  3. **Isolation via Regression Test:** Propose writing a new, minimal unit test that specifically and reliably reproduces the bug with the simplest possible input.

### STEP 4: IMPLEMENT & VERIFY FIX
- Once the root cause is confirmed via the diagnostic step, propose the minimal, targeted code change required to resolve the issue.
- You MUST provide a concise explanation of *why* the proposed fix resolves the identified root cause.
- After the user approves the fix, you MUST state the command to re-run the relevant tests (including any new regression test) to verify that the fix is effective and has not introduced new regressions.

## SPECIALIZED DEBUGGING PROTOCOLS

### LOGICAL ERROR DEBUGGING
- For logical errors (incorrect output), you must propose adding assertions (`assert`) at intermediate steps of the function to pinpoint where the data state first diverges from expectations.

### PERFORMANCE DEBUGGING
- For performance issues, you MUST use Python's built-in `cProfile` module. Generate a script to run the slow function under the profiler and output the statistics sorted by cumulative time (`tottime`).

### MINIMAL REPRODUCIBLE EXAMPLES
- Before debugging a complex issue, you must attempt to create a minimal, self-contained, reproducible example of the bug. This isolates the problem from the rest of the application.

## ARCHAEOLOGICAL DATA DEBUGGING CONSIDERATIONS
- When debugging coordinate transformation issues, always validate the input and output coordinate systems and check for common issues like axis order problems.
- For database-related errors involving spatial data, check geometry validity using `ST_IsValid` and spatial index integrity.
- When debugging legacy data processing issues, consider known TMP data quality problems and validate against documented data structures.
- For errors involving collection unit IDs (SSN), verify the ID exists in the expected range and cross-reference with available documentation.

## ERROR REPORTING & DOCUMENTATION
- Report your findings at each step of the process.
- If debugging fails after multiple attempts, explicitly state the difficulty, the approaches tried, and why they failed. Request human assistance or suggest an alternative diagnostic path.
- For complex debugging sessions, maintain a debugging log that documents hypotheses tested, verification methods used, and findings for future reference.
- When a fix is implemented, document the root cause and solution in code comments or project documentation to prevent similar issues.

## ADVANCED DEBUGGING TECHNIQUES
- Use `git bisect` recommendation when a bug was introduced recently and the exact commit is unknown, to efficiently locate the commit that introduced the regression.
- Apply "rubber duck" debugging as a final diagnostic step for subtle bugs: explain the logic of the failing code block back to the user, line by line, in plain English.
- For spatial data processing errors, use visualization techniques to inspect intermediate results and identify where spatial relationships break down.
