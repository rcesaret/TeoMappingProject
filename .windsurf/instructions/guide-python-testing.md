# Python Testing Guidelines & Protocols

## 1. Core Testing Philosophy

The primary goal of testing in the Digital TMP project is to **guarantee the correctness and reproducibility of the data transformation pipeline**. Every test should be seen as a verifiable, executable assertion about the data's integrity at a specific stage of its lifecycle.

Our testing is guided by these principles:

-   **Focus on Data Integrity:** The highest priority is verifying that data transformations, cleaning, and feature engineering are correct. A test that validates a complex data rule is more valuable than one that checks trivial code paths.
-   **Tests are Specifications:** Tests are not an afterthought; they are a living, executable specification of what the data pipeline is supposed to do.
-   **Risk-Oriented:** Testing effort must be focused on the areas of highest risk, namely: legacy data cleaning, geospatial transformations (especially CRS), and the integration points between phases.
-   **Testable Code:** All code must be designed to be testable. Functions should be pure where possible, and external resources should be handled via dependency injection to facilitate mocking.
-   **Clarity and Intent:** A test must be easy to read and its purpose must be immediately obvious. A future researcher (or AI) must understand *what* is being tested and *why*. Avoiding DRY (Don't Repeat Yourself) is acceptable if it makes a test clearer or less brittle.

## 2. Test Generation Protocol

For every new feature (function, class, method), a corresponding test suite **MUST** be generated. Each test suite **MUST** provide comprehensive coverage by testing three categories of scenarios:

1.  **SUCCESS CASES:** The expected use or "happy path" with typical inputs.
2.  **FAILURE CASES:** At least one common failure scenario to verify robust error handling (e.g., invalid input raising `ValueError`, file not found raising `FileNotFoundError`).
3.  **EDGE CASES:** At least one significant edge case (e.g., empty lists, zero values, `None` inputs, boundary conditions).

## 3. Test Structure and Location

-   **Location:** All test files **MUST** reside in the `tests/` directory.
-   **Mirroring Structure:** The `/tests` directory structure **MUST** mirror the `/phases` source directory structure. For a function in `phases/01_LegacyDB/src/profiling_modules/metrics_basic.py`, the corresponding test file **MUST** be `tests/01_LegacyDB/src/profiling_modules/test_metrics_basic.py`.

## 4. The Testing Pyramid in the TMP Context

We will categorize tests to ensure we have a healthy and maintainable test suite. The AI agent must be able to distinguish between these types.

-   **Unit Tests (Primary Focus):**
    -   **Definition:** A test that verifies a single function or method in isolation.
    -   **Characteristics:** Fast, has no external dependencies (e.g., no database, no filesystem, no network). All external interactions **MUST** be mocked.
    -   **Example:** Testing a function that parses a string from a `DF8` field into a standardized format.

-   **Integration Tests:**
    -   **Definition:** A test that verifies the interaction between components. For this project, this almost always means **testing code that interacts with the PostgreSQL/PostGIS database**.
    -   **Characteristics:** Slower than unit tests. Requires a running Docker container with the test database. These tests **MUST** be explicitly marked.
    -   **Example:** Testing a script from Phase 5 that performs a spatial join and calculates derived density attributes within the database.

-   **Pipeline (E2E) Tests:**
    -   **Definition:** A test that runs an entire phase's main script (e.g., `phases/01_LegacyDB/src/00_setup_databases.py`) and checks for the expected final side effects (e.g., the correct databases were created, the output files exist).
    -   **Characteristics:** Slowest of all. Used sparingly to validate major workflow steps.

-   **Explicitly Excluded Testing Types:**
    -   **Performance Testing:** While important for the final API (Phase 8), this is a separate activity and is not part of the unit/integration test suite.
    -   **Mutation Testing:** Considered out of scope for the current project lifecycle.
    -   **Contract Testing:** Not applicable to the project's architecture.

## 5. General Rules and Naming Conventions

1.  **Framework:** All tests **MUST** be written using the `pytest` framework.
2.  **File and Function Naming:** Test filenames **MUST** be prefixed with `test_`. Test function names inside the file **MUST** also be prefixed with `test_`.
3.  **Descriptive Naming:** Test function names must be descriptive of the behavior they are testing. The `test_when_condition_then_behavior` pattern is required (e.g., `test_when_invalid_crs_then_raises_exception`).
4.  **Structure (Arrange, Act, Assert):** Every test function **MUST** follow the Arrange-Act-Assert pattern for clarity.
    ```python
    def test_some_feature():
        # 1. ARRANGE: Set up the test data and mocks.
        input_data = ...
        expected_output = ...

        # 2. ACT: Call the function or method being tested.
        actual_output = my_module.my_function(input_data)

        # 3. ASSERT: Check that the result is what you expected.
        assert actual_output == expected_output
    ```
5.  **Assertions:** Use plain `assert` statements provided by `pytest`. Do not use `unittest.TestCase` assertions.
6.  **Isolation:** Tests **MUST** be completely independent. The success or failure of one test shall not affect another.
7.  **Documentation:** Every test function **MUST** have a docstring explaining its purpose in one sentence. Example: `"""Verify that the clean_site_id function correctly handles leading zeros."""`


## 6. Unit Testing: Patterns and Rules

### 6.1 Mocking External Dependencies

All external dependencies in unit tests **MUST** be mocked using `pytest-mock` (which provides the `mocker` fixture) to isolate the unit under test.

-   **No Live Calls:** Unit tests **MUST NOT** make live network, database, or filesystem calls. This is a critical rule for test stability and speed.
-   **Implementation:** Use `mocker.patch()` as a decorator or context manager to replace the external dependency with a mock object.
-   **Verification:** Your test **MUST** assert that the mock was called with the expected arguments (e.g., `mock_db_connection.execute.assert_called_with(...)`).
-   **Mock Database Connections:** Any function that would connect to PostgreSQL **MUST** have the database connector (`psycopg2`, `sqlalchemy`) mocked.
-   **Mock Filesystem Access:** Any function that reads from or writes to the filesystem (`open()`, `pandas.read_csv`, `geopandas.to_file`) **MUST** be mocked. Use `mocker.patch` to control the data returned or verify the data written.

### 6.2 Parametrization for Multiple Cases

For functions that can be tested with multiple distinct input/output pairs, you **MUST** use the `@pytest.mark.parametrize` decorator. This is the required method for testing variations.

**Example Parametrized Test:**
```python
import pytest
from my_project.phases.02_TransformDB.src.cleaning import clean_numeric_field

@pytest.mark.parametrize(
    "input_value, expected_output",
    [
        ("123", 123),      # Success case: standard string
        (" 123 ", 123),     # Edge case: whitespace
        (None, None),      # Edge case: None input
        ("abc", None),     # Failure case: non-numeric string
    ]
)
def test_clean_numeric_field(input_value, expected_output):
    """Verify clean_numeric_field handles various inputs correctly."""
    assert clean_numeric_field(input_value) == expected_output
```

### 6.3 Reusable Setups with Pytest Fixtures

For setting up reusable test objects, states, or resources, you **MUST** use `pytest` fixtures.

-   **Definition:** Define fixtures using the `@pytest.fixture` decorator.
-   **Location:** Fixtures should preferably be defined in a central `conftest.py` file within the relevant test directory (e.g., `tests/02_TransformDB/conftest.py`).

**Example Fixture (`conftest.py`):**
```python
import pytest
import pandas as pd

@pytest.fixture
def sample_df10_data() -> pd.DataFrame:
    """Returns a sample DataFrame mimicking the structure of a raw DF10 table."""
    data = {
        'ssn': [1001, 1002, 1003],
        'architectural_style': ['Classic ', ' Terminal', 'Early Classic'],
        'notes': ['note 1', 'note 2', None]
    }
    return pd.DataFrame(data)
```

## 7. Project-Specific Testing: Data and Geospatial

### 7.1 Testing Tabular and Geospatial DataFrames

-   When testing functions that return a `pandas.DataFrame` or `geopandas.GeoDataFrame`, you **MUST** use the `pandas.testing.assert_frame_equal` or `geopandas.testing.assert_geodataframe_equal` functions, respectively. Do not use a simple `==` check.

### 7.2 Testing Legacy and Spatial Data

-   **Legacy Data Issues:** Tests **MUST** include cases for known data quality issues specific to the archaeological dataset (e.g., the "Total Counts Problem," inconsistent encodings, ambiguous "gray variables").
-   **Spatial Functions:** For spatial functions, tests **MUST** validate geometry validity (`is_valid`) and key spatial relationships (e.g., containment, intersection, area calculations).
-   **Coordinate Transformations:** For functions handling coordinate transformations, include specific tests that validate transformation accuracy using known control points.

## 8. Property-Based Testing with Hypothesis

For functions that implement a clear rule or transformation, property-based tests **SHOULD** be used to supplement example-based tests. This is especially valuable for data cleaning and validation functions.

-   **Use Case:** Ideal for testing functions that handle the messy, unpredictable data from legacy sources.
-   **Implementation:** Use the `@given` decorator from the `hypothesis` library with appropriate `hypothesis.strategies`.
-   **Shrinking:** Rely on Hypothesis's ability to "shrink" a failing example to the simplest possible case to aid in debugging.

**Example Property-Based Test:**
```python
from hypothesis import given, assume
import hypothesis.strategies as st
from my_project.phases.02_TransformDB.src.cleaning import normalize_text_field

@given(text=st.text())
def test_property_normalized_text_is_idempotent(text):
    """Property: Applying normalization twice has the same result as applying it once."""
    normalized_once = normalize_text_field(text)
    normalized_twice = normalize_text_field(normalized_once)
    assert normalized_once == normalized_twice

@given(text=st.text())
def test_property_normalized_text_has_no_leading_trailing_whitespace(text):
    """Property: A normalized field never has leading or trailing whitespace."""
    # We can't test this on an empty string, so we discard that case.
    assume(len(text.strip()) > 0)
    normalized = normalize_text_field(text)
    assert normalized == normalized.strip()
```

## 9. Integration Testing Rules

Integration tests are critical for verifying database interactions but must be handled carefully.

1.  **Marking:** All integration tests **MUST** be decorated with `@pytest.mark.integration`. This allows them to be run separately from the fast unit tests (e.g., `pytest -m "not integration"`).
2.  **Database Connection:** Integration tests are **ALLOWED** to connect to the test database running in Docker. They should use a dedicated set of test credentials.
3.  **Transactional Tests:** Each integration test **MUST** run inside a transaction that is rolled back at the end of the test. This ensures that tests do not interfere with each other. A `pytest` fixture can be created in a root `conftest.py` to manage this automatically.

**Example Integration Test:**
```python
import pytest
import sqlalchemy

# This test assumes a fixture 'db_session' is defined in conftest.py
# that provides a transactional database session.

@pytest.mark.integration
def test_spatial_join_creates_correct_number_of_records(db_session):
    """Verify that the spatial join script correctly links all records."""
    # ARRANGE: Ensure the source tables are populated (or populate them).
    # This might be done in the fixture itself.

    # ACT: Run the actual integration script from the project.
    from my_project.phases.05_GeoIntegration.src.run_integration import perform_spatial_join
    perform_spatial_join(db_session)

    # ASSERT: Query the database to check the result.
    result = db_session.execute(sqlalchemy.text("SELECT COUNT(*) FROM integrated_table;")).scalar_one()
    expected_count = 5046 # From project documentation
    assert result == expected_count
```

## 10. Test Execution and Quality Gates

1.  **Execution:** Generate commands to run tests using the `pytest` command. Target specific files or directories to limit scope and speed up execution (e.g., `pytest tests/01_LegacyDB/`).
2.  **Interpretation:** Clearly interpret `pytest` output, distinguishing between passed (`.`), failed (`F`), and errored (`E`) tests. If tests fail, the full `pytest` report **MUST** be presented.
3.  **Coverage:** After running tests, use `pytest-cov` to generate a coverage report. Any new or significantly modified module with a test coverage below **80%** **MUST** be flagged for improvement.

---
