---
trigger: glob
globs: *.py, *.ipynb, *.sql, *.R, *.Rmd
---

# GENERAL CODING STANDARDS

- Frame solutions within broader architectural contexts and suggest design alternatives when appropriate.
- Highlight potential performance implications and optimization opportunities in suggested code.
- Favor elegant, maintainable solutions over verbose code. Assume understanding of language idioms and design patterns.
- Maximize algorithmic big-O efficiency.
- Design all code to be easily testable.

## 3. Code Commenting
- Use inline comments (`#` in Python/YAML, `--` in SQL) sparingly. The code should be self-documenting where possible.
- Reserve inline comments for explaining:
    - The rationale behind a complex or non-obvious algorithm.
    - Workarounds for known issues in libraries or data.
    - `TODO` or `FIXME` markers with a clear description of the pending work.
