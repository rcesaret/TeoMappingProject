# Instructional Guide: SQL Best Practices & Style

## 1. Core Philosophy & Guiding Principles

This document provides the definitive set of rules and protocols for all SQL-related work. The AI agent's output MUST adhere to these standards. Our approach is governed by three core principles:

-   **Data Integrity:** The database is the ultimate source of truth. SQL must be written to rigorously protect and enforce the integrity of the data through constraints, transactions, and explicit logic.
-   **Performance:** Queries are the primary interface to the data. They must be written and indexed efficiently to support both analytical workloads and potential application backends.
-   **Readability & Reproducibility:** SQL is code. It must be as readable, maintainable, and version-controlled as any other programming language to ensure results are reproducible and logic is transparent.

## 2. Formatting & Style (The Canonical Style)

A consistent style is mandatory to ensure readability and maintainability.

### 2.1 Casing
-   **KEYWORDS:** All SQL keywords (e.g., `SELECT`, `FROM`, `WHERE`, `JOIN`, `GROUP BY`, `ORDER BY`, `HAVING`, `CASE`, `WHEN`, `END`) MUST be in **ALL CAPS**.
-   **IDENTIFIERS:** All database object identifiers (tables, columns, views, functions, schemas, aliases) MUST use lowercase `snake_case`.
    -   **Good:** `survey_collection_units`, `artifact_count`, `publication_year`
    -   **Bad:** `SurveyCollectionUnits`, `ArtifactCount`

### 2.2 Layout & Indentation
-   **Main Clauses:** Main clauses (`SELECT`, `FROM`, `WHERE`, `GROUP BY`, etc.) MUST start on a new line and be aligned.
-   **Column Layout:** For any `SELECT` statement with more than one column, each column MUST be on its own new line, indented from the `SELECT` keyword.
-   **JOIN Layout:** Each `JOIN` clause MUST be on a new line, with its `ON` condition indented beneath it.
-   **Subqueries & Expressions:** Subqueries and `CASE` statements MUST be indented to reflect the logical structure of the query.

### 2.3 Commas
-   **Trailing Commas:** Trailing commas MUST be used in vertical column lists (e.g., in `SELECT` statements and `CREATE TABLE` definitions). This makes reordering lines and reviewing diffs in version control significantly cleaner.

### 2.4 Quoting & Aliasing
-   **Quoting:** Identifiers MUST NOT be quoted unless they are reserved keywords or contain special characters.
-   **Aliasing:** All tables, views, and CTEs in a query MUST be given a clear and concise alias using `AS`. Column aliases (`AS`) MUST be used for any calculated, aggregated, or transformed fields.

## 3. Documentation & Commenting

### 3.1 File Header
Every `.sql` file MUST begin with a header comment block (`--`) that provides essential metadata.

```sql
-- Name:         rpt_active_project_artifact_summary.sql
-- Author:       R. Cesaretti
-- Date:         2025-06-19
-- Description:  This query calculates the total number of artifacts for active
--               projects started after 1960, filtering for projects with
--               more than 10 artifacts.
-- Depends On:   01_create_core_tables.sql
-- Side Effects: None. Returns a result set to the client.
```

### 3.2 Inline Comments
-   Inline comments (`--`) MUST be used to explain complex business logic, intricate joins, non-obvious `WHERE` clause conditions, or performance-related optimizations.

## 4. Querying Best Practices (DQL)

### 4.1 Column Selection
-   **NO `SELECT *`:** The `SELECT *` syntax is **STRICTLY FORBIDDEN** in production queries. You MUST explicitly list all required columns. This improves clarity, performance (by reducing data transfer), and resilience to schema changes.

### 4.2 Common Table Expressions (CTEs)
-   For any query involving more than one level of nesting or multiple logical steps, you MUST use Common Table Expressions (`WITH ... AS (...)`). CTEs deconstruct logic into readable, named, sequential steps, which is mandatory for maintainability.
-   Use `WITH RECURSIVE` for hierarchical or graph traversal queries.

-   **"Before" (Nested Subqueries - Bad):**
    ```sql
    SELECT avg(daily_count) FROM (SELECT collection_date, count(*) as daily_count FROM artifacts WHERE project_id = 5 GROUP BY collection_date) as daily_counts;
    ```
-   **"After" (CTEs - Good):**
    ```sql
    WITH daily_counts AS (
        SELECT
            collection_date,
            COUNT(*) AS num_artifacts
        FROM
            artifacts
        WHERE
            project_id = 5
        GROUP BY
            collection_date
    )
    SELECT
        AVG(num_artifacts) AS avg_daily_artifact_count
    FROM
        daily_counts;
    ```

### 4.3 JOINs
-   **Explicit Syntax:** You MUST use explicit ANSI `JOIN` syntax (`INNER JOIN`, `LEFT JOIN`, etc.). Implicit, comma-separated joins in the `FROM` clause are strictly forbidden as they are less clear and can easily lead to accidental cross joins.
-   **Logical Use:**
    -   **`INNER JOIN`**: Returns only rows that have a match in both tables. This is the most common join type.
    -   **`LEFT JOIN`** (or `LEFT OUTER JOIN`): Returns all rows from the left table, and the matched rows from the right table. If no match, the columns from the right table will be `NULL`. Essential for finding items in one table that may *not* have a corresponding entry in another.
    -   **`RIGHT JOIN`**: The inverse of a `LEFT JOIN`. It is generally less readable and can almost always be rewritten as a `LEFT JOIN`. **Prefer `LEFT JOIN`**.
    -   **`FULL OUTER JOIN`**: Returns all rows when there is a match in either the left or the right table.

### 4.4 Filtering: `WHERE` vs. `HAVING`
Understand the logical order of SQL operations: `WHERE` filters *before* grouping, and `HAVING` filters *after* grouping.
-   **`WHERE`**: Filters individual rows. Use it to remove rows from consideration as early as possible.
-   **`HAVING`**: Filters entire groups created by `GROUP BY`. Use it exclusively to filter based on an aggregate function (e.g., `COUNT(*) > 10`, `AVG(price) < 50.0`).

### 4.5 Set Operations (`UNION` vs. `UNION ALL`)
-   **`UNION`**: Combines result sets and performs an implicit `DISTINCT` operation to remove duplicate rows. This requires sorting the entire result set and can be very computationally expensive.
-   **`UNION ALL`**: Combines result sets *without* removing duplicates by simply appending them. This is significantly faster.
-   **Guideline:** You MUST use `UNION ALL` by default unless you have a specific, documented reason that you need to remove duplicate rows.

### 4.6 Aggregation
-   When using `GROUP BY`, all non-aggregated columns in the `SELECT` list MUST be explicitly included in the `GROUP BY` clause. Do not rely on dialect-specific shortcuts.

### 4.7 Window Functions
-   For analyses that require calculations over a set of related rows (e.g., rankings, running totals, moving averages), you MUST use window functions (`OVER (...)`). They are vastly more performant and readable than self-joins or complex subqueries for these tasks.

-   **Example: Find the 5 most artifact-heavy collection units in each survey tract.**
    ```sql
    WITH ranked_units AS (
        SELECT
            survey_tract_number,
            collection_unit_id,
            artifact_count,
            ROW_NUMBER() OVER(PARTITION BY survey_tract_number ORDER BY artifact_count DESC) AS rn
        FROM
            unit_summary
    )
    SELECT
        survey_tract_number,
        collection_unit_id,
        artifact_count
    FROM
        ranked_units
    WHERE
        rn <= 5;
    ```

## 5. Schema Design & Data Definition (DDL)

### 5.1 Data Types
Always use the most specific and appropriate PostgreSQL data type to improve data integrity, performance, and storage.

-   **Temporal:** `TIMESTAMPTZ` (`TIMESTAMP WITH TIME ZONE`). This MUST be used for all timestamps. It stores the value in UTC internally, eliminating all timezone ambiguity.
-   **Numeric:** `NUMERIC` for precise values where exactness matters (e.g., financial data, measurements). `INTEGER` or `BIGINT` for whole numbers. `DOUBLE PRECISION` for scientific floating-point data.
-   **Identifiers:** `UUID` is the preferred type for primary keys in all new tables. Use `gen_random_uuid()` as the default value.
-   **Text:** `TEXT` is the default choice for strings of unknown or variable length. `VARCHAR(n)` should only be used if there is a hard, known limit that must be enforced.
-   **Semi-Structured:** `JSONB` MUST be used for storing JSON data. It is stored in a decomposed binary format which is faster to process and can be indexed.
-   **Spatial:** `GEOMETRY` is the standard for spatial data (via PostGIS).
-   **Other PG Types:** Leverage rich types like `ARRAY`, `INET`, and range types where appropriate.

### 5.2 Constraints & Data Integrity
Constraints are the primary mechanism for enforcing data integrity at the database level and are mandatory.

#### 5.2.1 Naming Conventions
All constraints MUST be explicitly named using the format: `tablename_columnnames_constrainttype`.
-   **Examples:** `artifacts_collection_unit_id_fk` (foreign key), `researchers_email_uk` (unique key), `artifacts_artifact_type_check` (check constraint).

#### 5.2.2 DDL Example
```sql
CREATE TABLE artifacts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    collection_unit_id BIGINT NOT NULL,
    artifact_type TEXT NOT NULL,
    material TEXT,
    properties JSONB,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT artifacts_collection_unit_id_fk
        FOREIGN KEY (collection_unit_id)
        REFERENCES survey_collection_units(id)
        ON DELETE CASCADE,

    CONSTRAINT artifacts_artifact_type_check
        CHECK (artifact_type IN ('sherd', 'lithic', 'figurine'))
);
```

### 5.3 PostgreSQL Domains
For enforcing integrity on common data patterns, you SHOULD use a `DOMAIN`. A domain is a custom data type with built-in `CHECK` constraints, ensuring consistent validation across the database.

-   **Example: Email Domain**
    ```sql
    CREATE DOMAIN public.email_address AS TEXT
    CHECK (
        VALUE ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$'
    );

    CREATE TABLE researchers (
        id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
        researcher_email email_address NOT NULL,
        CONSTRAINT researchers_email_uk UNIQUE (researcher_email)
    );
    ```

### 5.4 Normalization & Partitioning
-   **Normalization:** Apply database normalization principles (1NF, 2NF, 3NF) to avoid data redundancy. Denormalize cautiously and deliberately only for proven performance reasons.
-   **Partitioning:** For very large tables (VLDBs), use PostgreSQL's declarative partitioning (by `RANGE` or `LIST`) to improve query performance and table manageability.

## 6. Data Manipulation & Transactions (DML)

### 6.1 Transaction Control
-   Any script that performs one or more data modification statements (`INSERT`, `UPDATE`, `DELETE`) on persistent tables MUST be wrapped in a transaction block (`BEGIN; ... COMMIT;`) to ensure atomicity.
-   Explicit `ROLLBACK;` logic MUST be included to handle potential errors within a transaction.

### 6.2 Savepoints for Complex Operations
-   For complex ingestion scripts that process records in a loop, use `SAVEPOINT`s to handle errors for individual records without failing the entire transaction.
    ```sql
    BEGIN;
    -- ...
    LOOP
        SAVEPOINT before_record_insert;
        BEGIN
            INSERT INTO ... ;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK TO SAVEPOINT before_record_insert;
                -- Log the error and continue to the next record
        END;
    END LOOP;
    -- ...
    COMMIT;
    ```

### 6.3 DML Best Practices
-   **Explicit `INSERT`:** All `INSERT` statements MUST include an explicit column list. This makes scripts robust against future schema changes.
-   **Batch Operations:** For bulk `INSERT`/`UPDATE`/`DELETE` operations, use batching mechanisms like the `COPY` command or client library features instead of row-by-row operations.

## 7. Performance Tuning & Analysis

### 7.1 Execution Plan Analysis
-   **`EXPLAIN ANALYZE`:** This is the paramount tool for understanding query performance. You MUST use `EXPLAIN (ANALYZE, BUFFERS) ...` to profile queries and identify bottlenecks.
-   **Key Indicators to Check:**
    -   `Seq Scan` (Sequential Scan): A major warning sign on a large table. It means the database is reading the entire table from disk and indicates a missing or unusable index.
    -   `Index Scan` or `Bitmap Heap Scan`: Good. An index is being used.
    -   `actual time`: The real execution time in milliseconds. This is the most important measure.
    -   `rows` vs `actual rows`: A large discrepancy between the planner's estimate (`rows=...`) and reality (`actual rows=...`) suggests stale statistics.

### 7.2 The Importance of Statistics (`ANALYZE`)
-   The PostgreSQL query planner relies on statistical metadata about data distribution. After large data loads, updates, or deletes, this metadata can become stale, causing the planner to choose inefficient query plans.
-   **Mandate:** After any significant data modification in a script or ETL process, you MUST run `ANALYZE tablename;` or `VACUUM ANALYZE tablename;` on the affected tables to update the planner's statistics.

### 7.3 Writing Sargable Queries
-   A query is "Sargable" (Search ARGument-able) if the database engine can use an index to satisfy a `WHERE` clause. Non-sargable conditions force a `Seq Scan`. You MUST write sargable queries.
-   **Bad (Non-sargable):** `WHERE EXTRACT(YEAR FROM created_at) = 2024;` (Function is applied to the column).
-   **Good (Sargable):** `WHERE created_at >= '2024-01-01' AND created_at < '2025-01-01';` (The column is bare, allowing an index on `created_at` to be used).

### 7.4 Indexing Strategy
Proper indexing is the most important factor in query performance.

#### 7.4.1 General Principles
-   A B-Tree index MUST be created on every **foreign key column**.
-   Index columns frequently used in `WHERE` clauses, `JOIN` conditions (`ON`), `ORDER BY`, and `GROUP BY`.

#### 7.4.2 Index Types
-   **B-Tree:** The default index, suitable for most equality and range queries.
-   **GIN (Generalized Inverted Index):** Use for indexing composite types where elements need to be looked up (e.g., `JSONB`, `ARRAY`, full-text search).
-   **GiST (Generalized Search Tree):** Use for geometric data types (`geometry`) and full-text search.
-   **BRIN (Block Range Index):** Use for very large, physically ordered tables (e.g., by a timestamp column). Can be much smaller and faster than B-Tree for this use case.

#### 7.4.3 Advanced Indexing
-   **Compound Indexes:** Create multi-column indexes. The order of columns in the index definition MUST match the order in the query's `WHERE`/`ORDER BY` clause for maximum effectiveness.
-   **Covering Indexes:** An index that includes all columns required by a query (using the `INCLUDE` clause), allowing the database to answer the query from the index alone.
-   **Partial Indexes:** Index a subset of a table's rows (`CREATE INDEX ... WHERE ...`). Useful for very large tables where queries target a specific, small status (e.g., `WHERE is_active = TRUE`).
-   **Expression Indexes:** Index the result of a function or expression (`CREATE INDEX ... ON ... (lower(column))`). Essential for making function-based `WHERE` clauses sargable.

#### 7.4.4 Index Management
-   **Avoid Over-Indexing:** Too many indexes slow down write operations (`INSERT`, `UPDATE`, `DELETE`) and consume storage. Remove unused indexes.
-   **Maintain Statistics:** Understand the importance of `VACUUM` (especially autovacuum) and `ANALYZE` for keeping table statistics up-to-date.

## 8. PostgreSQL-Specific Protocols

-   **JSONB Operations:** Utilize efficient `JSONB` operators (`@>`, `?`, `->`, `->>`) for querying JSON data, and create `GIN` indexes on `JSONB` columns for performance.
-   **Geospatial (PostGIS):** Use PostGIS spatial functions (e.g., `ST_Transform`, `ST_Area`, `ST_DWithin`). Always validate geometries using `ST_IsValid` after loading or transformations.
-   **Materialized Views:** Use materialized views for complex, frequently accessed, read-only data to pre-compute and store results.
-   **PL/pgSQL:** Use functions (`CREATE FUNCTION ... LANGUAGE plpgsql`) to encapsulate reusable logic on the database server, but be mindful of performance implications.
-   **Data Loading:** For bulk data loading, prefer PostgreSQL's `COPY` command. For spatial data, use `ogr2ogr` or `raster2pgsql`.

## 9. Security & Application Interaction

-   **Parameterized Queries:** When generating application code (e.g., Python, Go) that interacts with the database, you MUST use parameterized queries or prepared statements to prevent SQL injection vulnerabilities.
-   **Principle of Least Privilege:** Database users should be granted the minimum set of privileges necessary to perform their function.
-   **Connection Management:** Use connection pooling in the application layer to avoid the overhead of establishing new database connections for each query.
-   **Destructive Operations:** Always require explicit user confirmation before generating or executing destructive operations (e.g., `DROP TABLE`, `TRUNCATE`, `DELETE` without a `WHERE` clause).

## 10. AI Agent Directives & Workflow

### 10.1 Summary Checklist
1.  **Formatting:**
    -   **Keywords:** ALL CAPS.
    -   **Identifiers:** `snake_case`.
    -   **Layout:** Indent logically, place columns and clauses on new lines, use trailing commas.
2.  **Query Generation:**
    -   **Columns:** List all columns explicitly. **NEVER use `SELECT *`**.
    -   **Structure:** Use `WITH` clauses (CTEs) for any non-trivial query.
    -   **JOINs:** Use explicit ANSI `JOIN` syntax only.
    -   **Analysis:** Use window functions for ranking, partitioning, and running totals.
3.  **PostgreSQL Specifics:**
    -   **Target:** Write ANSI SQL compatible with PostgreSQL 17.
    -   **Data Types:** Proactively suggest `UUID`, `JSONB`, `TIMESTAMPTZ`, `NUMERIC`, and `GEOMETRY` where appropriate.
    -   **Indexing:** Recommend specific index types (`B-Tree`, `GIN`, `GiST`, `BRIN`, partial, expression) based on data types and query patterns.
    -   **JSONB:** Generate queries using efficient `JSONB` operators.
4.  **Performance & Optimization:**
    -   **Analysis:** Always suggest running `EXPLAIN ANALYZE` on generated queries and offer to help interpret the results.
    -   **Sargability:** Identify and flag non-sargable conditions in `WHERE` clauses, suggesting rewrites or expression indexes.
5.  **Data Integrity & Security:**
    -   **DML:** Wrap all data modification scripts in a `BEGIN...COMMIT` block with error handling.
    -   **`INSERT`:** Always generate `INSERT` statements with an explicit column list.
    -   **Application Code:** When generating code snippets, use parameterized queries to prevent SQL injection.

### 10.2 AI Agent Workflow
The agent MUST follow this sequence when generating SQL:
1.  **Formatting:** First, ensure the entire SQL query adheres to the canonical formatting and style rules.
2.  **Query Generation:** Next, generate the SQL code, applying all best practices for DQL, DDL, and DML.
3.  **PostgreSQL Specifics:** Then, ensure the query adheres to all PostgreSQL-specific standards (data types, operators, etc.).
4.  **Performance & Optimization:** Finally, analyze the query for performance bottlenecks (sargability, indexing) and suggest improvements.

---
