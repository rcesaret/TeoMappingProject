---
trigger: manual
---

# GIS DIGITIZATION

## OBJECTIVE
Your objective is to assist in the Quality Assurance (QA) of manually digitized geospatial vector data. You will generate Python scripts to perform validation checks, generate schemas, create metadata, and automate recurring QA tasks.

## QA SCRIPTING
- When tasked with writing a QA script for a vector layer (e.g., a Shapefile, GeoPackage, GeoJSON):
- You MUST use `geopandas` to read and process the vector data.
- The script MUST check for invalid geometries using `gdf.is_valid`. It must report the count and IDs of any invalid features. If requested, the script should attempt to repair invalid geometries using the `.buffer(0)` technique and report on the success of the repair.
- The script MUST check for common topological errors, including self-intersections. For polygon layers expected to form a contiguous coverage, the script must check for and report any gaps or overlaps between adjacent features.
- The script MUST verify that the file's CRS is defined and that it matches one of the project's sanctioned CRSs listed in `/docs/CRS_Catalogue.csv`.

## ATTRIBUTE & SCHEMA VALIDATION
- Generate a script to check for attribute consistency. The script must flag any features where attribute values do not conform to a predefined domain list or type (e.g., 'LandUse' attribute must be a string from an approved list; 'FeatureID' must be an integer). These domains should be defined in the plan's context.
- Generate provisional attribute schemas as a JSON file. The schema must define each field's name, data type (`string`, `integer`, `float`, `date`), and any constraints (e.g., `required`, `unique`).

## METADATA & REPORTING
- Create scripts to generate geospatial metadata for each layer. The metadata must document:
  - Source materials (e.g., scanned map ID).
  - Digitization scale.
  - Known accuracy limitations.
  - A full data dictionary explaining each attribute field.
- The output of any QA script must be a clear Markdown report summarizing the checks performed, the number of features validated, and a detailed list of any errors or warnings found, including feature IDs for easy identification.
- Generate a Python script that creates a `.qgs` QGIS project file, automatically loading specified vector and raster layers with predefined, consistent styles to aid in manual visual inspection.

## SPATIAL RELATIONSHIP VALIDATION
- Create a script that validates expected spatial relationships. For example, 'All 'Building' polygons must be completely contained within a 'Survey Tract' polygon'.
- Generate a script to perform change detection between two versions of a digitized layer, highlighting added, removed, or modified features and calculating the area of change.
- For polygon datasets representing archaeological features, implement checks for minimum area thresholds and maximum complexity (vertex count) to identify potential digitization errors.

## ARCHAEOLOGICAL DATA CONSIDERATIONS
- When validating collection unit polygons, cross-reference with SSN (collection unit ID) ranges and verify against documented survey boundaries.
- For architectural feature validation, implement checks against known architectural typologies and reasonable size constraints.
- Include validation for temporal attributes where applicable, ensuring that archaeological phase assignments are consistent with project chronologies.
- Validate that digitized features maintain appropriate spatial relationships with topographic and environmental context layers.

## AUTOMATION & WORKFLOW INTEGRATION
- Generate a script that scans all files in the `/data/processed/gis/` directory and produces a report flagging any files that are missing a corresponding `.meta.json` metadata file.
- Create batch processing scripts that can validate multiple vector layers simultaneously, producing consolidated reports and identifying systematic issues across datasets.
- Implement automated backup and versioning for digitized layers, ensuring that QA processes don't accidentally overwrite original work.

## INTEGRATION WITH PROJECT STANDARDS
- Ensure all QA scripts are compatible with the project's coordinate reference systems and transformation workflows.
- Validate that digitized features will integrate properly with the PostGIS database schema planned for Phase 7.
- Include checks for compliance with tDAR archival requirements, such as file naming conventions and metadata completeness.
- Generate scripts that prepare digitized data for integration with the tabular datasets from Phase 2, including spatial join validation and attribute alignment checks.
