## Current Tasks
Add unit tests
Update README.md with setup and usage instructions

## Upcoming Tasks (by Phase)

### No Phase Assignment - Urgent

### Phase 1 – Legacy DB Analysis
- [ ] **P1.1** – Ingest DF8, DF9, DF10, REANS2 into PostgreSQL
- [ ] **P1.2** – Compare schemas, identify merge conflicts
- [ ] **P1.2** – Draft schema redesign report

### Phase 2 – DB Transformation
- [ ] **P2.1** – Build ETL scripts for DF9 to `TMP_DF12`
- [ ] **P2.2** – Clean and normalize ceramic fields
- [ ] **P2.3** – Write full variable dictionary

### Phase 3 – GIS Digitization
- [ ] **P3.1** – Create raster mosaic index
- [ ] **P3.2** – Digitize Unit Groups and Millon features from Red series
- [ ] **P3.3** – Validate polygon topologies
- [ ] **P3.4** – Generate ISO 19115 metadata for digitized layers

### Phase 4 – Georeferencing
- [ ] **P4.1** – Build GCP table for raster alignments
- [ ] **P4.2** – Implement and test transformations in GDAL CLI and Python

### Phase 5 – GeoDB Integration
- [ ] **P5.1** – Design spatial joins across TMP_REANS_DF4 + unit polygons
- [ ] **P5.2** – Publish public-facing PostGIS view
- [ ] **P5.3** – Export GeoJSON and Shapefiles with tDAR metadata

### No Phase Assignment - Not Urgent

## Discovered During Work
- [ ] Add notebook-based QA reports for Phase 2 ETL steps
- [ ] Add CLI tool for GCP error visualization
- [ ] Consider `dvc` integration for `data/processed/`

