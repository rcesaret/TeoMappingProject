---
trigger: manual
---

# BASE

## PROBLEM-SOLVING PROTOCOL
- Deconstruct requests into core objectives, constraints, and success criteria. State understanding explicitly before proceeding.
- For ambiguous requests, ask specific clarifying questions rather than assumptions. Identify missing information.
- Propose high-level action sequences. For tasks requiring >4 distinct steps, recommend formal planning with specialized modes.
- Prioritize simplest effective solutions. Avoid unnecessary abstractions unless explicitly requested.
- Consider computational complexity and resource requirements for data-intensive operations.

## PYTHON DATA SCIENCE STANDARDS
- Use Python 3.11+ with strict PEP 8 compliance. Format with `ruff` (88-char limit). All code must pass linting.
- **Required Libraries**: `pandas`/`numpy` for data; `pathlib` for paths; `logging` for output; `typing` for hints; `pytest` for testing.
- **Type Hints**: All functions MUST include parameter and return type annotations using `typing` module.
- **Error Handling**: Use specific exceptions (`ValueError`, `FileNotFoundError`, `TypeError`). Implement `try-except` for I/O, API calls, database operations.
- **Resource Management**: Use `with` statements for files, database connections, external resources. Ensure proper cleanup.
- **Constants**: Define as `UPPER_SNAKE_CASE` at module top with explanatory comments. No magic numbers in logic.
- **Functions**: Use pure functions where possible. Implement defensive programming with input validation.

## DATA WORKFLOW BEST PRACTICES
- **Reproducibility**: Set random seeds (`np.random.seed`, `random.seed`). Document all parameters. Log transformation steps with timestamps.
- **Path Handling**: Use `pathlib.Path` exclusively. Never hardcode absolute paths. Use relative paths from project root.
- **Coordinate Systems**: Always validate and document CRS for geospatial data. Use authority codes (EPSG). Verify transformations.
- **Data Quality**: Check duplicates, outliers, missing values. Document cleaning decisions. Implement automated quality checks.

## PROJECT ORGANIZATION & STRUCTURE
- **File Structure**: Mirror source structure in tests (`src/module.py` → `tests/test_module.py`). Use descriptive, lowercase-kebab-case filenames.
- **Imports**: Group by standard library, third-party, local. Sort alphabetically within groups. Use absolute imports for project modules.
- **Documentation**: Google-style docstrings for all public functions. Update README for new features/dependencies. Maintain changelog.
- **Configuration**: Use environment variables via `.env` files. Reference `.env.example`. Never hardcode secrets or API keys.
- **Notebooks**: Use for exploration only. Convert finalized analysis to scripts. Clear output before committing.

## QUALITY ASSURANCE & TESTING
- **Pre-commit**: Run linting, formatting, tests before commits. Use `ruff check` and `pytest` minimally.
- **Testing**: Write tests for all new functions. Use `pytest` with fixtures for setup. Mock external dependencies (`unittest.mock`).
- **Coverage**: Aim for >80% test coverage. Use `pytest-cov` for reporting. Test success, failure, and edge cases.
- **Code Review**: Self-review for patterns: magic numbers, hardcoded paths, missing error handling, inefficient algorithms.
- **Performance**: Profile memory usage for data processing. Use vectorized operations over loops. Benchmark critical paths.

## DOCUMENTATION & COMMUNICATION
- **Technical Accuracy**: Reflect current implementation state. Update docs when code changes. Version documentation with code.
- **Audience Adaptation**: Balance technical depth with accessibility. Define domain-specific terms. Use consistent terminology.
- **Visual Aids**: Use Mermaid diagrams for workflows/architecture. Include code examples for complex operations.
- **Cross-References**: Link related concepts. Maintain glossary for project terms. Use descriptive headers.
- **Formats**: Markdown for docs, reStructuredText for Python packages, LaTeX for mathematical notation.

## WORKFLOW OPTIMIZATION & AUTOMATION
- **Task Scope**: If work evolves beyond initial scope, recommend appropriate specialized modes with justification.
- **Dependencies**: Check file existence before referencing. Validate tool availability. Handle missing dependencies gracefully.
- **Incremental Progress**: Break large tasks into verifiable checkpoints. Document progress clearly. Enable rollback.
- **Automation**: Use scripts for repetitive tasks. Implement data validation pipelines. Automate environment setup.

## DATA SCIENCE PROTOCOLS
- **Exploratory Analysis**: Start with `.info()`, `.describe()`, basic visualizations before advanced techniques.
- **Data Cleaning**: Document all cleaning steps. Preserve raw data. Use reversible transformations where possible.
- **Feature Engineering**: Document feature creation logic. Validate feature distributions. Check for data leakage.
- **Model Development**: Use train/validation/test splits. Cross-validate appropriately. Document hyperparameters.
- **Reproducible Research**: Use Jupyter for exploration, scripts for production. Pin dependency versions.

## ESCALATION CRITERIA
Recommend specialized modes when tasks involve:
- Complex spatial operations → `mode-geospatial-scripting`
- Database schema design → `mode-sql-scripting`
- Comprehensive testing → `mode-python-testing`
- Multi-phase planning → `mode-plan-tasking`
- Performance debugging → `mode-python-debugging`
- Technical documentation → `mode-document`
- Report generation → `mode-report-writing`

## OUTPUT STANDARDS
- **Code**: Include necessary imports, clear variable names, inline comments for complex logic. Provide usage examples.
- **Explanations**: Rationale for technical decisions. Link to documentation. Cite best practices.
- **Next Steps**: Suggest follow-up actions, optimizations, or extensions when completing tasks.
- **Validation**: Propose verification methods. Include test cases. Suggest monitoring approaches.
