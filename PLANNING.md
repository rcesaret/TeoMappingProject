# Digital TMP – `PLANNING.md`

---
**Author:** Rudolf Cesaretti
**Affiliation:** ASU Teotihuacan Research Laboratory
**Date:** June 24, 2025
**Version:** v3.0
---

AI assistants **MUST** reference this file at the start of each coding or documentation session to stay aligned with the overall architecture, deliverables, and reproducibility vision.

This file provides strategic, narrative context for collaborators and AI assistants. Machine-enforceable conventions for this project live exclusively in the `.windsurf/rules/` directory. If procedure or behaviour guidance in this file ever conflicts with those rule files, **the rule files prevail**.

---

## 1. Project Summary

This project modernizes and unifies the legacy datasets of the **Teotihuacan Mapping Project (TMP)** archaeological survey. The initiative converts fragmented analog and digital records—including field notes, MS Access databases, and hand-digitized maps—into a fully reproducible PostgreSQL/PostGIS infrastructure for scholarly research, heritage management, and public dissemination.

The effort proceeds through eight sequential, modular phases that systematically transform legacy archaeological databases into a modern, integrated geospatial data infrastructure. This phased approach ensures a methodical progression from raw data analysis to the delivery of user-facing applications, with quality assurance and validation gates at each critical juncture.

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

---

## 2. AI-Driven Workflow & Guiding Principles

This project is architected to be developed and executed with the assistance of the **Windsurf Cascade AI agent**. The agent's behavior is governed by a deterministic, task-driven protocol designed to maximize accuracy, quality, and reproducibility.

### 2.1 Core AI Operational Protocol

- **Determinism**: The AI functions as a state machine, executing a predefined script of tasks rather than improvising. This ensures that every action is deliberate and traceable.
- **Atomicity**: Work is decomposed into small, granular, and verifiable tasks. This allows for precise quality control and simplifies debugging.
- **Context-Awareness**: Tasks act as pointers, directing the AI to detailed instructions within the project's full documentation suite, including this `PLANNING.md` file.

The `TASKS.md` file is the central "program" for the AI agent. It contains a structured list of all work items, their dependencies, and the explicit "Definition of Done" for each. **A detailed specification of the task schema and the agent's operational protocol is defined directly within the front matter of the `TASKS.md` file.** The agent is required by `global_rules.md` to adhere to this protocol at all times.

### 2.2 Guiding Principles & AI Constraints

The Digital TMP project is built upon core methodological principles that ensure its long-term viability, scientific rigor, and broader impact. To ensure strict adherence, these principles are implemented as non-negotiable constraints that must govern every action taken by the AI agent.

*   **Constraint: Reproducibility**
    All data transformations, analyses, and generated artifacts must be fully reproducible. Every operation that modifies or creates data must be encapsulated in a version-controlled script (e.g., Python, SQL, R). All script executions must use the project's official Conda environment, `digital_tmp_base`, as defined in `envs/digital_tmp_base_env.yml`, to guarantee a consistent computational environment. This eliminates "works on my machine" issues and ensures that any researcher can replicate the entire data pipeline from source to final product. Manual, one-off changes to data are strictly prohibited.

*   **Constraint: Provenance Tracking**
    The system must maintain a complete and traceable lineage for all data. For each phase that generates new data artifacts, a `metadata.json` file must be created or updated within that phase's directory. This file must log the input sources, the scripts used, the parameters of the operation, and the output artifacts. This ensures that every piece of data in the final product can be traced back to its origin through a verifiable chain of operations, a critical requirement for scholarly integrity.

*   **Constraint: Quality Assurance**
    Data integrity is paramount. Automated data quality validation checks must be implemented and executed at the conclusion of key data transformation phases (especially Phase 2 and Phase 5). Tools like Great Expectations will be used to define data assertions in a declarative, version-controllable format. Any data that fails validation must be flagged, and the process must not proceed until the issues are resolved and documented. For geospatial data, this includes running topology and geometry validation checks to ensure features are valid and free of errors like self-intersections or gaps.

*   **Constraint: Scalability**
    All architectural and code-level decisions must consider future scalability. The system must be designed to handle the full complexity of the TMP dataset and accommodate future expansion with new datasets (e.g., LiDAR, GPR, drone photogrammetry, excavation data). This includes designing database schemas that are performant and writing modular, extensible code that can be adapted without requiring a complete redesign.

*   **Constraint: Interoperability**
    All final data outputs must conform to open, community-accepted standards to ensure maximum compatibility with third-party tools and long-term archival standards as required by tDAR. Tabular data should be available in CSV, spatial vector data in GeoJSON and Shapefile, and spatial raster data in GeoTIFF. This approach supports diverse stakeholder needs and facilitates integration with other research contexts.

*   **Constraint: Accessibility**
    The project aims to make the TMP data broadly accessible. Documentation must be clear, comprehensive, and targeted to a range of user expertise. Final data products must be organized logically and be suitable for multiple access patterns, from direct PostGIS database connections for technical users to user-friendly web applications and downloadable datasets for the general public and researchers in other domains.

---

## 3. Project Architecture & Detailed Phase Execution Plan

The project is decomposed into three nested units: **Phases** (macro-level milestones), **Workflows** (cohesive processes within a phase), and **Tasks** (atomic work items tracked in `TASKS.md`). The following sections provide a detailed, phase-by-phase execution plan, integrating the strategic workflows with specific operational tasks and validation criteria.

### **Phase 1: Legacy Database Analysis**

*   **Objective:** To ingest, profile, and benchmark the four legacy TMP databases to produce a quantitative, evidence-based justification for the project's denormalization strategy. This phase is foundational, ensuring all subsequent transformations are based on a deep, empirical understanding of the source data's structure, content, and performance characteristics.

*   **Key Workflows:**
    *   **Workflow 1.1** — Create local PostgreSQL instances of legacy databases from SQL dump files and generate denormalized "benchmark" databases for performance comparison.
    *   **Workflow 1.2** — Orchestration script runs a suite of profiling modules against all databases and generates visual ERDs for each schema.
    *   **Workflow 1.3** — Aggregate detailed raw metric data files from Workflow 1.2 into high-level summaries and produce reports.
    *   **Workflow 1.4** — Schema Analysis, Profiling, and Denormalization Evaluation using Jupyter Notebooks to report, evaluate and compare databases; draft a redesign proposal.

*   **Execution & Validation:**
    *   **Key Inputs:**
        *   `infrastructure/db/legacy_db_sql_scripts/TMP_DF8.sql`
        *   `infrastructure/db/legacy_db_sql_scripts/TMP_DF9.sql`
        *   `infrastructure/db/legacy_db_sql_scripts/TMP_DF10.sql`
        *   `infrastructure/db/legacy_db_sql_scripts/TMP_REAN_DF2.sql`
    *   **Core Tasks:**
        1.  Execute `phases/01_LegacyDB/src/00_setup_databases.py` to create the PostgreSQL databases and ingest the legacy SQL dumps.
        2.  Execute `phases/01_LegacyDB/src/01_create_benchmark_dbs.py` to generate the two denormalized benchmark databases (`tmp_benchmark_wide_numeric`, `tmp_benchmark_wide_text_nulls`) from the `tmp_df9` source.
        3.  Execute `phases/01_LegacyDB/src/02_run_profiling_pipeline.py` to generate detailed data profiles for each of the six databases (four legacy, two benchmark).
        4.  Execute `phases/01_LegacyDB/src/03_generate_erds.py` to generate Entity-Relationship Diagrams (ERDs) for each database schema.
        5.  Execute `phases/01_LegacyDB/src/04_run_comparison.py` to run a canonical set of queries against all databases and measure the performance differences.
    *   **Key Outputs:**
        *   New tables in the PostgreSQL `tmp_benchmark` database.
        *   Data profile reports (HTML) located in `data/processed/profiling/`.
        *   ERD image files (.png) located in `data/processed/erds/`.
        *   A comparative performance report (`Phase1_Performance_WhitePaper.md`) in `data/processed/reports/`.
        *   An updated `phases/01_LegacyDB/metadata.json` file logging the entire process.
    *   **Validation Criteria:**
        *   All Python scripts must execute without error.
        *   All specified output directories and files must be created.
        *   The performance report must show a quantifiable performance improvement for analytical queries on the benchmark databases compared to the normalized legacy databases.

### **Phase 2: Database Transformation**

*   **Objective:** To execute a comprehensive ETL pipeline that transforms the fragmented legacy data into two unified, analysis-ready, and validated primary datasets (`TMP_DF12` and `TMP_REANs_DF4`). This phase addresses decades of data quality issues, standardizes vocabularies, and engineers new features for analysis.

*   **Key Workflows:**
    *   **Workflow 2.1** — Legacy Dataset Integration (DF8, DF9, DF10 → DF11; REAN DF2 → REAN DF3): ETL and integration into wide‑format dataframes.
    *   **Workflow 2.2** — Variable Redesign and Analytical Transformation (DF11 → DF12; REAN DF3 → REAN DF4): Variable‑level cleaning, recoding, and feature engineering.
    *   **Workflow 2.3** — Controlled Vocabulary Consolidation: Build metadata (data dictionaries, QA reports).
    *   **Workflow 2.4** — Automated Metadata Validation & Data Quality Framework: Implement validation and quality assurance using Great Expectations.

*   **Execution & Validation:**
    *   **Key Inputs:**
        *   All tables within the `tmp_df8`, `tmp_df9`, `tmp_df10`, and `tmp_rean_df2` PostgreSQL databases.
    *   **Core Tasks:**
        1.  Execute scripts to consolidate `tmp_df8`, `tmp_df9`, and `tmp_df10` into a provisional `tmp_df11` dataset.
        2.  Execute scripts for variable-level cleaning, recoding, and feature engineering to transform `tmp_df11` into the final `tmp_df12`.
        3.  Execute scripts for cleaning and transformation of `tmp_rean_df2` to produce `tmp_reans_df4`.
        4.  Implement and run a Great Expectations checkpoint against the final tables to validate data integrity.
    *   **Key Outputs:**
        *   The final, cleaned `TMP_DF12` and `TMP_REANs_DF4` tables within a new `digital_tmp` PostgreSQL schema.
        *   A Great Expectations Data Docs site detailing the results of the validation.
        *   An updated `phases/02_TransformDB/metadata.json` file.
    *   **Validation Criteria:**
        *   All ETL scripts must execute without error.
        *   The final tables `TMP_DF12` and `TMP_REANs_DF4` must be created and populated.
        *   The Great Expectations validation suite must pass with a success rate of at least 98.5%.

### **Phase 3: GIS Digitization**

*   **Objective:** To manually create high-fidelity provisional vector datasets by digitizing all relevant archaeological, environmental, and modern features from the original TMP raster maps. This is a critical, labor-intensive phase that translates analog cartographic knowledge into a structured digital format.

*   **Key Workflows:**
    *   **Workflow 3.1** — Raster Assembly for Digitization Context: Construct high‑resolution raster mosaics.
    *   **Workflow 3.2** — Manual Digitization of Vector Layers from the TMP Topo/Survey Map: Digitize archaeological and environmental features.
    *   **Workflow 3.3** — Manual Digitization of Vector Layers from the TMP Architectural Reconstructions Map: Apply classification tags, validate topologies.
    *   **Workflow 3.4** — Pre-Georeferencing Metadata & Quality Assurance: Generate GIS layer metadata.

*   **Execution & Validation:**
    *   **Key Inputs:**
        *   Assembled raster basemaps: `TMP_Map_Topo_MillonSpace_Full_v2.tif` and `TMP_Map_Architecture_MillonSpace_Full.tif`.
        *   Legacy vector data layers (e.g., Sherfield's architectural polygons, Robertson's collection units).
    *   **Core Tasks:**
        1.  Finalize the collection unit polygons, correcting topological errors and resolving missing/duplicate SSNs.
        2.  Digitize all previously un-digitized 'on-site' archaeological features from the Topo/Survey map (e.g., floors, walls, sherd concentrations, excavations).
        3.  Digitize all 'off-site' survey annotations (e.g., "Not Surveyed," "Nada" density zones).
        4.  Digitize all modern land use and environmental features (e.g., canals, roads, "Destroyed" areas).
        5.  Finalize the architectural reconstruction polygons by implementing Sherfield's "Map Assignations System" to convert line features into valid polygons.
    *   **Key Outputs:**
        *   A complete and topologically clean set of provisional vector datasets (as Shapefiles or GeoPackage files) in the local "Millon Space" coordinate system, stored in `data/interim/gis/`.
        *   An updated `phases/03_DigitizeGIS/metadata.json` file.
    *   **Validation Criteria:**
        *   All output vector layers must pass QGIS Geometry and Topology Checker validation (e.g., no self-intersections, no gaps, no invalid geometries).
        *   Feature counts in the digitized layers must align with manual counts from the source maps to ensure completeness.

### **Phase 4: Georeferencing**

*   **Objective:** To accurately transform all raster and vector datasets from the local, non-standard "Millon Space" to the target projected Coordinate Reference System, UTM Zone 14N (EPSG:32614), using a high-precision, custom transformation.

*   **Key Workflows:**
    *   **Workflow 4.1** — Raster Pre-Processing and Ground Control Points (GCPs): GCP calibration and transformation‑model selection.
    *   **Workflow 4.2** — Raster Basemap Georeferencing Method Calibration and Optimization: Apply custom CRS transformations using PROJ + GDAL.
    *   **Workflow 4.3** — Generation of Custom NTv2 Grid Shift Transformation Pipeline: Develop high-accuracy NTv2 grid shift files to model non-linear distortions.
    *   **Workflow 4.4** — Vector Data Georeferencing Using NTv2 Transformations: Apply transformations to vector datasets.
    *   **Workflow 4.5** — Accuracy Assessment and Validation: Implement spatial accuracy validation procedures.
    *   **Workflow 4.6** — Export of Georeferenced Datasets in Final CRSs: Prepare datasets for distribution.

*   **Execution & Validation:**
    *   **Key Inputs:**
        *   All provisional vector and raster datasets from Phase 3.
        *   The Ground Control Point (GCP) file: `data/raw/GIS/Georef/GCPs_SixthPassGeoref_3.13.25_Assessment_v4.csv`.
    *   **Core Tasks:**
        1.  Generate a custom NTv2 grid shift file (`.gsb`) using a Thin Plate Spline (TPS) transformation on the 1,900+ GCPs.
        2.  Define a custom CRS for "Millon Space" and register the new NTv2 transformation within the local PROJ database.
        3.  Apply the custom transformation to all vector layers using Python/GeoPandas.
        4.  Apply the custom transformation to the raster base maps using `gdal.Warp`.
    *   **Key Outputs:**
        *   A custom NTv2 grid shift file (`.gsb`).
        *   A complete set of georeferenced vector and raster datasets in UTM Zone 14N, stored in `data/processed/gis/`.
        *   An updated `phases/04_Georef/metadata.json` file.
        *   A detailed georeferencing accuracy report, including Root Mean Square Error (RMSE) and spatial error analysis.
    *   **Validation Criteria:**
        *   The georeferencing transformation must achieve a Root Mean Square Error (RMSE) of less than 2.0 meters.
        *   Moran's I analysis of residuals must show no significant spatial autocorrelation, indicating an unbiased transformation across the entire survey area.

### **Phase 5: Geospatial Integration**

*   **Objective:** To fully integrate the transformed tabular datasets with the georeferenced spatial layers within the PostGIS database and perform advanced spatial feature engineering to create a rich, analysis-ready geospatial dataset.

*   **Key Workflows:**
    *   **Workflow 5.1** — GIS Integration: Load datasets into PostGIS.
    *   **Workflow 5.2** — Architectural Feature Classification: Perform spatial joins and crosswalk generation.
    *   **Workflow 5.3** — Geospatial Feature Engineering: Engineer spatial features; publish/export outputs.
    *   **Workflow 5.4** — Spatial QA and Export: Final validation and export preparation.

*   **Execution & Validation:**
    *   **Key Inputs:**
        *   `TMP_DF12` and `TMP_REANs_DF4` tables in PostgreSQL.
        *   All georeferenced vector datasets from Phase 4.
    *   **Core Tasks:**
        1.  Load all georeferenced vector layers into the `digital_tmp` PostGIS database.
        2.  Perform spatial joins to link the `TMP_DF12` and `TMP_REANs_DF4` attribute data to their corresponding spatial geometries using the `SSN` primary key.
        3.  Execute SQL/GeoPandas scripts to perform spatial feature engineering (e.g., calculate areas, densities, proximity to features).
        4.  Execute rule-based classification scripts to assign final architectural types based on spatial and attribute logic.
    *   **Key Outputs:**
        *   A fully integrated PostGIS database with both attribute and spatial data correctly linked and accessible.
        *   New columns in the database tables containing the derived spatial features.
        *   An updated `phases/05_GeoIntegration/metadata.json` file.
    *   **Validation Criteria:**
        *   All spatial joins must be successfully executed with 100% record matching based on the SSN key.
        *   Derived spatial features must pass range and logical consistency checks (e.g., areas are positive, densities are within expected bounds).

### **Phase 6: tDAR Outputs**

*   **Objective:** To prepare and package all final datasets and documentation for long-term archival and preservation in The Digital Archaeological Record (tDAR), ensuring the project's outputs are durable and accessible for future generations of scholars.

*   **Key Workflows:**
    *   **Workflow 6.1** — Data Preparation & Transformation: Convert datasets into archival-safe, tDAR-compliant formats.
    *   **Workflow 6.2** — Metadata and Ontology Preparation: Create comprehensive metadata and controlled vocabularies.
    *   **Workflow 6.3** — Documentation & Tutorial Development: Develop user-centered tutorials and guides.
    *   **Workflow 6.4** — Packaging & Distribution: Finalize preparation for distribution through tDAR and supplementary repositories.

*   **Execution & Validation:**
    *   **Key Inputs:**
        *   The final, integrated PostGIS database from Phase 5.
        *   All project documentation from the `docs/` directory.
    *   **Core Tasks:**
        1.  Export all final data tables and GIS layers into tDAR-compliant, non-proprietary formats (CSV, GeoJSON, Shapefile, GeoTIFF).
        2.  Create a comprehensive, multi-level metadata package compliant with tDAR standards.
        3.  Develop user-centered documentation, including data dictionaries and tutorials.
    *   **Key Outputs:**
        *   A complete set of archival packages, organized logically in `data/processed/tdar_submission/`.
        *   An updated `phases/06_tDAR/metadata.json` file.
    *   **Validation Criteria:**
        *   All exported data files must conform to the specified formats.
        *   The metadata package must successfully validate against the tDAR submission schema.

### **Phase 7: PostGIS Database**

*   **Objective:** To finalize and package the production-grade PostGIS database for public distribution, enabling advanced users to directly access and query the full, integrated dataset.

*   **Key Workflows:**
    *   **Workflow 7.1** — PostGIS Database Design & Setup: Conceptualize and construct PostGIS database schema.
    *   **Workflow 7.2** — PostGIS Database Construction & Validation: Implement schema and ingest spatial/non-spatial datasets.
    *   **Workflow 7.3** — PostGIS Database Packaging & Distribution: Package and distribute for diverse user needs via Docker.

*   **Execution & Validation:**
    *   **Key Inputs:**
        *   The final, integrated PostGIS database from Phase 5.
    *   **Core Tasks:**
        1.  Perform final database optimizations, including vacuuming, analyzing tables, and ensuring all spatial indexes are correctly built.
        2.  Create full and schema-only SQL dumps of the final database.
        3.  Create and test a Docker Compose file that can build and deploy the complete PostGIS database from the SQL dump.
    *   **Key Outputs:**
        *   A production-ready Docker image/Compose file.
        *   Finalized SQL dumps (`schema_only.sql`, `full_data.sql`).
        *   An updated `phases/07_PostGIS/metadata.json` file.
    *   **Validation Criteria:**
        *   The Docker Compose file must successfully build and run a fully functional, queryable instance of the database on a clean system.

### **Phase 8: Tutorials & Dashboards**

*   **Objective:** To create user-friendly access points to the data through an interactive web dashboard, a RESTful API, and comprehensive tutorials, broadening the project's impact and user base.

*   **Key Workflows:**
    *   **Workflow 8.1** — Interactive WebGIS Dashboard App: Develop public-facing WebGIS dashboard.
    *   **Workflow 8.2** — Python PostGIS Database Tutorial: Create Python-based tutorial in Jupyter Notebook format.
    *   **Workflow 8.3** — R PostGIS Database Tutorial: Produce RMarkdown tutorial for R users.
    *   **Workflow 8.4** — QGIS PostGIS Database Tutorial: Develop comprehensive QGIS tutorial.

*   **Execution & Validation:**
    *   **Key Inputs:**
        *   The final PostGIS database from Phase 7.
    *   **Core Tasks:**
        1.  Develop and deploy a RESTful API using FastAPI to serve curated datasets from the PostGIS database.
        2.  Develop and deploy a public-facing, interactive WebGIS dashboard using Leaflet.js that consumes data from the API.
        3.  Write comprehensive tutorials for common analytical workflows in QGIS, Python (Jupyter), and R (RMarkdown).
    *   **Key Outputs:**
        *   A deployed and operational WebGIS dashboard.
        *   A documented and operational RESTful API.
        *   A complete suite of tutorials in the repository.
        *   An updated `phases/08_Dashboards/metadata.json` file.
    *   **Validation Criteria:**
        *   The web dashboard and API must be publicly accessible and functional.
        *   All tutorial code must be executable and produce the documented results without error.

---

## 4. Repository Structure

The repository follows a modular structure aligned with project phases and workflows. The AI agent must be aware of these key directories to navigate and modify the project correctly.

```
\<repo-root\>/
├── .windsurf/rules/             # Windsurf project-specific rule files
├── PLANNING.md                  # Project overview, strategic context, and high-level architecture
├── TASKS.md                     # Atomic work items and task tracking
├── .gitignore                   # Files to ignore from Git version control
├── data/                        # Project data (raw, interim, processed, external)
│   ├── external/
│   ├── interim/
│   ├── processed/
│   └── raw/
├── docs/                        # Human-readable project documentation
│   └── drafts/
├── envs/                        # Conda environment files
│   └── digital_tmp_base_env.yml
├── infrastructure/              # Database scripts, Docker configurations
│   ├── db/
│   │   └── legacy_db_sql_scripts/
│   └── docker/
├── knowledge_base/              # Knowledge files approved for the AI
├── notes/
├── outputs/                     # Final deliverables, figures, and publication materials
├── phases/                      # Structured by project phase
│   ├── 01_LegacyDB/
│   │   ├── notebooks/
│   │   ├── outputs/
│   │   └── src/
│   ├── 02_TransformDB/
│   │   ├── notebooks/
│   │   ├── outputs/
│   │   └── src/
│   ├── 03_DigitizeGIS/
│   │   ├── notebooks/
│   │   ├── outputs/
│   │   └── src/
│   ├── 04_Georef/
│   │   ├── notebooks/
│   │   ├── outputs/
│   │   └── src/
│   ├── 05_GeoDB/
│   │   ├── notebooks/
│   │   ├── outputs/
│   │   └── src/
│   ├── 06_tDAR/
│   │   ├── notebooks/
│   │   ├── outputs/
│   │   └── src/
│   ├── 07_PostGIS/
│   │   ├── notebooks/
│   │   ├── outputs/
│   │   └── src/
│   └── 08_Dashboards/
│       ├── notebooks/
│       ├── outputs/
│       └── src/
├── project_materials/           # Project materials not for the AI
├── report/                      # Project reports
└── tests/                       # Unit and integration tests by phase
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

The Digital TMP project uses a dedicated Conda environment named **`digital_tmp_base`** as the primary computational environment for all project work. This environment provides a consistent, reproducible foundation that includes all necessary Python packages, geospatial libraries, and analytical tools required across the eight project phases.

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

- **Default Environment**: All Python scripts, notebooks, and analysis should be run within the `digital_tmp_base` environment. The use of other environments requires explicit justification and documentation.
- **Version Pinning**: All dependencies in environment.yml must have their versions pinned to ensure reproducible analysis across workstations and over time.
- **Package Installation Order**: Always prefer conda-forge channel packages over pip installations to ensure binary compatibility, especially for geospatial libraries with complex dependencies.
- **Environment Isolation**: Do not use the `base` conda environment for project work. Always use the dedicated `digital_tmp_base` environment to prevent dependency conflicts.
- **Documentation**: Document any non-standard environment configurations or workstation-specific adaptations in project notes.
- **Testing**: Test environment portability by periodically creating fresh environments from `digital_tmp_base_env.yml`/`environment.yml` on different workstations to ensure reproducibility.

#### 5.4.4 Key Environment Components

The digital_tmp_base environment integrates several critical component groups:

- **Core Python Stack**: Python 3.11+ with standard scientific computing packages
- **Geospatial Core**: GDAL, GeoPandas, Shapely, PyProj, and other geospatial libraries
- **Database Connectors**: SQLAlchemy, psycopg2, and GeoAlchemy for PostgreSQL/PostGIS integration
- **Visualization Tools**: Matplotlib, Folium, Plotly for geospatial visualization
- **Validation Frameworks**: Great Expectations, Pandera for data quality assurance
- **Jupyter Extensions**: Required notebook extensions for interactive development and documentation

This comprehensive environment ensures that all project contributors work with identical software configurations, maintaining computational reproducibility and consistent analytical outputs across different computing environments.

### 5.5 Project MCP Server Toolchain

The project's AI-assisted development workflow is enabled by a suite of Model Context Protocol (MCP) servers. These servers act as specialized, tool-bearing components that provide a standardized API for an AI agent to interact with the local development environment, external services, and the project's data. Each server is a distinct component with specific responsibilities.

#### 5.5.1 `desktop-commander`

*   **Description:** This component serves as the primary interface to the local desktop environment. It provides comprehensive tools for filesystem access, command execution, process management, and advanced text/code editing. It is foundational for any task involving reading or writing local files, running build scripts, or performing automated code modifications.
*   **Responsibilities:**
    *   Provide full CRUD (Create, Read, Update, Delete) operations for files and directories.
    *   Execute arbitrary terminal commands and manage long-running processes.
    *   Perform advanced, pattern-based search-and-replace operations on text and code.
*   **Interfaces:** `read_multiple_files`, `search_files`, `write_file`, `execute_command`, `list_directory`.
*   **Dependencies:** Cross-platform. Security can be enhanced by setting the `DESKTOP_COMMANDER_ALLOWED_DIRS` environment variable.

#### 5.5.2 `sequential-thinking`

*   **Description:** A core reasoning component that enables a dynamic, reflective, and stepwise approach to problem-solving. It allows an agent to break down complex problems, maintain context across multiple steps, and revise its own thinking process.
*   **Responsibilities:**
    *   Facilitate the breakdown of complex problems into a sequence of manageable "thoughts".
    *   Support non-linear reasoning through branching and revision of previous steps.
*   **Interfaces:** `sequentialthinking` (main tool).

#### 5.5.3 `context7`

*   **Description:** A specialized component for real-time documentation retrieval. It fetches up-to-date, version-specific documentation and code examples for programming libraries and injects them into the AI's context, grounding its responses in factual information to avoid API "hallucinations."
*   **Responsibilities:**
    *   Resolve library names into specific, versioned documentation IDs.
    *   Fetch documentation and code samples for a given library ID.
*   **Interfaces:** `resolve-library-id`, `get-library-docs`.

#### 5.5.4 `brave-search`

*   **Description:** Provides access to the web via the Brave Search API. This component enables the agent to perform both general web searches and specific local business searches.
*   **Responsibilities:**
    *   Execute broad web search queries with support for pagination and filtering.
    *   Execute local business search queries.
*   **Interfaces:** `brave_web_search`, `brave_local_search`.
*   **Dependencies:** Requires a `BRAVE_API_KEY` environment variable.

#### 5.5.5 `memory`

*   **Description:** A persistent, local knowledge graph component. It provides long-term memory for an AI agent, allowing it to remember facts, entities, and relationships across sessions.
*   **Responsibilities:**
    *   Create, read, update, and delete entities (nodes) and relationships (edges).
    *   Provide full graph search and retrieval capabilities.
*   **Interfaces:** `create_entities`, `create_relations`, `read_graph`, `search_nodes`.

#### 5.5.6 `github`

*   **Description:** A comprehensive component for interacting with GitHub repositories, allowing the agent to perform a wide range of version control and repository management tasks.
*   **Responsibilities:**
    *   Manage files and branches (create, update, push).
    *   Manage issues and pull requests (create, update, list, comment, merge).
*   **Interfaces:** `create_or_update_file`, `push_files`, `create_pull_request`, `search_code`.
*   **Dependencies:** Requires a `GITHUB_PERSONAL_ACCESS_TOKEN` environment variable.

#### 5.5.7 `fetcher`

*   **Description:** A web content extraction component that uses a headless browser (Playwright) to render JavaScript-heavy pages and intelligently extract the main content, ignoring boilerplate.
*   **Responsibilities:**
    *   Fetch and render content from URLs, executing JavaScript as needed.
    *   Convert content to clean Markdown or return raw HTML.
*   **Interfaces:** `fetch_url`, `fetch_urls`.

#### 5.5.8 `excel`

*   **Description:** A component for programmatic interaction with Microsoft Excel workbooks.
*   **Responsibilities:**
    *   Read from and write to specific cells or ranges.
    *   Manage worksheets and create tables.
*   **Interfaces:** `excel_read_sheet`, `excel_write_to_sheet`, `excel_create_table`.
*   **Dependencies:** Core features are cross-platform, but live editing and screen capture are Windows-only.

#### 5.5.9 `mcp-sequentialthinking-tools`

*   **Description:** An advanced reasoning component that combines the reflective process of `sequential-thinking` with an intelligent tool recommender, suggesting the most appropriate MCP tools for each step in a thought process.
*   **Responsibilities:**
    *   Orchestrate a sequential thinking process.
    *   Recommend relevant MCP tools with confidence scores and rationale.
*   **Interfaces:** `sequentialthinking_tools`.

#### 5.5.10 `code-reasoning`

*   **Description:** A reasoning component highly specialized for programming and code-related problem-solving, using a hypothesis-driven, branchable thinking process.
*   **Responsibilities:**
    *   Facilitate structured, stepwise reasoning specifically for coding tasks.
    *   Support branching to explore multiple solution paths in parallel.
*   **Interfaces:** `code-reasoning`.

#### 5.5.11 `docs-manager`

*   **Description:** A full-featured component for managing a knowledge base of Markdown documents, with strong support for YAML frontmatter and LLM-optimized exports.
*   **Responsibilities:**
    *   Read, write, and perform precise, line-based edits on Markdown documents.
    *   Generate navigation structures and run health checks for broken links.
*   **Interfaces:** `read_doc`, `edit_doc`, `generate_navigation`, `list_docs`.

#### 5.5.12 `postgres-mcp`

*   **Description:** A comprehensive component for interacting with and managing a PostgreSQL database, providing enterprise-grade tools for health analysis, index optimization, and safe SQL execution.
*   **Responsibilities:**
    *   Execute SQL queries with configurable access modes (unrestricted vs. restricted).
    *   Analyze database health and provide intelligent index recommendations.
*   **Interfaces:** `execute_sql`, `list_objects`, `get_object_details`, `analyze_db_health`.
*   **Dependencies:** Requires a PostgreSQL database connection string.

### 5.6 Metadata & Documentation

- **Markdown** for design notes; **YAML** side-cars for dataset metadata (conceptual).
- **tDAR exports:** metadata mapped to tDAR schema (conceptual).
- **LaTeX/Markdown with Pandoc** for comprehensive documentation generation.

### 5.7 Continuous Integration and Quality Gates

All automated enforcement (coverage floor, cyclomatic complexity, pre-commit hooks, schema-diff, etc.) is defined in `.windsurf/rules/`. CI runs on GitHub Actions.

---

## 6. Data Sources Overview

The project integrates multiple generations of archaeological datasets spanning over five decades.

### 6.1 Legacy TMP Databases
| Dataset                  | Source                                      | Format          | Time Span    | Use Case                                                                  |
| ------------------------ | ------------------------------------------- | --------------- | ------------ | ------------------------------------------------------------------------- |
| **TMP_DF8**       | ASU Teo Lab                                 | SQL dump (.sql) | 1975-1977    | First stable electronic representation, 5,050 cases, 291 variables        |
| **TMP_DF9**       | ASU Teo Lab (Ian Robertson & Angela Huster) | SQL dump (.sql) | 1990s        | Relational database version with GIS integration capabilities             |
| **TMP_DF10**      | ASU Teo Lab (Anne Sherfield)                | SQL dump (.sql) | 2022-present | Most recent database with structural improvements and issue documentation |
| **TMP_REAN_DF2** | ASU Teo Lab (Ian Robertson & Angela Huster) | SQL dump (.sql) | 1973-1983    | Ceramic reanalysis with enhanced typological detail                       |

### 6.2 Primary Spatial Datasets
| Dataset                                  | Source              | Format       | Coverage    | Use Case                                                |
| ---------------------------------------- | ------------------- | ------------ | ----------- | ------------------------------------------------------- |
| **TMP Survey Maps**                | René Millon (1962) | Scanned TIFF | 37.5 km²   | 1:2,000 scale photogrammetric base maps                 |
| **Architectural Overlays**         | Various researchers | Scanned TIFF | Urban core  | Red-ink architectural interpretation drawings           |
| **Collection Unit Polygons (MF2)** | Ian Robertson       | Shapefile    | Survey area | Digitized collection tract boundaries in "Millon Space" |
| **Architectural Polygons**         | Anne Sherfield      | Shapefile    | Urban core  | Digitized architectural features with classification    |

### 6.3 Known Data Quality Issues
The TMP digital archive presents complex legacy challenges including data fragmentation, quality, technological obsolescence, and incomplete documentation. This includes:
*   **Legacy Database Issues**: Encoding inconsistencies, missing REANs records, "Total Counts Problem," and transcription errors.
*   **Spatial Data Challenges**: Original "Millon Space" coordinate system, varied digitization precision, topology issues, and scale limitations of base maps.
*   **Temporal Inconsistencies**: Data collection and analysis span multiple decades with evolving methodologies and ceramic reclassifications.

---

## 7. Further Reading

- `.windsurf/rules/` — TMP-specific enforcement logic (directory for modular rules).
- `docs/overview.md` — Project context, goals, background, project outline, architecture overview, general summaries.
- `docs/architecture.md` — Comprehensive architectural blueprint for the project, detailing the system's design, structure, components, data flow, analytical methods, modelling choices, statistical procedures, datasets and databases, and integration pathways.
- `docs/technical_specs.md` — Comprehensive documentation of technical specifications, software, implementation details, methods and coding standards.
- `docs/outputs_summary.md` — Comprehensive showcase of all final outputs, deliverables, and research products.

---

*End of PLANNING.md*

---
