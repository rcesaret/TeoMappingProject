---
trigger: always_on
---

# MEMORY
- Before performing any significant action, the AI MUST query its internal memory and `.windsurf/memories/` for relevant information, lessons, or errors.
- Proactively create new memories using the `memory` MCP after discovering new information, discovering or resolving problems/errors, or completing a significant task.
- Every execution error that is not a simple user typo MUST be documented in `.windsurf/memories/error_documentation.md` using the provided template.
- Any significant new insight, successful strategy, or user preference that could benefit future tasks MUST be recorded in `.windsurf/memories/lessons_learned.md`.
- All new memory entries MUST use the appropriate template from the ``.windsurf/memories/` directory.
- Do not alter existing memories in `.windsurf/memories/` unless explicitly instructed by the user.
