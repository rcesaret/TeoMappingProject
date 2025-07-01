---
trigger: manual
---

# PYTHON SCRIPTING

## CORE STANDARDS & FORMATTING
- You MUST ALWAYS review and implement the guidelines & protocols from `.windsurf/instructions/guide-python-style.md`, which is the PRIMARY SOURCE OF TRUTH for all python coding tasks.
- All code MUST be compatible with Python 3.11+.
- All code MUST strictly adhere to PEP 8.
- All Python files MUST be formatted using the `ruff` formatter. The maximum line length is 88 characters.
- All code must pass `ruff` checks without errors.
- Imports MUST be at the top of the file, grouped into standard library, third-party, and local application imports, sorted alphabetically by `ruff`.

## NAMING & STRUCTURE
- `snake_case` for all variables, functions, and methods.
- `PascalCase` for all class names.
- `UPPER_SNAKE_CASE` for global constants.
- Organize code into clearly separated modules, grouped by feature or responsibility. A file should not exceed 600 lines; refactor into smaller helper modules if it approaches this limit.
- All file paths MUST be handled using `pathlib.Path` objects to ensure cross-platform compatibility. String-based path manipulation is forbidden.

## DOCUMENTATION & TYPE HINTING
- All function and method definitions MUST include type hints for all parameters and their return types. Use the `typing` module (`Optional`, `Union`, `List`, `Dict`, `Callable`, `Any`) for precision.
- All public modules, functions, classes, and methods MUST have a comprehensive Google-style docstring. The docstring must accurately reflect the current parameters and return types.
- For complex or non-obvious algorithms, you MUST add an inline comment block starting with `# REASON:` to explain the rationale behind the implementation choice.

## LANGUAGE IDIOMS & BEST PRACTICES
- Prioritize idiomatic Python for readability and performance. Use list comprehensions, generator expressions, and dictionary comprehensions over manual loops where appropriate.
- Implement `try...except` blocks for operations that can fail (e.g., file I/O, API calls, database connections). Raise specific, meaningful exceptions (e.g., `ValueError`, `TypeError`) rather than generic `Exception`.
- Implement input validation for functions that receive external data. Use assertions (`assert`) to check for internal state validity and program invariants during development.
- You MUST use `with` statements for managing external resources like file handles and database connections to guarantee they are properly closed, even if errors occur.
- Implement consistent, structured logging using the `logging` module to aid in debugging and monitoring. Do not use `print()` for logging.

## DATA-SPECIFIC LIBRARY USAGE
- You MUST prefer `pandas` and `geopandas` for all tabular and vector geospatial data manipulation tasks.
- When reading legacy CSV files known to have potential encoding issues (as documented in `data_sources.md`), you MUST explicitly set `encoding='latin1'` in the `pd.read_csv` call.
- You MUST use `sqlalchemy` and its Core Expression Language for all PostgreSQL interactions. Do not construct raw SQL strings.
- For structures that primarily hold data (e.g., DTOs, configuration objects), you MUST use Python's `@dataclass` decorator. Avoid creating custom `__init__` methods for simple data containers.
- When a function needs to return a large sequence of items, you MUST use a generator (with `yield`) instead of creating the entire sequence in memory at once.

## FORBIDDEN PATTERNS
- All file system paths must be `pathlib.Path` objects.
- Do not use f-strings or `%` formatting to inject variables into SQL queries. Use SQLAlchemy's parameterized query constructs.
- Do not use unnamed, hardcoded numbers or strings in logic. Define them as `UPPER_SNAKE_CASE` constants at the top of the module with a comment explaining their purpose.
- Do not use mutable types (e.g., `list`, `dict`) as default values for function arguments. Use `None` as the default and initialize the mutable type inside the function.

## ARCHAEOLOGICAL DATA HANDLING
- For functions handling collection unit IDs (SSN), always validate against the expected range and format before processing.
- Validate and document the CRS for all coordinate data.
- Include specific validation for known TMP data quality issues with clear error reporting.

## ADVANCED PATTERNS
- For functions with >2-3 args, use keyword-only arguments (`*`).
- For any function that sets up and tears down a resource or context (e.g., a temporary file, a database transaction), you MUST implement it as a context manager using the `@contextmanager` decorator from `contextlib`.
- Classes should be designed with minimal public methods (< 5-7). Methods should be cohesive and operate on the class's state. Prefer composition over inheritance where possible.
