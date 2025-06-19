# Instructional Guide: Database Design & Management

## 1. Introduction & Design Philosophy

This document is the authoritative guide for designing, implementing, and maintaining the database schemas for the Digital Teotihuacan Mapping Project (TMP). It expands upon the rules in `guide-sql-best-practices.md` to provide a complete architectural framework for our PostgreSQL/PostGIS database.

Our design philosophy is governed by three core principles:
-   **Data Integrity First:** The database MUST be the ultimate guarantor of data correctness. Integrity will be enforced at the lowest possible level through a rich set of constraints, data types, and transactions. We do not rely on the application layer to enforce core data rules.
-   **Performance by Design:** Performance is not an afterthought. It is designed into the schema through proper normalization, a comprehensive indexing strategy, and an understanding of the query patterns the database must support.
-   **Maintainability and Clarity:** The database schema is a core part of the project's source code. It must be as readable, well-documented, and version-controlled as any Python module.

## 2. The Project's Data Model: From Legacy to Integrated

The project's data architecture involves a clear progression from legacy sources to a modern, integrated production environment.
-   **Legacy Schemas:** The original data from MS Access (`DF*` files) is often denormalized, with inconsistent data types and implicit relationships.
-   **Benchmark Schemas:** The SQLite databases created in Phase 1 serve as benchmarks and initial cleaned versions of the legacy data.
-   **Production Schema:** The final PostGIS database represents a normalized, relational, and spatially-enabled model that integrates all project data into a single, cohesive source of truth. The goal of our design work is to build this production schema.

## 3. Relational Database Design & Normalization

The default state for our production schema is Third Normal Form (3NF).

-   **Normalization Principles:**
    -   **1NF (First Normal Form):** Each column must contain atomic (indivisible) values, and each record must be unique. This means no repeating groups or multi-valued columns (e.g., an `authors` column containing "John Doe, Jane Smith").
    -   **2NF (Second Normal Form):** Must be in 1NF. All non-key attributes must be fully dependent on the entire primary key. This primarily applies to tables with composite primary keys and is resolved by splitting tables.
    -   **3NF (Third Normal Form):** Must be in 2NF. All attributes must be dependent only on the primary key, not on other non-key attributes.
    -   **Practical Example (Resolving a 1NF Violation):**
        -   **Legacy (Bad):** A `publications` table with columns `(pub_id, title, authors_text)`. The `authors_text` column violates 1NF.
        -   **Normalized (Good):** This is resolved by creating three tables:
            1.  `publications (publication_id, title)`
            2.  `authors (author_id, author_name)`
            3.  `publication_authors (publication_id, author_id)` (A linking table).
-   **Denormalization for Performance:** While 3NF is the standard, deliberate, and documented denormalization is an acceptable strategy for specific performance optimizations. This is typically done for analytics and reporting workflows (e.g., Phase 8 dashboards) by creating **materialized views**. A materialized view is a physical copy of a query result, which can be indexed and queried much faster than the complex join it represents. This MUST be a conscious architectural decision, not an accidental one.

## 4. Physical Schema Design & Implementation in PostgreSQL

### 4.1 Schema Organization

To maintain clarity, tables MUST be organized into logical schemas within the database. The standard project schemas are:
-   `raw_legacy`: For direct, unaltered dumps of the original legacy data.
-   `staging`: For intermediate tables used during data cleaning and transformation pipelines.
-   `production`: For the final, cleaned, and normalized application-ready tables.
-   `analytics`: For materialized views and other reporting-focused objects.

### 4.2 Data Type Selection

Using the correct data type is the first line of defense for data integrity.
| Use Case | Recommended PostgreSQL Type | Rationale |
| :--- | :--- | :--- |
| All Timestamps | `TIMESTAMPTZ` | Stores in UTC, converts to client timezone. Eliminates all ambiguity. |
| Primary Keys | `UUID` | Universally unique, avoids sequence conflicts. Use `gen_random_uuid()` as default. |
| Precise Numbers | `NUMERIC` | For calculations where precision is critical (e.g., measurements). |
| General Text | `TEXT` | For strings of variable or unknown length. No performance penalty vs. `VARCHAR`. |
| JSON Documents | `JSONB` | Stored in a decomposed binary format. Faster to process and can be indexed with GIN. |
| Spatial Data | `GEOMETRY` | The PostGIS standard for projected and geographic data. |
| Reusable Types | `DOMAIN` | A custom type with built-in `CHECK` constraints (see `guide-sql-best-practices.md`). |

### 4.3 Constraint Protocol

All constraints MUST be explicitly named using the convention `tablename_columnnames_constrainttype`.
-   **FOREIGN KEYs are mandatory** for all relational links.
-   `ON DELETE` behavior must be explicitly defined. `ON DELETE RESTRICT` (the default) is safest. Use `ON DELETE CASCADE` or `ON DELETE SET NULL` only when the business logic explicitly calls for it and it is documented.

```sql
CREATE TABLE production.artifacts (
    artifact_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    collection_unit_id UUID NOT NULL,
    material TEXT NOT NULL,
    geom GEOMETRY(Point, 6362) NOT NULL, -- ITRF2008 / UTM zone 14N

    CONSTRAINT artifacts_collection_unit_id_fk
        FOREIGN KEY (collection_unit_id)
        REFERENCES production.survey_collection_units(unit_id)
        ON DELETE RESTRICT, -- Do not allow deleting a unit if artifacts are linked

    CONSTRAINT artifacts_material_check
        CHECK (material IN ('sherd', 'lithic', 'figurine', 'obsidian'))
);
```

## 5. Indexing Strategy for High Performance

-   **B-Tree Indexes:** A B-Tree index MUST be created on every **foreign key column** and any column frequently used in `WHERE` or `ORDER BY` clauses.
-   **GiST Indexes:** A GiST index MUST be created on every `geometry` column.
-   **GIN Indexes:** A GIN index MUST be created on `JSONB` columns to enable fast searching within the JSON structure.
-   **Advanced Indexes:**
    -   **Expression Index:** Use when queries frequently filter on an expression.
        ```sql
        -- To speed up case-insensitive searches for researcher emails
        CREATE INDEX idx_researchers_lower_email ON production.researchers (lower(email));
        ```
    -   **Partial Index:** Use when queries frequently target a small, well-defined subset of a large table.
        ```sql
        -- To speed up finding only the active, published artifacts
        CREATE INDEX idx_artifacts_published ON production.artifacts (artifact_id)
        WHERE is_published = TRUE AND is_active = TRUE;
        ```

## 6. Generating Entity-Relationship Diagrams (ERDs)

The database schema MUST be visualized and documented with an Entity-Relationship Diagram (ERD).
-   **Protocol:** The AI will generate the `DOT` language script for the project's schema. This `DOT` script can then be rendered into an image using the `Graphviz` tool. Alternatively, a tool like `eralchemy` can be used to generate the diagram directly from the project's SQLAlchemy models. The final ERD image (`schema.png`) must be stored in the `/docs` directory.

## 7. Database Migration Strategy (The `alembic` Protocol)

All changes to the production database schema after its initial creation MUST be managed through a database migration tool. **`alembic` is the project standard.**

-   **Rationale:** Manual `ALTER TABLE` commands are forbidden for shared databases because they are not version-controlled, not easily repeatable across different environments (dev, staging, prod), and not peer-reviewed. `alembic` solves this by treating your schema as code.
-   **Workflow:**
    1.  After changing your SQLAlchemy models in the Python code...
    2.  Generate a new migration script: `alembic revision --autogenerate -m "Add artifact_materials table"`
    3.  Review the generated Python script in the `versions/` directory to ensure it correctly reflects the intended changes. Add any custom data migrations if needed.
    4.  Apply the migration to the database: `alembic upgrade head`.
    5.  Commit the migration script to Git.

---
