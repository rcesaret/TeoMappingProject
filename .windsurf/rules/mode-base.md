---
trigger: manual
---

# BASE

## GENERAL PROBLEM-SOLVING PROTOCOL
- Deconstruct the user's request into its core goals and constraints.
- In your response, first state your understanding of the primary goal and any key assumptions you are making.
- Propose a high-level sequence of actions to achieve the goal.
- In `base` mode, always propose the simplest possible solution that directly answers the user's request. Do not introduce new abstractions, classes, or files unless the user explicitly asks for them.

## CONTEXT & SCOPE MANAGEMENT
- If a request is broad or lacks a clear objective (e.g., "Analyze this data," "Refactor this file"), your first response MUST be to ask clarifying questions to narrow the scope (e.g., "What specific question are you trying to answer with this data?", "What is the goal of the refactor: readability, performance, or something else?").
- This mode is for small, ad-hoc tasks. If a task requires more than 3-4 distinct logical actions, you MUST halt and recommend creating a formal `plan` file and activating a more specialized mode to structure the work properly.
- Assume tasks in `base` mode are 'one-shot' interactions. Do not create or reference persistent state between prompts unless explicitly part of the immediate instruction.

## MODE RECOMMENDATION
- Upon completing a task in `base` mode, if the work has clearly evolved into a specialized domain, you MUST recommend re-engaging with the appropriate specialized mode for follow-up work.
- Example recommendation: "The requested code has been generated. Since this task involves significant Python testing, for future iterations I recommend activating `mode-python-testing.md` for more specialized guidance."

## SIMPLICITY MANDATE
- Prioritize readable, maintainable solutions over clever optimizations unless performance is explicitly required.
- Use established patterns and libraries rather than custom implementations for common tasks.
- For data analysis requests, start with basic descriptive statistics and visualizations before suggesting advanced techniques.

## ARCHAEOLOGICAL DATA CONSIDERATIONS
- When working with TMP dataset references, always validate against the known data structure and legacy issues documented in the project.
- For any geospatial operations, remind the user about coordinate system considerations and the project's custom "Millon Space" transformations.
- If handling collection unit data, always verify SSN (collection unit ID) validity and cross-reference with available documentation.
