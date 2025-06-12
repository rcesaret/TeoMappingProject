# Digital TMP – `PLANNING.md`

AI assistants **MUST** reference this file at the start of each coding or documentation session to stay aligned with the overall architecture, deliverables, and reproducibility vision.

This file provides strategic, narrative context for collaborators and AI assistants. Machine-enforceable conventions now live in `global_rules.md` (generic) and `.windsurf/rules/` (TMP-specific). If procedure or behaviour guidance in this file ever conflicts with those rule files, **the rule files prevail**.

---

## 1. Project Summary

This project modernizes and unifies the legacy datasets of the **Teotihuacan Mapping Project (TMP)** archaeological survey. The initiative converts fragmented analog and digital records—including field notes, MS Access databases, and hand-digitized maps—into a fully reproducible PostgreSQL/PostGIS infrastructure for scholarly research, heritage management, and public dissemination.

The effort proceeds through eight sequential, modular phases that systematically transform legacy archaeological databases into a modern, integrated geospatial data infrastructure.

| Phase                               | Core Objective                                                                                              | Principal Outputs                                                                        |
| ----------------------------------- | ----------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| **1 Database Analysis**       | Systematic evaluation and profiling of legacy MS Access databases to inform optimal schema design           | PostgreSQL migration, ERDs, schema profiling reports, denormalization white paper        |
| **2 Database Transformation** | Comprehensive ETL and feature engineering to produce analysis-ready tabular datasets                        | TMP_DF12, TMP_REANs_DF4, transformation logs, validation reports                         |
| **3 GIS Digitization**        | Manual digitization of archaeological, environmental, and modern features from historical raster maps       | Digitized vector layers, provisional attribute schemas, digitization metadata            |
| **4 Georeferencing**          | High-precision georeferencing using custom NTv2 transformations and spatial accuracy validation             | Spatially-aligned datasets, transformation grids, accuracy assessments                   |
| **5 Geospatial Integration**  | Integration of tabular and spatial data with advanced feature engineering and architectural classification  | Fully integrated geospatial datasets, derived spatial attributes, classification schemes |
| **6 tDAR Outputs**            | Preparation and packaging of archival-ready datasets with comprehensive metadata for long-term preservation | tDAR-compliant packages, controlled vocabularies, documentation, tutorials               |
| **7 PostGIS Database**        | Design and deployment of production-grade spatial database with optimized schemas and performance tuning    | PostGIS database, Docker containers, SQL dumps, API endpoints                            |
| **8 Tutorials & Dashboards**  | Development of user-facing applications and comprehensive tutorials for diverse analytical workflows        | WebGIS dashboard, REST API, Python/R/QGIS tutorials                                      |

### 1.1 Guiding Principles

The Digital TMP project is built upon core methodological principles that ensure its long-term viability, scientific rigor, and broader impact. All development and transformations must adhere to these foundational tenets:

* **Reproducibility**: All transformations are documented in version-controlled code notebooks and tracked using version control (Git). Reproducible computational environments (e.g., Docker containers) ensure exact replication of the database environment across various platforms.
* **Provenance Tracking**: Maintain complete lineage documentation from original field records to final outputs, ensuring every step of data transformation is traceable.
* **Quality Assurance**: Implement multi-stage validation using both automated frameworks (e.g., Great Expectations) and expert human review to ensure data accuracy and integrity at every phase.
* **Scalability**: Design the system to handle the complexity of the full TMP dataset and accommodate future expansion, allowing for additional dataset integration (e.g., TMP excavations, LiDAR, GPR, drone photogrammetry).
* **Interoperability**: Ensure outputs conform to open standards for GIS and tabular data (e.g., Shapefile, GeoJSON, CSV, SQL) and prioritize compatibility with future technological environments. This approach supports diverse stakeholder needs and facilitates integration with other research contexts.
* **Accessibility**: Provide multiple methods for data access, balancing preservation requirements with contemporary access patterns (e.g., downloadable datasets, PostGIS database, web applications).

---

## 2. AI-Driven Workflow & Task Management Protocol

This project is architected to be developed and executed with the assistance of the **Windsurf Cascade AI agent**. The agent's behavior is governed by a deterministic, task-driven protocol designed to maximize accuracy, quality, and reproducibility.

### 2.1. Core Principles

- **Determinism**: The AI functions as a state machine, executing a predefined script of tasks rather than improvising.
- **Atomicity**: Work is decomposed into small, granular, and verifiable tasks.
- **Context-Awareness**: Tasks act as pointers, directing the AI to detailed instructions within the project's full documentation suite.

### 2.2. The Role of `TASKS.md`

The `TASKS.md` file is the central "program" for the AI agent. It contains a structured list of all work items, their dependencies, and the explicit "Definition of Done" for each.

**A detailed specification of the task schema and the agent's operational protocol is defined directly within the front matter of the `TASKS.md` file.** The agent is required by `global_rules.md` to adhere to this protocol at all times.

---

## 3. Project Architecture

The project is decomposed into three nested units:

* **Phases** – macro-level milestones (see table above)
* **Workflows** – cohesive processes within a phase
* **Tasks** – atomic work items tracked in `TASKS.md`

### 3.1 Phase Overview Table

| Phase                              | Description                                                                                                                     | Key Outputs                                                                              |
| ---------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| Phase 1 – Database Analysis       | Systematic evaluation and profiling of legacy MS Access databases to inform optimal schema design and transformation strategies | PostgreSQL migration, ERDs, schema profiling reports, denormalization white paper        |
| Phase 2 – Database Transformation | Comprehensive ETL and feature engineering to produce analysis-ready tabular datasets with standardized vocabularies             | TMP_DF12, TMP_REANs_DF4, transformation logs, validation reports                         |
| Phase 3 – GIS Digitization        | Manual digitization of archaeological, environmental, and modern features from historical raster maps                           | Digitized vector layers, provisional attribute schemas, digitization metadata            |
| Phase 4 – Georeferencing          | High-precision georeferencing using custom NTv2 transformations and spatial accuracy validation                                 | Spatially-aligned datasets, transformation grids, accuracy assessments                   |
| Phase 5 – Geospatial Integration  | Integration of tabular and spatial data with advanced feature engineering and architectural classification                      | Fully integrated geospatial datasets, derived spatial attributes, classification schemes |
| Phase 6 – tDAR Outputs            | Preparation and packaging of archival-ready datasets with comprehensive metadata for long-term preservation                     | tDAR-compliant packages, controlled vocabularies, documentation, tutorials               |
| Phase 7 – PostGIS Database        | Design and deployment of production-grade spatial database with optimized schemas and performance tuning                        | PostGIS database, Docker containers, SQL dumps, API endpoints                            |
| Phase 8 – Tutorials & Dashboards  | Development of user-facing applications and comprehensive tutorials for diverse analytical workflows                            | WebGIS dashboard, REST API, Python/R/QGIS tutorials                                      |

### 3.2 Modular Phase Breakdown

<details>
<summary>Phase 1 – Database Analysis</summary>

* **Workflow 1.1** — Create local PostgreSQL instances of legacy databases from SQL dump files and generate denormalized "benchmark" databases for performance comparison.
* **Workflow 1.2** — Orchestration script runs suite of profiling modules against databases + generates visual ERDs for each schema.
* **Workflow 1.3** — Aggregates detailed raw metric data files from Workflow 1.2 into high-level summaries and produces reports
* **Workflow 1.4** — Schema Analysis, Profiling, and Denormalization Evaluation using Jupyter Notebooks to report, evaluate and compare DBs; draft redesign proposal
* **Output:** Reproducible PostgreSQL versions, automated ERDs, quantitative schema profiling reports, denormalization white paper

</details>

<details>
<summary>Phase 2 – Database Transformation</summary>

* **Workflow 2.1** — Legacy Dataset Integration (DF8, DF9, DF10 → DF11; REAN DF2 → REAN DF3): ETL and integration into wide‑format dataframes
* **Workflow 2.2** — Variable Redesign and Analytical Transformation (DF11 → DF12; REAN DF3 → REAN DF4): Variable‑level cleaning, recoding, and feature engineering
* **Workflow 2.3** — Controlled Vocabulary Consolidation: Build metadata (data dictionaries, QA reports)
* **Workflow 2.4** — Automated Metadata Validation & Data Quality Framework: Implement validation and quality assurance
* **Output:** TMP_DF12, TMP_REANs_DF4, controlled vocabulary glossaries, variable transformation logs, automated validation reports

</details>

<details>
<summary>Phase 3 – GIS Digitization</summary>

* **Workflow 3.1** — Raster Assembly for Digitization Context: Construct high‑resolution raster mosaics
* **Workflow 3.2** — Manual Digitization of Vector Layers from the TMP Topo/Survey Map: Digitise archaeological and environmental features
* **Workflow 3.3** — Manual Digitization of Vector Layers from the TMP Architectural Reconstructions Map: Apply classification tags, validate topologies
* **Workflow 3.4** — Pre-Georeferencing Metadata & Quality Assurance: Generate GIS layer metadata
* **Output:** Digitized vector layers, provisional attribute schemas, digitization metadata

</details>

<details>
<summary>Phase 4 – Georeferencing</summary>

* **Workflow 4.1** — Raster Pre-Processing and Ground Control Points (GCPs): GCP calibration and transformation‑model selection
* **Workflow 4.2** — Raster Basemap Georeferencing Method Calibration and Optimization: Apply custom CRS transformations using PROJ + GDAL
* **Workflow 4.3** — Generation of Custom NTv2 Grid Shift Transformation Pipeline: Develop high-accuracy NTv2 grid shift files
* **Workflow 4.4** — Vector Data Georeferencing Using NTv2 Transformations: Apply transformations to vector datasets
* **Workflow 4.5** — Accuracy Assessment and Validation: Implement spatial accuracy validation procedures
* **Workflow 4.6** — Export of Georeferenced Datasets in Final CRSs: Prepare datasets for distribution
* **Output:** Spatially-aligned datasets, transformation grids, accuracy assessments, custom CRS definitions

</details>

<details>
<summary>Phase 5 – Geospatial Integration</summary>

* **Workflow 5.1** — GIS Integration: Load datasets into PostGIS
* **Workflow 5.2** — Architectural Feature Classification: Perform spatial joins and crosswalk generation
* **Workflow 5.3** — Geospatial Feature Engineering: Engineer spatial features; publish/export outputs
* **Workflow 5.4** — Spatial QA and Export: Final validation and export preparation
* **Output:** Fully integrated geospatial datasets, derived spatial attributes, architectural classifications

</details>

<details>
<summary>Phase 6 – tDAR Outputs</summary>

* **Workflow 6.1** — Data Preparation & Transformation: Convert datasets into archival-safe, tDAR-compliant formats
* **Workflow 6.2** — Metadata and Ontology Preparation: Create comprehensive metadata and controlled vocabularies
* **Workflow 6.3** — Documentation & Tutorial Development: Develop user-centered tutorials and guides
* **Workflow 6.4** — Packaging & Distribution: Finalize preparation for distribution through tDAR and supplementary repositories
* **Output:** tDAR-compliant packages, controlled vocabularies, comprehensive documentation, user tutorials

</details>

<details>
<summary>Phase 7 – PostGIS Database</summary>

* **Workflow 7.1** — PostGIS Database Design & Setup: Conceptualize and construct PostGIS database schema
* **Workflow 7.2** — PostGIS Database Construction & Validation: Implement schema and ingest spatial/non-spatial datasets
* **Workflow 7.3** — PostGIS Database Packaging & Distribution: Package and distribute for diverse user needs
* **Output:** PostGIS database, Docker containers, SQL dumps, API endpoints, static dataset exports

</details>

<details>
<summary>Phase 8 – Tutorials & Dashboards</summary>

* **Workflow 8.1** — Interactive WebGIS Dashboard App: Develop public-facing WebGIS dashboard
* **Workflow 8.2** — Python PostGIS Database Tutorial: Create Python-based tutorial in Jupyter Notebook format
* **Workflow 8.3** — R PostGIS Database Tutorial: Produce RMarkdown tutorial for R users
* **Workflow 8.4** — QGIS PostGIS Database Tutorial: Develop comprehensive QGIS tutorial
* **Output:** WebGIS dashboard, REST API, comprehensive tutorials (Python/R/QGIS)

</details>

---

## 4. Repository Structure

The repository follows a modular structure aligned with project phases and workflows. Key folders include:

```
\<repo-root\>/
├── .windsurf/rules/             \# Windsurf project-specific rule files
├── PLANNING.md                  \# Project overview, strategic context, and high-level architecture
├── TASKS.md                     \# Atomic work items and task tracking
├── .gitignore                   \# Files to ignore from Git version control
├── data/                        \# Project data (raw, interim, processed, external)
│   ├── external/
│   ├── interim/
│   ├── processed/
│   └── raw/
├── docs/                        \# Human-readable project documentation
│   └── drafts/
├── infrastructure/              \# Database scripts, Docker configurations
│   ├── db/
│   │   └── legacy\_db\_sql\_scripts/
│   └── docker/
├── knowledge\_base/              \# Knowledge files approved for the AI
├── notes/
├── outputs/                     \# Final deliverables, figures, and publication materials
├── phases/                      \# Structured by project phase
│   ├── 01\_LegacyDB/
│   │   ├── drafts/
│   │   ├── notebooks/
│   │   ├── outputs/
│   │   │   ├── erds/
│   │   │   ├── metrics/
│   │   │   └── reports/
│   │   ├── sql/
│   │   │   └── canonical_queries/
│   │   └── src/
│   │       └── profiling_modules/
│   ├── 02\_TransformDB/
│   │   ├── drafts/
│   │   ├── notebooks/
│   │   ├── outputs/
│   │   └── src/
│   ├── 03\_DigitizeGIS/
│   │   ├── drafts/
│   │   ├── notebooks/
│   │   ├── outputs/
│   │   └── src/
│   ├── 04\_Georef/
│   │   ├── drafts/
│   │   ├── notebooks/
│   │   ├── outputs/
│   │   └── src/
│   ├── 05\_GeoDB/
│   │   ├── drafts/
│   │   ├── notebooks/
│   │   ├── outputs/
│   │   └── src/
│   ├── 06\_tDAR/
│   │   ├── drafts/
│   │   ├── notebooks/
│   │   ├── outputs/
│   │   └── src/
│   ├── 07\_PostGIS/
│   │   ├── drafts/
│   │   ├── notebooks/
│   │   ├── outputs/
│   │   └── src/
│   └── 08\_Dashboards/
│       ├── drafts/
│       ├── notebooks/
│       ├── outputs/
│       └── src/
├── project\_materials/           \# Project materials not for the AI
├── report/                      \# Project reports
│   ├── appendices/
│   ├── drafts/
│   └── figures/
└── tests/                       \# Unit and integration tests by phase
```

### 4.1 Root Directory Files and Folders

- `.env`, `.env.example` – project-specific credentials (Git-ignored)
- `requirements.txt` – primary Python dependency list (pip-style)
- `.gitignore` – specifies files and folders to be ignored by Git
- `.windsurf/rules/` – directory for Windsurf IDE project-specific rule files

### 4.2 Phase-Specific Directories (`phases/`)

Structured by project phase (e.g., `01_LegacyDB/`, `02_TransformDB/` etc.):

- Each phase includes:
  - `src/` – Python scripts for core logic
  - `notebooks/` – Jupyter notebooks for QA or prototyping
  - `outputs/` – final artifacts and deliverables
  - `drafts/` – working documents and temporary files
  - `README.md` + `metadata.json` – workflow description and schema (conceptual, to be defined later)

### 4.3 Data Directories (`data/`)

- `raw/`, `interim/`, `processed/` – represent a DVC-friendly data lifecycle
- `external/` – stores Dropbox-downloaded datasets (e.g., raster tiles)
  - Ignored from Git via `.gitignore`

### 4.4 Infrastructure Directories (`infrastructure/`)

- `db/legacy_db_sql_scripts/` – stores SQL exports of legacy databases
- `docker/` – reserved for late-stage containerization, primarily in Phase 7
- `cloud_downloads.md` – provides guidance for cloud import scripting (conceptual)

### 4.5 Documentation and Project Materials (`docs/`, `project_materials/`)

- `architecture.md`, `overview.md`, `methods.md`, `data_sources.md`, `outputs_summary.md`, `references.md` – core human-readable project documentation.
- `CRS_Catalogue.csv` - Defines all sanctioned spatial reference systems, including custom *Millon Space* CRSs. Extend via Pull Request (PR) only (conceptual for `PLANNING.md`).
- `tDAR/` – contains archival formatting and metadata standards (conceptual, to be defined later).
- `TMP_Project_DS_Portfolio_OptimizStrategy/` – stores strategy documents and summaries (conceptual).

### 4.6 Testing Directory (`tests/`)

- Contains unit and integration tests, structured by phase, mirroring the `phases/` directory.

### 4.7 Files Without Version Control (via `.gitignore`)

- All `drafts/` folders
- `data/external/ms_raster_tiles` (example large dataset)
- System/editor-specific folders (`.idea/`, `.vscode/`)
- `project_materials/` contains project materials not intended for AI processing (conceptual)
- `knowledge_base/` contains knowledge files approved for the AI
- Local notebooks, cache folders

### 4.8 Notes on Large Files

- **Git LFS** will manage large rasters and project imagery.
- **DVC** (optional) can track heavy data evolution beyond Git-LFS capacity.

---

## 5. Technology Stack, Tools, and Dependencies

### 5.1 Core Programming Stack

- **Language**: Python 3.11+
- **Notebooks**: Jupyter (used for QA and geospatial EDA in Phases 2–8)
- **Environments**:
  - Use `conda` for dependency management, only using `pip` secondarily when a package is not available on `conda` (conceptual).
  - Use `.env` for storing credentials (being sure to add placeholders to `.env.example` as well) (conceptual).
- **Databases:** PostgreSQL 17 with PostGIS 3.4
- **GIS Desktop:** QGIS 3.40.5

### 5.2 Key Python Libraries

- **Data / ETL**: `pandas`, `numpy`, `sqlalchemy`, `pydantic`, `great_expectations`
- **Geospatial**: `gdal`, `ogr`, `rasterio`, `fiona`, `geopandas`, `shapely`, `pyproj`, `whitebox` (conceptual additions based on project scope)
- **Georeferencing**: `ntv2`, `affine`, `pyproj-transformer` (conceptual additions based on project scope)
- **Web Services**: `fastapi`, `leaflet.js` (for dashboards)
- **Testing**: `pytest`, `pytest-cov`, `pandas.testing`, `geopandas.testing`, and `great_expectations` (where applicable) (conceptual additions based on project scope)

### 5.3 Technology Stack Rationale

This project leverages a comprehensive technology stack combining industry-standard geospatial tools, modern data science frameworks, and cloud-native deployment strategies. Software selection prioritizes reproducibility, scalability, and long-term maintainability while ensuring compatibility with both research and archival infrastructure requirements.

- **Database Infrastructure**: PostgreSQL with PostGIS provides enterprise-grade spatial capabilities, ACID compliance, and excellent performance for complex analytical queries. Version 17 offers enhanced spatial indexing and improved JSON handling for metadata management.
- **Geospatial Processing**: GDAL/OGR serves as the foundational library for spatial data I/O and transformations, ensuring compatibility across diverse formats. QGIS provides essential manual digitization capabilities and visualization tools for quality assurance.
- **Programming Environments**: Python ecosystem (GeoPandas, Shapely, Folium) offers comprehensive geospatial analysis capabilities, while R (sf, tidyverse) provides specialized statistical and visualization tools for archaeological analysis. Both environments support reproducible research through Jupyter Notebooks and RMarkdown.
- **Deployment & Distribution**: Docker containerization ensures reproducible deployment environments, while FastAPI provides lightweight, high-performance API services. Leaflet.js enables cross-platform web mapping without external dependencies.
- **Data Quality & Validation**: Great Expectations and dbt (optional) provide automated data validation frameworks, while custom SQL constraints enforce spatial and relational integrity throughout the pipeline.
- **Archival Compatibility**: Tools selection prioritizes long-term preservation requirements, with exports to standard formats (Shapefile, GeoJSON, CSV) ensuring compatibility with future technological environments.

### 5.4 Conda Environment Management - digital_tmp_base

#### 5.4.1 Environment Overview

The Digital TMP project uses a dedicated Conda environment named **digital_tmp_base** as the primary computational environment for all project work. This environment provides a consistent, reproducible foundation that includes all necessary Python packages, geospatial libraries, and analytical tools required across the eight project phases.

#### 5.4.2 Environment Setup and Maintenance

- **Environment Definition**: The `digital_tmp_base_env.yml` file in the project root directory is the single source of truth for the digital_tmp_base environment specification. This file should be kept under version control.
- **Environment Creation**: New team members or workstations should create the environment using:
  ```bash
  conda env create -f digital_tmp_base_env.yml
  ```
- **Environment Activation**: Always activate the environment before any project work:
  ```bash
  conda activate digital_tmp_base
  ```
- **Environment Updates**: When adding new dependencies:
  1. Install the package directly: `conda install -n digital_tmp_base package_name` (or `pip install package_name` if not available via conda)
  2. Export the updated environment: `conda env export -n digital_tmp_base --no-builds > digital_tmp_base_env.yml`
  3. Commit the updated environment.yml file to version control
  4. Notify team members to update their environments

#### 5.4.3 Windsurf Guidelines for Conda Usage

- **Default Environment**: All Python scripts, notebooks, and analysis should be run within the digital_tmp_base environment. The use of other environments requires explicit justification and documentation.
- **Version Pinning**: All dependencies in environment.yml must have their versions pinned to ensure reproducible analysis across workstations and over time.
- **Package Installation Order**: Always prefer conda-forge channel packages over pip installations to ensure binary compatibility, especially for geospatial libraries with complex dependencies.
- **Environment Isolation**: Do not use the base conda environment for project work. Always use the dedicated digital_tmp_base environment to prevent dependency conflicts.
- **Documentation**: Document any non-standard environment configurations or workstation-specific adaptations in project notes.
- **Testing**: Test environment portability by periodically creating fresh environments from environment.yml on different workstations to ensure reproducibility.

#### 5.4.4 Key Environment Components

The digital_tmp_base environment integrates several critical component groups:

- **Core Python Stack**: Python 3.11+ with standard scientific computing packages
- **Geospatial Core**: GDAL, GeoPandas, Shapely, PyProj, and other geospatial libraries
- **Database Connectors**: SQLAlchemy, psycopg2, and GeoAlchemy for PostgreSQL/PostGIS integration
- **Visualization Tools**: Matplotlib, Folium, Plotly for geospatial visualization
- **Validation Frameworks**: Great Expectations, Pandera for data quality assurance
- **Jupyter Extensions**: Required notebook extensions for interactive development and documentation

This comprehensive environment ensures that all project contributors work with identical software configurations, maintaining computational reproducibility and consistent analytical outputs across different computing environments.

### 5.5 Metadata & Documentation

- **Markdown** for design notes; **YAML** side-cars for dataset metadata (conceptual).
- **tDAR exports:** metadata mapped to tDAR schema (conceptual).
- **LaTeX/Markdown with Pandoc** for comprehensive documentation generation.

### 5.6 Continuous Integration and Quality Gates

All automated enforcement (coverage floor, cyclomatic complexity, pre-commit hooks, schema-diff, etc.) is defined in `.windsurf/rules/` (conceptual, referring to sections 7-9 in `Doc06`). CI runs on GitHub Actions.

---

## 6. Data Sources Overview

The Digital TMP project integrates multiple generations of archaeological datasets spanning over five decades of data collection, analysis, and reanalysis. These datasets represent one of the most comprehensive urban-scale archaeological surveys ever conducted, encompassing over 5,000 surface collection units across approximately 37.5 square kilometers of the ancient city of Teotihuacan. The project prioritizes data quality, rigorous metadata, and reproducibility in its integration efforts.

### 6.1 Primary Dataset Index

| Dataset                  | Source                                      | Format          | Size    | Time Span    | Use Case                                                                  |
| ------------------------ | ------------------------------------------- | --------------- | ------- | ------------ | ------------------------------------------------------------------------- |
| **TMP\_DF8**       | ASU Teo Lab                                 | SQL dump (.sql) | \~15 MB | 1975-1977    | First stable electronic representation, 5,050 cases, 291 variables        |
| **TMP\_DF9**       | ASU Teo Lab (Ian Robertson & Angela Huster) | SQL dump (.sql) | \~18 MB | 1990s        | Relational database version with GIS integration capabilities             |
| **TMP\_DF10**      | ASU Teo Lab (Anne Sherfield)                | SQL dump (.sql) | \~20 MB | 2022-present | Most recent database with structural improvements and issue documentation |
| **TMP\_REAN\_DF2** | ASU Teo Lab (Ian Robertson & Angela Huster) | SQL dump (.sql) | \~12 MB | 1973-1983    | Ceramic reanalysis with enhanced typological detail                       |

### 6.2 Spatial Data Sources

| Dataset                                  | Source              | Format       | Size     | Coverage    | Use Case                                                |
| ---------------------------------------- | ------------------- | ------------ | -------- | ----------- | ------------------------------------------------------- |
| **TMP Survey Maps**                | René Millon (1962) | Scanned TIFF | \~2 GB   | 37.5 km²   | 1:2,000 scale photogrammetric base maps                 |
| **Architectural Overlays**         | Various researchers | Scanned TIFF | \~800 MB | Urban core  | Red-ink architectural interpretation drawings           |
| **Collection Unit Polygons (MF2)** | Ian Robertson       | Shapefile    | \~50 MB  | Survey area | Digitized collection tract boundaries in "Millon Space" |
| **Architectural Polygons**         | Anne Sherfield      | Shapefile    | \~30 MB  | Urban core  | Digitized architectural features with classification    |
| **Modern Satellite Imagery**       | Various providers   | GeoTIFF      | \~1 GB   | Regional    | Reference data for georeferencing validation            |

### 6.3 Ground Control Points & Reference Data

| Dataset                                         | Source            | Format        | Size     | Purpose          | Use Case                                                       |
| ----------------------------------------------- | ----------------- | ------------- | -------- | ---------------- | -------------------------------------------------------------- |
| **High-Density GCP Dataset**              | Manual collection | Shapefile/CSV | \~5 MB   | Georeferencing   | Control points for "Millon Space" to global CRS transformation |
| **Satellite Images & Aerial Photography** | Various agencies  | TIFF/JPEG     | \~500 MB | Reference        | Modern reference for GCP validation and accuracy assessment    |
| **Topographic Maps**                      | INEGI             | PDF/TIFF      | \~200 MB | Regional context | Mexican national topographic coverage for validation           |

### 6.4 Known Data Quality Issues (High-level Summary)

Despite decades of effort, the TMP digital archive presents complex legacy challenges including data fragmentation, quality, technological obsolescence, and incomplete documentation. This includes:

* **Legacy Database Issues**: Encoding inconsistencies, missing REANs records, "Total Counts Problem", and transcription errors.
* **Spatial Data Challenges**: Original "Millon Space" coordinate system, varied digitization precision, topology issues, and scale limitations of base maps.
* **Temporal Inconsistencies**: Data collection and analysis span multiple decades with evolving methodologies and ceramic reclassifications.

---

## 7. Further Reading

- `global_rules.md` — Cross-project conventions & human best practices.
- `.windsurf/rules/` — TMP-specific enforcement logic (directory for modular rules).
- `overview.md` — Project context, goals, background, project outline, architecture overview, general summaries.
- `architecture.md` — Detailed system design and data-flow diagrams.
- `methods.md` — Analytical methods, modelling choices, and statistical procedures.
- `data_sources.md` — Comprehensive documentation of all legacy TMP datasets, their provenance, content, and integration pathways.
- `outputs_summary.md` — Comprehensive showcase of all final outputs, deliverables, and research products.

---

*End of PLANNING.md*
