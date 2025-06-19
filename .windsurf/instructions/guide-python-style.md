# Instructional Guide: Python Coding Guidelines and Protocols

## 1. Introduction

This document is the definitive and unified guide to Python coding standards and operational protocols for the Digital Teotihuacan Mapping Project (TMP). It integrates foundational software engineering principles, AI-specific workflows, and strict, project-specific coding standards into a single, cohesive framework. Adherence to these guidelines is mandatory to ensure all generated code is robust, readable, maintainable, secure, and strictly aligned with project conventions. It supplements the enforceable rules in `mode-python-scripting.md` with detailed explanations, canonical examples, and the rationale behind our standards. When a `plan` file includes this guide as context, the AI is expected to adhere to these patterns with high fidelity.

## 2. Core Philosophy & Guiding Principles

These core principles form the philosophical foundation for all coding tasks and must be applied universally.

-   **Readability:** Code is read far more often than it is written. It must be clean, simple, and immediately understandable to a developer unfamiliar with the original author's intent. We favor clarity over cleverness.
-   **Maintainability:** Code must be structured in a way that makes it easy to debug, refactor, and extend. This requires modularity, clear data flow, and adherence to established patterns.
-   **Reproducibility:** All code, especially data transformations, must produce the same results given the same inputs and environment. This requires explicit, deterministic, and well-documented logic.
-   **Simplicity First (KISS):** Always select the simplest viable solution. Avoid clever tricks or excessive abstraction that obscures intent. Follow the "Keep It Simple, Stupid" principle.
-   **DRY (Don't Repeat Yourself):** Abstract common logic into reusable functions, classes, or modules to avoid code duplication.
-   **Dependency Minimalism:** Do not introduce new libraries or frameworks without an explicit request or a compelling, well-documented justification.
-   **Test-Driven Thinking:** All code must be designed from its inception to be easily testable. This often involves favoring pure functions and utilizing dependency injection where appropriate.
-   **Explicit is Better than Implicit:** Be clear about intentions. Use meaningful variable names, comprehensive docstrings, and explicit type hints.

## 3. AI Agent Workflow & Protocols

This section outlines the mandatory operational procedures for the AI agent, from task intake to completion.

1.  **Context Integration & Validation:** Before any coding, perform a systematic context review:
    *   Scan all relevant project documentation (the "Memory Bank," e.g., `architecture.md`, `technical.md`) and the existing codebase to understand constraints, patterns, and integration points.
    *   Ensure proposals, code, and analysis are consistent with the documented project state. If inconsistencies arise or a deviation is necessary for the task, **you MUST explicitly highlight the deviation and justify it** based on task requirements.
2.  **Incremental Execution:** Follow the approved implementation plan for the task. For each step, perform a micro-cycle of:
    -   **a. Pre-Change Analysis:** Identify target files and verify the planned change against project architecture and standards.
    -   **b. Implement Change:** Write or modify code precisely as specified, applying all rules in this guide.
    -   **c. Mental Verification:** Mentally trace the execution of the new code to check for immediate side effects or logic breaks.
3.  **Documentation:** Add or update docstrings and comments as specified, focusing on explaining the "why" behind complex logic.

## 4. Environment, Tooling, and Formatting

These rules govern the development environment and code quality baseline and are non-negotiable.

### 4.1. Python Version

All code MUST be compatible with **Python 3.11 or newer**.

### 4.2. Package & Environment Management (Conda)

The project uses **Conda** for dependency management to ensure a consistent, reproducible computational environment.

-   **Primary Environment:** All work must be conducted within a dedicated project-specific Conda environment (e.g., `digital_tmp_base`). The use of other environments, including the `base` conda environment, is forbidden for project work to prevent dependency conflicts.
-   **Environment Definition:** A file named `environment.yml` (or a project-specific name like `digital_tmp_base_env.yml`) in the project root is the single source of truth for the environment specification. This file must be kept under version control.
-   **Version Pinning:** All dependencies in `environment.yml` MUST have their versions pinned to ensure reproducible analysis. The `--no-builds` flag should be used when exporting to avoid platform-specific build strings.
-   **Package Sources:** Always prefer packages from the `conda-forge` channel. Use `pip` only as a secondary option when a package is not available on `conda`, as this ensures maximum binary compatibility, especially for complex geospatial libraries.

#### Environment Lifecycle Workflow

-   **Creation:** New team members or workstations must create the environment from the definition file:
    ```bash
    conda env create -f environment.yml
    ```
-   **Activation:** Always activate the environment before starting any work:
    ```bash
    conda activate <your_env_name> # e.g., conda activate digital_tmp_base
    ```
-   **Updating Dependencies:** When adding a new dependency, follow this strict procedure:
    1.  Install the package into the active environment: `conda install -n <your_env_name> package_name`
    2.  Export the updated environment specification: `conda env export -n <your_env_name> --no-builds > environment.yml`
    3.  Commit the updated `environment.yml` file to version control.
    4.  Notify team members to update their local environments.

-   **Portability Testing:** Periodically test environment portability by creating a fresh environment from the `environment.yml` file on a clean system or different workstation to ensure reproducibility.
-   **Documentation:** Document any non-standard environment configurations or workstation-specific adaptations in project notes.

### 4.3. Code Formatting & Style
-   **Formatter:** All Python files MUST be formatted using the **`ruff`** formatter, configured for `black` compatibility.
-   **Line Length:** The maximum line length is strictly **88 characters**.
-   **Quotes:** Use double quotes (`"`) for strings. Single quotes (`'`) are acceptable for docstrings or within a string that already uses double quotes.

### 4.4. Pre-commit Hooks
Before a task is considered complete, the pre-commit hooks (`pre-commit run --all-files`) MUST be run and must pass without errors.

## 5. Code Structure and Organization

These rules define how code should be organized within files and across the project.

-   **Import Management:** Imports MUST be placed at the top of the file and sorted by `ruff`. They must be grouped in the following order:
    1.  Standard library imports
    2.  Third-party library imports
    3.  Local application imports
-   **Modularity & Single Responsibility:**
    *   Organize code into clearly separated modules, grouped by feature or responsibility (Single Responsibility Principle).
    *   A single file SHOULD NOT exceed 700 lines. If it approaches this limit, it MUST be refactored into smaller, more focused helper modules.
-   **Naming Conventions:**
    -   **`snake_case`:** For all variables, functions, methods, and module filenames.
    -   **`PascalCase`:** For all classes.
    -   **`UPPER_SNAKE_CASE`:** For global or module-level constants.
-   **Constants for Magic Values:** Do not use unnamed, hardcoded numbers or strings in logic. Define them as `UPPER_SNAKE_CASE` constants at the top of the module, accompanied by a comment explaining their purpose.
-   **Data Flow:** Ensure data flow is clear and explicit. Avoid using global state wherever possible to improve predictability and testability.
-   **Encapsulation:** Hide internal complexity behind well-defined, clear public interfaces or modules.

## 6. Documentation, Type Hinting, and Clarity

Code must be self-documenting and immediately understandable.

### 6.1. Docstrings (Google Style)

All public modules, classes, and functions require a comprehensive Google-style docstring. This is essential for documentation generation and maintainability.

- **Canonical Function Example:**
  ```python
  from typing import Optional

  class DatabaseError(Exception):
      """Custom exception for database connection errors."""
      pass

  def connect_to_database(
      host: str,
      port: int,
      username: str,
      password: str,
      dbname: str,
      ssl_mode: Optional[str] = "require"
  ) -> "psycopg2.connection":
      """Establishes a secure connection to the PostgreSQL database.

      This function attempts to connect to the specified PostgreSQL database
      using the provided credentials. It handles exceptions and
      ensures that a secure connection is attempted by default.

      Args:
          host: The database server host address.
          port: The port number for the database server.
          username: The username for authentication.
          password: The password for authentication.
          dbname: The name of the database to connect to.
          ssl_mode: The SSL connection mode. Defaults to "require".
              Valid options include "disable", "allow", "prefer", "require",
              "verify-ca", or "verify-full".

      Returns:
          A psycopg2 database connection object on success.

      Raises:
          ValueError: If the provided port number is outside the valid range.
          DatabaseError: If the connection to the database fails for any
              reason, wrapping the original exception.
      """
      if not 0 < port < 65536:
          raise ValueError("Invalid port number specified.")
      try:
          # ... connection logic using psycopg2 or sqlalchemy ...
          pass
      except Exception as e:
          # logging.error(f"Database connection failed: {e}")
          raise DatabaseError(f"Failed to connect to database: {e}")
  ```

#### 6.1.1. Documenting Class Attributes

When documenting a class, the docstring should immediately follow the class definition and include an `Attributes` section to describe public properties.

- **Canonical Class Example:**
  ```python
  from pathlib import Path

  class DataProcessor:
      """Processes raw data files from a source directory.

      This class encapsulates the logic for reading, cleaning, and
      validating data from source files before loading into the database.

      Attributes:
          source_directory (Path): A pathlib.Path object pointing to the
              directory containing raw data files.
          processed_count (int): A counter for the number of records
              successfully processed.
          logger (logging.Logger): The logger instance for this class.
      """
      def __init__(self, source_dir: str):
          """Initializes the DataProcessor.

          Args:
              source_dir: The path to the source data directory.
          """
          self.source_directory = Path(source_dir)
          self.processed_count = 0
          self.logger = logging.getLogger(__name__)

      def run_pipeline(self):
          # ...
  ```

### 6.2. Type Hinting

All functions and methods must be fully type-hinted. This practice is mandatory for improving code clarity, enabling static analysis with tools like `mypy`, and providing better IDE support.

- **Basic Types:**
  - `my_var: str = "hello"`
  - `item_count: int = 0`
  - `is_complete: bool = False`
- **Complex Types (from `typing` module):**
  - `List[str]`: A list of strings.
  - `Dict[str, int]`: A dictionary with string keys and integer values.
  - `Tuple[str, int, bool]`: A tuple with a fixed number of elements of specific types.
  - `Optional[str]`: A value that can be a `str` or `None`. This is equivalent to `Union[str, None]`.
  - `Union[str, int]`: A value that can be one of several types, in this case, `str` or `int`.
  - `Callable[[int, str], bool]`: A function (or other callable) that takes an `int` and a `str` as arguments and returns a `bool`.
- **DataFrames and GeoDataFrames:** To avoid circular import issues and to keep type checking efficient, use string forward references for complex types like DataFrames.
  ```python
  import pandas as pd
  import geopandas as gpd
  from typing import TYPE_CHECKING

  if TYPE_CHECKING:
      # This block is only seen by type checkers, not at runtime
      from geopandas import GeoDataFrame
      from pandas import DataFrame

  def process_data(df: "DataFrame") -> "GeoDataFrame":
      # function logic
  ```

#### 6.2.1 TypeAlias for Readability

For complex or frequently used type signatures, you MUST use `TypeAlias` to create a custom type definition. This dramatically improves readability and maintainability.

- **Example:**
  ```python
  from typing import Dict, Any, List, TypeAlias

  # Define a reusable type for JSON-like objects used across the app
  JsonDict: TypeAlias = Dict[str, Any]
  # Define a type for a list of user records, which are JSON-like
  UserRecords: TypeAlias = List[JsonDict]

  def process_users(users: UserRecords) -> int:
      """Processes a list of user records."""
      for user in users:
          print(user["username"])
      return len(users)
  ```

### 6.3. Rationale Comments

For complex, non-obvious, or highly optimized algorithms, you MUST add an inline comment block starting with `# REASON:` to explain the rationale behind the implementation choice (the "why," not just the "what").

## 7. Function and Class Design

These principles guide the design of robust and maintainable functions and classes.

-   **Function Design:**
    -   **Length:** Functions should be focused and SHOULD NOT exceed 50 lines of code.
    -   **Nesting:** Minimize deep nesting of conditional blocks (max 2 levels). Refactor nested logic into separate, clearly named functions.
    -   **Purity:** Favor pure functions (those with no side effects) where possible to simplify logic and improve testability.
    -   **Keyword-Only Arguments:** For functions with more than two arguments, particularly if they are of the same type, you MUST make subsequent arguments keyword-only by using `*` in the signature to improve clarity and prevent calling errors.
-   **Class Design:**
    -   **Data-Only Structures:** For structures that primarily hold data (e.g., DTOs, configuration objects), you MUST use Python's `@dataclass` decorator. Avoid writing custom `__init__` methods for these simple data containers.
    -   **Cohesion:** Classes should have a small, cohesive set of public methods (ideally fewer than 7) that operate on the class's state.
    -   **Composition Over Inheritance:** Prefer composition over inheritance as a general design principle to create more flexible and loosely coupled systems.

## 8. Python Idioms and Best Practices

These rules leverage Python's features for efficient, safe, and idiomatic code.

-   **Efficiency and Performance:**
    -   **Idiomatic Code:** Use list comprehensions, generator expressions, and dictionary comprehensions over manual `for` loops where appropriate.
    -   **Algorithmic Complexity:** Always consider the algorithmic (Big-O) efficiency of your implementation.
    - **Generators (`yield`):** For functions that produce a large sequence of results (e.g., reading a multi-gigabyte file line by line), you MUST use `yield` to return a generator. This processes one item at a time, which is critical for memory efficiency in data-intensive applications.
		- **Good for large files:**
			```python
			from typing import Generator

			def read_large_log_file(file_path: str) -> Generator[str, None, None]:
				"""Reads a large file line by line, yielding each line."""
				with open(file_path, "r", encoding="utf-8") as f:
					for line in f:
						yield line.strip()
			```
    -   **Profiling:** Use profiling tools to identify performance bottlenecks accurately before optimizing. Focus optimizations on identified bottlenecks, not premature micro-optimizations.
	- **List Comprehensions:** Prefer list comprehensions for creating lists from other iterables when the logic is simple and readable.
		- **Good:** `squares = [x*x for x in my_list if x > 0]`
		- **Use a `for` loop when:** The logic is too complex for a single line, involves multiple `if`/`else` conditions, or requires side effects.
-   **Resource Management:**
	- **Context Managers (`with`):** Always use the `with` statement for resources that need guaranteed setup and teardown, such as files or database connections. This ensures resources are closed even if errors occur.
		- **Good:**
			```python
			with open("data.txt", "r", encoding="utf-8") as f:
				content = f.read()
			# f is automatically closed here
			```
	-   **`with` Statements:** You MUST use `with` statements (context managers) for managing external resources like file handles and database connections to guarantee they are properly closed.
    -   **Custom Context Managers:** For any function that sets up and tears down a resource or context, you MUST implement it as a context manager, preferably using the `@contextmanager` decorator from the `contextlib` module.
-   **Error Handling:**
    *   Implement specific `try...except` blocks for operations that can fail (e.g., file I/O, API calls).
    *   Catch specific exceptions (e.g., `ValueError`, `FileNotFoundError`) rather than the generic `Exception`.
-   **Logging:** Implement consistent, structured logging using the `logging` module for all diagnostic output. Do not use `print()` for logging purposes in application code.
-	**Decorators for Cross-Cutting Concerns:** Decorators are a powerful tool for separating concerns like logging, timing, caching, or authentication from your core business logic. You should use decorators to keep your functions clean and focused on their primary responsibility.
	- **Example: A Timing Decorator**
	  ```python
	  import time
	  import logging
	  from functools import wraps

	  def timing_decorator(func):
		  """A decorator that logs the execution time of a function."""
		  @wraps(func) # Preserves original function metadata
		  def wrapper(*args, **kwargs):
			  logger = logging.getLogger(func.__module__)
			  start_time = time.perf_counter()
			  result = func(*args, **kwargs)
			  end_time = time.perf_counter()
			  run_time = end_time - start_time
			  logger.info(f"Function {func.__name__!r} finished in {run_time:.4f} seconds.")
			  return result
		  return wrapper

	  @timing_decorator
	  def process_large_dataset(dataset_path):
		  """Example function that performs a time-consuming task."""
		  # ... logic to process the dataset ...
	  ```

## 9. Data Handling and Library-Specific Protocols

These are mandatory protocols for interacting with common data sources and libraries.

-   **File Path Handling (`pathlib`):** All file system paths MUST be handled using `pathlib.Path` objects to ensure cross-platform compatibility. String-based path manipulation is strictly forbidden.
    ```python
    from pathlib import Path
    # Assume PROJECT_ROOT is a Path object pointing to the repo root
    PROJECT_ROOT = Path(__file__).resolve().parent.parent
    data_path = PROJECT_ROOT / "data" / "raw" / "file.csv"
    ```
-   **Database Interaction (`sqlalchemy`):** You MUST use `sqlalchemy` and its Core Expression Language for all PostgreSQL interactions. Constructing raw SQL strings via f-strings or `%`-formatting is strictly forbidden to prevent SQL injection.
    ```python
    from sqlalchemy import text

    # INCORRECT, VULNERABLE:
    # query_string = f"SELECT * FROM users WHERE id = {user_id}"

    # CORRECT, SAFE:
    query = text("SELECT * FROM users WHERE id = :user_id")
    result = db_connection.execute(query, {"user_id": user_id})
    ```
-   **Defensive Coding & Validation (`pydantic`):**
    *   You MUST use `pydantic` for data validation tasks, especially for data received from external or untrusted sources.
    *   Use assertions (`assert`) to check for internal state validity and program invariants during development.
-   **Data Manipulation (`pandas`, `geopandas`):**
    *   Prefer `pandas` for tabular data and `geopandas` for vector geospatial data.
    *   Prefer vectorized operations and method chaining over explicit loops for performance and readability.
    *   When reading legacy CSV files known to have potential encoding issues, you MUST explicitly set `encoding='latin1'` in the `pd.read_csv()` call.
    *   All `geopandas.GeoDataFrame` objects MUST have their Coordinate Reference System (CRS) set immediately upon creation.
-   **Data Visualization (`matplotlib`, `seaborn`):**
    *   Use `matplotlib` for low-level plotting control and `seaborn` for statistical visualizations.
    *   Create informative plots with proper labels, titles, and legends.
    *   Consider accessibility, such as using color-blind-friendly palettes.

## 10. Forbidden Patterns

The following patterns are strictly prohibited.

-   **Mutable Default Arguments:** Do not use mutable types (e.g., a `list` or `dict`) as default values for function arguments.
    -   **Incorrect:** `def my_func(items: list = []): ...`
    -   **Correct:** `def my_func(items: list | None = None): if items is None: items = [] ...`
-   **Unsafe SQL String Formatting:** As detailed in section 9, never use f-strings or other string formatting to build SQL queries. Always use parameterized queries.
-   **String-Based Path Manipulation:** As detailed in section 9, always use `pathlib`.
-   **Hardcoded Secrets:** Never hardcode API keys, database credentials, or other secrets. They must be managed as environment variables and loaded securely (e.g., from a `.env` file). The `.env` file itself MUST NEVER be committed to version control. A corresponding `.env.example` file with placeholder values MUST be maintained and committed to the repository to document required variables.
-   **Generic Exceptions:** Avoid catching the generic `Exception` unless it is immediately re-raised or handled in a top-level application entry point. Catch specific exceptions instead.
-   **`print()` for Logging:** Do not use `print()` for logging or debugging output in application code. Use the `logging` module.

## 11. Logging Configuration and Strategy

A consistent logging strategy is essential for debugging and monitoring a complex application. All modules should use a centrally configured logger.

- **Central Configuration:** Logging should be configured once at the application's entry point (e.g., in a `config.py` or `main.py`).
  ```python
  import logging
  import sys

  logging.basicConfig(
      level=logging.INFO,
      format="%(asctime)s [%(levelname)s] %(name)s: %(message)s",
      datefmt="%Y-%m-%d %H:%M:%S",
      handlers=[
          logging.FileHandler("digital_tmp.log"),
          logging.StreamHandler(sys.stdout) # Also log to console
      ]
  )
  ```
- **Usage in Modules:** In any other module, retrieve the logger instance by name. Do not re-configure it.
  ```python
  import logging
  logger = logging.getLogger(__name__)

  def some_function():
      logger.info("Starting some function.")
      try:
          # ...
      except Exception as e:
          logger.error(f"An error occurred: {e}", exc_info=True)
  ```
- **Log Levels:**
  - `DEBUG`: Detailed information, typically of interest only when diagnosing problems.
  - `INFO`: Confirmation that things are working as expected.
  - `WARNING`: An indication that something unexpected happened, but the software is still working as expected.
  - `ERROR`: Due to a more serious problem, the software has not been able to perform some function.
  - `CRITICAL`: A serious error, indicating that the program itself may be unable to continue running.

## 12. Class and Object-Oriented Design (OOD) Principles

While many data science tasks can be accomplished with functions, using classes is essential for encapsulating state and related behavior.

- **When to Use a Class:** Use a class when you have data (state) and a set of functions (behavior) that logically belong together. A `DataProcessor` class is a good example; it might hold state like file paths and offer methods like `.read()`, `.clean()`, and `.write()`.
- **Public vs. Private Members:** Python does not have true private members. By convention, attributes and methods prefixed with a single underscore (e.g., `self._internal_data`) are treated as non-public and should not be accessed directly from outside the class.
- **Properties for Controlled Access:** Use the `@property` decorator to expose class attributes as if they were public properties, while allowing for validation or computation in the background.
  ```python
  class Report:
      def __init__(self, data: list):
          self._data = data

      @property
      def row_count(self) -> int:
          """Returns the number of rows in the report's data."""
          return len(self._data)
  ```
- **Single Responsibility Principle (SRP):** A class should have only one reason to change. For this project, a class that reads a legacy database file should not also be responsible for transforming it into a GeoDataFrame. Those should be two separate classes (`LegacyDBReader`, `DataTransformer`).

---
