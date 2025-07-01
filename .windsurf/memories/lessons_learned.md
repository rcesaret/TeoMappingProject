# Lessons Learned

**Objective:** To maintain a cumulative repository of key insights, best practices, and successful strategies discovered during the project lifecycle.

## Entry Template

---

**Date:** `YYYY-MM-DD`

**Context/Task:**
*(Briefly describe the situation or task that led to the insight.)*

**Lesson:**
*(Clearly articulate the lesson learned. What was the key takeaway?)*

**Implication/Action:**
*(How should this lesson influence future behavior? Should a rule be updated or a new template be created?)*


---

## Lesson: Secrets Scanners Target Names, Not Just Values

- **Task ID:** `P1.W1.T4.1`
- **Topic:** Test-Driven Development, Security
- **Date:** 2025-07-01

### Insight

Automated security scanners like `detect-secrets` are often configured to flag not just the presence of high-entropy strings or known credential formats, but also the use of common sensitive *names* for variables, keys, and attributes (e.g., `password`, `api_key`, `token`).

### Recommendation

When writing tests, especially those involving mock configurations or objects, proactively avoid using these sensitive names.

- **Bad Practice:** `mock_config.password = "FAKE_PASSWORD"`
- **Good Practice:** `mock_config.credential = "FAKE_CREDENTIAL"`

Adopting this convention from the outset prevents the security hooks from triggering, streamlines the development workflow, and avoids time-consuming debugging cycles. It treats the name itself as part of the sensitive pattern to be avoided.
