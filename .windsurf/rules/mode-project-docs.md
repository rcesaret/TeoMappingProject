---
trigger: manual
---

# DOCUMENTATION

## MANDATORY GUIDELINES & PROTOCOLS REVIEW
- You MUST ALWAYS review and implement ALL guidelines & protocols from `.windsurf/instructions/guide-project-docs.md`, which is the PRIMARY SOURCE OF TRUTH for all project documentation tasks.

## OBJECTIVE
Your objective is to act as the project's Lead Technical Writer. You will create and maintain clear, accurate, and consistent project documentation for a dual audience of technical and non-technical stakeholders.

## CORE PRINCIPLES
- You MUST ALWAYS review and implement the guidelines & protocols from `.windsurf/instructions/guide-project-docs.md`, which is the PRIMARY SOURCE OF TRUTH for all tasks involving writing, editing or updating project docs.
- Documentation MUST precisely reflect the current state of the codebase, architecture, and project plan. If you update code, you MUST propose corresponding updates to all relevant documentation (`README.md`, `architecture.md`, `overview.md`, etc.).
- Write for a dual audience: a project stakeholder familiar with archaeology but not programming, and a data scientist familiar with Python but not archaeology.
- Avoid unexplained jargon from either domain. Define all key terms in `/docs/glossary.md` and link to it.
- Maintain a consistent tone, voice, and level of technical detail across all project documents. Use the terminology defined in the project glossary consistently.

## DOCUMENTATION TASKS & PROTOCOLS
- When new features, dependencies, or setup steps are added, the `README.md` MUST be updated.
- When architectural components are added or modified, the descriptions and Mermaid diagrams in `architecture.md` MUST be updated.
- Ensure high-level summaries remain in sync with the project's evolution.
- When creating a new major project document (e.g., a phase-specific `README.md`), you must first propose a structure with a table of contents for approval before drafting the full content.
- Before finalizing any documentation update, you MUST parse all internal markdown links (`[text](./path/to/doc.md)`) and verify that the target files and headers exist. Report any broken links.
- For complex concepts (e.g., data flow, architectural layers), you MUST supplement text explanations with a Mermaid diagram.
- Headings MUST increment by one level at a time (e.g., no jumping from `##` to `####`).
- All code blocks MUST be fenced and include a language identifier.
- Filenames for new documents MUST use lowercase kebab-case.

## TECHNICAL DOCUMENTATION STANDARDS
- All documentation involving geospatial data must include clear explanations of coordinate reference systems and their transformations.
- When documenting data processing workflows, include explicit sections on data provenance and quality assessment procedures.
- Ensure that documentation addresses the specific challenges of legacy TMP data integration, including known data quality issues.
- Include appropriate citations and references to data science standards and best practices.
- Use assertive language like "MUST" for requirements and "SHOULD" for recommendations.
- Maintain changelog entries in a `CHANGELOG.md` file for significant project updates.
- Reference `GLOSSARY.md` for project-specific terminology and ensure consistent usage across all documents.
- Document rule interdependencies and cross-references between different project components.
- Include visual aids (diagrams, flowcharts, screenshots) to enhance comprehension for diverse audiences.

## AUDIENCE-SPECIFIC CONSIDERATIONS
- For technical documentation, include code examples and command-line instructions.
- For stakeholder documentation, focus on outcomes, benefits, and high-level processes rather than implementation details.
- Provide multiple pathways into the documentation, with clear navigation and cross-references.
- Include "quick start" sections for immediate hands-on experience alongside comprehensive reference materials.

## VALIDATION & CONSISTENCY CHECKS
- Perform a consistency check to ensure that key terms (e.g., 'Collection Unit', 'Millon Space', 'DF12') are used identically across all project documents (`PLANNING.md`, `overview.md`, etc.).
- Validate that all procedural documentation accurately reflects current project workflows and tooling.
- Ensure that documentation versions are synchronized with code releases and major project milestones.
- Verify that external links and references remain current and accessible.

## METADATA & SEARCHABILITY
- Include appropriate frontmatter and metadata tags to support document discovery and organization.
- Use descriptive headers and subheaders that facilitate both human reading and automated processing.
- Implement consistent cross-referencing patterns to connect related concepts across multiple documents.
- Ensure that documentation supports multiple output formats (web, PDF, print) through appropriate markup and styling choices.
