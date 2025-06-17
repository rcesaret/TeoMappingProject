---
trigger: glob
globs: tests/*.py
---

# TESTING STANDARDS

## 1. General Policy
- All new or significantly modified public functions and methods within the `phases/*/src/` directories MUST have a corresponding unit test.
- The test suite should aim to maintain a minimum of 75% line coverage. You may be asked to add tests to increase coverage for a given module.
- All tests MUST be located in the `tests/` directory, mirroring the structure of the `src` directory they are testing.

## 2. Pytest Framework
- All tests MUST be written using the `pytest` framework.
- Test files MUST be named `test_*.py`.
- Test functions MUST be named `test_*`, clearly describing what they are testing (e.g., `test_calculate_metrics_returns_dataframe`).
- Use plain `assert` statements provided by pytest. Do not use `unittest.TestCase` assertions.

## 3. Test Structure and Patterns
- Structure tests using the Arrange-Act-Assert pattern, separated by newlines, for clarity.
- Use `pytest` fixtures (`@pytest.fixture`) to provide reusable setup and teardown logic, such as database connections or test dataframes.
- Use `pytest-mock` (and its `mocker` fixture) to patch external dependencies like API calls or database connections. Tests must be isolated and not rely on live services.
