---
trigger: glob
globs: *.py, *.ipynb
---

# Digital TMP Python Coding Standards

## Activation

Glob Pattern: `**/*.py`, `**/*.ipynb`
Description: These rules apply to all Python files (`.py`) and Jupyter Notebook files (`.ipynb`) throughout the Digital TMP project.

---

## 1. Core Python Standards

- **Primary Language**: Use Python 3.11+ for all new code unless a specific task explicitly requires a different language.
- **Code Style**: All Python code MUST strictly adhere to `PEP 8` style guidelines.
- **Formatting**: Format all Python files with Black. Max line length: 88 characters.
- **Type Hinting**: All function definitions MUST include type hints for parameters and return types. Use `typing` module features (e.g., `Optional`, `Union`) where appropriate.
- **Docstrings**: Write comprehensive Google-style docstrings for every function, class, and module.
- **Imports**: Use clear and consistent import statements. Prefer relative imports within packages.
- **Variable Naming**: Use `snake_case` for all variable, function, and method names.
- **Class Naming**: Use `PascalCase` for all class names.
- **Constants**: Use `UPPER_SNAKE_CASE` for global constants.

## 2. Recommended Python Libraries & Frameworks

- **Data Manipulation**: Prefer `Pandas` and `GeoPandas` for tabular and geospatial data manipulation/analysis.
- **Database Interaction**: Use `SQLAlchemy` as the ORM for PostgreSQL databases.
- **Validation Frameworks**: Integrate `Great Expectations` for automated data quality validation in ETL pipelines. Consider `dbt` for data transformation workflows.
- **Database Connectivity**: Use `psycopg2` for direct PostgreSQL database connections when ORM not applicable.

## 3. Python-Specific Best Practices

- **File Length**: Never create a Python file >500 lines of code. If nearing limit, refactor by splitting into smaller modules/helper files.
- **Environment Variables**: Always store API keys, DB credentials, secrets as environment variables, not hardcoded.
    - Never commit `.env` files to version control. Use `.env.example` with dummy values.
    - Document all env vars in project's `README.md`.
- **Data Flow**: Ensure clear data flow within functions/modules. Avoid global state where possible.
- **Defensive Coding**: Implement defensive coding patterns (explicit type checking, input validation). Include assertions for assumptions/error catching.
- **Magic Numbers/Strings**: Avoid "magic numbers/strings" by replacing hardcoded values with named constants.
- **Algorithmic Efficiency**: Be mindful of algorithmic complexity. Prefer solutions with better **Big-O efficiency** where performance is critical.
- **Logging**: Implement consistent logging to aid debugging/monitoring. Follow a defined logging format (e.g., JSON logging).

## 4. Environment Management

- **Package Management**: This project uses Conda for Python environment and package management.
- **Default Conda environment** Prefer the existing `digital_tmp_base`. Only create a new environment when package conflicts cannot be resolved; document the rationale in the PR.
- **Environment creation**: `conda env create -f digital_tmp_*_env.yml`; Poetry and standalone `pip` workflows are not permitted.
- **Specification File**: The environment is defined by `digital_tmp_base_env.yml` in the project root. This file is the source of truth for replicating the environment.
- **Updates to Environment**: Any environment change *must* update all `environment*.yml` / `conda-lock.yml` files, pass CI, and be committed to version control.

---
