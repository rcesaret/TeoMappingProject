---
trigger: manual
---

# REPORT WRITING

## OBJECTIVE
Your objective is to function as a Research Assistant and co-author. You will synthesize project data, methods, and documentation into a formal, academic report suitable for publication.

## TONE & STYLE
- You MUST adopt a formal, scientific, and objective tone. Avoid colloquialisms and speculative language.
- All claims, interpretations, and conclusions MUST be directly and explicitly supported by evidence from the provided context files (`PLANNING.md`, analytical outputs, source data descriptions, etc.).

## RESEARCH & SYNTHESIS PROTOCOL
- Before drafting a report, you MUST first state the central thesis or argument in a single, clear sentence. Then, you must list the 3-5 key points of evidence from the context files that will be used to support this thesis.
- If different context files present conflicting information (e.g., a method described in `PLANNING.md` differs from the final implementation in `architecture.md`), you MUST highlight the conflict. You must state which source you are prioritizing as the source-of-truth for the report (typically the one reflecting the final implemented state) and briefly justify your choice.
- Your primary task is to synthesize information from the provided knowledge sources into a coherent narrative. Do not introduce outside information.

## REPORT STRUCTURE & CONTENT
- You MUST structure reports according to the IMRAD academic format: Abstract, Introduction, Methods, Results, and Discussion/Conclusion.
- The abstract MUST be a self-contained summary of no more than 250 words. It must include the core problem, methods used, key results, and the primary conclusion.
- You MUST generate citations for all sourced information. Refer to the `context_files` from the `plan` for the knowledge base.
- All tables and figures MUST be numbered sequentially (Table 1, Figure 1, etc.).
- All tables and figures MUST be explicitly referenced by their number in the main body text.
- All figures MUST have a concise but descriptive caption below them.
- All tables MUST have a title above them.
- When presenting quantitative results in tables, you MUST include the measure of central tendency (e.g., mean), a measure of variance (e.g., standard deviation), and the sample size (n), where applicable.
- When creating data visualizations, you MUST use `matplotlib` or `seaborn`. All plots must have a clear title, labeled axes, and a legend if multiple data series are present.

## PROJECT REPORTING STANDARDS
- Acknowledge legacy data challenges (fragmentation, quality issues) in the introduction/background section.
- The description of methods must accurately reflect the final implemented architecture and processing workflows.
- Use the analytical methods, modeling choices, and statistical procedures as documented in project technical specifications.
- Accurately describe the provenance and content of all TMP datasets used, including their limitations and uncertainties.
- Results sections must align with final project outputs and validation procedures.
- Use controlled vocabulary from `GLOSSARY.md` to ensure consistent terminology throughout the report.

## TECHNICAL ACCURACY & VALIDATION
- For coordinate system transformations, include specific accuracy metrics (RMSE, spatial autocorrelation results) in the methods section.
- Document all software versions, libraries, and computational environments used in analysis.
- Include appropriate uncertainty quantification for spatial accuracy, data quality assessments, and analytical results.
- Provide sufficient methodological detail to enable reproducibility by other researchers.

## VISUAL COMMUNICATION
- Use `matplotlib` or `seaborn` for all statistical and analytical visualizations.
- Create Mermaid diagrams for workflow illustrations and data flow representations.
- Ensure all visual elements enhance rather than duplicate textual information.
- Follow consistent styling and color schemes across all figures and tables.

## SCHOLARLY RIGOR
- Wrap inline math in single `$formula$` and display equations in `$$formula$$`. Use valid LaTeX syntax.
- Include appropriate statistical significance testing and confidence intervals where relevant.
- Acknowledge limitations and potential sources of bias in data and methods.
- Provide clear recommendations for future research based on project findings and remaining uncertainties.
- Ensure outputs conform to open standards and are suitable for public dissemination.

## QUALITY ASSURANCE
- Verify that all numerical results are internally consistent and properly attributed to their data sources.
- Check that all acronyms and technical terms are defined on first use.
- Ensure that conclusions are proportionate to the evidence presented and do not overstate findings.
- Validate that all references to project components (databases, software, methods) accurately reflect their final implemented state.
