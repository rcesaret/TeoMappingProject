# INSTRUCTIONAL GUIDE: JUPYTER NOTEBOOK STANDARDS

## 1.0 Introduction & Philosophy
This document is the definitive guide for using Jupyter Notebooks for research, analysis, and prototyping within the Digital Teotihuacan Mapping Project (TMP). It provides the standards necessary to elevate notebooks from personal scratchpads into professional, reproducible, and shareable research artifacts.

Our core philosophy is that a Jupyter Notebook is a **"computational narrative"** or a **"research logbook."** It must tell a clear, logical story that seamlessly integrates code, its output, and textual explanations. The goal is to create a document where another researcher can understand your thought process, reproduce your results, and build upon your work with confidence.

**Notebooks are for exploration and analysis. Production data pipelines MUST be implemented as standalone Python scripts.**

## 2.0 Environment and Setup

### 2.1 Kernel Configuration
To ensure dependency consistency and full reproducibility, all project notebooks **MUST** use the project's standard Conda environment as their kernel.
-   **Environment:** `digital_tmp_base`
-   **In VS Code:** When you first open a notebook, use the kernel picker in the top-right corner to select the `digital_tmp_base` environment.

### 2.2 Linting and Formatting
Code quality standards do not get relaxed in notebooks. All code within notebook cells **MUST** adhere to the standards outlined in `guide-python-style.md`.
-   **Protocol:** Use the integrated Jupyter extension tools in your IDE (e.g., VS Code) to format cells with `ruff` or `black` on save. This ensures consistency with the rest of the project's Python code.

## 3.0 The Standard Notebook Structure
All analytical notebooks MUST adhere to the following structure, derived from the project's templates (`template_*.ipynb`).

1.  **Header (First Cell, Markdown):** A level-1 heading (`#`) with the notebook's title, followed by author, date, and a clear, one-paragraph **Objective** that states the research question or hypothesis being investigated.
2.  **Setup (Second Cell, Code):** A single cell containing all library imports (`import pandas as pd`, `import matplotlib.pyplot as plt`, etc.).
3.  **Parameters (Optional Third Cell, Code):** For notebooks designed for reuse, this cell should define all key parameters, such as input file paths or model thresholds. This makes the notebook easily configurable.
4.  **Data Loading (Code Cell(s)):** Load all necessary data from canonical sources (e.g., the PostGIS database via `sqlalchemy`, or versioned files in `/data/processed/`).
5.  **Analysis & Visualization (Multiple Code & Markdown Cells):** This is the main body of the notebook where the exploratory work is performed.
6.  **Summary of Findings (Final Cell, Markdown):** A concluding section with a level-2 heading (`## Summary of Findings`). This section must:
    -   Summarize the key results in clear, non-technical language.
    -   Explicitly state whether the initial hypothesis was supported, rejected, or if the results were inconclusive.
    -   Provide a bulleted list of the full paths to any figures or data files that were saved to disk during the notebook's execution.

## 4.0 The "Narrative Cell" Protocol
This protocol is the core of creating a readable "computational narrative" and is mandatory. Every significant code cell (or logical group of cells) **MUST** be bracketed by Markdown cells.

-   **Preceding Markdown Cell:** Explains the **objective** of the code that follows. It answers the question, "What am I about to do, and why?"
-   **Code Cell:** Contains the code to execute the step.
-   **Following Markdown Cell:** **Interprets** the output of the code cell. It answers the question, "What do these results mean in the context of my analysis?"

-   **Example:**
    **BAD (Code without narrative):**
    ```python
    # CODE CELL
    artifact_counts = df['artifact_type'].value_counts()
    print(artifact_counts)
    ```

    **GOOD (Code with narrative):**

    (Markdown Cell)
    Next, I will calculate the frequency of each artifact type in the dataset to understand the overall distribution of materials.

    ```python
    # CODE CELL
    artifact_counts = df['artifact_type'].value_counts()
    print(artifact_counts)
    ```
    (Markdown Cell)
    The output shows that 'sherd' is by far the most common artifact type, followed by 'lithic'. This is consistent with expectations for this type of surface collection survey.

## 5.0 Best Practices for Reproducible Notebooks

-   **No Hardcoded Paths:** You MUST use `pathlib` to build paths relative to a defined project root, as detailed in `guide-python-style.md`.
-   **Execution Order:** A notebook is only considered valid and reproducible if it can be executed successfully from top to bottom by selecting **"Kernel > Restart & Run All"** in the Jupyter menu. You must perform this check before committing your work to ensure there is no hidden state from out-of-order cell execution.
-   **Parameterization:** For reusable notebooks, use a "Parameters" cell at the top or refactor the core logic into a function that can be called with different parameters. This is preferable to copying and pasting notebooks.

## 6.0 Version Control for Notebooks (`.ipynb` files)
-   **The Challenge:** `.ipynb` files are JSON documents that include cell outputs and execution counts. This makes `git diff` outputs noisy and difficult to read.
-   **The Protocol:** Before committing a notebook to version control, you **MUST** run **"Kernel > Clear All Outputs"**. This removes the output data from the file, ensuring that only meaningful changes to your code and Markdown narrative are tracked in the commit history.

## 7.0 Role in the Analytical Workflow
The Jupyter Notebook is the primary tool for the **exploratory** phase of research. It is where you discover findings. The final, validated findings, figures, code snippets, and interpretations from a notebook are the raw materials that are then synthesized and structured into a formal Markdown report, as detailed in `guide-analysis-reporting.md`. A notebook is the "lab work"; the report is the "publication."
