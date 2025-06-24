<!--
**GLOBAL INSTRUCTION FOR ARCHITECTURAL DESIGN AGENT:**
Your primary objective is to generate a complete and exhaustive execution plan for the specified project phase. This document is the **single source of truth** for all subsequent AI agents (Code Drafters, Testers, Executors). Its purpose is to translate the high-level architectural blueprint into a set of direct, unambiguous, and meticulously detailed instructions.

**The level of detail in this document is paramount.** It is not a summary; it is an operational runbook. Any ambiguity, omission, or lack of technical depth in this plan will lead to implementation errors, testing failures, and potentially catastrophic pipeline failures by the downstream agents who depend on it for all context and instructions. You must be exhaustive.

**Minimum Length Requirement:** The final generated document must be a minimum of **7,500 words**. This is a proxy for the required level of detail. Do not use filler; achieve this length by providing deep, specific, and comprehensive technical specifications in every section.

**Structure:** Adhere strictly to the following template. You are empowered to add as many subsections as necessary within each section to meet the required level of detail and fully describe the execution plan.
-->

# Phase [Phase Number]: [Phase Title] - Execution Plan & Agent Guide

> **Version:** 1.0
> **Author:** Architectural Design Agent
> **Date:** [Date of Generation]
> **Status:** **Ready for Execution**

## Table of Contents
* [1. Purpose & Architectural Philosophy](#1-purpose--architectural-philosophy)
* [2. Phase Architectural Overview (from Blueprint)](#2-phase-architectural-overview-from-blueprint)
* [3. Master Execution Plan: From Setup to Synthesis](#3-master-execution-plan-from-setup-to-synthesis)
* [4. Detailed Task Protocols for All Files](#4-detailed-task-protocols-for-all-files)
* [5. Analytical Assets & Deliverables (from Blueprint)](#5-analytical-assets--deliverables)
* [6. Strategic Project Guidance](#6-strategic-project-guidance)

---

## 1. Purpose & Architectural Philosophy

### 1.1. Purpose and Core Objective of Phase [Phase Number]

<!--
**INSTRUCTION FOR AGENT:**
Copy the "Purpose & Core Objective" section directly from the `Phase_X_Architectural_Blueprint.md`.
-->

[AGENT-GENERATED CONTENT COPIED FROM BLUEPRINT]

### 1.2. Architectural Philosophy Guiding Phase Workflows

<!--
**INSTRUCTION FOR AGENT:**
Copy the "Architectural Philosophy" section directly from the `Phase_X_Architectural_Blueprint.md`.
-->

[AGENT-GENERATED CONTENT COPIED FROM BLUEPRINT]

---

## 2. Phase Architectural Overview (from Blueprint)

<!--
**INSTRUCTION FOR AGENT:**
You must populate this entire section by summarizing and directly embedding content from the `Phase_X_Architectural_Blueprint.md` you have just created. This provides the necessary context for the execution plan.
-->

### 2.1. The [Number] Workflows of Phase [Phase Number]

[AGENT-GENERATED CONTENT COPIED FROM BLUEPRINT]

### 2.2. Architectural Flowchart

[AGENT-GENERATED MERMAID DIAGRAM COPIED FROM BLUEPRINT]

### 2.3. Directory Structure

[AGENT-GENERATED DIRECTORY TREE COPIED FROM BLUEPRINT]

### 2.4. Tools & Technologies Utilized

[AGENT-GENERATED CONTENT COPIED FROM BLUEPRINT]

---

## 3. Master Execution Plan: From Setup to Synthesis

<!--
**INSTRUCTION FOR AGENT:**
Based on the workflows defined in the blueprint, create a high-level, staged execution plan. This section must be very long and technically detailed, providing a comprehensive narrative of the entire execution process from start to finish. **This section should be roughly 2000 words -- mostly in the form of detailed subsections within 3.2. Staged Execution Plan**
-->

This section outlines the high-level, sequential stages for executing the full pipeline for this phase. All development and drafting tasks are considered complete. The focus is now on execution, testing, and validation.

### 3.1. Pre-Execution Go/No-Go Checklist

Before initiating the pipeline, the executing agent must confirm that the following conditions are met. If any check fails, the process must halt until the issue is resolved.

| # | Check | Status |
| :- | :--- | :--- |
| 1 | Conda environment `digital_tmp_base` is activated? | `[ ] Yes` |
| 2 | `src/config.ini` has been reviewed and populated with the correct local credentials and paths? | `[ ] Yes` |
| 3 | All required external dependencies (e.g., Graphviz) are installed and accessible in the system PATH? | `[ ] Yes` |
| 4 | All required input files and data sources (e.g., SQL dumps, canonical queries) are present in their specified locations? | `[ ] Yes` |

### 3.2. Staged Execution Plan

<!--
**INSTRUCTION FOR AGENT:**
Provide substantial technical detail for each stage and action within the staged execution plan.
-->

#### 3.2.1. Stage 1: [e.g., Environment & Database Setup]

...details...

##### Execute: `python [script_1.py]`

...details...

##### Execute: `python [script_2.py]`

...details...

##### ...etc...

...details...

#### 3.2.2. Stage 2: [e.g., Metric & Artifact Generation]

...details...

##### Execute: `python [script_3.py]`

...details...

##### ...etc...

...etc...

---

## 4. Detailed Task Protocols for All Files

<!--
**INSTRUCTION FOR AGENT:**
This is the core of the execution plan. For **every single script, module, and key configuration file** identified in the Architectural Blueprint, you must generate a corresponding "Task Protocol" section below. Each protocol is a self-contained set of instructions for the entire lifecycle of that file.

**Each individual protocol section must be exceptionally long and detailed, aiming for a word count between 2500 and 3500 words.** This length is necessary to capture the exhaustive technical specification required by the downstream agents.
-->

---

### **Protocol for: `[path/to/file_name.ext]`**

#### **Objective** 🎯
<!-- **Instruction:** Briefly state the one-sentence goal of this specific file. -->
[AGENT-GENERATED CONTENT]


#### TASKS.md Generation Protocol

-   **Task ID:** [AGENT-GENERATED HIERARCHICAL ID, e.g., P1.1.1]
-   **Description:** [AGENT-GENERATED, one-sentence description of the task's objective.]
-   **Acceptance Criteria:**
    -   `[ ]` [AGENT-GENERATED, specific, verifiable outcome 1.]
    -   `[ ]` [AGENT-GENERATED, specific, verifiable outcome 2.]
-   **Context Map:**
    -   `[ ]` **Source File(s):** [e.g., `phases/01_LegacyDB/src/00_setup_databases.py`]
    -   `[ ]` **Documentation:** [e.g., `.windsurf/instructions/guide-database-design.md#4.3`]
    -   `[ ]` **Rule Mode(s):** [e.g., `mode-python-scripting`, `mode-sql-scripting`]

---

#### **Part A: Code Drafting & Implementation Plan (for Code Drafting Agent)**

<!--
**INSTRUCTION FOR ARCHITECT AGENT:**
This section must be exhaustive and meticulously detailed. It is the complete set of instructions for the Code Drafting Agent. Do NOT write the code itself, but provide a detailed, unambiguous plan to create it. Your description must be long-form and provide deep technical context for every decision.
-->

##### **1. Core Logic & Strategy**
<!-- **Instruction:** Describe the high-level approach and strategy for the script in extensive detail. Explain the "why" behind the chosen strategy, discuss alternatives that were considered and rejected, and justify the final design. How will it achieve its objective in a robust and maintainable way? -->
[AGENT-GENERATED CONTENT: e.g., "This script will connect to a root PostgreSQL database, iterate through a list of database names from the config file, and issue a CREATE DATABASE command for each one inside a transaction block..."]

##### **2. Required Imports**
<!-- **Instruction:** List all necessary Python libraries to be imported, and for non-standard libraries, provide a brief justification for their inclusion. -->
*   `[e.g., argparse]`
*   `[e.g., configparser]`
*   `[e.g., logging]`
*   `[e.g., pathlib]`
*   `[e.g., pandas]`
*   `[e.g., sqlalchemy]`

##### **3. Constants & Configuration**
<!-- **Instruction:** Detail any file-level constants that should be defined and list the specific keys that must be read from the `config.ini` file. Provide example values and explain the purpose of each constant and configuration key in detail. -->
*   **Constants**: `[e.g., LOG_FILE_NAME = "00_setup_databases.log"]`
*   **Configuration from `config.ini`**:
    *   `[postgresql]` section: `host`, `port`, `user`, `password`, `root_db`
    *   `[databases]` section: `legacy_dbs`
    *   `[paths]` section: `sql_dump_dir`

##### **4. Function Definitions**
<!-- **Instruction:** For each function in the script, provide a comprehensive specification. This must include a detailed description of its logic, its full signature with type hints, a line-by-line breakdown of its parameters and return values, and a discussion of its role within the script. -->
*   **`function_1(param1: str, param2: int) -> bool`**:
    *   **Description**: [AGENT-GENERATED DESCRIPTION]
    *   **Parameters**:
        *   `param1`: [Description of parameter 1]
        *   `param2`: [Description of parameter 2]
    *   **Returns**: [Description of return value]
*   **`function_2(...)`**: ...etc.

##### **5. Step-by-Step Execution Flow (Main Function)**
<!-- **Instruction:** This is critical. Describe the sequential logic of the `main()` function in exhaustive, step-by-step detail. Each step should be a paragraph explaining the action, its purpose, and how it connects to the previous and next steps. -->
1.  **Parse Arguments**: Initialize `argparse` to accept a `--config` argument.
2.  **Setup Logging**: Configure the `logging` module to write to both the console and a file named according to the `LOG_FILE_NAME` constant.
3.  **Read Configuration**: Instantiate `ConfigParser` and read the settings from the provided config file path.
4.  **Prepare DB Connection Info**: Extract the PostgreSQL connection details into a dictionary.
5.  **Main Loop**: Iterate through the list of databases defined in `config.ini`.
6.  **Inside Loop - Step 1**: For each database name, call `function_1(...)` to create the database.
7.  **Inside Loop - Step 2**: For each database name, call `function_2(...)` to populate it from its SQL file.
8.  **Completion**: Log a final "Process Complete" message.

##### **6. Error Handling & Logging Strategy**
<!-- **Instruction:** Specify exactly how errors should be handled and what should be logged in meticulous detail. Describe the expected log messages for both success and failure scenarios for every major operation. -->
*   The script should exit with a `sys.exit(1)` if the `config.ini` file is not found.
*   The `create_database` function must wrap its `CREATE DATABASE` call in a `try...except psycopg2.errors.DuplicateDatabase` block. On this specific error, it should log a `WARNING` and return `True`. For all other `psycopg2.Error` exceptions, it should log an `ERROR` and return `False`.
*   The main loop should check the boolean return value of each function call and `continue` to the next database if a failure is reported.

---

#### **Part B: Execution & Validation Plan (for Executor/Tester Agent)**

<!--
**INSTRUCTION FOR ARCHITECT AGENT:**
This section details the post-drafting tasks. It must be populated with exhaustive, unambiguous instructions.
-->

##### **1. Pre-run Checklist**
<!-- **Instruction:** List all files, database states, or configurations that must be in place before this task's script can be run. Be explicit and exhaustive. -->
1.  [AGENT-GENERATED PREREQUISITE 1]
2.  [AGENT-GENERATED PREREQUISITE 2]

##### **2. Execution**
<!-- **Instruction:** Provide the exact, single command line instruction to run the script for this task. Include examples of optional flags if applicable. -->
```bash
[AGENT-GENERATED COMMAND]
```

##### **3. Validation Procedures**
<!-- **Instruction:** Provide a detailed, step-by-step list of checks to verify a successful execution. Include specific commands (`psql`, `ls`), expected file outputs, expected data values, and expected row counts. Leave no room for ambiguity. -->
1.  **Log File Review**: [AGENT-GENERATED INSTRUCTION]
2.  **Output Verification**: [AGENT-GENERATED INSTRUCTION]
3.  **Content Spot-Check**: [AGENT-GENERATED INSTRUCTION]

##### **4. Testing Strategy**
<!-- **Instruction:** Provide a detailed testing plan. Specify the framework (`pytest`), the focus of the tests, and a comprehensive plan for unit and/or integration tests. Detail the required fixtures, what needs to be mocked, and the specific assertions to be made for each test case. -->
*   **Focus**: [AGENT-GENERATED CONTENT]
*   **Framework**: `pytest` and `pytest-mock`.
*   **Test Plan**:
    1.  **Test Setup**: [AGENT-GENERATED CONTENT]
    2.  **Unit/Integration Tests**: [AGENT-GENERATED CONTENT]
    3.  **Assertions**: [AGENT-GENERATED CONTENT]

##### **5. Data Validation Strategy**
<!-- **Instruction:** Specify a strategy for validating the data itself at each stage of the phase's pipeline. This could involve recommending specific data quality checks (e.g., using pandera or Great Expectations) or defining schema validation protocols. -->

[AGENT-GENERATED CONTENT HERE]

##### **6. Foresight & Downstream Considerations**
<!-- **Instruction:** Identify and discuss potential future issues, limitations, or enhancement opportunities related to this task's script or output. Discuss scalability, dependencies, security, and extensibility in detail. -->
*   [AGENT-GENERATED CONSIDERATION 1]
*   [AGENT-GENERATED CONSIDERATION 2]

---
<!-- **Instruction:** Repeat the above template for the next file/task. -->

### **Protocol for: `[path/to/next_file.ext]`**
...etc...

---

## 5. Analytical Assets & Deliverables (from Blueprint)

<!--
**INSTRUCTION FOR AGENT:**
Copy the "Analytical Assets & Deliverables" table and the entire "Phase-Specific Analytical Framework" appendix directly from the `Phase_X_Architectural_Blueprint.md`. This makes the execution plan a self-contained reference document. This section must be very long and technically detailed, providing a comprehensive narrative of the entire set of deliverables.
-->

### 5.1. Summary of Deliverables

[AGENT-GENERATED DELIVERABLES TABLE COPIED FROM BLUEPRINT]

### 5.2. Phase-Specific Analytical Framework

[AGENT-GENERATED CUSTOM FRAMEWORK COPIED FROM BLUEPRINT'S APPENDIX]

---

## 6. Strategic Project Guidance

### 6.1. Implement a Test Suite
<!--
**INSTRUCTION FOR AGENT:**
Provide a detailed paragraph explaining the importance of implementing the formal `pytest` test suites as detailed in the protocols. Emphasize that this is a non-negotiable step for ensuring software quality and preventing regressions.
-->

### 6.2. Version Control Best Practices
<!--
**INSTRUCTION FOR AGENT:**
Provide a detailed paragraph outlining the required version control practices. Mandate the use of Git, the commitment of all final scripts and templates, and the critical importance of ensuring that `config.ini` and the `outputs/` directory are included in `.gitignore`.
-->

### 6.3. Documentation Update
<!--
**INSTRUCTION FOR AGENT:**
Provide a detailed paragraph explaining the final step of updating high-level project documentation (`PLANNING.md`, `architecture.md`) upon the successful completion of the entire phase.
-->

---
