---
trigger: manual
---

# tDAR PACKAGING

## OBJECTIVE
Your objective is to generate scripts and configurations for packaging project datasets into fully compliant archival packages for The Digital Archaeological Record (tDAR).

## DATA FORMATTING PROTOCOL
- When scripting the conversion of data to ESRI Shapefile format, you MUST address its limitations:
  - Attribute field names MUST be truncated to 10 characters.
  - The script MUST generate a separate attribute crosswalk file (e.g., `[layer_name]_crosswalk.csv`) that maps the truncated names back to their full, descriptive names and includes data type information.
  - For datasets with more attributes than can be stored in a single Shapefile's DBF, the script must produce linked CSV files containing the extended attribute tables, ensuring each file includes the unique feature identifier for relational joining.
- Scripts that process rasters for archival MUST clip large GeoTIFFs into thematically focused, size-constrained subsets. Where appropriate, generate derived analytical raster products (e.g., slope, aspect) instead of archiving raw imagery.
- All text-based files (CSV, TXT, etc.) MUST be encoded in UTF-8.

## METADATA GENERATION PROTOCOL
- You must generate a tDAR-compliant metadata XML file for each dataset package. This XML MUST conform to the tDAR schema.
- The metadata generation script must populate all required fields at the project, dataset, and file levels, including:
  - Provenance and data collection methodologies.
  - Spatial and temporal coverage.
  - Creator and contributor attribution.
  - A full data dictionary for all variables, referencing the attribute crosswalk where applicable.
- The script must produce CSV files for all controlled vocabularies used within the datasets and validate that data values conform to these vocabularies.

## DOCUMENTATION & PACKAGING PROTOCOL
- For each archival package, you MUST generate a `README.txt` file that includes:
  - A brief description of the dataset.
  - Instructions on how to use the data, including how to rejoin any linked CSV attribute tables.
  - A file manifest listing all included files.
- Every tDAR package MUST include a `LICENSE.md` file specifying the data usage and distribution license (e.g., Creative Commons license).
- You MUST generate a `manifest.txt` file for each archive package. The manifest must list all included files, their sizes, and their MD5 checksums for integrity verification.
- You must generate a script that uses a standard, open tool like `7-Zip` or `tar` to produce the final compressed, preservation-ready submission package (`.zip` or `.tar.gz`).
- Upon package completion, you MUST prompt the user to generate a DOI (Digital Object Identifier) and formulate a recommended citation string for the dataset.

## ARCHAEOLOGICAL DATA COMPLIANCE
- Ensure all archaeological datasets include appropriate temporal and cultural context information required by tDAR standards.
- Generate scripts that validate spatial data against archaeological data quality standards, including coordinate system documentation and spatial accuracy reporting.
- Include specialized metadata for archaeological datasets, such as site type classifications, cultural affiliations, and research contexts.
- Ensure compliance with ethical guidelines for archaeological data sharing, including appropriate handling of sensitive location information.

## QUALITY ASSURANCE & VALIDATION
- Generate a script that validates the project's data against the controlled vocabulary files, flagging any values in the data that are not present in the official vocabulary.
- Implement automated validation of package completeness, ensuring all required files and metadata are present before finalization.
- Create validation scripts that verify file format compliance and data integrity across all package components.
- Include automated testing of data reconstruction procedures to ensure that end users can successfully rejoin split datasets.

## ARCHIVAL OPTIMIZATION
- Generate scripts that optimize file sizes while preserving data integrity, including appropriate compression strategies for different data types.
- Implement strategies for handling large datasets that exceed tDAR size limitations, including data subdivision and external repository linking.
- Create automated procedures for generating multiple format versions (e.g., both Shapefile and GeoJSON) to maximize accessibility.
- Ensure all archival packages include sufficient documentation for long-term preservation and future migration to new formats.

## WORKFLOW INTEGRATION
- Generate scripts that integrate tDAR packaging with the broader project workflow, ensuring consistency with data transformations from earlier phases.
- Include automated validation that packaged datasets maintain spatial and attribute integrity from source through archival format conversion.
- Create procedures for updating and versioning archival packages as project data evolves.
- Implement automated cross-referencing between tDAR packages and other project deliverables (PostGIS database, web services) to maintain data consistency.
