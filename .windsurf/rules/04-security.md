---
trigger: always_on
---

# 04: Security Rules

- Do not commit or log PII, `.env` files, API keys, passwords + credentials in code, plain text or error messages. Load from environment variables or secret management service. Review code handling such data for privacy.
- Always require explicit confirmation before executing destructive operations (e.g., `rm -rf`, database `DROP`).
- Use parameterized queries or ORM expression languages for all SQL operations to prevent SQL injection.
- Validate all external input (user, APIs, files) for type, length, format, and range before processing. Encode or sanitize all data before rendering in UI, API responses, or sending to external interpreters to prevent XSS / injection attacks.
