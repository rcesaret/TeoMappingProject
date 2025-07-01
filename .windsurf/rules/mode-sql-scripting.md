---
trigger: manual
---

# SQL SCRIPTING

- You MUST ALWAYS review and implement the guidelines & protocols from `.windsurf/instructions/guide-sql-best-practices.md`, which is the PRIMARY SOURCE OF TRUTH for all SQL coding tasks.

## SYNTAX & FORMATTING
- All SQL keywords (e.g., `SELECT`, `FROM`, `WHERE`, `JOIN`, `GROUP BY`, `ORDER BY`, `HAVING`, `CASE`, `WHEN`, `END`) MUST be in ALL CAPS.
- All identifiers (table names, column names, view names, function names, aliases, schemas) MUST use `snake_case`.
- Code blocks MUST be indented consistently to reflect logical structure. `JOIN` clauses, subqueries, and `CASE` statements must be indented.
- For any `SELECT` statement with more than two columns, each column MUST be on a new line. The `FROM` clause and subsequent clauses must also start on new lines.
- Use trailing commas in column lists for easier reordering and cleaner diffs.
- Only quote identifiers if they are reserved keywords or contain special characters. Do not quote standard identifiers.

## QUERY STRUCTURE & BEST PRACTICES
- You MUST use explicit `JOIN` syntax (`INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `FULL OUTER JOIN`). Implicit, comma-separated joins in the `FROM` clause are strictly forbidden. The `ON` condition for a join must immediately follow the `JOIN` statement.
- For any query involving more than one level of sub-querying or aggregation, you MUST use Common Table Expressions (`WITH ... AS (...)`) to deconstruct the logic into readable, named steps. This is mandatory for maintainability.
- All tables, views, and CTEs in a query MUST be given a clear and concise alias. Column aliases should be used for any calculated or transformed fields.
- All non-aggregated columns in a `SELECT` statement MUST be included in the `GROUP BY` clause. Do not rely on dialect-specific shortcuts.
- Use the `WHERE` clause to filter rows *before* aggregation. Use the `HAVING` clause to filter groups *after* aggregation.

## DATA INTEGRITY & TRANSACTIONS
- Any script that performs data modification (`INSERT`, `UPDATE`, `DELETE`) on persistent tables MUST be wrapped in a transaction block (`BEGIN; ... COMMIT;`).
- You MUST include explicit `ROLLBACK;` logic to handle potential errors within a transaction block, if the dialect supports it (as PostgreSQL does).
- All `INSERT` statements MUST use an explicit column list. Do not rely on the table's default column order.
- Use the most appropriate and specific data types for columns (e.g., `TIMESTAMP WITH TIME ZONE` instead of `VARCHAR` for timestamps, `NUMERIC` for financial data, `UUID` for unique identifiers).

## SPATIAL DATA HANDLING
- All tables with a `geometry` or `geography` column MUST have a GiST (Generalized Search Tree) index created on that column. You must propose the `CREATE INDEX idx_tablename_geom ON tablename USING GIST (geom_column);` command immediately after any `CREATE TABLE` statement involving a geometry column.
- When performing spatial queries (e.g., intersection, distance), you MUST structure the `WHERE` clause to use an indexed operator first to filter the candidate set before applying a more computationally expensive function.
- Correct Pattern: `WHERE a.geom && b.geom AND ST_Intersects(a.geom, b.geom)`
- Incorrect Pattern: `WHERE ST_Intersects(a.geom, b.geom)`
- Use the `geometry` type for projected data (e.g., UTM) where planar calculations are appropriate. Use the `geography` type for unprojected, global data (lon/lat) when great-circle distance or area calculations are required.
- For CRS transformations within the database, you MUST use the `ST_Transform(geometry, srid)` function. The target SRID must be a valid entry in the `spatial_ref_sys` table.

## PERFORMANCE OPTIMIZATION
- All foreign key columns MUST have a B-Tree index created on them to optimize join performance. Propose the `CREATE INDEX` statement after the `CREATE TABLE` DDL.
- All constraints (PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK) MUST be explicitly named using the convention `tablename_columnname_constrainttype` (e.g., `survey_collections_project_id_fk`).
- For any complex `SELECT` query intended for a performance-critical path, you must also generate the `EXPLAIN ANALYZE` version of the query to allow for query plan inspection.
- For tasks requiring ranking or sequential analysis (e.g., finding the latest entry per group), you MUST prefer using window functions (`ROW_NUMBER()`, `RANK()`, `LEAD()`, `LAG()`) over self-joins for clarity and performance.

## DOCUMENTATION
- Every `.sql` file MUST begin with a header comment block (`--`) that explains:
  - The script's overall purpose and objective.
  - Any required inputs (e.g., temporary tables, specific data states).
  - The outputs or side effects (e.g., tables created/modified, data returned).
  - The author and date of last modification.
- Add inline comments (`--`) to explain complex business logic, intricate joins, non-obvious `WHERE` clause conditions, or performance-related optimizations.

## PROJECT DATA CONSIDERATIONS
- When working with TMP collection unit data, always validate SSN (collection unit ID) ranges and cross-reference with documented collection procedures.
- For queries involving temporal analysis of archaeological phases, ensure proper handling of uncertain or missing date ranges.
- When aggregating artifact counts, implement checks for the known "Total Counts Problem" in legacy TMP data and document any data quality issues discovered.
- For spatial queries involving archaeological features, consider the uncertainty and precision of digitized boundaries when interpreting results.

## DATA VALIDATION & QUALITY ASSURANCE
- All data type casts must be explicit using the `::datatype` or `CAST(column AS datatype)` syntax. Avoid implicit type casting.
- Include data validation checks in scripts that modify large datasets, such as row count verification before and after operations.
- For scripts that create materialized views, include refresh procedures and document the appropriate refresh schedule.
- When creating views for public access, ensure they include appropriate column aliases and documentation for end users.
