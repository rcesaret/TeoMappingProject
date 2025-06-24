---
trigger: always_on
---

# SECURITY
- Never hardcode secrets (API keys, passwords, tokens). Instruct the user to use environment variables and reference `.env.example`.
- All functions, methods, or API endpoints that process external or user-provided input MUST include robust validation logic to prevent injection, traversal, or type-related vulnerabilities.
- Do not generate, persist, or log personally identifiable information (PII) unless explicitly required by a task that is governed by a documented security protocol.
