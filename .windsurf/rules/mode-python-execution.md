---
trigger: manual
---

# PYTHON EXECUTION

## MANDATORY GUIDELINES & PROTOCOLS REVIEW
- You MUST ALWAYS review and implement ALL guidelines & protocols from from the following files, which are the PRIMARY SOURCES OF TRUTH for all python execution & validation tasks:
  - `.windsurf/instructions/guide-python-execution.md`
  - `.windsurf/instructions/guide-python-style.md`
- When a task involves Jupyter notebooks (`*.ipynb`), you MUST ALWAYS review and implement ALL guidelines & protocols from `.windsurf/instructions/guide-jupyter-notebooks.md`

## ENVIRONMENT MANAGEMENT
- All Python scripts, tests, and tools MUST be executed within the `digital_tmp_base` conda environment defined in `envs/digital_tmp_base_env.yml`. This is non-negotiable.
- Before generating any execution command, you MUST first generate the command to activate the correct conda environment: `conda activate digital_tmp_base`. This is always the first step.
- If a script requires a new dependency, you must inform the user and propose the command to install it via conda, preferably from the `conda-forge` channel: `conda install -c conda-forge <package_name>`.
- After any installation, you MUST remind the user to export the updated environment to `digital_tmp_base_env.yml` to ensure reproducibility. The command is: `conda env export -n digital_tmp_base --no-builds > envs/digital_tmp_base_env.yml`.

## SCRIPT INVOCATION
- Generate full, explicit, and secure commands to run Python scripts.
- You MUST prefer invoking scripts as modules using the `python -m` flag where the script is part of a package (e.g., `python -m phases.01_LegacyDB.src.profiling_modules.metrics_basic`). This ensures correct relative import resolution.
- For standalone scripts not part of a package, use the full relative path from the project root (e.g., `python phases/01_LegacyDB/src/00_setup_databases.py`).
- Any command-line arguments must be clearly specified, explained, and properly quoted to prevent shell injection vulnerabilities.

## OUTPUT INTERPRETATION
- You must capture and present both `stdout` (standard output) and `stderr` (standard error) from any script execution.
- If a script fails with an exception, you MUST present the full, unabridged traceback from `stderr`. Do not summarize, paraphrase, or truncate tracebacks. The complete error output is mandatory for effective debugging.
- Report the exit code of the script if it is non-zero, as this indicates an error.

## ORCHESTRATION & WORKFLOW
- For workflows requiring the execution of multiple scripts in a specific order, you MUST generate a master shell script (`.sh`) or a `Makefile` that defines the execution sequence and dependencies.
- All executable scripts MUST use `sys.exit(1)` upon encountering a fatal error. Your orchestration scripts must check for non-zero exit codes from child processes and halt execution immediately.
- Any Python script that accepts command-line arguments MUST use the `argparse` module. Provide clear help messages for all arguments.

## ENVIRONMENT VARIABLE & CONFIGURATION
- Scripts requiring secrets or configuration from `.env` files MUST use a library like `python-dotenv` to load them. Do not assume environment variables are pre-populated in the shell.
- Never specify absolute paths in execution commands. Use relative paths from the project root or utilize path resolution within the scripts themselves.
- For large-scale data processing scripts, include memory usage monitoring and implement chunking strategies to prevent system resource exhaustion.

## PROJECT DATA PROCESSING
- When executing scripts that process TMP legacy data, always include validation steps to check for expected data structure and known quality issues.
- For scripts performing coordinate transformations, include verification steps that validate the transformation accuracy and spatial integrity.
- When running scripts that modify database schemas or large datasets, ensure backup and rollback procedures are documented and accessible.
- Include progress reporting for long-running data processing tasks, especially those handling the full TMP dataset.

## PERFORMANCE & MONITORING
- For scripts processing large datasets (>10MB), implement progress bars using `tqdm` or similar libraries.
- When executing scripts that write to the database, monitor connection pools and implement appropriate timeout settings.
- For spatial processing operations, monitor memory usage and implement spatial indexing strategies to optimize performance.
