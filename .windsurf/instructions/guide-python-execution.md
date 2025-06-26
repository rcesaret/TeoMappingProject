---
guide_id: "guide-python-execution"
version: "1.0"
last_updated: "2025-06-26"
related_mode: "mode-python-execution.md"
---

# GUIDE: Python Execution Protocol

## 1. CORE OBJECTIVE
To ensure every Python script execution within the project is **perfectly reproducible, environmentally isolated, and secure**. This protocol eliminates the "it works on my machine" problem by enforcing a strict and consistent execution environment.

## 2. GOVERNING PRINCIPLES
- **Principle of Environmental Purity:** The *only* valid Python environment for this project is the `digital_tmp_base` conda environment. No script shall be run using a global or different Python interpreter. This guarantees that all executions use the exact same versions of all dependencies as defined in `envs/digital_tmp_base_env.yml`.
- **Principle of Idempotency:** Scripts, especially those performing setup or data transformation, should be idempotent where possible. Running a script multiple times should not produce errors or unintended side effects.
- **Principle of Explicit Invocation:** The method of invoking a Python script is not a matter of preference; it is a matter of correctness. Using `python -m` for package modules is mandatory to ensure the integrity of Python's import system.
- **Principle of Total Transparency:** All output, especially errors, must be captured and presented completely. There is no such thing as a "minor" error; every traceback is a critical piece of diagnostic information.

## 3. PROCEDURAL PROTOCOL: Secure and Reproducible Execution
This is the mandatory sequence for generating and interpreting Python execution commands.

**Step 1: Always Activate the Environment**
- The absolute first command generated for any execution sequence MUST be `conda activate digital_tmp_base`. This sets up the correct environment.

**Step 2: Select the Correct Invocation Method**
- **For scripts within a Python package** (i.e., in a directory with an `__init__.py` file and using relative imports): You MUST use the `python -m` flag. This runs the script as a module and correctly resolves the project's package structure.
- **For standalone scripts** (typically top-level orchestration scripts that are not part of a package): You MAY use the direct path method.
- All paths MUST be relative to the project root. Never use absolute paths.

**Step 3: Handle Dependencies**
- If a script fails due to a `ModuleNotFoundError`, a new dependency is required.
- You MUST propose the `conda install -c conda-forge <package_name>` command.
- Immediately after, you MUST remind the user to update the environment file with `conda env export -n digital_tmp_base --no-builds > envs/digital_tmp_base_env.yml`. This is a critical step for reproducibility.

**Step 4: Capture and Report Output**
- You must capture and display the complete `stdout` and `stderr` streams.
- If the script produces an exception, you MUST present the **full, unabridged traceback**. Do not summarize it. The line numbers, file paths, and sequence of calls are essential for debugging.
- Report the final exit code if it is anything other than `0`.

## 4. CONTEXT-SPECIFIC EXAMPLES & HEURISTICS
**Scenario 1:** Running a profiling module within the `phases.01_LegacyDB` package.

**CORRECT EXECUTION COMMANDS:**
```bash
conda activate digital_tmp_base
python -m phases.01_LegacyDB.src.profiling_modules.metrics_basic
````

**Reasoning:* The script is part of a package, so `python -m` is required to handle the relative imports correctly.*

**INCORRECT EXECUTION COMMAND:**

```bash
python phases/01_LegacyDB/src/profiling_modules/metrics_basic.py
```

**Reasoning:* This will fail with an `ImportError: attempted relative import with no known parent package` because the Python interpreter does not recognize `phases` as a package when run this way.*

**Scenario 2:** A script fails because `pandas` is not installed.

**CORRECT RESPONSE SEQUENCE:**

1.  **Diagnose:** "The script failed with `ModuleNotFoundError: No module named 'pandas'`."
2.  **Propose Install:** "To fix this, please run the following command to install the dependency: `conda install -c conda-forge pandas`"
3.  **Propose Environment Update:** "After the installation is complete, please update the project's environment file to ensure reproducibility by running: `conda env export -n digital_tmp_base --no-builds > envs/digital_tmp_base_env.yml`"

## 5\. ANTI-PATTERNS & TROUBLESHOOTING

  - **Anti-Pattern: Ignoring the Environment.** Never generate a `python ...` command without first generating the `conda activate` command.
  - **Anti-Pattern: Summarizing Errors.** Never paraphrase a traceback. The user needs to see the exact error, including all lines of the stack trace, to debug effectively.
  - **Troubleshooting: Script works locally but fails in CI/CD.** This is almost always an environment mismatch. The cause is a failure to keep `digital_tmp_base_env.yml` updated. Your protocol of reminding the user to export the environment after every install is designed to prevent this exact problem.

<!-- end list -->

---
