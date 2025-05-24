---
title: "TMP Project Tasks"
date: "2025-05-23"
tasks:
  - id: P1.W1.1.1
    description: "Configure PostgreSQL connection parameters in a `.env` file"
    depends: []
    status: pending
  - id: P1.W1.1.2
    description: "Load environment variables and verify secure credentials"
    depends: ["P1.W1.1.1"]
    status: pending
  - id: P1.W1.1.3
    description: "Run `setup_databases.py` to create PostgreSQL instances for each legacy TMP database"
    depends: ["P1.W1.1.2"]
    status: pending
  - id: P1.W1.1.4
    description: "Execute SQL scripts to populate each instance with legacy data"
    depends: ["P1.W1.1.3"]
    status: pending
  - id: P1.W1.1.5
    description: "Invoke `schema_viz.py` to auto-generate ERD diagrams for each database"
    depends: ["P1.W1.1.4"]
    status: pending
  - id: P1.W1.1.6
    description: "Run `profile_db.py` to collect schema metrics (table cardinalities, data-type distributions, null frequencies)"
    depends: ["P1.W1.1.5"]
    status: pending
  - id: P1.W1.1.7
    description: "Persist profiling outputs into the `tmp_db_metrics` schema"
    depends: ["P1.W1.1.6"]
    status: pending
  - id: P1.W1.1.8
    description: "Commit and update Phase 1 setup & profiling documentation"
    depends: ["P1.W1.1.7"]
    status: pending

  - id: P1.W1.2.1
    description: "Execute `profile_db.py` for deep schema profiling across DF8, DF9, DF10"
    depends: []
    status: pending
  - id: P1.W1.2.2
    description: "Generate ERDs for DF8, DF9, DF10 and export to PNG"
    depends: ["P1.W1.2.1"]
    status: pending
  - id: P1.W1.2.3
    description: "Validate primary-key and foreign-key integrity (identify orphans, duplicates)"
    depends: ["P1.W1.2.2"]
    status: pending
  - id: P1.W1.2.4
    description: "Compute Join-Dependency Index (JDI) & Lookup Inflation Factor (LIF) for each schema"
    depends: ["P1.W1.2.3"]
    status: pending
  - id: P1.W1.2.5
    description: "Prototype denormalized schema variants (flatten key tables)"
    depends: ["P1.W1.2.4"]
    status: pending
  - id: P1.W1.2.6
    description: "Benchmark representative analytical queries with `EXPLAIN ANALYZE`"
    depends: ["P1.W1.2.5"]
    status: pending
  - id: P1.W1.2.7
    description: "Draft “Denormalization White Paper” summarizing trade-offs & performance gains"
    depends: ["P1.W1.2.6"]
    status: pending
  - id: P1.W1.2.8
    description: "Update Phase 1 analysis documentation with denormalization outcomes"
    depends: ["P1.W1.2.7"]
    status: pending

  - id: P2.W2.1.1
    description: "Compare DF8, DF9, DF10 schemas to identify structural discrepancies"
    depends: []
    status: pending
  - id: P2.W2.1.2
    description: "Build attribute crosswalk tables mapping legacy field names → standardized names"
    depends: ["P2.W2.1.1"]
    status: pending
  - id: P2.W2.1.3
    description: "Flatten multi-table structures into a wide-format provisional dataset (DF11)"
    depends: ["P2.W2.1.2"]
    status: pending
  - id: P2.W2.1.4
    description: "Clean & transform REAN_DF2 into provisional REAN_DF3"
    depends: ["P2.W2.1.3"]
    status: pending
  - id: P2.W2.1.5
    description: "Develop Python ETL scripts (Pandas + SQLAlchemy) to merge DF8/9/10 → DF11"
    depends: ["P2.W2.1.4"]
    status: pending
  - id: P2.W2.1.6
    description: "Apply rule-based resolution to remove duplicate records"
    depends: ["P2.W2.1.5"]
    status: pending
  - id: P2.W2.1.7
    description: "Archive DF11 & REAN_DF3 with detailed integration logs"
    depends: ["P2.W2.1.6"]
    status: pending
  - id: P2.W2.1.8
    description: "Update integration workflow docs and README"
    depends: ["P2.W2.1.7"]
    status: pending

  - id: P2.W2.2.1
    description: "Evaluate each DF11 variable for completeness, relevance, redundancy"
    depends: []
    status: pending
  - id: P2.W2.2.2
    description: "Engineer new analytic variables (e.g., site-count per unit, ordinal scales)"
    depends: ["P2.W2.2.1"]
    status: pending
  - id: P2.W2.2.3
    description: "Clean text/categorical fields via regex normalization"
    depends: ["P2.W2.2.2"]
    status: pending
  - id: P2.W2.2.4
    description: "Recode nominal → ordinal variables where appropriate"
    depends: ["P2.W2.2.3"]
    status: pending
  - id: P2.W2.2.5
    description: "Remove low-information variables; log deletions in Variable Transformation Log"
    depends: ["P2.W2.2.4"]
    status: pending
  - id: P2.W2.2.6
    description: "Reorder & rename columns for consistency"
    depends: ["P2.W2.2.5"]
    status: pending
  - id: P2.W2.2.7
    description: "Produce final DF12 and controlled-vocabulary lookup tables"
    depends: ["P2.W2.2.6"]
    status: pending
  - id: P2.W2.2.8
    description: "Align REAN_DF3 with DF12 by SSN; output REAN_DF4"
    depends: ["P2.W2.2.7"]
    status: pending
  - id: P2.W2.2.9
    description: "Update transformation pipeline documentation"
    depends: ["P2.W2.2.8"]
    status: pending

  - id: P2.W2.3.1
    description: "Consolidate categorical value sets into unified lookup tables"
    depends: []
    status: pending
  - id: P2.W2.3.2
    description: "Apply vocabulary mappings to DF12 & REAN_DF4"
    depends: ["P2.W2.3.1"]
    status: pending
  - id: P2.W2.3.3
    description: "Export glossaries as PDF and CSV"
    depends: ["P2.W2.3.2"]
    status: pending
  - id: P2.W2.3.4
    description: "Verify alignment with tDAR metadata requirements"
    depends: ["P2.W2.3.3"]
    status: pending
  - id: P2.W2.3.5
    description: "Update controlled-vocabulary docs"
    depends: ["P2.W2.3.4"]
    status: pending

  - id: P2.W2.4.1
    description: "Integrate Great Expectations/dbt into ETL pipelines"
    depends: []
    status: pending
  - id: P2.W2.4.2
    description: "Define validation rules for schema, content ranges, uniqueness, nullability"
    depends: ["P2.W2.4.1"]
    status: pending
  - id: P2.W2.4.3
    description: "Automate metadata completeness checks at project/dataset/file levels"
    depends: ["P2.W2.4.2"]
    status: pending
  - id: P2.W2.4.4
    description: "Embed validation in CI/CD (GitHub Actions or Prefect)"
    depends: ["P2.W2.4.3"]
    status: pending
  - id: P2.W2.4.5
    description: "Generate & archive data quality reports for each release"
    depends: ["P2.W2.4.4"]
    status: pending
  - id: P2.W2.4.6
    description: "Document data lineage & transformation traceability"
    depends: ["P2.W2.4.5"]
    status: pending
  - id: P2.W2.4.7
    description: "Update QA framework documentation"
    depends: ["P2.W2.4.6"]
    status: pending

  - id: P3.W3.1.1
    description: "Catalog all raster basemaps (survey maps, aerial imagery)"
    depends: []
    status: pending
  - id: P3.W3.1.2
    description: "Align and trim raster edges for unified coverage"
    depends: ["P3.W3.1.1"]
    status: pending
  - id: P3.W3.1.3
    description: "Mosaic rasters into “TMP Topo/Survey” and “TMP Architectural Reconstruction” layers"
    depends: ["P3.W3.1.2"]
    status: pending
  - id: P3.W3.1.4
    description: "Enhance rasters via GDAL (contrast, de-skew)"
    depends: ["P3.W3.1.3"]
    status: pending
  - id: P3.W3.1.5
    description: "Create QGIS project templates with standardized symbology"
    depends: ["P3.W3.1.4"]
    status: pending
  - id: P3.W3.1.6
    description: "Export high-res mosaics for digitization"
    depends: ["P3.W3.1.5"]
    status: pending
  - id: P3.W3.1.7
    description: "Document raster preprocessing steps"
    depends: ["P3.W3.1.6"]
    status: pending

  - id: P3.W3.2.1
    description: "Digitize Floors"
    depends: []
    status: pending
  - id: P3.W3.2.2
    description: "Digitize Walls"
    depends: ["P3.W3.2.1"]
    status: pending
  - id: P3.W3.2.3
    description: "Digitize Taludes & Tableros"
    depends: ["P3.W3.2.2"]
    status: pending
  - id: P3.W3.2.4
    description: "Digitize Plazas"
    depends: ["P3.W3.2.3"]
    status: pending
  - id: P3.W3.2.5
    description: "Digitize Pits"
    depends: ["P3.W3.2.4"]
    status: pending
  - id: P3.W3.2.6
    description: "Digitize Mounds"
    depends: ["P3.W3.2.5"]
    status: pending
  - id: P3.W3.2.7
    description: "Digitize Stone concentrations"
    depends: ["P3.W3.2.6"]
    status: pending
  - id: P3.W3.2.8
    description: "Digitize Sherd concentrations"
    depends: ["P3.W3.2.7"]
    status: pending
  - id: P3.W3.2.9
    description: "Digitize Obsidian concentrations"
    depends: ["P3.W3.2.8"]
    status: pending
  - id: P3.W3.2.10
    description: "Digitize Excavations"
    depends: ["P3.W3.2.9"]
    status: pending
  - id: P3.W3.2.11
    description: "Digitize Staircases"
    depends: ["P3.W3.2.10"]
    status: pending
  - id: P3.W3.2.12
    description: "Digitize Sherd dumps"
    depends: ["P3.W3.2.11"]
    status: pending
  - id: P3.W3.2.13
    description: "Digitize “Not Surveyed + No Permission” zones"
    depends: ["P3.W3.2.12"]
    status: pending
  - id: P3.W3.2.14
    description: "Digitize “Nada (N)” survey tracts"
    depends: ["P3.W3.2.13"]
    status: pending
  - id: P3.W3.2.15
    description: "Digitize “Almost Nada (AN)” survey tracts"
    depends: ["P3.W3.2.14"]
    status: pending
  - id: P3.W3.2.16
    description: "Validate and record Topo/Survey digitization metadata"
    depends: ["P3.W3.2.15"]
    status: pending

  - id: P3.W3.3.1
    description: "Load Architectural Reconstruction raster"
    depends: []
    status: pending
  - id: P3.W3.3.2
    description: "Compare existing polygon versions"
    depends: ["P3.W3.3.1"]
    status: pending
  - id: P3.W3.3.3
    description: "Re-digitize Sherfield’s 2023 urban polygons per “Map Assignations”"
    depends: ["P3.W3.3.2"]
    status: pending
  - id: P3.W3.3.4
    description: "Resolve overlaps with Topo/Survey layers"
    depends: ["P3.W3.3.3"]
    status: pending
  - id: P3.W3.3.5
    description: "Apply provisional attribute schemas"
    depends: ["P3.W3.3.4"]
    status: pending
  - id: P3.W3.3.6
    description: "Archive architectural digitization metadata"
    depends: ["P3.W3.3.5"]
    status: pending

  - id: P3.W3.4.1
    description: "Run QGIS Geometry Validity & Topology Checker"
    depends: []
    status: pending
  - id: P3.W3.4.2
    description: "Snap and close polygons; correct line intersections"
    depends: ["P3.W3.4.1"]
    status: pending
  - id: P3.W3.4.3
    description: "Standardize provisional attribute fields"
    depends: ["P3.W3.4.2"]
    status: pending
  - id: P3.W3.4.4
    description: "Generate spatial metadata summaries (counts, extents)"
    depends: ["P3.W3.4.3"]
    status: pending
  - id: P3.W3.4.5
    description: "Archive QA reports & update Phase 3 docs"
    depends: ["P3.W3.4.4"]
    status: pending

  - id: P4.W4.1.1
    description: "Import photogrammetry reference rasters for GCP collection"
    depends: []
    status: pending
  - id: P4.W4.1.2
    description: "Manually collect GCPs in QGIS; export as point layer"
    depends: ["P4.W4.1.1"]
    status: pending
  - id: P4.W4.1.3
    description: "Convert GCPs to GDAL format and attach to rasters"
    depends: ["P4.W4.1.2"]
    status: pending
  - id: P4.W4.1.4
    description: "Preprocess rasters (denoise, crop) for georeferencing"
    depends: ["P4.W4.1.3"]
    status: pending
  - id: P4.W4.1.5
    description: "Log GCP collection metadata"
    depends: ["P4.W4.1.4"]
    status: pending

  - id: P4.W4.2.1
    description: "Perform sensitivity tests across resampling methods (Lanczos, etc.)"
    depends: []
    status: pending
  - id: P4.W4.2.2
    description: "Calculate RMSE for GCP residuals"
    depends: ["P4.W4.2.1"]
    status: pending
  - id: P4.W4.2.3
    description: "Produce spatial error heatmaps & residual plots"
    depends: ["P4.W4.2.2"]
    status: pending
  - id: P4.W4.2.4
    description: "Conduct spatial autocorrelation (Moran’s I) on residuals"
    depends: ["P4.W4.2.3"]
    status: pending
  - id: P4.W4.2.5
    description: "Select optimal georeferencing method"
    depends: ["P4.W4.2.4"]
    status: pending
  - id: P4.W4.2.6
    description: "Document method calibration & accuracy report"
    depends: ["P4.W4.2.5"]
    status: pending

  - id: P4.W4.3.1
    description: "Define custom “Millon Space” CRS with PROJ"
    depends: []
    status: pending
  - id: P4.W4.3.2
    description: "Apply TPS interpolation to refined GCPs"
    depends: ["P4.W4.3.1"]
    status: pending
  - id: P4.W4.3.3
    description: "Generate `.gsb` NTv2 grid shift files"
    depends: ["P4.W4.3.2"]
    status: pending
  - id: P4.W4.3.4
    description: "Register `.gsb` with PROJ/QGIS"
    depends: ["P4.W4.3.3"]
    status: pending
  - id: P4.W4.3.5
    description: "Archive NTv2 grid files & docs"
    depends: ["P4.W4.3.4"]
    status: pending

  - id: P4.W4.4.1
    description: "Apply NTv2 shift to provisional vector layers via GDAL/pyproj"
    depends: []
    status: pending
  - id: P4.W4.4.2
    description: "Validate post-transformation geometries (`ST_IsValid`)"
    depends: ["P4.W4.4.1"]
    status: pending
  - id: P4.W4.4.3
    description: "Assign EPSG:32614 CRS to all layers"
    depends: ["P4.W4.4.2"]
    status: pending
  - id: P4.W4.4.4
    description: "Archive georeferenced vectors"
    depends: ["P4.W4.4.3"]
    status: pending

  - id: P4.W4.5.1
    description: "Recompute RMSE on transformed GCPs"
    depends: []
    status: pending
  - id: P4.W4.5.2
    description: "Generate final error diagnostics & visuals"
    depends: ["P4.W4.5.1"]
    status: pending
  - id: P4.W4.5.3
    description: "Apply rubber-sheet corrections if needed"
    depends: ["P4.W4.5.2"]
    status: pending
  - id: P4.W4.5.4
    description: "Update georeferencing validation documentation"
    depends: ["P4.W4.5.3"]
    status: pending

  - id: P4.W4.6.1
    description: "Export production layers in EPSG:32614"
    depends: []
    status: pending
  - id: P4.W4.6.2
    description: "Export dissemination layers in EPSG:4326 (simplified)"
    depends: ["P4.W4.6.1"]
    status: pending
  - id: P4.W4.6.3
    description: "Produce CRS transformation metadata"
    depends: ["P4.W4.6.2"]
    status: pending
  - id: P4.W4.6.4
    description: "Archive final georeferenced exports and update Phase 4 docs"
    depends: ["P4.W4.6.3"]
    status: pending

  - id: P5.W5.1.1
    description: "QA georeferenced layers; remove overlaps/duplicates"
    depends: []
    status: pending
  - id: P5.W5.1.2
    description: "Join DF12 & REAN_DF4 to collection-unit polygon layer"
    depends: ["P5.W5.1.1"]
    status: pending
  - id: P5.W5.1.3
    description: "Document join logic & scripts"
    depends: ["P5.W5.1.2"]
    status: pending

  - id: P5.W5.2.1
    description: "Define hierarchical classification schema"
    depends: []
    status: pending
  - id: P5.W5.2.2
    description: "Build spatial overlay algorithm linking features ↔ collection units"
    depends: ["P5.W5.2.1"]
    status: pending
  - id: P5.W5.2.3
    description: "Compute proportional overlaps & assign weights"
    depends: ["P5.W5.2.2"]
    status: pending
  - id: P5.W5.2.4
    description: "Compare against prior classifications; flag discrepancies"
    depends: ["P5.W5.2.3"]
    status: pending
  - id: P5.W5.2.5
    description: "Update architectural feature attributes"
    depends: ["P5.W5.2.4"]
    status: pending
  - id: P5.W5.2.6
    description: "Archive classification metadata"
    depends: ["P5.W5.2.5"]
    status: pending

  - id: P5.W5.3.1
    description: "Calculate geometry metrics (area, complexity indices)"
    depends: []
    status: pending
  - id: P5.W5.3.2
    description: "Generate spatial entropy & density measures"
    depends: ["P5.W5.3.1"]
    status: pending
  - id: P5.W5.3.3
    description: "Derive new spatial variables and append to DF12"
    depends: ["P5.W5.3.2"]
    status: pending
  - id: P5.W5.3.4
    description: "Validate derived fields against original DB values"
    depends: ["P5.W5.3.3"]
    status: pending
  - id: P5.W5.3.5
    description: "Export updated DF12 with spatial attributes"
    depends: ["P5.W5.3.4"]
    status: pending
  - id: P5.W5.3.6
    description: "Update data dictionary with spatial variables"
    depends: ["P5.W5.3.5"]
    status: pending

  - id: P5.W5.4.1
    description: "Validate geometries & attributes consistency"
    depends: []
    status: pending
  - id: P5.W5.4.2
    description: "Ensure uniform CRS across all layers"
    depends: ["P5.W5.4.1"]
    status: pending
  - id: P5.W5.4.3
    description: "Produce spatial metadata summary"
    depends: ["P5.W5.4.2"]
    status: pending
  - id: P5.W5.4.4
    description: "Archive integrated dataset for Phase 6/7"
    depends: ["P5.W5.4.3"]
    status: pending
  - id: P5.W5.4.5
    description: "Update Phase 5 integration documentation"
    depends: ["P5.W5.4.4"]
    status: pending

  - id: P6.W6.1.1
    description: "Convert vector datasets → Shapefiles (apply name-truncation rules)"
    depends: []
    status: pending
  - id: P6.W6.1.2
    description: "Export extended attributes → linked CSV tables"
    depends: ["P6.W6.1.1"]
    status: pending
  - id: P6.W6.1.3
    description: "Clip/compress GeoTIFF rasters for tDAR size limits"
    depends: ["P6.W6.1.2"]
    status: pending
  - id: P6.W6.1.4
    description: "Derive analytical raster products where appropriate"
    depends: ["P6.W6.1.3"]
    status: pending
  - id: P6.W6.1.5
    description: "Archive tDAR-ready data packages"
    depends: ["P6.W6.1.4"]
    status: pending

  - id: P6.W6.2.1
    description: "Draft project-level metadata (context, coverage, creators)"
    depends: []
    status: pending
  - id: P6.W6.2.2
    description: "Create dataset-level metadata for each package"
    depends: ["P6.W6.2.1"]
    status: pending
  - id: P6.W6.2.3
    description: "Produce file-level metadata (CRS, schemas, descriptions)"
    depends: ["P6.W6.2.2"]
    status: pending
  - id: P6.W6.2.4
    description: "Export controlled-vocabulary CSVs & glossaries"
    depends: ["P6.W6.2.3"]
    status: pending
  - id: P6.W6.2.5
    description: "Generate ERDs illustrating dataset relationships"
    depends: ["P6.W6.2.4"]
    status: pending
  - id: P6.W6.2.6
    description: "Validate metadata against tDAR schema"
    depends: ["P6.W6.2.5"]
    status: pending

  - id: P6.W6.3.1
    description: "Write README for each data package"
    depends: []
    status: pending
  - id: P6.W6.3.2
    description: "Create detailed data dictionaries (variables, units, codes)"
    depends: ["P6.W6.3.1"]
    status: pending
  - id: P6.W6.3.3
    description: "Draft methodological report (workflows, limitations)"
    depends: ["P6.W6.3.2"]
    status: pending
  - id: P6.W6.3.4
    description: "Produce versioning & provenance logs"
    depends: ["P6.W6.3.3"]
    status: pending
  - id: P6.W6.3.5
    description: "Develop QGIS/ArcGIS CSV-Shapefile rejoin tutorial"
    depends: ["P6.W6.3.4"]
    status: pending
  - id: P6.W6.3.6
    description: "Create “Quick Start” GIS guides (maps, screenshots)"
    depends: ["P6.W6.3.5"]
    status: pending
  - id: P6.W6.3.7
    description: "Package tutorials with sample data"
    depends: ["P6.W6.3.6"]
    status: pending

  - id: P6.W6.4.1
    description: "Apply standardized naming conventions"
    depends: []
    status: pending
  - id: P6.W6.4.2
    description: "Archive data, metadata, docs into compressed packages"
    depends: ["P6.W6.4.1"]
    status: pending
  - id: P6.W6.4.3
    description: "Upload compliant packages to tDAR; fill metadata fields"
    depends: ["P6.W6.4.2"]
    status: pending
  - id: P6.W6.4.4
    description: "Upload large files to Zenodo/Figshare; record DOIs"
    depends: ["P6.W6.4.3"]
    status: pending
  - id: P6.W6.4.5
    description: "Link external DOIs in tDAR records"
    depends: ["P6.W6.4.4"]
    status: pending
  - id: P6.W6.4.6
    description: "Final review of tDAR submissions"
    depends: ["P6.W6.4.5"]
    status: pending

  - id: P7.W7.1.1
    description: "Define spatial entities & relational tables (sites, artifacts, units)"
    depends: []
    status: pending
  - id: P7.W7.1.2
    description: "Integrate controlled-vocabulary tables as lookups"
    depends: ["P7.W7.1.1"]
    status: pending
  - id: P7.W7.1.3
    description: "Design normalized schema; plan selective denormalization"
    depends: ["P7.W7.1.2"]
    status: pending
  - id: P7.W7.1.4
    description: "Specify GIST & BRIN index strategies"
    depends: ["P7.W7.1.3"]
    status: pending
  - id: P7.W7.1.5
    description: "Define primary/foreign-key constraints"
    depends: ["P7.W7.1.4"]
    status: pending
  - id: P7.W7.1.6
    description: "Draft topology models if needed"
    depends: ["P7.W7.1.5"]
    status: pending
  - id: P7.W7.1.7
    description: "Create SQL views/materialized views for common queries"
    depends: ["P7.W7.1.6"]
    status: pending
  - id: P7.W7.1.8
    description: "Document database schema design"
    depends: ["P7.W7.1.7"]
    status: pending

  - id: P7.W7.2.1
    description: "Initialize PostgreSQL with PostGIS (and pgrouting)"
    depends: []
    status: pending
  - id: P7.W7.2.2
    description: "Load DF12 & REAN_DF4 as spatial-enabled tables"
    depends: ["P7.W7.2.1"]
    status: pending
  - id: P7.W7.2.3
    description: "Import Phase 3–4 layers via `ogr2ogr`/`raster2pgsql`"
    depends: ["P7.W7.2.2"]
    status: pending
  - id: P7.W7.2.4
    description: "Validate & transform CRS to WGS84/UTM zone"
    depends: ["P7.W7.2.3"]
    status: pending
  - id: P7.W7.2.5
    description: "Create spatial indexes on geometry columns"
    depends: ["P7.W7.2.4"]
    status: pending
  - id: P7.W7.2.6
    description: "Enforce NOT NULL, UNIQUE, FOREIGN KEY constraints"
    depends: ["P7.W7.2.5"]
    status: pending
  - id: P7.W7.2.7
    description: "Repair invalid geometries (`ST_MakeValid`)"
    depends: ["P7.W7.2.6"]
    status: pending
  - id: P7.W7.2.8
    description: "Profile queries with `EXPLAIN ANALYZE`; optimize"
    depends: ["P7.W7.2.7"]
    status: pending
  - id: P7.W7.2.9
    description: "Archive database build & validation logs"
    depends: ["P7.W7.2.8"]
    status: pending

  - id: P7.W7.3.1
    description: "Generate `schema_only.sql` & `full_data.sql` dumps"
    depends: []
    status: pending
  - id: P7.W7.3.2
    description: "Build Docker container with PostgreSQL/PostGIS instance"
    depends: ["P7.W7.3.1"]
    status: pending
  - id: P7.W7.3.3
    description: "Write Docker Compose & restoration docs"
    depends: ["P7.W7.3.2"]
    status: pending
  - id: P7.W7.3.4
    description: "Export GeoJSON/CSV/GeoTIFF static files for non-technical users"
    depends: ["P7.W7.3.3"]
    status: pending
  - id: P7.W7.3.5
    description: "Deploy FastAPI endpoints for GeoJSON/CSV delivery"
    depends: ["P7.W7.3.4"]
    status: pending
  - id: P7.W7.3.6
    description: "Develop Leaflet.js WebGIS dashboard"
    depends: ["P7.W7.3.5"]
    status: pending
  - id: P7.W7.3.7
    description: "Host API & dashboard (GitHub Pages or equivalent)"
    depends: ["P7.W7.3.6"]
    status: pending
  - id: P7.W7.3.8
    description: "Update distribution & deployment documentation"
    depends: ["P7.W7.3.7"]
    status: pending

  - id: P8.W8.1.1
    description: "Scaffold frontend with Leaflet.js (responsive UI)"
    depends: []
    status: pending
  - id: P8.W8.1.2
    description: "Implement FastAPI endpoints for dynamic data loads"
    depends: ["P8.W8.1.1"]
    status: pending
  - id: P8.W8.1.3
    description: "Add spatial filtering & attribute queries in dashboard"
    depends: ["P8.W8.1.2"]
    status: pending
  - id: P8.W8.1.4
    description: "Enable direct data downloads (GeoJSON/CSV)"
    depends: ["P8.W8.1.3"]
    status: pending
  - id: P8.W8.1.5
    description: "Deploy to hosting platform"
    depends: ["P8.W8.1.4"]
    status: pending
  - id: P8.W8.1.6
    description: "Embed usage guide in dashboard interface"
    depends: ["P8.W8.1.5"]
    status: pending

  - id: P8.W8.2.1
    description: "Create Jupyter Notebook for Docker-based PostGIS setup"
    depends: []
    status: pending
  - id: P8.W8.2.2
    description: "Demonstrate `psycopg2`/`SQLAlchemy` DB connections"
    depends: ["P8.W8.2.1"]
    status: pending
  - id: P8.W8.2.3
    description: "Show data ingestion & visualization (GeoPandas, Folium, Plotly)"
    depends: ["P8.W8.2.2"]
    status: pending
  - id: P8.W8.2.4
    description: "Include spatial-analysis examples (density, proximity)"
    depends: ["P8.W8.2.3"]
    status: pending
  - id: P8.W8.2.5
    description: "Package with sample datasets"
    depends: ["P8.W8.2.4"]
    status: pending
  - id: P8.W8.2.6
    description: "Update tutorial repository & README"
    depends: ["P8.W8.2.5"]
    status: pending

  - id: P8.W8.3.1
    description: "Write RMarkdown tutorial for DBI/RPostgreSQL connection"
    depends: []
    status: pending
  - id: P8.W8.3.2
    description: "Demonstrate spatial data manipulation with `sf`"
    depends: ["P8.W8.3.1"]
    status: pending
  - id: P8.W8.3.3
    description: "Perform spatial analyses (point patterns, autocorrelation)"
    depends: ["P8.W8.3.2"]
    status: pending
  - id: P8.W8.3.4
    description: "Create `ggplot2`/`tmap` visualizations"
    depends: ["P8.W8.3.3"]
    status: pending
  - id: P8.W8.3.5
    description: "Embed code snippets for CSV/GeoJSON exports"
    depends: ["P8.W8.3.4"]
    status: pending
  - id: P8.W8.3.6
    description: "Publish R tutorial to project site"
    depends: ["P8.W8.3.5"]
    status: pending

  - id: P8.W8.4.1
    description: "Draft PDF guide for QGIS Data Source Manager setup"
    depends: []
    status: pending
  - id: P8.W8.4.2
    description: "Instruct on loading vector/raster layers from PostGIS"
    depends: ["P8.W8.4.1"]
    status: pending
  - id: P8.W8.4.3
    description: "Show graphical queries & spatial operations (buffers, joins)"
    depends: ["P8.W8.4.2"]
    status: pending
  - id: P8.W8.4.4
    description: "Demonstrate export workflows (CSV, Shapefile, PNG/PDF)"
    depends: ["P8.W8.4.3"]
    status: pending
  - id: P8.W8.4.5
    description: "Include annotated screenshots & diagrams"
    depends: ["P8.W8.4.4"]
    status: pending
  - id: P8.W8.4.6
    description: "Package QGIS `.qgs` project files with sample data"
    depends: ["P8.W8.4.5"]
    status: pending
  - id: P8.W8.4.7
    description: "Upload QGIS tutorial package"
    depends: ["P8.W8.4.6"]
    status: pending
---
# Current Tasks
- [ ] Add unit tests
- [ ] Update README.md with setup and usage instructions

# Discovered During Work
- [ ] Add notebook-based QA reports for Phase 2 ETL steps
- [ ] Add CLI tool for GCP error visualization
- [ ] Consider `dvc` integration for `data/processed/`

# Upcoming Tasks (by Phase and Workflow)

## No Phase Assignment - Urgent



## Phase 1: Database Analysis

### Workflow 1.1 Legacy Database Instantiation & Validation
- [ ] **P1.W1.1.1** Configure PostgreSQL connection parameters in a `.env` file
- [ ] **P1.W1.1.2** Load environment variables and verify secure credentials
- [ ] **P1.W1.1.3** Run `setup_databases.py` to create PostgreSQL instances for each legacy TMP database
- [ ] **P1.W1.1.4** Execute SQL scripts to populate each instance with legacy data
- [ ] **P1.W1.1.5** Invoke `schema_viz.py` to auto-generate ERD diagrams for each database
- [ ] **P1.W1.1.6** Run `profile_db.py` to collect schema metrics (table cardinalities, data-type distributions, null frequencies)
- [ ] **P1.W1.1.7** Persist profiling outputs into the `tmp_db_metrics` schema
- [ ] **P1.W1.1.8** Commit and update Phase 1 setup & profiling documentation

### Workflow 1.2 Schema Analysis, Profiling & Denormalization Evaluation
- [ ] **P1.W1.2.1** Execute `profile_db.py` for deep schema profiling across DF8, DF9, DF10
- [ ] **P1.W1.2.2** Generate ERDs for DF8, DF9, DF10 and export to PNG
- [ ] **P1.W1.2.3** Validate primary-key and foreign-key integrity (identify orphans, duplicates)
- [ ] **P1.W1.2.4** Compute Join-Dependency Index (JDI) & Lookup Inflation Factor (LIF) for each schema
- [ ] **P1.W1.2.5** Prototype denormalized schema variants (flatten key tables)
- [ ] **P1.W1.2.6** Benchmark representative analytical queries with `EXPLAIN ANALYZE`
- [ ] **P1.W1.2.7** Draft “Denormalization White Paper” summarizing trade-offs & performance gains
- [ ] **P1.W1.2.8** Update Phase 1 analysis documentation with denormalization outcomes

## Phase 2: Database Transformation

### Workflow 2.1 Legacy Dataset Integration (DF8/9/10 → DF11; REAN_DF2 → REAN_DF3)
- [ ] **P2.W2.1.1** Compare DF8, DF9, DF10 schemas to identify structural discrepancies
- [ ] **P2.W2.1.2** Build attribute crosswalk tables mapping legacy field names → standardized names
- [ ] **P2.W2.1.3** Flatten multi-table structures into a wide-format provisional dataset (DF11)
- [ ] **P2.W2.1.4** Clean & transform REAN_DF2 into provisional REAN_DF3
- [ ] **P2.W2.1.5** Develop Python ETL scripts (Pandas + SQLAlchemy) to merge DF8/9/10 → DF11
- [ ] **P2.W2.1.6** Apply rule-based resolution to remove duplicate records
- [ ] **P2.W2.1.7** Archive DF11 & REAN_DF3 with detailed integration logs
- [ ] **P2.W2.1.8** Update integration workflow docs and README

### Workflow 2.2 Variable Redesign & Analytical Transformation (DF11 → DF12; REAN_DF3 → REAN_DF4)
- [ ] **P2.W2.2.1** Evaluate each DF11 variable for completeness, relevance, redundancy
- [ ] **P2.W2.2.2** Engineer new analytic variables (e.g., site-count per unit, ordinal scales)
- [ ] **P2.W2.2.3** Clean text/categorical fields via regex normalization
- [ ] **P2.W2.2.4** Recode nominal → ordinal variables where appropriate
- [ ] **P2.W2.2.5** Remove low-information variables; log deletions in Variable Transformation Log
- [ ] **P2.W2.2.6** Reorder & rename columns for consistency
- [ ] **P2.W2.2.7** Produce final DF12 and controlled-vocabulary lookup tables
- [ ] **P2.W2.2.8** Align REAN_DF3 with DF12 by SSN; output REAN_DF4
- [ ] **P2.W2.2.9** Update transformation pipeline documentation

### Workflow 2.3 Controlled Vocabulary Consolidation
- [ ] **P2.W2.3.1** Consolidate categorical value sets into unified lookup tables
- [ ] **P2.W2.3.2** Apply vocabulary mappings to DF12 & REAN_DF4
- [ ] **P2.W2.3.3** Export glossaries as PDF and CSV
- [ ] **P2.W2.3.4** Verify alignment with tDAR metadata requirements
- [ ] **P2.W2.3.5** Update controlled-vocabulary docs

### Workflow 2.4 Automated Metadata Validation & Data Quality
- [ ] **P2.W2.4.1** Integrate Great Expectations/dbt into ETL pipelines
- [ ] **P2.W2.4.2** Define validation rules for schema, content ranges, uniqueness, nullability
- [ ] **P2.W2.4.3** Automate metadata completeness checks at project/dataset/file levels
- [ ] **P2.W2.4.4** Embed validation in CI/CD (GitHub Actions or Prefect)
- [ ] **P2.W2.4.5** Generate & archive data quality reports for each release
- [ ] **P2.W2.4.6** Document data lineage & transformation traceability
- [ ] **P2.W2.4.7** Update QA framework documentation

## Phase 3: GIS Digitization

### Workflow 3.1 Raster Assembly for Digitization
- [ ] **P3.W3.1.1** Catalog all raster basemaps (survey maps, aerial imagery)
- [ ] **P3.W3.1.2** Align and trim raster edges for unified coverage
- [ ] **P3.W3.1.3** Mosaic rasters into “TMP Topo/Survey” and “TMP Architectural Reconstruction” layers
- [ ] **P3.W3.1.4** Enhance rasters via GDAL (contrast, de-skew)
- [ ] **P3.W3.1.5** Create QGIS project templates with standardized symbology
- [ ] **P3.W3.1.6** Export high-res mosaics for digitization
- [ ] **P3.W3.1.7** Document raster preprocessing steps

### Workflow 3.2 Manual Digitization – Topo/Survey Map
- [ ] **P3.W3.2.1** Digitize Floors  
- [ ] **P3.W3.2.2** Digitize Walls  
- [ ] **P3.W3.2.3** Digitize Taludes & Tableros  
- [ ] **P3.W3.2.4** Digitize Plazas  
- [ ] **P3.W3.2.5** Digitize Pits  
- [ ] **P3.W3.2.6** Digitize Mounds  
- [ ] **P3.W3.2.7** Digitize Stone concentrations  
- [ ] **P3.W3.2.8** Digitize Sherd concentrations  
- [ ] **P3.W3.2.9** Digitize Obsidian concentrations  
- [ ] **P3.W3.2.10** Digitize Excavations  
- [ ] **P3.W3.2.11** Digitize Staircases  
- [ ] **P3.W3.2.12** Digitize Sherd dumps  
- [ ] **P3.W3.2.13** Digitize “Not Surveyed + No Permission” zones  
- [ ] **P3.W3.2.14** Digitize “Nada (N)” survey tracts  
- [ ] **P3.W3.2.15** Digitize “Almost Nada (AN)” survey tracts  
- [ ] **P3.W3.2.16** Validate and record Topo/Survey digitization metadata

### Workflow 3.3 Manual Digitization – Architectural Reconstructions
- [ ] **P3.W3.3.1** Load Architectural Reconstruction raster
- [ ] **P3.W3.3.2** Compare existing polygon versions
- [ ] **P3.W3.3.3** Re-digitize Sherfield’s 2023 urban polygons per “Map Assignations”
- [ ] **P3.W3.3.4** Resolve overlaps with Topo/Survey layers
- [ ] **P3.W3.3.5** Apply provisional attribute schemas
- [ ] **P3.W3.3.6** Archive architectural digitization metadata

### Workflow 3.4 Pre-Georeferencing QA
- [ ] **P3.W3.4.1** Run QGIS Geometry Validity & Topology Checker
- [ ] **P3.W3.4.2** Snap and close polygons; correct line intersections
- [ ] **P3.W3.4.3** Standardize provisional attribute fields
- [ ] **P3.W3.4.4** Generate spatial metadata summaries (counts, extents)
- [ ] **P3.W3.4.5** Archive QA reports & update Phase 3 docs

## Phase 4: Georeferencing

### Workflow 4.1 Raster Prep & Ground Control Points
- [ ] **P4.W4.1.1** Import photogrammetry reference rasters for GCP collection
- [ ] **P4.W4.1.2** Manually collect GCPs in QGIS; export as point layer
- [ ] **P4.W4.1.3** Convert GCPs to GDAL format and attach to rasters
- [ ] **P4.W4.1.4** Preprocess rasters (denoise, crop) for georeferencing
- [ ] **P4.W4.1.5** Log GCP collection metadata

### Workflow 4.2 Method Calibration & Accuracy Assessment
- [ ] **P4.W4.2.1** Perform sensitivity tests across resampling methods (Lanczos, etc.)
- [ ] **P4.W4.2.2** Calculate RMSE for GCP residuals
- [ ] **P4.W4.2.3** Produce spatial error heatmaps & residual plots
- [ ] **P4.W4.2.4** Conduct spatial autocorrelation (Moran’s I) on residuals
- [ ] **P4.W4.2.5** Select optimal georeferencing method
- [ ] **P4.W4.2.6** Document method calibration & accuracy report

### Workflow 4.3 NTv2 Grid Shift Pipeline
- [ ] **P4.W4.3.1** Define custom “Millon Space” CRS with PROJ
- [ ] **P4.W4.3.2** Apply TPS interpolation to refined GCPs
- [ ] **P4.W4.3.3** Generate `.gsb` NTv2 grid shift files
- [ ] **P4.W4.3.4** Register `.gsb` with PROJ/QGIS
- [ ] **P4.W4.3.5** Archive NTv2 grid files & docs

### Workflow 4.4 Vector Georeferencing
- [ ] **P4.W4.4.1** Apply NTv2 shift to provisional vector layers via GDAL/pyproj
- [ ] **P4.W4.4.2** Validate post-transformation geometries (`ST_IsValid`)
- [ ] **P4.W4.4.3** Assign EPSG:32614 CRS to all layers
- [ ] **P4.W4.4.4** Archive georeferenced vectors

### Workflow 4.5 Final Accuracy Validation
- [ ] **P4.W4.5.1** Recompute RMSE on transformed GCPs
- [ ] **P4.W4.5.2** Generate final error diagnostics & visuals
- [ ] **P4.W4.5.3** Apply rubber-sheet corrections if needed
- [ ] **P4.W4.5.4** Update georeferencing validation documentation

### Workflow 4.6 Export Georeferenced Datasets
- [ ] **P4.W4.6.1** Export production layers in EPSG:32614
- [ ] **P4.W4.6.2** Export dissemination layers in EPSG:4326 (simplified)
- [ ] **P4.W4.6.3** Produce CRS transformation metadata
- [ ] **P4.W4.6.4** Archive final georeferenced exports and update Phase 4 docs

## Phase 5: Geospatial Integration

### Workflow 5.1 GIS Integration
- [ ] **P5.W5.1.1** QA georeferenced layers; remove overlaps/duplicates
- [ ] **P5.W5.1.2** Join DF12 & REAN_DF4 to collection-unit polygon layer
- [ ] **P5.W5.1.3** Document join logic & scripts

### Workflow 5.2 Architectural Feature Classification
- [ ] **P5.W5.2.1** Define hierarchical classification schema
- [ ] **P5.W5.2.2** Build spatial overlay algorithm linking features ↔ collection units
- [ ] **P5.W5.2.3** Compute proportional overlaps & assign weights
- [ ] **P5.W5.2.4** Compare against prior classifications; flag discrepancies
- [ ] **P5.W5.2.5** Update architectural feature attributes
- [ ] **P5.W5.2.6** Archive classification metadata

### Workflow 5.3 Spatial Feature Engineering
- [ ] **P5.W5.3.1** Calculate geometry metrics (area, complexity indices)
- [ ] **P5.W5.3.2** Generate spatial entropy & density measures
- [ ] **P5.W5.3.3** Derive new spatial variables and append to DF12
- [ ] **P5.W5.3.4** Validate derived fields against original DB values
- [ ] **P5.W5.3.5** Export updated DF12 with spatial attributes
- [ ] **P5.W5.3.6** Update data dictionary with spatial variables

### Workflow 5.4 Spatial QA & Export
- [ ] **P5.W5.4.1** Validate geometries & attributes consistency
- [ ] **P5.W5.4.2** Ensure uniform CRS across all layers
- [ ] **P5.W5.4.3** Produce spatial metadata summary
- [ ] **P5.W5.4.4** Archive integrated dataset for Phase 6/7
- [ ] **P5.W5.4.5** Update Phase 5 integration documentation

## Phase 6: tDAR Outputs

### Workflow 6.1 Data Preparation & Conversion
- [ ] **P6.W6.1.1** Convert vector datasets → Shapefiles (apply name-truncation rules)
- [ ] **P6.W6.1.2** Export extended attributes → linked CSV tables
- [ ] **P6.W6.1.3** Clip/compress GeoTIFF rasters for tDAR size limits
- [ ] **P6.W6.1.4** Derive analytical raster products where appropriate
- [ ] **P6.W6.1.5** Archive tDAR-ready data packages

### Workflow 6.2 Metadata & Ontology Prep
- [ ] **P6.W6.2.1** Draft project-level metadata (context, coverage, creators)
- [ ] **P6.W6.2.2** Create dataset-level metadata for each package
- [ ] **P6.W6.2.3** Produce file-level metadata (CRS, schemas, descriptions)
- [ ] **P6.W6.2.4** Export controlled-vocabulary CSVs & glossaries
- [ ] **P6.W6.2.5** Generate ERDs illustrating dataset relationships
- [ ] **P6.W6.2.6** Validate metadata against tDAR schema

### Workflow 6.3 Documentation & Tutorials
- [ ] **P6.W6.3.1** Write README for each data package
- [ ] **P6.W6.3.2** Create detailed data dictionaries (variables, units, codes)
- [ ] **P6.W6.3.3** Draft methodological report (workflows, limitations)
- [ ] **P6.W6.3.4** Produce versioning & provenance logs
- [ ] **P6.W6.3.5** Develop QGIS/ArcGIS CSV-Shapefile rejoin tutorial
- [ ] **P6.W6.3.6** Create “Quick Start” GIS guides (maps, screenshots)
- [ ] **P6.W6.3.7** Package tutorials with sample data

### Workflow 6.4 Packaging & Submission
- [ ] **P6.W6.4.1** Apply standardized naming conventions
- [ ] **P6.W6.4.2** Archive data, metadata, docs into compressed packages
- [ ] **P6.W6.4.3** Upload compliant packages to tDAR; fill metadata fields
- [ ] **P6.W6.4.4** Upload large files to Zenodo/Figshare; record DOIs
- [ ] **P6.W6.4.5** Link external DOIs in tDAR records
- [ ] **P6.W6.4.6** Final review of tDAR submissions

## Phase 7: PostGIS Database

### Workflow 7.1 Design & Schema Setup
- [ ] **P7.W7.1.1** Define spatial entities & relational tables (sites, artifacts, units)
- [ ] **P7.W7.1.2** Integrate controlled-vocabulary tables as lookups
- [ ] **P7.W7.1.3** Design normalized schema; plan selective denormalization
- [ ] **P7.W7.1.4** Specify GIST & BRIN index strategies
- [ ] **P7.W7.1.5** Define primary/foreign-key constraints
- [ ] **P7.W7.1.6** Draft topology models if needed
- [ ] **P7.W7.1.7** Create SQL views/materialized views for common queries
- [ ] **P7.W7.1.8** Document database schema design

### Workflow 7.2 Construction & Validation
- [ ] **P7.W7.2.1** Initialize PostgreSQL with PostGIS (and pgrouting)
- [ ] **P7.W7.2.2** Load DF12 & REAN_DF4 as spatial-enabled tables
- [ ] **P7.W7.2.3** Import Phase 3–4 layers via `ogr2ogr`/`raster2pgsql`
- [ ] **P7.W7.2.4** Validate & transform CRS to WGS84/UTM zone
- [ ] **P7.W7.2.5** Create spatial indexes on geometry columns
- [ ] **P7.W7.2.6** Enforce NOT NULL, UNIQUE, FOREIGN KEY constraints
- [ ] **P7.W7.2.7** Repair invalid geometries (`ST_MakeValid`)
- [ ] **P7.W7.2.8** Profile queries with `EXPLAIN ANALYZE`; optimize
- [ ] **P7.W7.2.9** Archive database build & validation logs

### Workflow 7.3 Packaging & Distribution
- [ ] **P7.W7.3.1** Generate `schema_only.sql` & `full_data.sql` dumps
- [ ] **P7.W7.3.2** Build Docker container with PostgreSQL/PostGIS instance
- [ ] **P7.W7.3.3** Write Docker Compose & restoration docs
- [ ] **P7.W7.3.4** Export GeoJSON/CSV/GeoTIFF static files for non-technical users
- [ ] **P7.W7.3.5** Deploy FastAPI endpoints for GeoJSON/CSV delivery
- [ ] **P7.W7.3.6** Develop Leaflet.js WebGIS dashboard
- [ ] **P7.W7.3.7** Host API & dashboard (GitHub Pages or equivalent)
- [ ] **P7.W7.3.8** Update distribution & deployment documentation

## Phase 8: Tutorials & Dashboards

### Workflow 8.1 WebGIS Dashboard App
- [ ] **P8.W8.1.1** Scaffold frontend with Leaflet.js (responsive UI)
- [ ] **P8.W8.1.2** Implement FastAPI endpoints for dynamic data loads
- [ ] **P8.W8.1.3** Add spatial filtering & attribute queries in dashboard
- [ ] **P8.W8.1.4** Enable direct data downloads (GeoJSON/CSV)
- [ ] **P8.W8.1.5** Deploy to hosting platform
- [ ] **P8.W8.1.6** Embed usage guide in dashboard interface

### Workflow 8.2 Python PostGIS Tutorial
- [ ] **P8.W8.2.1** Create Jupyter Notebook for Docker-based PostGIS setup
- [ ] **P8.W8.2.2** Demonstrate `psycopg2`/`SQLAlchemy` DB connections
- [ ] **P8.W8.2.3** Show data ingestion & visualization (GeoPandas, Folium, Plotly)
- [ ] **P8.W8.2.4** Include spatial-analysis examples (density, proximity)
- [ ] **P8.W8.2.5** Package with sample datasets
- [ ] **P8.W8.2.6** Update tutorial repository & README

### Workflow 8.3 R PostGIS Tutorial
- [ ] **P8.W8.3.1** Write RMarkdown tutorial for DBI/RPostgreSQL connection
- [ ] **P8.W8.3.2** Demonstrate spatial data manipulation with `sf`
- [ ] **P8.W8.3.3** Perform spatial analyses (point patterns, autocorrelation)
- [ ] **P8.W8.3.4** Create `ggplot2`/`tmap` visualizations
- [ ] **P8.W8.3.5** Embed code snippets for CSV/GeoJSON exports
- [ ] **P8.W8.3.6** Publish R tutorial to project site

### Workflow 8.4 QGIS PostGIS Tutorial
- [ ] **P8.W8.4.1** Draft PDF guide for QGIS Data Source Manager setup
- [ ] **P8.W8.4.2** Instruct on loading vector/raster layers from PostGIS
- [ ] **P8.W8.4.3** Show graphical queries & spatial operations (buffers, joins)
- [ ] **P8.W8.4.4** Demonstrate export workflows (CSV, Shapefile, PNG/PDF)
- [ ] **P8.W8.4.5** Include annotated screenshots & diagrams
- [ ] **P8.W8.4.6** Package QGIS `.qgs` project files with sample data
- [ ] **P8.W8.4.7** Upload QGIS tutorial package

## No Phase Assignment - Not Urgent






