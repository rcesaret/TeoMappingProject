---
trigger: manual
---

# PYTHON TESTING

## TEST GENERATION PROTOCOL
- For every new feature (function, class, API route), you MUST generate a corresponding test suite.
- Each test suite MUST provide comprehensive coverage by testing three categories of scenarios:
  1. **SUCCESS CASES:** The expected use or "happy path" with typical inputs.
  2. **FAILURE CASES:** At least one common failure scenario to verify robust error handling (e.g., invalid input raising `ValueError`, file not found raising `FileNotFoundError`).
  3. **EDGE CASES:** At least one significant edge case (e.g., empty lists, zero values, `None` inputs, boundary conditions for numerical algorithms).

## TEST STRUCTURE & LOCATION
- All test files MUST be located in the `/tests` directory.
- The `/tests` directory structure MUST mirror the `/phases` source directory structure. For a function in `phases/01_LegacyDB/src/profiling_modules/metrics_basic.py`, the corresponding test file MUST be `tests/01_LegacyDB/src/profiling_modules/test_metrics_basic.py`.
- Test filenames MUST be prefixed with `test_`. Test function names inside the file MUST also be prefixed with `test_`.

## ADVANCED TESTING PATTERNS
- For functions that can be tested with multiple distinct input/output pairs, you MUST use the `@pytest.mark.parametrize` decorator. This is the required method for testing variations, as it is more concise and scalable than writing separate test functions for each case.
- For functions with external dependencies (e.g., database connections, API calls, file system access), you MUST use the `unittest.mock` library, specifically `patch` and `MagicMock`, to isolate the unit under test.
- Use `patch` as a decorator or context manager to replace the external dependency with a `MagicMock` object.
- Your test MUST assert that the mock was called with the expected arguments (e.g., `mock_db_connection.execute.assert_called_with(...)`).
- Tests MUST NOT make live network or database calls. This is a critical rule for test stability and speed.
- For setting up reusable test objects, states, or resources (like a temporary database, a test file on disk, or a complex data structure), you MUST use `pytest` fixtures. Define fixtures using the `@pytest.fixture` decorator, preferably in a central `conftest.py` file within the relevant test directory.

## TEST EXECUTION & VALIDATION
- Generate commands to run tests using the `pytest` command.
- When running tests for a specific file or feature, target that file or directory directly to limit scope and speed up execution (e.g., `pytest tests/path/to/test_file.py`).
- Interpret `pytest` output clearly, distinguishing between passed (`.`), failed (`F`), and errored (`E`) tests. If tests fail or error, you MUST present the full `pytest` report, including the error summary.

## PROJECT DATA TESTING REQUIREMENTS
- Integration tests that require a live database MUST use a dedicated test database (not production). Use `pytest` fixtures to manage the connection and ensure transaction rollback after each test to maintain a clean state.
- After running tests, you must use `pytest-cov` to generate a coverage report. You must flag any new module with a test coverage below 80%.
- When testing functions that return a `pandas.DataFrame` or `geopandas.GeoDataFrame`, you MUST use the `pandas.testing.assert_frame_equal` or `geopandas.testing.assert_geodataframe_equal` functions for comparison, not a simple `==` check.
- For functions that operate on a wide range of numerical or string inputs (e.g., parsers, validators), you MUST propose using the `hypothesis` library to generate property-based tests in addition to example-based tests.

## TEST NAMING & ORGANIZATION
- Test function names must be descriptive of the behavior they are testing. Use the `test_when_condition_then_behavior` pattern (e.g., `test_when_invalid_crs_then_raises_exception`).
- For functions handling coordinate transformations, include specific tests that validate transformation accuracy using known control points.
- When testing functions that process TMP legacy data, include tests for known data quality issues and edge cases specific to the archaeological dataset.
- For spatial functions, include tests that validate geometry validity and spatial relationships (e.g., containment, intersection).

## QUALITY ASSURANCE INTEGRATION
- All code must be testable. Design functions to be pure where possible and use dependency injection for external resources.
- After updating any logic, check whether existing unit tests need updates and perform them.
- Ensure all external service calls (databases, APIs) are mocked in tests to prevent flaky test failures due to network issues.
- For tests only, avoiding DRY (Don't Repeat Yourself) might be preferable if it improves clarity or makes tests less brittle.
