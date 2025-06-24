---
trigger: manual
---

# POSTGIS DEPLOYMENT

## OBJECTIVE
Your objective is to assist with scripting the entire lifecycle of the production PostGIS database, from secure design and deployment to maintenance and migration.

## SCHEMA & DESIGN PROTOCOL
- Generate SQL Data Definition Language (DDL) scripts for creating tables, views, and functions.
- Scripts MUST define the most appropriate and specific PostgreSQL data types (`TIMESTAMPTZ` for time, `NUMERIC` for precise numbers, `GEOMETRY` for projected data, `GEOGRAPHY` for geographic data).
- For every table with a `geometry` or `geography` column, the DDL script MUST create a spatial index using the GiST method (`CREATE INDEX ... USING GIST (...)`). This is a non-negotiable performance requirement.
- Scripts should create standard B-Tree indexes on foreign key columns and frequently queried attribute columns. For very large tables, propose partitioning strategies.

## DEPLOYMENT & INGESTION PROTOCOL
- Generate `Dockerfile`s for creating a containerized PostGIS service.
  - The `Dockerfile` MUST specify the correct major versions of PostgreSQL (17) and PostGIS (3.4).
  - It MUST include logic to initialize the database with the generated DDL scripts.
- Generate scripts using `ogr2ogr` for vector data and `raster2pgsql` for raster data to perform bulk loading. Scripts must include tiling options for rasters to improve rendering performance.
- Python code for database interaction MUST use `sqlalchemy` and the `geoalchemy2` extension.

## SECURITY & MAINTENANCE PROTOCOL
- When generating a `Dockerfile` for PostGIS, you MUST include security best practices:
  - Create a non-root user for running the PostgreSQL service.
  - Generate a `pg_hba.conf` file that restricts connections to trusted IP addresses or networks. Do not use `trust` authentication.
- Create a shell script that uses `pg_dump` to perform daily backups.
  - The script MUST differentiate between `schema_only` and `full_data` dumps.
  - The output MUST be compressed (e.g., `.sql.gz`).
  - The backup filename MUST be versioned with the date (e.g., `tmp_backup_YYYY-MM-DD.sql.gz`).
- Generate a SQL script that runs routine database maintenance tasks, including `VACUUM ANALYZE` on all project tables and `REINDEX` on spatial indexes.
- When generating configuration for the FastAPI application that connects to this database, you MUST include a database connection pool (e.g., using `SQLAlchemy`'s `QueuePool`) to manage connections efficiently and prevent overwhelming the database.

## DATABASE MIGRATION PROTOCOL
- For any schema changes *after* the initial deployment, you MUST use `alembic` to generate and manage migration scripts.
- You are strictly forbidden from proposing manual `ALTER TABLE` commands for production environments. All schema changes must be captured in a versioned `alembic` migration script.
- Generate the `alembic` revision script and include both the `upgrade()` and `downgrade()` functions for full reversibility.

## PROJECT DATA OPTIMIZATION
- Generate scripts that optimize PostGIS performance for archaeological datasets, including appropriate spatial indexing strategies for point, line, and polygon features.
- Implement specialized indexes for temporal queries on archaeological data, including date ranges and cultural phase assignments.
- Create materialized views for common archaeological analysis patterns, such as artifact density calculations and spatial proximity analysis.
- Generate scripts that validate spatial data integrity specifically for archaeological features, including geometry validation and topological consistency checks.

## SPATIAL DATA INTEGRATION
- Generate scripts that ensure all spatial datasets are transformed to a unified spatial reference system using `ST_Transform`.
- Implement validation scripts using `ST_IsValid` and repair procedures with `ST_MakeValid` for all spatial geometries.
- Create procedures for spatial joins between tabular archaeological data and geometric features, with validation of join success rates.
- Generate scripts that implement spatial relationship validation for archaeological features (e.g., artifacts within collection units, structures within survey areas).

## PERFORMANCE MONITORING & OPTIMIZATION
- Generate scripts that use `EXPLAIN ANALYZE` to identify performance bottlenecks and create materialized views for high-demand queries.
- Implement monitoring procedures for database performance, including spatial query execution times and index usage statistics.
- Create automated procedures for refreshing materialized views and updating spatial statistics as data volumes grow.
- Generate scripts that optimize PostgreSQL configuration parameters specifically for spatial data processing and archaeological datasets.

## API & SERVICE INTEGRATION
- Generate configuration scripts for RESTful API deployment using FastAPI to serve curated datasets in GeoJSON and CSV formats.
- Implement API endpoint logic that efficiently serves spatial data with appropriate spatial filtering and coordinate system transformation.
- Create automated procedures for API documentation generation and testing to ensure reliable data access.
- Generate scripts that implement appropriate caching strategies for frequently accessed spatial datasets and complex analytical queries.

## BACKUP & DISASTER RECOVERY
- Generate comprehensive backup procedures that include both database dumps and spatial configuration files (custom CRS definitions, NTv2 grids).
- Implement automated testing of backup restoration procedures to ensure data recovery capabilities.
- Create procedures for maintaining multiple backup generations and implementing appropriate retention policies.
- Generate documentation for disaster recovery procedures specific to spatial databases and archaeological datasets.
