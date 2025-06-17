# USER

Can you analyze my project docs (architecture, overview, readme_updated) and study the other attached docs on windsurf rule system design in great detail. Then, can you help me work on the design of an optimal windsurf rule system for my project? I want to use a .windsurf/rules/ setup, global_rules.md, TASKS.md, PLANNING.md/TASKS.md, and likely some of the other types of files as well (but I need your help!!) I also want to setup an MCP rule system protocol, and I need your help figuring out the optimal MCPs to use (per online research). My current MCPs are below:

| MCP Server | Category / Primary Use‑Case | Key Capabilities (summary) | Representative Tools / APIs | Required Env Vars | OS / Platform Notes | Docs / Source |
|------------|----------------------------|----------------------------|-----------------------------|-------------------|---------------------|---------------|
| **sequential‑thinking** | Reflective step‑wise reasoning | Dynamic “chain‑of‑thought”, branching, revisions, adjustable step count | `sequentialthinking` | – | Cross‑platform | [link](https://github.com/modelcontextprotocol/servers/tree/main/src/sequentialthinking) |
| **context7** | Live library documentation retrieval | Pulls **version‑specific** docs & code samples into LLM prompts; avoids hallucinations | `resolve‑library‑id`, `get‑library‑docs` | – | Cross‑platform | [site](https://context7.com) / [git](https://github.com/upstash/context7) |
| **filesystem** | Local file & directory operations | Read / write / edit / move / search files; JSON tree & metadata | `read_file`, `edit_file`, `search_files`, `directory_tree` | – | Access **restricted to whitelisted paths** | [git](https://github.com/modelcontextprotocol/servers/tree/main/src/filesystem) |
| **brave‑search** | Web & local search | Brave Web Search + Local business search; pagination, freshness filters, smart fallback | `brave_web_search`, `brave_local_search` | `BRAVE_API_KEY` (redacted) | Cross‑platform | [git](https://github.com/w-jeon/mcp-brave-search) |
| **memory** | Knowledge‑graph long‑term memory | Persistent entities, relations, atomic observations; full CRUD + graph read/search | `create_entities`, `create_relations`, `read_graph` | – | Cross‑platform | [git](https://github.com/modelcontextprotocol/servers/tree/main/src/memory) |
| **github** | GitHub repo & PR automation | Create/update files, branches, issues, PRs, code/issue/user search, batch pushes | `create_or_update_file`, `push_files`, `create_pull_request` | `GITHUB_PERSONAL_ACCESS_TOKEN` (redacted) | Cross‑platform | [git](https://github.com/modelcontextprotocol/servers/tree/main/src/github) |
| **fetcher** | Web page content extraction | Playwright‑based JS rendering; Readability main‑content; HTML/MD output; batch fetch | `fetch_url`, `fetch_urls` | – | Cross‑platform | [git](https://github.com/jae-jae/fetcher-mcp) |
| **excel** | Excel workbook manipulation | Read/write cells & formulas, sheet/table ops, screen capture (Win) | `excel_read_sheet`, `excel_write_to_sheet`, `excel_create_table` | `EXCEL_MCP_PAGING_CELLS_LIMIT` (optional) | **Windows‑only** for live features | [git](https://github.com/negokaz/excel-mcp-server) |
| **mcp‑sequentialthinking‑tools** | Reasoning **+ tool recommender** | Sequential thinking **with confidence‑scored MCP tool suggestions** per step | `sequentialthinking_tools` | – | Cross‑platform | [git](https://github.com/spences10/mcp-sequentialthinking-tools) |
| **code‑reasoning** | Code‑focused structured reasoning | Hybrid prompt; branchable, revision‑aware programming analysis & debugging | `code-reasoning` | – | Cross‑platform | [git](https://github.com/mikeysrecipes/code-reasoning) |
| **docs‑manager** | Markdown docs lifecycle | Read/write/edit with YAML front‑matter, nav generation, health checks, LLM export | `read_doc`, `edit_doc`, `generate_navigation`* | – | Cross‑platform | [git](https://github.com/alekspetrov/mcp-docs-service) |
| **doc‑tools‑mcp** | Word document automation | Create/open docs, add paragraphs/tables, find‑replace, metadata, layout | `create_document`, `add_table`, `search_and_replace` | – | Cross‑platform | [git](https://github.com/puchunjie/doc-tools-mcp) |
| **smart‑thinking** | Graph‑based adaptive reasoning | Multi‑dimensional thought graph, auto‑verification, visualisation, persistence | `smart-thinking` | `SMART_THINKING_DATA_DIR` (optional) | Cross‑platform; NVM‑aware | [git](https://github.com/leghis/smart-thinking) |

**ALSO I just added the Desktop COmmander MCP and its outstanding -- will definitely use it!**


---

# ASSISTANT

# Gemini 2.5 Pro proposed rule system

Okay, I can help you design an optimal Windsurf rule system for your Digital TMP project. This is a fascinating and complex undertaking, and a well-structured rule system will be invaluable for guiding Cascade and ensuring consistency across its eight phases.

Here's a proposed design for your Windsurf rule system, including the `.windsurf/rules/` setup, `global_rules.md`, `PLANNING.MD`, `TASKS.MD`, supporting files, and an MCP rule protocol tailored to your project's needs and your listed MCPs (including Desktop Commander).

## Windsurf Rule System Design for Digital TMP

This system emphasizes modularity, phase-specific guidance, and efficient use of your powerful MCP toolset.

---

### 1. Core Rule Files & Project Context Documents

These files will provide the foundational context and high-level instructions for Cascade.

**A. `PLANNING.MD` (Project Root)**

* **Purpose**: This document will serve as the primary, high-level overview of the Digital TMP project for Cascade. It should be relatively static but comprehensive.
* **Content Strategy**: Synthesize key information from your `overview.md` and the "Project Architecture Summary" and "Phase Overview" sections of your `architecture.md`.
* **Key Sections to Include**:
    * **Project Abstract & Goals**: Briefly state the project's aim (modernize TMP data into a geospatial research platform).
    * **Overall Architecture Philosophy**: Data science pipeline approach, reproducibility, scalability, interoperability, 8-phase structure.
    * **Key Stakeholders**: ASU Teotihuacan Research Laboratory, researchers, public audiences, INAH (informal).
    * **Primary Deliverables**: Unified PostgreSQL/PostGIS database, tDAR archival packages, webGIS dashboard, tutorials.
    * **Core Technologies (High-Level)**: Python, R, PostgreSQL/PostGIS, QGIS, GDAL, Docker, FastAPI, Leaflet.js. (Detailed tech per phase will go into `ARCHITECTURE_DETAILS.MD`).
    * **Ethical Considerations/Data Sensitivity**: (If any, e.g., handling archaeological site data).
* **AI Interaction**: "Always consult `PLANNING.MD` at the beginning of a new major task or when switching project phases to re-orient to the project's overall goals and context."

**B. `ARCHITECTURE_DETAILS.MD` (Project Root or in `.windsurf/`)**

* **Purpose**: This document will provide Cascade with the detailed, phase-by-phase architectural and methodological information from your `architecture.md`. It's the technical blueprint.
* **Content Strategy**: This will be a structured representation of your `architecture.md`, focusing on:
    * **Detailed Phase Descriptions**: For each of the 8 phases:
        * Objective/Description
        * Key Inputs
        * Key Outputs
        * Core Technologies & Specialized Tools/Libraries to be used in this phase.
    * **Data Flow Overview**: A summary of how data transforms from Phase 1 through Phase 8.
    * **Key Database Schemas (Conceptual)**: Brief overview of legacy schemas and the target PostGIS schema.
* **AI Interaction**: "For any task related to a specific project phase, consult `ARCHITECTURE_DETAILS.MD` to understand the inputs, outputs, tools, and objectives of that phase."

**C. `TASKS.MD` (Project Root - Dynamic)**

* **Purpose**: This is your dynamic, AI-managed task list. Cascade will update this as it completes steps.
* **Initial Content**: You can pre-populate this with the 8 main phases as top-level tasks, and perhaps the key workflows within each phase as initial sub-tasks.
    ```markdown
    # Digital TMP Project Tasks

    ## [ ] Phase 1: Database Analysis
        - [ ] Workflow 1.1: Legacy Database Instantiation & Validation
        - [ ] Workflow 1.2: Schema Analysis, Profiling, and Denormalization Evaluation
    ## [ ] Phase 2: Database Transformation
        - [ ] Workflow 2.1: Legacy Dataset Integration
        - [ ] Workflow 2.2: Variable Redesign and Analytical Transformation
        ... (and so on for all 8 phases)
    ```
* **AI Interaction**: Cascade will be instructed by rules (see below) to break down workflow tasks into smaller, actionable steps and mark them as complete in this file.

---

### 2. Global Rules: `global_rules.md`

This file, stored in your Windsurf global configuration, will set universal standards for Cascade's behavior across all your projects, including Digital TMP.

```markdown
# Global AI Coding Assistant Rules

## 🗣️ Communication & Interaction
- **Language**: Always respond in clear, concise, and professional English.
- **Clarity**: If instructions are ambiguous or potentially lead to data loss/security risks, ASK for clarification before proceeding. Do not make assumptions on critical tasks.
- **Verbosity**: Be appropriately verbose. Provide enough detail to understand your actions and reasoning, but avoid unnecessary chatter. Summarize long outputs.
- **Error Reporting**: Report errors clearly, stating the error, the context, and potential causes or steps taken to debug.
- **Mode Declaration (If using RIPER-5 or similar)**: Explicitly state your current operational mode (e.g., `[MODE: PLANNING]`, `[MODE: EXECUTING]`) if requested for specific complex workflows.

## 💻 Code Generation & Quality
- **Primary Languages**: For the Digital TMP project, primary languages are Python, SQL, and R. Adhere to best practices for each.
- **Python**:
    - Follow PEP 8 style guidelines.
    - Use type hints for all new functions and class methods.
    - Write clear, Google-style docstrings for all functions and classes.
    - Prioritize readable, maintainable code.
- **SQL**:
    - Format SQL queries читабельно (e.g., keywords in uppercase, proper indentation).
    - Use explicit JOINs.
    - Comment complex query sections.
- **R**:
    - Follow a consistent style (e.g., Tidyverse style guide).
    - Comment code adequately.
    - Use `library()` for package loading at the start of scripts.
- **Version Control**: Assume all project code is managed with Git. Generate `.gitignore` files appropriate for the project technologies. Adhere to commit message guidelines if provided in project rules.
- **Testing**: For new functions or significant logic, suggest or generate basic unit tests (e.g., using `pytest` for Python, `testthat` for R).
- **Security**:
    - NEVER hardcode secrets (API keys, passwords, database credentials). Instruct the user to use environment variables or a secure secret management system.
    - Be cautious with file system operations. Confirm paths and destructive actions.
- **Documentation**: Generate or update documentation (READMEs, code comments, external docs) as requested or when implementing new features.

## 🛠️ Tool Usage (General MCP Guidelines)
- **Transparency**: When using an MCP tool, briefly state which tool you are using and for what purpose, unless instructed to be silent.
- **Error Handling**: If an MCP tool call fails, report the error and suggest fallback strategies if appropriate (e.g., "`context7` failed, shall I try `brave-search` for documentation?").
- **Resource Limits**: Be mindful of potential rate limits or token consumption. For lengthy research, summarize findings or ask if more detail is needed.

## 📝 File Handling
- **File Paths**: Always confirm file paths, especially before writing or overwriting. Use relative paths from the project root where appropriate.
- **New Files**: When creating new files, suggest a logical location within the project structure.
- **Contextual Awareness**: Before modifying a file, state which file you are about to modify.
```

---

### 3. Project-Specific Rules: `.windsurf/rules/` Directory

This directory, located at the root of your Digital TMP project, will house Markdown files with rules tailored to the project's specific needs and phases.

**A. `project_conventions.md`**
* **Purpose**: Defines project-wide conventions for naming, versioning, documentation, and general conduct.
* **Content Examples**:
    ```markdown
    # Digital TMP Project Conventions

    ## Naming Conventions
    - **Databases & Schemas**: Use `tmp_` prefix for project-specific schemas (e.g., `tmp_raw_legacy_dbs`, `tmp_transformed_df12`). Tables and columns in `snake_case`.
    - **GIS Layers**: Use descriptive names in `kebab-case` or `snake_case` (e.g., `tmp_collection_units_poly.shp`, `architectural_reconstructions_final.gpkg`).
    - **Scripts**: Python/R scripts in `snake_case.py` or `snake_case.R`.
    - **Output Files**: Clearly indicate phase and content (e.g., `phase2_df12_output.csv`, `phase4_georeferencing_accuracy_report.pdf`).

    ## Versioning
    - Adhere to semantic versioning (MAJOR.MINOR.PATCH) for any software components developed (e.g., API, processing scripts).
    - Data outputs should be versioned using date stamps or version numbers in filenames/metadata (e.g., `TMP_DF12_v1.1_2025-05-23.csv`).

    ## Documentation Style
    - Project documentation (READMEs, phase reports) should be in Markdown.
    - Use clear, academic tone suitable for archaeological research. Cite sources where appropriate.
    - Diagrams (ERDs, flowcharts) should be generated using Mermaid syntax or linked as images.

    ## Task Management
    - Refer to and update `TASKS.MD` at the root of the project for all major steps.
    - Break down tasks from `ARCHITECTURE_DETAILS.MD` into actionable steps in `TASKS.MD`.
    ```

**B. `phase_specific_rules.md` (or one file per phase group, e.g., `data_foundation_rules.md` for P1-P2)**
* **Purpose**: Provides specific guidance relevant to the current phase of the project. This helps Cascade focus its actions and tool usage. You can use "Glob" activation here or instruct Cascade to manually load rules for a given phase.
* **Activation Suggestion**: Use "Manual" activation (e.g., `@phase1_rules`) or "Model Decision" based on task description mentioning a phase.
* **Content Examples**:

    ```markdown
    # Phase 1: Database Analysis Specific Rules
    - **Input Databases**: Legacy TMP Databases: `TMP_DF8`, `TMP_DF9`, `TMP_DF10`, and `TMP_REAN_DF2`.
    - **Core Tools**: PostgreSQL 17, Python 3.11+, SQLAlchemy, psycopg2, Pandas, SQLParse, Graphviz.
    - **Outputs**: PostgreSQL migration scripts, ERDs, schema profiling reports, denormalization white paper.
    - **Key Task**: Focus on systematic evaluation, profiling, and migrating legacy MS Access databases to PostgreSQL.
    - **MCP Usage**:
        - Use `filesystem` to read SQL DDL and data scripts.
        - Use `code-reasoning` or `sequential-thinking` to analyze database schemas and plan migration steps.
        - Use `docs-manager` if generating ERD descriptions or schema reports in Markdown.
    ```

    ```markdown
    # Phase 3: GIS Digitization Specific Rules
    - **Core Tool**: QGIS 3.40.5.
    - **Inputs**: Raster basemaps, legacy documentation.
    - **Key Task**: Manual digitization of archaeological, environmental, and modern features. Focus on accuracy and provisional attribute schemas.
    - **Outputs**: Digitized vector layers (Shapefiles initially), provisional attribute schemas, digitization metadata.
    - **MCP Usage**:
        - Use `Desktop Commander` to potentially script QGIS actions (if feasible and secure) or manage QGIS project files. Confirm specific QGIS scripting capabilities.
        - Use `filesystem` to manage raster basemaps and output vector files.
        - Use `sequential-thinking` to plan the systematic digitization of different feature categories.
    ```
    *(Create similar blocks for other phases or groups of phases, referencing your `architecture.md` for tools and tasks.)*

**C. `database_interaction_rules.md`**
* **Purpose**: Rules for interacting with PostgreSQL and PostGIS.
* **Content Examples**:
    ```markdown
    # Database Interaction Rules (PostgreSQL/PostGIS)

    - **Connection**: Assume database connection details are managed via environment variables or a secure config. Do not ask for credentials in chat.
    - **SQL Queries**:
        - Write ANSI SQL compatible with PostgreSQL 17.
        - Use PostGIS spatial functions for geospatial queries (e.g., `ST_Transform`, `ST_Area`, `ST_IsValid`).
        - Always parameterize queries when dealing with user inputs (though direct user input to DB might be rare in this project's AI tasks).
    - **Schema Migrations**: If schema changes are needed, suggest generating Alembic migration scripts (if SQLAlchemy ORM is used) or standard SQL DDL.
    - **Data Loading**: For loading data (e.g., CSVs into tables), prefer PostgreSQL's `COPY` command or `psycopg2`'s `copy_expert`. For spatial data, use `ogr2ogr` or `raster2pgsql`.
    - **Validation**: Always validate spatial geometries using `ST_IsValid` after transformations or loading.
    ```

**D. `gis_processing_rules.md`**
* **Purpose**: Guidelines for using QGIS, GDAL, PROJ, and related geospatial libraries.
* **Content Examples**:
    ```markdown
    # GIS Processing Rules

    - **CRS (Coordinate Reference Systems)**:
        - Be explicit about CRS for all spatial data. Default analytical CRS is EPSG:32614 (UTM Zone 14N). Public-facing/WebGIS is EPSG:4326.
        - For transformations involving "Millon Space," refer to the custom NTv2 grid shift pipeline defined in Phase 4 documentation.
    - **GDAL/OGR**:
        - Use `gdal_warp` and `gdal_translate` for raster operations.
        - Use `ogr2ogr` for vector format conversions and transformations.
        - When scripting with Python, use the `osgeo.gdal` and `osgeo.ogr` libraries.
    - **QGIS**:
        - Assume QGIS 3.40.5 is the primary desktop GIS.
        - For manual digitization, follow guidelines in `phase_specific_rules.md` (Phase 3).
        - For georeferencing, use QGIS Georeferencer or GDAL tools as specified in Phase 4.
    - **Python Geospatial Libraries**:
        - Prefer `geopandas` for vector data manipulation in Python.
        - Use `shapely` for geometry operations.
        - Use `rasterio` or `rioxarray` for raster processing in Python (rasterstats is also mentioned).
        - Use `pyproj` for programmatic CRS transformations.
    ```

**E. `tdar_outputs_rules.md`**
* **Purpose**: Specific rules for preparing archival packages for tDAR in Phase 6.
* **Content Examples**:
    ```markdown
    # tDAR Output Preparation Rules (Phase 6)

    - **Formats**: Ensure datasets are in tDAR-compliant formats (Shapefiles, CSV, compressed GeoTIFF subsets).
    - **Metadata**: All datasets must have comprehensive metadata at project, dataset, and file levels, adhering to tDAR standards.
    - **Controlled Vocabularies**: Use and package controlled vocabularies (CSV and PDF glossaries).
    - **Documentation**: Include ReadMe files, data dictionaries, methodological reports, and provenance information.
    - **Packaging**: Use 7-Zip for creating compressed submission packages. For large datasets, use Zenodo/Figshare and link with DOIs in tDAR.
    ```

---

### 4. Supporting Rule System Files

These files provide additional structured context that Cascade can reference.

**A. `GLOSSARY.MD` (in `.windsurf/` or project root)**
* **Purpose**: Defines key terms, acronyms, database versions, and project-specific jargon.
* **Content Examples**:
    * `TMP`: Teotihuacan Mapping Project
    * `DF8, DF9, DF10, DF11, DF12`: Specific legacy or transformed database versions.
    * `REANs_DF2, REANs_DF3, REANs_DF4`: Ceramic reanalysis database versions.
    * `SSN`: Site Survey Number (Primary Key).
    * `GCP`: Ground Control Point.
    * `NTv2`: National Transformation version 2 (grid shift format).
    * `tDAR`: The Digital Archaeological Record.
    * `Millon Space`: The local, non-georeferenced coordinate system of the original TMP maps.

**B. `TOOLING_MCP.MD` (in `.windsurf/`)**
* **Purpose**: Defines how Cascade should use specific MCP tools for the Digital TMP project, including preferred tools for tasks, parameters, and simple fallback logic.
* **Content Examples**:

    ```markdown
    # Digital TMP MCP Tool Usage Protocols

    ## General Principles
    - When a task involves multiple steps or complex reasoning, prefer `mcp-sequentialthinking-tools` or `smart-thinking` to plan and suggest subsequent tool use.
    - For coding tasks (Python, R, SQL), use `code-reasoning` for analysis and generation.
    - Always confirm file operations with `filesystem` or `Desktop Commander` if they are potentially destructive or outside a clearly defined output directory.

    ## Specific Tool Guidance

    ### `filesystem` & `Desktop Commander`
    - **Use for**: Reading source data (SQL scripts, legacy DB files if accessible as flat files), writing transformed data, managing GIS files, creating output reports, interacting with local QGIS/GDAL CLI if `Desktop Commander` allows direct command execution.
    - **Default Paths**: Assume project root for relative paths unless specified. Outputs should generally go to a phase-specific `outputs/` subfolder (e.g., `phases/02_TransformDB/outputs/`).
    - **Security**: Confirm write paths, especially with `Desktop Commander`. Do not write outside the project directory without explicit confirmation.
    - **`Desktop Commander` specific**: If capable of executing local commands (e.g., `ogr2ogr`, `psql`), confirm command syntax and expected outcomes before execution. Prioritize this for local CLI tool interactions over `run_command` if more robust.

    ### `github`
    - **Use for**: Committing versioned datasets, scripts, documentation, and rule files. Creating branches for new phases or features.
    - **Commit Messages**: Follow `feat:`, `fix:`, `docs:`, `chore:`, `refactor:`, `style:` conventions as per `project_conventions.md`.
    - **Branching**: Suggest creating a new branch for tasks related to a new project phase.

    ### `context7`
    - **Use for**: Getting documentation for Python (e.g., `pandas`, `geopandas`, `sqlalchemy`, `psycopg2`, `shapely`, `fastapi`) and R (`sf`, `tidyverse`, `DBI`) libraries used in scripting.
    - **Fallback**: If `context7` fails or docs are unavailable, try `brave-search`.

    ### `brave-search` & `Workspaceer`
    - **Use for**:
        - Researching specific archaeological methods or standards (e.g., tDAR metadata requirements, georeferencing techniques).
        - Finding documentation for less common tools or libraries not covered by `context7`.
        - Investigating errors or specific PostGIS/GDAL function usage.
    - **`Workspaceer`**: Use when a direct URL to relevant documentation or a resource is identified.

    ### `memory`
    - **Use for**:
        - Storing key decisions made during each phase (e.g., "Phase 1: Decided on denormalized schema X for REANs database based on profiling report Y").
        - Remembering critical parameters (e.g., "Millon Space to EPSG:32614 transformation grid name is Z").
        - Storing controlled vocabulary lists once finalized.
    - **Prompting**: "Remember this decision for future tasks related to [Phase/Topic]: [Decision details]."

    ### `docs-manager`
    - **Use for**:
        - Generating structured documentation for tDAR packages (Phase 6).
        - Creating tutorial outlines and content for Python, R, QGIS (Phase 8).
        - Maintaining `README.md`, `PLANNING.MD`, `ARCHITECTURE_DETAILS.MD`.
    - **Frontmatter**: Ensure YAML frontmatter in generated docs includes `title`, `phase`, `last_updated`.

    ### `doc-tools-mcp`
    - **Use for**: Only if "historical documentation" includes Word documents that need text extraction or analysis. Otherwise, likely low priority.

    ### `code-reasoning`, `sequential-thinking`, `mcp-sequentialthinking-tools`, `smart-thinking`
    - **`code-reasoning`**: Use for detailed analysis of existing scripts (Python, R, SQL), planning refactoring, or debugging.
    - **`sequential-thinking`**: For breaking down high-level tasks (e.g., "Plan Phase 2 ETL process") into a sequence of logical steps.
    - **`mcp-sequentialthinking-tools`**: Prefer this if the task involves both planning *and* identifying appropriate subsequent MCP tool calls. This tool can recommend other MCPs.
    - **`smart-thinking`**: For complex problem-solving where multiple dimensions or alternative approaches need to be explored, e.g., optimizing the georeferencing workflow or designing the PostGIS database schema.

    ## Fallback Strategy Example
    - "If `context7` lookup for 'geopandas.overlay' fails, then use `brave-search` for 'geopandas overlay function example python'."
    ```

**C. `EXAMPLES.MD` (in `.windsurf/`)**
* **Purpose**: Provides Cascade with canonical examples of code, queries, metadata structures, and file formats.
* **Content Examples**:
    * A well-formatted Python function with type hints and docstrings.
    * An example of a complex PostGIS spatial query used in the project.
    * The required YAML frontmatter structure for tDAR metadata.
    * A snippet of a correctly formatted controlled vocabulary CSV.
    * An example commit message.

---

### 5. Using the Rule System in Practice

* **Activation**:
    * `global_rules.md` and rules in `.windsurf/rules/` (without specific glob or manual triggers) will generally be "Always On" or "Model Decision" by default depending on Windsurf's behavior.
    * For phase-specific rules, explicitly instruct Cascade: "For this task in Phase 3, please apply rules from `@phase3_gis_digitization_rules` (if using manual activation via `@rule_name` convention) or consider guidelines in `phase_specific_rules.md` relevant to GIS digitization."
* **Initial Prompting**: When starting work on a new phase or a major task: "We are now beginning Phase X: [Phase Name]. Please consult `PLANNING.MD` for general project context, `ARCHITECTURE_DETAILS.MD` for the specifics of Phase X, and load relevant rules from `phase_specific_rules.md` and `TOOLING_MCP.MD`. The current objectives are outlined in `TASKS.MD` under Phase X."
* **Iterative Refinement**: Observe Cascade's behavior. If it deviates from expectations, refine the rules in the `.windsurf/rules/` files or adjust your prompting strategy. Use `RULES_FEEDBACK.MD` (another supporting file you could create) to log when rules are misapplied or need improvement.

This comprehensive rule system, combining global standards, project-specific conventions, detailed architectural context, and explicit MCP tool guidance, should provide a robust framework for leveraging Cascade effectively throughout your Digital TMP project. Remember that rule systems are "living documents" and will benefit from iterative refinement as the project progresses.
