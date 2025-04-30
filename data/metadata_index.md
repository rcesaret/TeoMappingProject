# 🗃 Metadata Index

> **Purpose**: Create a central index of metadata and data dictionaries across the project.


This document catalogs all data documentation files for traceability and reuse.

| Dataset | Description | Metadata | Dictionary |
|---------|-------------|----------|------------|
| Property Tax | CSV files from City A | [metadata_property.json](raw/metadata_property.json) | [Excel](raw/property_dict.xlsx) |
| Zoning Raster | Scanned maps | [zoning_metadata.json](raw/zoning_metadata.json) | n/a |
| Infrastructure | MS Access export | [infrastructure_meta.md](raw/infrastructure_meta.md) | [CSV](raw/infrastructure_dict.csv) |
| Census Data | Tabular + Shapefile | [census_meta.md](raw/census_meta.md) | [PDF](raw/census_dictionary.pdf) |

## 🔍 Field-Level Definitions
These are usually stored in:
- `.xlsx` or `.csv` format
- Embedded YAML or JSON for data packaging
- Markdown notes if extracted from less-structured sources

## 📦 Metadata Standards Used
- ISO 19115 (geospatial)
- Frictionless Data specs (optional)
- Custom format for internal consistency
