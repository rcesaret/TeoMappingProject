# Digital TMP Project: MCP Tool Usage Guidelines & Protocols

**Version:** 1.1
**Date:** 2025-06-17
**Status:** Revision 1 (Integrated Community & Project Rules)

## 1. Introduction

This document is the authoritative guide for using Model Context Protocol (MCP) servers and tools within the Digital TMP project. It is intended for both human developers and the Windsurf Cascade AI agent. All MCP tool usage **MUST** adhere to the protocols and best practices outlined herein.

This guide is a "living document" and should be considered **reference material**, as defined in our architectural discussions. It is invoked by a `model_decision` rule within the `.windsurf/rules/` directory when a prompt's context is related to MCP operations. Its purpose is to provide detailed, task-level instructions that complement the high-level behavioral constraints defined in the core rule files.

All operations must align with the project's guiding principles of **Reproducibility, Provenance Tracking, and Quality Assurance** as detailed in `PLANNING.md`.

## 2. General Principles for All MCP Tool Usage

These universal principles apply to the use of **any** MCP tool within this project and have been synthesized from global and project-specific rule files.

### 2.1 Core Tenets of Tool Usage

* **Intentionality:** Only use a tool when you have a clear and specific purpose for it. Do not use tools for exploratory "fishing expeditions".
* **Strategic Selection:** Analyze the codebase and user intent thoroughly before choosing tools. Select the most appropriate tool for each specific task.
* **Prefer Specialization:** Always use a specific, specialized tool over a generic one if available (e.g., use `mcp3_read_file` instead of `mcp3_execute_command` with `cat`). Specialized tools provide structured, reliable output. For example, use `read_file` instead of `execute_command('cat file.txt')`.
* **Parameter Precision:** Provide accurate and specific parameters to tools. For all tools that accept a file or directory path, always use the full absolute path to avoid ambiguity.
* **Output Analysis:** After a tool runs, carefully analyze its output. If the output is unexpected or indicates an error, address it before proceeding.

### 2.2 Safety and Efficiency Protocols

* **Safety First:** Never auto-run unsafe commands (e.g., deleting files, installing system dependencies) without explicit confirmation. Prioritize safety in all operations.
* **Be Explicit:** Never assume the environment state (e.g., active Conda environment, current directory). Explicitly define it in the tool call (e.g., using `conda run` or chaining a `cd` command).
* **Efficiency and Resource Awareness:** Be mindful of resource-intensive tools, such as those making external API calls. Use them efficiently and avoid redundant calls. Plan to collect all necessary data in a single step to avoid multiple calls for the same information.
* **Document Learnings:** Any new error resolution or effective strategy discovered during a task **must** be recorded in a memory to ensure this guide and future actions are updated.

### 2.3 Context and Fallback Awareness

* **MCP Awareness:** Always be aware of MCP as the primary means to access external tools and data. Consider using an MCP tool if a task requires information beyond the local codebase.
* **Tool Selection Rationale:** If multiple tools could apply to a task, briefly explain the rationale for choosing one, especially if the choice impacts performance or security.
* **Fallback Awareness:** If a primary external tool or service fails, suggest fallback mechanisms or alternatives, such as using cached results, local processing, or requesting manual intervention. Only fall back to `brave-search` when `context7` fails or for non-API research.

## 3. High-Level Tool Orchestration Strategy

For any complex, multi-step task that will involve several different MCP tools (e.g., executing a workflow from `PLANNING.md`), the **`mcp-sequentialthinking-tools`** server should be invoked first. Alternatively, `smart-thinking` can be used for complex spatial reasoning tasks.

* **Purpose:** To generate a high-level plan that outlines which tools to use, in what order, and with what expected outcomes. This provides a structured, auditable workflow before any actions are taken.
* **Workflow:**
    1.  Initiate `sequentialthinking_tools` to decompose the task.
    2.  Review the recommended tool chain and confidence scores.
    3.  Proceed with executing the steps using the recommended tools, guided by the `current_step` output.

### 3.1 Project Tool Mapping

The following provides a high-level mapping of project tasks to the appropriate MCP server, based on project rules.

* **Database Migrations & Queries:** `postgres-mcp`. Use for all PostGIS queries and migrations.
* **File System Operations (I/O):** `filesystem` (via `desktop-commander`). Also use for CSV ↔ Postgres conversions.
* **Command Line Operations (GDAL, ogr2ogr, Docker):** `desktop-commander`.
* **Code Analysis & Logic Decomposition:** `code-reasoning`.
* **Expert Research & Library Docs:** `context7` is the preferred tool.
* **Broader Web Research:** `brave-search`. Use for archaeological standards research when docs are absent.
* **Version Control (Git):** `github`. Use for version control and PR automation.
* **Markdown Documentation Management:** `docs-manager`. Use for front-matter and navigation generation.

## 4. Detailed Guidelines by MCP Server

The following sections provide project-specific guidance for each configured MCP server.

---

### **`brave-search` (MCP 0)**

* **Project Role:** Used for gathering external context, researching modern best practices for libraries used in the project (e.g., `GDAL`, `GeoPandas`), and finding solutions to novel technical challenges not covered by existing project documentation. It is also designated for archaeological standards research when specific documentation is absent.
* **Available Tools:** `mcp0_brave_web_search`, `mcp0_brave_local_search`.
* **Project-Specific Best Practices:**
    * An API key is required and **MUST** be configured in the environment before use.
    * When researching technologies used in the TMP project, use freshness filters (e.g., last year) to ensure results are relevant to the specified versions (`PostgreSQL 17`, `Python 3.11+`).
    * For location-based queries related to Teotihuacan, use `mcp0_brave_local_search` to gather information on nearby landmarks that could serve as potential modern Ground Control Points (GCPs).
    * This tool should only be used as a fallback when `context7` fails or for non-API research needs.

---

### **`code-reasoning` (MCP 1)**

* **Project Role:** A critical planning tool for decomposing complex programming tasks, particularly within the ETL and analysis scripts of Phases 1, 2, and 5. It should be used to think through logic before implementation.
* **Available Tools:** `mcp1_code-reasoning`.
* **Project-Specific Best Practices:**
    * This is a **planning tool, not an execution tool**. Use it to generate a `thought` sequence outlining the implementation of a complex Python function or SQL query.
    * The generated logic should then be passed to the agent for implementation.
    * Use the branching and revision features (`branch_from_thought`, `is_revision`) to explore and document trade-offs, such as comparing different schema denormalization strategies in Phase 1.

---

### **`context7` (MCP 2)**

* **Project Role:** The **primary and preferred** tool for fetching documentation for the core Python libraries used in this project (`SQLAlchemy`, `GeoPandas`, `pandas`, `Shapely`, `FastAPI`, `Great Expectations`). This helps avoid API misuse and model hallucinations.
* **Available Tools:** `mcp2_resolve-library-id`, `mcp2_get-library-docs`.
* **Project-Specific Best Practices:**
    * **Mandatory Workflow:** You **MUST** call `mcp2_resolve-library-id` first to get the `context7CompatibleLibraryID`. This exact ID must then be passed to `mcp2_get-library-docs`.
    * Use the `topic` parameter to narrow results, especially for large libraries like `pandas` or `GeoPandas`. For example, `topic="spatial_join"` is more efficient than fetching the entire GeoPandas documentation.

---

### **`desktop-commander` (MCP 3)**

* **Project Role:** The core server for all local system interactions, including running Python scripts, managing the Conda environment, and performing file operations as part of the ETL and analysis workflows. It is the designated tool for executing batch shell commands and CLI tools like `GDAL`, `ogr2ogr`, and `Docker`.
* **Available Tools:** `mcp3_execute_command`, `mcp3_read_file`, `mcp3_write_file`, `mcp3_list_directory`, `mcp3_edit_block`, etc..
* **Project-Specific Best Practices:**
    * **File Operations:** Strongly prefer the direct file tools (`mcp3_read_file`, `mcp3_write_file`, etc.) over shell equivalents (`cat`, `echo`). They are more robust and provide structured output suitable for a programmatic workflow. The `filesystem` toolset via `desktop-commander` is designated for all standard file I/O.
    * **Running Scripts:** To execute a Python script within the project's environment, **ALWAYS** use `conda run -n digital_tmp_base python phases/01_LegacyDB/src/00_setup_databases.py`. A direct `python` call may fail if the `digital_tmp_base` environment is not active in the shell where the MCP server is running.
    * **Editing Files:** Use `mcp3_edit_block` for small, surgical changes. For multiple edits in a single file, it is safer to use multiple, sequential `edit_block` calls rather than one large, complex replacement string.

---

### **`docs-manager` (MCP 4)**

* **Project Role:** Primary tool for managing the structured documentation in the `/docs` directory and the `README.md` files within each phase's sub-directory. Designated tool for managing Markdown front-matter and navigation generation.
* **Available Tools:** `mcp4_write_document`, `mcp4_read_document`, `mcp4_edit_document`, etc..
* **Project-Specific Best Practices:**
    * **Known Issue:** Be aware that `mcp4_list_documents` and `mcp4_search_documents` may be unreliable. Use `desktop-commander`'s `list_directory` as a fallback if needed.
    * **Directory Creation:** The `mcp4_create_folder` tool is not implemented. To create a new directory, include the full desired path in the `path` parameter of `mcp4_write_document` (e.g., `docs/new_folder/new_doc.md`).

---

### **`excel` (MCP 5)**

* **Project Role:** This tool is of limited use for the Digital TMP project, as all legacy data has been migrated from MS Access to SQL dumps. However, it may be used in initial QA steps if any `project_materials` are provided in `.xlsx` format.
* **Available Tools:** `mcp5_excel_describe_sheets`, `mcp5_excel_read_sheet`, `mcp5_excel_write_to_sheet`.
* **Project-Specific Best Practices:**
    * **Platform Constraint:** This tool is **Windows-only** for its live features. It should not be a required part of any cross-platform workflow.
    * Always begin by using `mcp5_excel_describe_sheets` to understand the file's structure before attempting to read data.

---

### **`fetcher` (MCP 6)**

* **Project Role:** Used for retrieving content from web pages, such as supplementary articles, external documentation, or data from public repositories referenced in `data_sources.md`.
* **Available Tools:** `mcp6_fetch_url`, `mcp6_fetch_urls`.
* **Project-Specific Best Practices:**
    * Use the default `extractContent=true` parameter for clean, readable text suitable for analysis or ingestion into project documentation.
    * If a target website uses heavy JavaScript or anti-bot measures, the `waitForNavigation=true` parameter may be required for a successful fetch.

---

### **`github` (MCP 7)**

* **Project Role:** Essential for all version control operations, including committing transformation scripts, updating documentation, and managing the project's PR-based workflow.
* **Available Tools:** `create_or_update_file`, `get_file_contents`, `create_pull_request`, `list_commits`, etc..
* **Project-Specific Best Practices:**
    * **File Updates:** When using `create_or_update_file` to modify an existing file, it is **mandatory** to provide the correct `sha` of the blob being replaced to avoid overwriting concurrent changes.
    * Always double-check `owner`, `repo`, and `branch` parameters to ensure operations are performed on the correct repository (`rcesaret/digital-tmp`) and branch.

---

### **`mcp-sequentialthinking-tools` (MCP 8)**

* **Project Role:** The **primary orchestrator** for complex, multi-phase workflows like "Phase 1: Database Analysis" or "Phase 4: Georeferencing". It combines planning with actionable tool recommendations and is the designated tool for phase planning and step sequencing.
* **Available Tools:** `sequentialthinking_tools`.
* **Project-Specific Best Practices:**
    * Invoke this at the beginning of any task described in `TASKS.md` that involves more than two distinct steps or tools.
    * Pay close attention to the `recommended_tools` output, including the `confidence` score and `rationale`, to make an informed decision on the next action.

---

### **`memory` (MCP 9)**

* **Project Role:** Critical for adhering to the "Document Learnings" general principle. Use this to build a persistent, long-term knowledge graph of the project's architecture and key decisions.
* **Available Tools:** `create_entities`, `add_observations`, `create_relations`.
* **Project-Specific Best Practices:**
    * **Entities:** Create entities for key project components like `TMP_DF12`, `PostGIS_Database`, `Phase4_Georeferencing_Workflow`.
    * **Observations:** Add atomic facts, such as "`TMP_DF12` contains 400+ variables" or "Georeferencing achieved <2m RMSE".
    * **Relations:** Define relationships, such as "`TMP_DF12` is an input to `Phase5_Geospatial_Integration`".

---

### **`postgres` (MCP 10)**

* **Project Role:** The main interface for direct interaction with the project's PostgreSQL/PostGIS databases during development, testing, and validation in Phases 1, 2, 5, 7, and 8.
* **Available Tools:** `execute_sql`, `list_objects`, `get_object_details`, `analyze_db_health`, `analyze_workload_indexes`.
* **Project-Specific Best Practices:**
    * **Error Avoidance:** When running a script that includes a `CREATE DATABASE` command (as in Phase 1 setup), the database connection **MUST** be set to **autocommit mode**. Failure to do so will result in transaction block errors.
    * **Discovery First:** Before querying, always use `mcp10_list_schemas` and `mcp10_list_objects` to explore the database and verify table/view names.
    * **Performance Tuning:** For any complex spatial queries developed in Phase 5 or 7, use `mcp10_explain_query` (with `analyze=true`) and `mcp10_analyze_query_indexes` to diagnose and improve performance.

---

### **`sequential-thinking` (MCP 11)**

* **Project Role:** A general-purpose planning tool, lighter than `code-reasoning`. Useful for outlining documentation structure in `docs/` or planning the steps for a Jupyter notebook analysis before writing the code.
* **Available Tools:** `sequentialthinking`.
* **Project-Specific Best Practices:**
    * Use this for non-coding problems or high-level planning. For code-specific logic breakdown, prefer `code-reasoning`. For multi-tool workflows, prefer `mcp-sequentialthinking-tools`.

---
