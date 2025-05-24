# Digital TMP – PLANNING.md

AI assistants **MUST** reference this file at the start of each coding or documentation session to stay aligned with the overall architecture, deliverables, and reproducibility vision.

This file provides strategic, narrative context for collaborators and AI assistants. Machine‑enforceable conventions now live in `global_rules.md` (generic) and `.windsurfrules` (TMP‑specific). If procedure or behaviour guidance in this file ever conflicts with those rule files, **the rule files prevail**.

---

## 1  Project Summary

This project modernizes and unifies the legacy datasets of the **Teotihuacan Mapping Project (TMP)**, one of the most comprehensive archaeological surveys in the Americas. The initiative converts fragmented analog and digital records—including field notes, MS Access databases, and hand‑digitized maps—into a fully reproducible PostgreSQL/PostGIS infrastructure for scholarly research, heritage management, and public dissemination.

The effort proceeds through five sequential, modular phases:

| Phase                          | Core Objective                                                                                              | Principal Outputs                                  |
| ------------------------------ | ----------------------------------------------------------------------------------------------------------- | -------------------------------------------------- |
| **1  Database Analysis**       | Audit four legacy TMP databases (DF8, DF9, DF10, REANS2) and migrate them into PostgreSQL                   | Migrated DBs, schema‑audit report                  |
| **2  Database Transformation** | Produce cleaned, denormalised wide‑format datasets (`TMP_DF12`, `TMP_REANS_DF4`) with complete metadata     | Two analytical tables + YAML/Markdown dictionaries |
| **3  GIS Digitization**        | Digitise archaeological, architectural, and environmental features from 1:2,000 raster base maps            | Validated vector layers + metadata                 |
| **4  Georeferencing**          | Align digitised layers with global CRSs via high‑precision control points and custom affine/NTv2 transforms | Aligned GIS layers, transformation logs            |
| **5  Geospatial Integration**  | Fuse tabular and spatial assets into a unified PostGIS database and publish derivatives                     | Unified geodatabase; archive‑ready exports         |


---

## 2  Project Architecture

The project is decomposed into three nested units:

* **Phases** – macro‑level milestones (see table above)
* **Workflows** – cohesive processes within a phase
* **Tasks** – atomic work items tracked in `TASKS.md`

### 2.1  Phase Overview Table

| Phase                             | Description                                                | Key Outputs                                        |
| --------------------------------- | ---------------------------------------------------------- | -------------------------------------------------- |
| Phase 1 – Database Analysis       | Analyse legacy TMP databases; produce redesign proposal    | PostgreSQL DBs + schema audit report               |
| Phase 2 – Database Transformation | ETL into cleaned, denormalised datasets ready for analysis | `TMP_DF12`, `TMP_REANS_DF4` + metadata             |
| Phase 3 – GIS Digitization        | Manual digitisation of archaeological features             | Vector GIS layers (GeoJSON, Shapefile, GeoPackage) |
| Phase 4 – Georeferencing          | Apply control‑point‑driven CRS transformations             | Aligned GIS layers, transformation logs            |
| Phase 5 – Geospatial Integration  | Merge tabular + spatial data in PostGIS                    | Unified geodatabase, public exports                |

### 2.2  Modular Phase Breakdown

<details>
<summary>Phase 1 – Database Analysis</summary>

* **Workflow 1.1** — Set up PostgreSQL versions of DF8, DF9, DF10, REANS2
* **Workflow 1.2** — Evaluate and compare schemas; draft redesign proposal
* **Output:** Schema audit report + redesign recommendations

</details>

<details>
<summary>Phase 2 – Database Transformation</summary>

* **Workflow 2.1** — ETL and integration into wide‑format dataframes
* **Workflow 2.2** — Variable‑level cleaning, recoding, and feature engineering
* **Workflow 2.3** — Build metadata (data dictionaries, QA reports)
* **Output:** `TMP_DF12`, `TMP_REANS_DF4` + YAML/Markdown metadata

</details>

<details>
<summary>Phase 3 – GIS Digitization</summary>

* **Workflow 3.1** — Construct high‑resolution raster mosaics
* **Workflow 3.2** — Digitise archaeological and environmental features
* **Workflow 3.3** — Apply classification tags, validate topologies
* **Workflow 3.4** — Generate GIS layer metadata
* **Output:** Validated vector GIS files with ISO 19115 metadata

</details>

<details>
<summary>Phase 4 – Georeferencing</summary>

* **Workflow 4.1** — GCP calibration and transformation‑model selection
* **Workflow 4.2** — Apply custom CRS transformations using PROJ + GDAL
* **Output:** Aligned GIS layers (UTM 14N/WGS 84), transformation logs

</details>

<details>
<summary>Phase 5 – Geospatial Integration</summary>

* **Workflow 5.1** — Load datasets into PostGIS
* **Workflow 5.2** — Perform spatial joins and crosswalk generation
* **Workflow 5.3** — Engineer spatial features; publish/export outputs
* **Output:** Unified PostGIS geodatabase; public archive‑ready files

</details>

---

## 3  Repository Structure

The repository follows a modular structure aligned with project phases and workflows. Key folders include:

```
<repo‑root>/
├── .windsurfrules
├── PLANNING.md
├── TASKS.md
├── .gitignore
├───data
│   ├───external
│   ├───interim
│   ├───processed
│   └───raw
├───docs
│   └───drafts
├───infrastructure
│   ├───db
│   │   └───legacy_db_sql_scripts
│   └───docker
├───knowledge_base
├───notes
├───outputs
├───phases
│   ├───01_LegacyDB
│   │   ├───drafts
│   │   ├───notebooks
│   │   ├───outputs
│   │   └───src
│   ├───02_TransformDB
│   │   ├───drafts
│   │   ├───notebooks
│   │   ├───outputs
│   │   └───src
│   ├───03_DigitizeGIS
│   │   ├───drafts
│   │   ├───notebooks
│   │   ├───outputs
│   │   └───src
│   ├───04_Georef
│   │   ├───drafts
│   │   ├───notebooks
│   │   ├───outputs
│   │   └───src
│   └───05_GeoDB
│       ├───drafts
│       ├───notebooks
│       ├───outputs
│       └───src
├───project_materials
├───report
│   ├───appendices
│   ├───drafts
│   └───figures
└───tests
```



### 📁 Root
- `.env`, `.env.example` – project-specific credentials
- `requirements.txt` – primary dependency list (pip-style)
- `.gitignore` – ignores unused databases, drafts, local metadata, system junk
- `.windsurfrules` – Windsurf IDE config

### 📁 `phases/`
Structured by project phase:
- `01_LegacyDB/`, `02_TransformDB/`, `03_DigitizeGIS/`, `04_Georef/`, `05_GeoDB/`
  - Each phase includes:
    - `src/` – Python scripts
    - `notebooks/` – QA or prototyping
    - `outputs/` – final artifacts
    - `drafts/` – working documents
    - `README.md` + `metadata.json` – workflow description and schema

### 📁 `data/`
- `raw/`, `interim/`, `processed/` – DVC-friendly data lifecycle
- `external/` – Dropbox-downloaded datasets (raster tiles etc.)
  - Ignored from Git via `.gitignore`

### 📁 `infrastructure/`
- `db/legacy_db_sql_scripts/` – Legacy database SQL exports
- `docker/` – Reserved for late-stage containerization
- `cloud_downloads.md` – Cloud import scripting guidance

### 📁 `docs/` and `project_materials/`
- `architecture.md`, `overview.md`, `methods.md`, `data_sources.md`, `outputs_summary.md`, `references.md` – human-readable project docs
- `CRS_Catalogue.csv` - All sanctioned spatial reference systems—including two custom *Millon Space* CRSs—are defined here. Extend via PR only.
- `tDAR/` – archival formatting and metadata standards
- `TMP_Project_DS_Portfolio_OptimizStrategy/` – strategy documents and summaries

### 📁 `tests/`
- Unit and integration tests by phase, mirroring `phases/`

### ⚠️ Files Without Version Control (See `.gitignore`)
- All `drafts/` folders
- `data/external/ms_raster_tiles`
- System/editor-specific folders (`.idea/`, `.vscode/`)
- `project_materials/` contains project materials not for the AI
- `knowledge_base/` contains knowledge files approved for the AI
- Local notebooks, cache folders

### Notes on Large Files

- **Git LFS** manages large rasters and project imagery.
- **DVC** (optional) can track heavy data evolution beyond Git‑LFS capacity.

---

## 4  Tech Stack, Tools, and Dependencies

### 🐍 Core Programming Stack
- **Language**: Python 3.11+
- **Notebooks**: Jupyter (used for QA and geospatial EDA in Phases 2–5)
- **Environments**: 
  - Use `conda` for dependency management, only using `pip` secondarily when a package is not available on `conda`
  - Use `.env` for storing credentials (being sure to add placeholders to `.env.example` as well)
- **Databases:** PostgreSQL 17 with PostGIS
- **GIS Desktop:** QGIS 3.40+
  
  
### 4.1  Core Programming Stack

- **Language:** Python 3.11+
  (Version policy & upgrade path are enforced in `.windsurfrules` §2.)
- **Notebooks:** Jupyter (used for QA & EDA in Phases 2–5)
- **Database:** PostgreSQL 15+ with PostGIS
- **GIS Desktop:** QGIS 3.40+

### 4.2  Key Python Libraries

- Data / ETL — `pandas`, `numpy`, `sqlalchemy`, `pydantic`, `great_expectations`
- Geospatial — `gdal`, `ogr`, `rasterio`, `fiona`, `geopandas`, `shapely`, `pyproj`, `whitebox`
- Georeferencing — `ntv2`, `affine`, `pyproj‑transformer`
- Testing — `pytest`, `pytest‑cov`, `pandas.testing`, `geopandas.testing`, and `geopandas.testing`, and `great_expectations` (where applicable)

### 4.3  Metadata & Documentation

- **Markdown** for design notes; **YAML** side‑cars for dataset metadata.
- **tDAR exports:** metadata mapped to tDAR schema.

### 4.4  Continuous Integration and Quality Gates

All automated enforcement (coverage floor, cyclomatic complexity, pre‑commit hooks, schema‑diff, etc.) is defined in `.windsurfrules` §§7–9. CI runs on GitHub Actions.

---

## 4.6  Operational Standards

### 🐳 Dockerization & Deployment
- Dockerization will occur **only at the end of the project**.
- No Docker/k8s work should begin unless explicitly requested and scheduled by the user.
- Final deployment will ship PostgreSQL + PostGIS and a read‑only API in separate containers for portability.

### 🌍 GIS Metadata and File Standards
- All digitized geospatial outputs must include metadata compliant with **ISO 19115**.
- Vector files must be validated with topologies and CRS metadata embedded.
- Produce and use `.geojson`, `.shp`, and `.gpkg` formats for maximum compatibility.
- Store and maintain GCPs, transformation matrices, and raster alignment logs alongside spatial products.

### ⬇️ External Data Downloads
- Large datasets stored externally will be downloaded via **Python scripts** using **Dropbox direct links**.
- All download scripts must:
  - Validate checksum (e.g., SHA-256) after download
  - Write a `.download.log` file with timestamp, source, file name
  - Default target directory: `data/external/`

### 📦 tDAR-Compatible Output Requirements
When preparing export-ready files for tDAR (The Digital Archaeological Record):
- All metadata must adhere to tDAR’s structured templates for:
  - **Datasets** (CSV, XLSX, MDB)
  - **GIS Files** (SHP, PRJ, DBF, XML)
  - **Documents** (PDF, DOCX)
  - **Ontologies** (.owl format or tab-indented list syntax)
- Required metadata includes:
  - Title, year, creators, institutions, roles
  - Spatial and temporal coverage
  - Site terms, cultural periods, material types
  - Investigation type, archive source, and licensing/copyright info
- Use structured YAML or Markdown `metadata.yaml` for each output set to support tDAR ingest scripts.

---

## 5  Authorial Writing Style Guide

> **Reference location for AI:** all sample writings are indexed under `knowledge_base/user_style/`. Always consult them before generating or rewriting narrative text.

### 6.1  Stylistic Fundamentals

| Dimension                 | Guideline                                                                                                                         |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Tone**                  | Formal, analytic, and objective; avoid conversational idioms.                                                                     |
| **Sentence construction** | Prefer long, multi‑clause sentences that layer evidence and qualification (average 25–35 words), but ensure syntactic clarity.    |
| **Hedging & precision**   | Use qualifiers such as *suggests, indicates, likely, appears* to convey uncertainty.                                              |
| **Citations**             | Parenthetical Chicago Author‑Date style: (Author Year: page). Multiple sources separated by semicolons.                           |
| **Terminology**           | Employ discipline‑specific vocabulary from archaeology, historiography, economic history, and data science. Verify term accuracy. |
| **Transitions**           | Use explicit linking phrases to signal logical progression (*“Building upon this premise …”*, *“By contrast …”*).                 |
| **Figures & tables**      | Refer to them in‑text as “Figure X” or “Table Y”; store assets under `outputs/figures/`.                                          |

### 6.2  Structural Conventions

1. **Canonical section order** — *Introduction → Methodology → Analysis → Discussion → Conclusion*.
2. **Bullet‑to‑prose transformation** — Convert lists into cohesive paragraphs while preserving logical hierarchy.
3. **Numbered sign‑posting** — For complex arguments, use ordinal adverbs (*First, Second, Third*) to guide the reader.
4. **Passive voice** — Acceptable where processes are foregrounded over actors; otherwise favour active constructions.
5. **Citation density** — Substantive claims require at least one citation; theory‑heavy passages may group citations at paragraph end.

### 6.3  AI Writing Workflow

1. **Scope confirmation** — Ask the user for desired length and depth if ambiguous.
2. **Source mapping** — Break input into logical units; cross‑reference sample corpus for stylistic anchors.
3. **Draft generation** — Apply the rules in §6.1–6.2; mirror paragraph cadence and citation frequency of samples.
4. **Self‑audit checklist** — Verify tone, sentence length, citation style, hedging language, and logical flow.
5. **User iteration** — Present draft, incorporate feedback, repeat audit.

*Failure to obtain clarification should trigger sensible defaults derived from this guide.*

---

## 6  Further Reading

- `global_rules.md` — Cross‑project conventions & human best practices.
- `.windsurfrules` — TMP‑specific enforcement logic.
- `overview.md` — Project context, goals, background, project outline, architecture overview, general summaries.
- `architecture.md` — Detailed system design and data‑flow diagrams.
- `methods.md` — Analytical methods, modelling choices, and statistical procedures.

---

*End of PLANNING.md*
