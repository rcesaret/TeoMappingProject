---
trigger: manual
---

# BASE

## PROBLEM-SOLVING
- Deconstruct requests: objectives, constraints, criteria. Confirm understanding.
- Clarify ambiguities; don't assume. Identify missing info.
- Propose high-level plans. For >4 steps, suggest formal planning mode.
- Prioritize simple, effective solutions. Avoid needless complexity.
- Consider compute/resource cost of data operations.

## PYTHON STANDARDS
- Python 3.11+ (PEP 8, `ruff`, 88-char limit). Must pass linting.
- Libs: `pandas`/`numpy`, `pathlib`, `logging`, `typing`, `pytest`.
- All functions need `typing` hints for params and returns.
- Use specific exceptions (`ValueError`). `try-except` for I/O, APIs, DBs.
- Use `with` for files, DBs, resources to ensure cleanup.
- Define `UPPER_SNAKE_CASE` constants at module top. No magic numbers.
- Use pure functions. Validate inputs defensively.

## DATA WORKFLOW
- Set random seeds. Log transforms with timestamps for reproducibility.
- Use `pathlib.Path` for relative paths. No hardcoded absolute paths.
- Validate/document CRS (e.g., EPSG). Verify transforms.
- Check for duplicates, outliers, missing values. Document cleaning.

## PROJECT STRUCTURE
- Mirror source in tests (`src/mod.py` → `tests/test_mod.py`). Use kebab-case names.
- Group imports: standard, third-party, local. Sort alphabetically.
- Google-style docstrings for public functions. Update README/changelog.
- Use `.env` for config/secrets via `.env.example`. No hardcoding.
- Notebooks for exploration only. Convert to scripts. Clear output before commit.

## QA & TESTING
- Pre-commit: lint (`ruff check`), format, test (`pytest`).
- Write `pytest` tests for all new functions. Mock external dependencies.
- Aim for >80% test coverage (`pytest-cov`). Test success, failure, edge cases.
- Self-review for: magic numbers, hardcoded paths, missing error handling.
- Profile memory usage. Use vectorized operations over loops. Benchmark.

## DOCS & COMMS
- Docs must reflect current code state. Version docs with code.
- Balance technical depth and accessibility. Define terms.
- Use Mermaid for diagrams, code examples for complex logic.
- Link related concepts. Maintain a glossary. Use descriptive headers.
- Use Markdown, reStructuredText, and LaTeX appropriately.

## WORKFLOW & AUTOMATION
- If scope expands, recommend specialized modes with justification.
- Check file/tool existence. Handle missing dependencies gracefully.
- Break large tasks into verifiable checkpoints. Allow rollback.
- Script repetitive tasks. Automate validation and environment setup.

## DATA SCIENCE
- Start EDA with `.info()`, `.describe()`, basic plots.
- Document cleaning steps. Preserve raw data. Use reversible transforms.
- Document feature logic. Validate distributions. Prevent data leakage.
- Use train/validation/test splits. Cross-validate. Document hyperparameters.
- Use notebooks for exploration, scripts for production. Pin dependencies.

## ESCALATION
- Escalate to specialized modes for: spatial ops, DB schema, testing, planning, debugging, docs, or reports.

## OUTPUT
- Code: include imports, clear names, comments. Provide examples.
- Explain decisions, cite best practices, link to docs.
- Suggest follow-up actions, optimizations, or extensions.
- Propose validation methods, test cases, and monitoring.
