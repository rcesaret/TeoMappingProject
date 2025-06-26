---
guide_id: "guide-postgis-deployment"
version: "1.0"
last_updated: "2025-06-26"
related_mode: "mode-postgis-deployment.md"
---

# GUIDE: PostGIS Database Deployment & Management

## 1. CORE OBJECTIVE
To architect, deploy, and maintain a **secure, performant, and reproducible** PostGIS database instance tailored for the analytical and archival needs of the Digital TMP project. This guide provides the strategic rationale behind the specific, imperative rules in `mode-postgis-deployment.md`.

## 2. GOVERNING PRINCIPLES
- **Principle of Reproducibility:** The entire database environment—including the specific PostgreSQL and PostGIS versions, schema, and initial data—MUST be fully reproducible from version-controlled scripts. This is achieved through Docker and SQL DDL scripts.
- **Principle of Least Privilege:** The database service must operate with the minimum permissions necessary. Never run the service as a `root` user, and restrict network access to only trusted clients. Security is not an afterthought.
- **Principle of Performance by Design:** Performance is architected, not bolted on. Every table with spatial data MUST have an appropriate spatial index created at the same time as the table itself. This is a non-negotiable requirement for handling archaeological geospatial queries efficiently.
- **Principle of Managed Evolution:** All changes to the database schema after initial deployment MUST be handled through a versioned migration tool (`alembic`). Manual `ALTER TABLE` commands against a production database are strictly forbidden to ensure a traceable and reversible history of the schema.

## 3. PROCEDURAL PROTOCOL: The Database Lifecycle
**Step 1: Schema Definition (DDL Scripts)**
- When defining table schemas, select the most precise data type. For the TMP project, this means:
  - `GEOMETRY`: For projected data like the architectural features in the local "Millon Space" or final UTM projection.
  - `GEOGRAPHY`: For global-scale data or calculations where spherical earth measurements are critical (less common for this project but a key distinction).
  - `TIMESTAMPTZ`: To store all temporal data with time zone information, avoiding ambiguity.
- **Crucially, for every `GEOMETRY` or `GEOGRAPHY` column, you MUST immediately follow its table definition with a `CREATE INDEX ... USING GIST (...)` statement.** GiST (Generalized Search Tree) is the indexing method that enables PostGIS to perform fast spatial queries (e.g., intersects, contains). A standard B-Tree index is ineffective for spatial data.

**Step 2: Containerized Deployment (Dockerfile)**
- Your `Dockerfile` is the blueprint for a reproducible environment.
- It MUST start from an official PostgreSQL image (e.g., `postgres:17`) and add the specific, matching version of PostGIS (e.g., `postgis/postgis:17-3.4`). Version consistency is key.
- The `Dockerfile` MUST create a dedicated, non-root user (e.g., `postgres_user`) and switch to this user with the `USER` instruction before starting the service.
- It should copy your DDL scripts and any initialization scripts into the `/docker-entrypoint-initdb.d` directory. Scripts in this directory are automatically run when the container is first created, setting up your schema.

**Step 3: Data Ingestion**
- For bulk loading geospatial data, `ogr2ogr` (for vector) and `raster2pgsql` (for raster) are the standard, high-performance tools.
- Your ingestion scripts MUST include options to create spatial indexes during the load (`-lco SPATIAL_INDEX=GIST`) and to tile large rasters for better rendering performance in GIS clients.

**Step 4: Schema Migration (Alembic)**
- After the database is live, any change is a migration.
- **Never write a manual `ALTER TABLE` query.**
- Use `alembic revision --autogenerate -m "Description of change"` to detect schema changes and create a new migration script.
- You must review the generated script and ensure it includes both an `upgrade()` function (to apply the change) and a `downgrade()` function (to revert it). This ensures the schema's history is fully manageable.

## 4. CONTEXT-SPECIFIC EXAMPLES & HEURISTICS
**Scenario:** Creating a new table for archaeological sites.

**CORRECT DDL & INDEXING SCRIPT:**
```sql
-- DDL for the new 'archaeological_sites' table
CREATE TABLE archaeological_sites (
    id SERIAL PRIMARY KEY,
    site_name VARCHAR(255) NOT NULL,
    tmp_id VARCHAR(50) UNIQUE,
    excavation_date TIMESTAMPTZ,
    geom GEOMETRY(Polygon, 32614) -- Storing as UTM Zone 14N
);

-- NON-NEGOTIABLE: Immediately create the spatial index after the table.
CREATE INDEX idx_archaeological_sites_geom
ON archaeological_sites
USING GIST (geom);

-- Also index the foreign key for performance
CREATE INDEX idx_archaeological_sites_tmp_id
ON archaeological_sites (tmp_id);
````

**Reasoning:* The `USING GIST` clause is the most important part of this example. It tells PostgreSQL to use a spatial index, which is essential for any query that uses the `geom` column in a `WHERE` clause (e.g., finding all sites within a certain area).*

**SECURE `pg_hba.conf` ENTRY:**

```conf
# TYPE  DATABASE        USER            ADDRESS                 METHOD
# Allow replication connections from a specific IP
host    replication     replicator      192.168.1.100/32        scram-sha-256
# Allow the web application to connect from its specific IP
host    tmp_database    webapp_user     192.168.1.200/32        scram-sha-256
```

**Reasoning:* This configuration is secure. It uses `scram-sha-256` for password-based authentication and restricts access to specific users from specific IP addresses. It avoids the insecure `trust` or overly broad `0.0.0.0/0` address ranges.*

## 5\. ANTI-PATTERNS & TROUBLESHOOTING

  - **Anti-Pattern: Forgetting the Spatial Index.** A PostGIS table with a geometry column but no GiST index will be catastrophically slow for spatial queries. The `mode-postgis-deployment.md` rule makes this a mandatory check.
  - **Anti-Pattern: Running as Root.** A container running its service as the `root` user is a major security vulnerability. The `Dockerfile` MUST create and switch to a non-root user.
  - **Anti-Pattern: Manual Schema Changes.** If you find yourself typing `ALTER TABLE` into a `psql` prompt connected to a staging or production database, you have violated the migration protocol. Stop and use `alembic` instead.
  - **Troubleshooting: Slow Queries.** If spatial queries are slow, the first step is *always* to run `EXPLAIN ANALYZE` on the query. The output will immediately show if the query is using the spatial index. If it is not, the index is likely missing, or the query needs to be rewritten to be "index-friendly."

<!-- end list -->

---
