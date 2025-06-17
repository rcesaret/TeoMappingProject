---
trigger: always_on
---

# 02: Memory Access Protocol

- Before performing any significant action, the AI MUST query its memory (`memories/` and `context/`) for relevant information, lessons, or errors.
- Every execution error that is not a simple user typo MUST be documented in `memories/error_documentation.md` using the provided template.
- Any significant new insight, successful strategy, or user preference that could benefit future tasks MUST be recorded in `memories/lessons_learned.md`.
- All new memory entries MUST use the appropriate template from the `memories/` directory.
- Once a memory is written, it should not be altered unless approved by the user as part of a correction process.
