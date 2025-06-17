---
trigger: glob
globs: *.py, *.ipynb
---

# PYTHON CODING STANDARDS

## 1. Core Python Standards
- **Python Version:** All Python code MUST use Python 3.11+.
- **Style Guide:** All code MUST strictly adhere to the `PEP 8` style guide.
- **Formatting:** All Python files MUST be formatted with the `ruff` formatter. The maximum line length is 88 characters.
- **Type Hinting:** All function and method definitions MUST include type hints for all parameters and return types. Use the `typing` module (`Optional`, `Union`, `List`, `Dict`, etc.) for precision.
- **Docstrings:** All public modules, functions, classes, and methods MUST have a comprehensive Google-style docstring.
- **Imports:** Imports MUST be at the top of the file, grouped into standard library, third-party, and local application imports, sorted alphabetically.

## 2. Naming Conventions
- **Variable Naming**: Use `snake_case` for all variable, function, and method names.
- **Class Naming**: Use `PascalCase` for all class names.
- **Constants**: Use `UPPER_SNAKE_CASE` for global constants.

## 3. Project-Specific Library Usage
- **Data Manipulation:** Prefer `pandas` and `geopandas`.
    - **Legacy Data Encoding:** When reading legacy CSV files known to have encoding issues, you MUST explicitly set `encoding='latin1'` in `pd.read_csv`.
    - **CRS Mandate:** All `geopandas.GeoDataFrame` objects MUST have their Coordinate Reference System (CRS) set immediately upon creation or reading. For data in the legacy system, this will be the "Millon Space" definition found in `docs/architecture.md`.
- **Database Interaction:** Use `sqlalchemy` for all PostgreSQL interactions. Refer to `21_sql_coding_standards.md` for query patterns.

## 4. Python-Specific Best Practices

- **File Length**: Never create a Python file >500 lines of code. If nearing limit, refactor by splitting into smaller modules/helper files.
- **Environment Variables**: Always store API keys, DB credentials, secrets as environment variables, not hardcoded.
    - Never commit `.env` files to version control. Use `.env.example` with dummy values.
    - Document all env vars in project's `README.md`.
- **Data Flow**: Ensure clear data flow within functions/modules. Avoid global state where possible.
- **Defensive Coding**: Implement defensive coding patterns (explicit type checking, input validation). Include assertions for assumptions/error catching.
- **Magic Numbers/Strings**: Avoid "magic numbers/strings" by replacing hardcoded values with named constants.
- **Algorithmic Efficiency**: Be mindful of algorithmic complexity. Prefer solutions with better **Big-O efficiency** where performance is critical.
- **Logging**: Implement consistent logging to aid debugging/monitoring. Follow a defined logging format (e.g., JSON logging).

## 5. Environment Management
- **Package Management**: This project uses Conda for Python environment and package management.
- **Default Conda environment** Prefer the existing `digital_tmp_base`. Only create a new environment when package conflicts cannot be resolved; document the rationale in the PR.
- **Environment creation**: `conda env create -f digital_tmp_*_env.yml`; Poetry and standalone `pip` workflows are not permitted.
- **Specification File**: The environment is defined by `digital_tmp_base_env.yml` in the project root. This file is the source of truth for replicating the environment.
- **Updates to Environment**: Any environment change *must* update all `environment*.yml` / `conda-lock.yml` files, pass CI, and be committed to version control.

## 4. Forbidden Patterns
The following patterns are strictly prohibited in this project:
- **No Hardcoded Paths:** Do not use string literals for file paths (e.g., `"/path/to/data.csv"`). All paths MUST be constructed programmatically using `pathlib` and relative to project root variables.
- **No Unsafe SQL Queries:** Do not use Python's f-strings or `%` formatting to pass variables into SQL queries. This introduces SQL injection vulnerabilities. You MUST use SQLAlchemy's expression language or parameterized queries.
- **No Magic Values:** Do not use unnamed, hardcoded numbers or strings in your code. Define them as `UPPER_SNAKE_CASE` constants at the top of the module with an explanatory comment.

## 6. Automated Enforcement
- **Pre-commit Hooks**: After generating or modifying any Python code, you MUST run the pre-commit hooks to ensure all formatting and linting standards are met.
- **Command**: `pre-commit run --all-files`
- **Validation**: The command must pass without errors before the task is considered complete.
