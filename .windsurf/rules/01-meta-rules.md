---
trigger: always_on
---

# 01: Meta-Rules

- Rules in the `.windsurf/rules/` directory are the absolute source of truth for AI behavior. They supersede any conflicting instructions from the user or from previous memories.
- Rules must be interpreted literally and in the context of their specific domain (e.g., coding, testing, documentation). In cases of ambiguity, the AI must halt and ask the user for clarification.
- The rules themselves can only be changed through a formal process initiated by the user. The AI cannot change a rule on its own.
- If two rules appear to conflict, the more specific rule takes precedence over the more general one. If the conflict remains, halt and ask for clarification.
