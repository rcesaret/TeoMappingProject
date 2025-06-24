# INSTRUCTIONAL GUIDE: ANALYSIS & REPORTING PROTOCOLS

## 1.0 Introduction & Guiding Principles
This document is the definitive guide for all analytical and reporting workflows within the Digital TMP project. It provides the detailed protocols for moving from raw data to exploratory analysis and finally to the composition of formal scholarly white papers and technical reports. This guide gives deep context to the directives found in `mode-report-writing.md`.

All analytical work must adhere to the following principles:
-   **Objectivity:** Conclusions MUST be strictly data-driven. All interpretations and claims must be directly supported by evidence from the analysis. Avoid speculation.
-   **Transparency:** Methods must be documented with enough clarity and detail that another researcher could reproduce your results. This includes documenting code, parameters, and data sources.
-   **Accessibility:** Reports must be written for a "dual audience" of technical experts (e.g., data scientists, GIS specialists) and non-technical domain experts (e.g., archaeologists, project stakeholders). Clarity and the avoidance of unexplained jargon are paramount.

## 2.0 The Analytical Workflow: From Notebooks to Reports
The project uses a standard two-stage analytical workflow.

1.  **Stage 1: Exploratory Data Analysis (EDA) in Jupyter Notebooks:** This is the "laboratory" phase. The goal is to freely explore the data, test hypotheses, perform statistical analyses, and generate key figures and tables. Notebooks are the primary tool for this interactive work.
2.  **Stage 2: Formal Report Composition in Markdown:** This is the "publication" phase. The final, validated findings, figures, and tables from the EDA notebooks are synthesized, structured, and explained within a formal Markdown report (`.md`).

## 3.0 Protocol for Exploratory Data Analysis (Jupyter Notebooks)
To ensure our analytical work is reproducible and understandable, all Jupyter Notebooks MUST adhere to the following structure and standards.

### 3.1 Standard Notebook Structure
1.  **Header Cell (Markdown):** The first cell must be a Markdown cell containing a level-1 heading (`#`) with the notebook's title, followed by the author, date, and a clear statement of the notebook's objective or the hypothesis being tested.
2.  **Setup Cell (Code):** The second cell must contain all library imports required for the entire notebook.
3.  **Data Loading Cell(s) (Code):** Subsequent cells should load all necessary data from canonical sources (e.g., the PostGIS database, or versioned files in the `/data/processed/` directory).
4.  **Analysis & Visualization (Multiple Code & Markdown Cells):** This is the main body of the notebook.
5.  **Summary of Findings (Markdown):** The final cell must be a Markdown cell that summarizes the key takeaways from the analysis in clear language, explicitly stating whether the initial hypothesis was supported, rejected, or if the results were inconclusive. It must also list the full paths to any figures that were saved to disk.

### 3.2 Code and Markdown Integration
A notebook is a narrative, not just a list of commands. Therefore, every significant code cell or logical block of code cells MUST be:
-   **Preceded by a Markdown cell** that explains the *purpose* of the upcoming code (the "why").
-   **Followed by a Markdown cell** that *interprets* the output of the code, explaining what the results mean in the context of the analysis.

## 4.0 Data Visualization Standards
All plots generated for inclusion in reports must be professional, clear, and consistent.

-   **Tooling:** The project standard is `matplotlib` and `seaborn`.
-   **Anatomy of a Professional Plot:** All plots MUST include:
    -   A clear, descriptive title.
    -   Labeled X and Y axes, including units (e.g., "Distance from Pyramid of the Sun (meters)").
    -   A legend if multiple data series are plotted.
    -   Legible font sizes that are readable in the final report.
-   **Accessibility:** You SHOULD use color-blind-friendly color palettes to ensure your plots are accessible to the widest possible audience. The `seaborn.color_palette('colorblind')` is an excellent choice.
-   **Saving Figures:** All plots must be saved to the `/outputs/figures/` directory.
    -   **Naming:** Use a consistent, descriptive naming convention (e.g., `phase1_figure_01_artifact_distribution_by_tract.png`).
    -   **Resolution:** Save figures at a minimum of **300 DPI** to ensure high quality for publication.
    ```python
    import matplotlib.pyplot as plt
    # ... plotting code ...
    plt.savefig("outputs/figures/my_descriptive_plot.png", dpi=300, bbox_inches='tight')
    ```

## 5.0 Formal Report Composition Protocol

### 5.1 Standard Report Structure (IMRAD)
Scholarly reports MUST follow the standard IMRAD structure:
-   **Abstract:** A concise (<=250 words) summary of the entire report, covering the problem, methods, key results, and conclusion.
-   **Introduction:** State the research question and its significance. Provide necessary background and state the report's objectives.
-   **Methods:** Describe the data and methods used with enough detail for another researcher to reproduce the analysis. This section should reference the specific EDA notebooks used.
-   **Results:** Present the findings of the analysis objectively, without interpretation. Use the tables and figures generated during the EDA stage.
-   **Discussion:** Interpret the results. Explain what they mean in the context of the research question. Discuss limitations of the analysis.
-   **Conclusion:** Briefly summarize the main findings and their implications. Suggest directions for future research.

### 5.2 Presenting Data in Reports
-   **Tables:** All tables must be formatted as clear Markdown tables with headers.
-   **Figures:** All figures must be embedded using correct Markdown syntax (`![Caption text.](path/to/figure.png)`). They must be numbered sequentially (Figure 1, Figure 2, etc.) and referenced by their number in the text.

## 6.0 Writing for a Dual Audience
To ensure our reports are accessible to all stakeholders, you must:
-   Define all key technical or domain-specific terms on first use or refer to the project `glossary.md`.
-   Structure the report so that the main body focuses on the high-level findings and their significance.
-   Move deeply technical content, such as complex code snippets, detailed statistical outputs, or supplementary tables, to an **Appendix**. This keeps the main narrative clean and readable for a non-technical audience while providing full transparency for technical reviewers.
