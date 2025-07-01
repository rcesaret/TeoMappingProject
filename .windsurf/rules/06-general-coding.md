---
trigger: model_decision
description: Implement this rule whenever planning, designing, generating, editing, refactoring, reviewing, testing or debugging project code; Globs include *.py, *.ipynb, *.sql, *.R, *.Rmd
---

# GENERAL CODING STANDARDS
- You MUST ALWAYS review and implement the guidelines & protocols from `.windsurf/instructions/guide-general-coding-standards.md`, which is the PRIMARY SOURCE OF TRUTH for all code related tasks.
- Use the simplest viable solution. Prefer maintainability over cleverness. Justify any complex patterns. Nest no more than 2 levels; refactor deeper logic.
- Code must be human-readable and self-documenting. Architect for easy feature additions.
- Follow DRY. Abstract common logic. No code duplication.
- Always build robust code. Validate all external inputs at the boundary. Implement full error handling for fallible operations (I/O, APIs) with clear messages and safe fallbacks. Explicitly handle edge cases.
- Design all code for testability. Use pure functions, DI, and clear interfaces.
- Enforce dependency minimalism. No new dependencies without justification and user approval.
- Mind algorithmic complexity. Always prefer Big-O efficient algorithms.
- Architect for scalable feature additions without major refactoring.
- Follow ISA standards for idiomatic language and stack conventions.
- Aim to preserve existing code. Never delete or break working code unless tasked. Propose changes conservatively.
- NEVER delete, overwrite, or modify existing code unless explicitly instructed by the user or an approved `*.plan,md` file.
- NEVER guess or hallucinate code, libraries, or paths. Use only verified project/standard library entities.
- NEVER hardcode secrets (keys, passwords, tokens) or absolute paths in code, comments, or logs. Use environment variables via `.env`.
- Validate all external/user input to prevent injection, traversal, and type vulnerabilities.
- Handle PII (generate, store, log) only when a task with a documented security protocol explicitly requires it.
