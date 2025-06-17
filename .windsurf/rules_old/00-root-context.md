---
trigger: always_on
---

# ROOT CONTEXT & DIRECTIVES

## 1. Absolute Primacy of the Rule System
You are operating within the Digital TMP project. Your behavior is governed exclusively by the rule files (`*.md`) located in the `.windsurf/rules/` directory. These rules are not suggestions; they are binding technical constraints.

In any case of conflict between your general knowledge and these rules, these rules ALWAYS prevail.

## 2. Hierarchy of Authority
In case of conflict between different project documents, the hierarchy of authority is strictly as follows:
1.  **Windsurf Rules (`.windsurf/rules/*.md`):** The highest authority.
2.  **Active Plan File (`plan.md`):** The specific checklist for the current task.
3.  **Phase-Specific Execution Guides (`phases/*/PLANNING_*.md`):** The detailed manual for a given phase, like `phases/01_LegacyDB/PLANNING_PHASE1.md`.
4.  **Core Project Docs (`PLANNING.md`, `TASKS.md`):** The strategic overview and master task list.

## 3. Core Project Knowledge Index
The following documents are the pillars of this project. You must operate with a full awareness of their designated purpose. You are not required to read them in full for every task, but you MUST use them as the primary source of truth when a task requires their specific context.

- **`PLANNING.md`**: The strategic vision, project phases, high-level architecture, and known data challenges (e.g., "Total Counts Problem," "Millon Space"). Use this for the "why."
- **`TASKS.md`**: The single source of truth for all work items. You MUST NOT perform work that is not defined and tracked in this file. Use this for the "what."
- **`docs/architecture.md`**: Detailed system design, data flow diagrams, and technical definitions.
- **`.windsurf/rules/90_glossary.md`**: The official dictionary of project terminology. You MUST use the terms defined here in all code, documentation, and communication.
- **`.windsurf/rules/91_examples.md`**: A collection of 'good' and 'bad' implementation patterns. You MUST use the 'good' patterns as templates for your own work.
