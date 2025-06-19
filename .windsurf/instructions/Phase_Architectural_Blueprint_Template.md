<!--
**GLOBAL INSTRUCTION FOR ARCHITECTURAL DESIGN AGENT:**
Your primary objective is to generate a complete and exhaustive architectural blueprint for the specified project phase. This document must be meticulously detailed, technically precise, and serve as the single source of truth for all subsequent development and execution tasks.

**Minimum Length Requirement:** The final generated document must be a minimum of **7,500 words** to ensure a sufficient level of detail.

**Structure:** Adhere strictly to the following template. You are empowered to add as many subsections as necessary within each section to meet the required level of detail and fully describe the architecture.
-->

# Phase [Phase Number]: [Phase Title] - Architectural Blueprint

> **Document Version:** 1.0
> **Author:** Architectural Design Agent
> **Date:** [Date of Generation]
> **Status:** **Proposed Blueprint for Development**

## **1.0 Executive Summary**

<!--
**INSTRUCTION FOR AGENT:**
1.  Synthesize the primary goal of this project phase from the high-level project documentation (`PLANNING.md`, `architecture.md`).
2.  Write a concise, 1-2 paragraph summary describing what this phase aims to achieve, its key challenges, and its importance for the overall project.
3.  Clearly state the key deliverables that will be produced by the end of this phase.
-->

[AGENT-GENERATED CONTENT HERE]

## **2.0 Formal Review of Prior Architecture**

<!--
**INSTRUCTION FOR AGENT:**
1.  Analyze the existing state of the project phase, including any preliminary scripts, plans, or legacy components.
2.  Identify and list the **Strengths** of the current approach (what works well and should be kept).
3.  Identify and list the **Weaknesses & Opportunities for Revision** (what is inefficient, brittle, or incomplete). This section justifies the need for the new architecture you are proposing.
-->

### **2.1 Strengths**

[AGENT-GENERATED CONTENT HERE]

### **2.2 Weaknesses & Opportunities for Revision**

[AGENT-GENERATED CONTENT HERE]

## **3.0 Goals for the Revised Phase Architecture**

<!--
**INSTRUCTION FOR AGENT:**
Based on the review in Section 2.0, explicitly list the primary technical and strategic goals that the revised architecture must achieve. These goals should be specific and measurable.
-->

Based on the review, the revised architecture is designed to achieve the following primary goals:

1.  **[Goal 1 - e.g., Modularity]:** [AGENT-GENERATED DESCRIPTION]
2.  **[Goal 2 - e.g., Extensibility]:** [AGENT-GENERATED DESCRIPTION]
3.  **[Goal 3 - e.g., Reproducibility]:** [AGENT-GENERATED DESCRIPTION]
4.  **[Goal 4 - e.g., Robustness]:** [AGENT-GENERATED DESCRIPTION]
5.  **[Goal 5 - e.g., Maintainability]:** [AGENT-GENERATED DESCRIPTION]
6.  **[Goal 6 - e.g., Comprehensive Analysis]:** [AGENT-GENERATED DESCRIPTION]

## **4.0 New Architecture Overview**

<!--
**INSTRUCTION FOR AGENT:**
1.  Decompose the work for this phase into a series of logical, sequential **Workflows**.
2.  Provide a brief, high-level description of the overall process flow through these workflows.
3.  For each workflow, write a 1-2 sentence summary of its specific goal.
-->

The revised architecture is a pipeline orchestrated by a series of Python scripts within the `src/` directory. It operates in **[Number]** distinct workflows:

1.  **Workflow [X.1]: [Workflow Title]**: [AGENT-GENERATED SUMMARY]
2.  **Workflow [X.2]: [Workflow Title]**: [AGENT-GENERATED SUMMARY]
    *...(add as many as needed)...*

### **4.1 Visual Logic & Architecture Model**

<!--
**INSTRUCTION FOR AGENT:**
Based on the workflows you defined above, generate a **Mermaid `graph TD` flowchart** that visually represents the end-to-end process for this phase.
-->

```mermaid
[AGENT-GENERATED MERMAID DIAGRAM HERE]
```

### **4.2 Revised Phase File Structure**

<!--
**INSTRUCTION FOR AGENT:**
Based on the files you will specify in Section 7.0, generate a complete, commented directory tree for this phase.
-->

```
[AGENT-GENERATED DIRECTORY TREE HERE]
```

## **5.0 Analytical Assets & Deliverables**

<!--
**INSTRUCTION FOR AGENT:**
Summarize the key outputs of this phase in a structured Markdown table.
-->

The execution of this phase produces a rich set of data files, reports, and analytical notebooks.

| Output Category | Description | Format | Location |
| :--- | :--- | :--- | :--- |
| **[Category 1]** | [AGENT-GENERATED DESCRIPTION] | [e.g., CSV, JSON] | `[e.g., outputs/metrics/]` |
| **[Category 2]** | [AGENT-GENERATED DESCRIPTION] | [e.g., SVG] | `[e.g., outputs/erds/]` |
| **[Category 3]** | [AGENT-GENERATED DESCRIPTION] | [e.g., Markdown] | `[e.g., drafts/]` |

## **6.0 Tools & Technologies**

<!--
**INSTRUCTION FOR AGENT:**
List the specific tools and libraries required to execute this phase.
-->

*   **Databases**: [e.g., PostgreSQL (v17+)]
*   **Programming**: [e.g., Python 3.11+, SQL]
*   **Core Python Libraries**: [e.g., Pandas, SQLAlchemy, GeoPandas]
*   **Schema Visualization**: [e.g., Graphviz]
*   **Analysis Environment**: [e.g., Jupyter Notebooks]

---

## **7.0 Detailed File & Module Specifications**

<!--
**INSTRUCTION FOR AGENT:**
This is a critical section. For **every single script, module, and key configuration file** in your proposed architecture, create a dedicated subsection. For each file, you MUST provide:
- **Objective**: A one-sentence summary of the file's purpose.
- **Description**: A more detailed paragraph explaining what the file does and its role in the pipeline.
- **Inputs**: A list of all files, database connections, or configurations it depends on.
- **Outputs**: A list of all files, database tables, or other artifacts it produces.
- **Python Libraries**: A list of the key Python libraries it will use.
- **Key Features Checklist**: A markdown checklist of the essential logic, features, and error handling that must be implemented in this file. This will guide the Code Drafting Agent.
-->

This section provides the detailed blueprint for each critical file in the `src/` directory.

-----

### **`[path/to/file_1.py]`**

*   **Objective**: [AGENT-GENERATED CONTENT]
*   **Description**: [AGENT-GENERATED CONTENT]
*   **Inputs**: [AGENT-GENERATED CONTENT]
*   **Outputs**: [AGENT-GENERATED CONTENT]
*   **Python Libraries**: [AGENT-GENERATED CONTENT]
*   **Key Features Checklist**:
    *   [ ] [AGENT-GENERATED FEATURE 1]
    *   [ ] [AGENT-GENERATED FEATURE 2]
    *   [ ] [AGENT-GENERATED FEATURE 3]

-----

### **`[path/to/file_2.sql]`**

*   **Objective**: [AGENT-GENERATED CONTENT]
*   ...etc...

---

## **8.0 Atomized Task Plan for Phase Development**

<!--
**INSTRUCTION FOR AGENT:**
Based on the architecture you have designed, create a detailed, sequential, step-by-step development plan.
1.  Organize the plan by the **Workflows** you defined in Section 4.0.
2.  Break down each workflow into a series of **Tasks** (e.g., "Task 1.1: Initialize Project Structure", "Task 1.2: Develop `script_name.py`").
3.  For each task, provide a list of specific **Actions** that need to be completed. These actions should be concrete and developer-focused.
-->

This plan breaks down the development into sequential, manageable tasks.


#### **Workflow [X.1]: [Workflow Title]**


*   [ ] **Task [X.1.1]: [Task Title]**.
    *   Action: [AGENT-GENERATED ACTION 1]
    *   Action: [AGENT-GENERATED ACTION 2]
*   [ ] **Task [X.1.2]: [Task Title]**.
    *   Action: [AGENT-GENERATED ACTION 1]

#### **Workflow [X.2]: [Workflow Title]**

*   ...etc...

## **9. Future Dependency & Environment Analysis**

### **9.1 Required Python Library Analysis**

[AGENT-GENERATED CONTENT HERE]

<!--
**INSTRUCTION FOR AGENT:**
If new python libraries are absolutely necessary to accomplish the goals of the project (i.e. existing libraries do not have the features/capabilities that are necessary for successful completion of this phase), analyze the current contents of the `digital_tmp_base` conda environment to determine whether all libraries required for this phase are present. If not, specify the additional libraries that need to be installed.
-->

### **9.2 Specialized Environment Recommendation**

<!--
**INSTRUCTION FOR AGENT:**
If new libraries are required, conduct an analysis of the current contents of the `digital_tmp_base` conda environment to determine whether the required new libraries are compatable with the `digital_tmp_base` conda environment. If they are not, determine whether we need to create a new conda environment to accomplish the core goals of this phase. If yes, then propose the creation of a new conda environment and determine all of its specifications and dependencies.
-->

[AGENT-GENERATED CONTENT HERE]

---

## **Appendices**

### **Appendix A: Phase-Specific Context & Analytical Framework**

<!--
**INSTRUCTION FOR AGENT:**
This is the most important section for tailoring the blueprint to the specific analytical needs of the current phase.
1.  **Compile All Guiding Context:** Meticulously review all provided project documents (`PLANNING.md`, `architecture.md`, `overview.md`, etc.) and the user's prompt. Extract and compile **all** information that structures and guides the architectural design for this specific phase. This includes, but is not limited to:
    -   Specific datasets, files, or databases to be analyzed.
    -   Key variables, metrics, or measurements that must be calculated.
    -   Required analytical methods or statistical approaches.
    -   Specific goals or hypotheses that the architecture must be able to address.
2.  **Design a Custom Framework:** Organize this compiled information into a structured, detailed framework. This will often take the form of multiple, detailed Markdown tables, but could also be lists of rules, decision trees, or data validation schemas.
3.  **Serve as a Checklist:** This appendix MUST be detailed enough to serve as a definitive guide and checklist for you (the Architect Agent) during the design process. It is the evidence base for the architecture you are proposing in the main body of the document. You will refer back to this appendix to justify your design choices.
-->

[AGENT-GENERATED CUSTOM FRAMEWORK (e.g., multiple Markdown tables, lists of rules, etc.) HERE]

### **Appendix B: [Optional Additional Appendix]**

<!--
**INSTRUCTION FOR AGENT:**
If necessary, create additional appendices for other detailed compilations, such as a full data dictionary, a list of all API endpoints, etc.
-->

[AGENT-GENERATED CONTENT HERE]
