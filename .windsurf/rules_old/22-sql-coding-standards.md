---
trigger: glob
globs: *.sql
---

# SQL CODING STANDARDS

### Guidelines for SQL

### POSTGRES

- Use connection pooling to manage database connections efficiently
- Implement JSONB columns for semi-structured data instead of creating many tables for {{flexible_data}}
- Use materialized views for complex, frequently accessed read-only data

# Windsurf Rules: PostgreSQL Best Practices

## Guiding Principles (Extends Generic SQL)
- **Leverage Data Types:** Utilize PostgreSQL's rich data types (e.g., `JSONB`, `ARRAY`, `UUID`, `INET`, geometric types, range types) where appropriate.
- **Indexing:**
    - Use standard B-tree indexes for most cases.
    - Consider specialized index types: `GIN` (for `JSONB`, `ARRAY`, full-text), `GiST` (geometric, full-text), `BRIN` (for large, physically ordered tables).
    - Use partial indexes (`CREATE INDEX ... WHERE ...`) for subsets of data.
    - Use expression indexes (`CREATE INDEX ... ON ... (lower(column))`) for case-insensitive or function-based lookups.
- **Window Functions:** Use powerful window functions (`OVER (...)`) for complex analytical queries, avoiding self-joins or complex subqueries where possible.
- **Common Table Expressions (CTEs):** Use `WITH` clauses (CTEs) to break down complex queries into logical, readable steps. Use `WITH RECURSIVE` for hierarchical or graph traversal.
- **Transactions:** Understand transaction isolation levels (`READ COMMITTED` default). Use advisory locks (`pg_advisory_lock`) for application-level locking if needed.
- **Stored Procedures/Functions (PL/pgSQL):** Use functions (`CREATE FUNCTION ... LANGUAGE plpgsql`) for encapsulating reusable logic on the database server. Be mindful of performance implications.
- **Partitioning:** Use declarative partitioning for very large tables based on ranges or lists to improve manageability and query performance.
- **JSONB Operations:** Utilize efficient `JSONB` operators (`@>`, `?`, `->`, `->>`) for querying JSON data.
- **EXPLAIN ANALYZE:** Use `EXPLAIN ANALYZE` extensively to understand query plans and identify performance bottlenecks.
- **Vacuuming & Statistics:** Understand the importance of `VACUUM` (especially autovacuum) and `ANALYZE` for maintaining performance and accurate query planning.

## AI Instructions
- **Data Type Suggestions:** Suggest PostgreSQL-specific types like `JSONB`, `UUID`, `ARRAY` when appropriate for the data model.
- **Index Type Recommendations:** Recommend specific index types (`GIN`, `GiST`, `BRIN`, partial, expression) based on the query patterns and data types involved.
- **Window Function Usage:** Generate queries using window functions for ranking, aggregation over partitions, etc.
- **CTE Generation:** Structure complex queries using CTEs (`WITH` clauses).
- **PL/pgSQL Snippets:** Generate basic PL/pgSQL function structures.
- **Partitioning Syntax:** Provide examples of declarative partitioning syntax.
- **JSONB Query Generation:** Generate queries using `JSONB` operators.
- **EXPLAIN Command:** Suggest using `EXPLAIN ANALYZE` to profile generated queries.

# Windsurf Rules: Generic SQL Best Practices

## Guiding Principles
- **Readability & Formatting:**
    - Use consistent casing for keywords (UPPERCASE often preferred: `SELECT`, `FROM`, `WHERE`).
    - Use consistent casing for identifiers (lowercase `snake_case` often preferred: `user_id`, `order_details`).
    - Indent clauses (`FROM`, `WHERE`, `GROUP BY`, `ORDER BY`) for clarity.
    - Use comments (`--` or `/* ... */`) to explain complex logic.
- **Explicit Column Listing:** Avoid `SELECT *`. Explicitly list the columns needed to improve clarity, performance, and resilience to schema changes.
- **Meaningful Aliases:** Use clear and concise aliases for tables (`FROM users u`) and columns (`SELECT count(*) AS total_users`).
- **WHERE Clause Effectiveness:**
    - Place filtering conditions in the `WHERE` clause, not in `JOIN ON` clauses where possible (unless it's outer join logic).
    - Ensure `WHERE` clauses can leverage indexes where appropriate (Sargable queries).
- **JOINs:**
    - Prefer ANSI standard `JOIN` syntax (`INNER JOIN`, `LEFT JOIN`) over older comma-based syntax.
    - Be explicit with `INNER JOIN` vs. `OUTER JOIN` (`LEFT`, `RIGHT`, `FULL`).
- **Data Types:** Use the most appropriate and specific data types for columns (e.g., `INT` vs `VARCHAR` for numbers, `DATE`/`TIMESTAMP` vs `VARCHAR` for dates).
- **Indexing:** Understand and create appropriate indexes (e.g., on foreign keys, columns frequently used in `WHERE`, `JOIN`, `ORDER BY`) to optimize query performance. Avoid over-indexing.
- **Normalization:** Understand database normalization principles (1NF, 2NF, 3NF) and apply them appropriately to avoid data redundancy and anomalies. Denormalize cautiously for performance reasons when necessary.
- **Transaction Management:** Use transactions (`BEGIN`, `COMMIT`, `ROLLBACK`) to ensure atomicity for operations involving multiple DML statements.
- **Avoid Vendor Lock-in (where practical):** Stick to standard SQL functions and syntax where possible if portability is a concern. If using vendor-specific features, be aware of the trade-offs.
- **Security:**
    - Use parameterized queries or prepared statements in application code to prevent SQL injection.
    - Grant least privilege to database users.

## AI Instructions
- **Formatting:** Generate SQL code with consistent keyword casing (UPPERCASE) and identifier casing (lowercase snake_case), and proper indentation.
- **Explicit Columns:** Generate `SELECT` statements listing specific columns instead of `SELECT *`.
- **Aliases:** Add meaningful table and column aliases.
- **Standard JOINs:** Use ANSI `JOIN` syntax.
- **Index Suggestions:** Suggest potential indexes based on `WHERE`, `JOIN`, and `ORDER BY` clauses in generated queries.
- **Parameterized Queries:** When generating application code interacting with SQL, use parameterized queries/prepared statements.
- **Standard Functions:** Prefer standard SQL functions over vendor-specific ones unless explicitly requested or necessary for a specific dialect feature.


# Windsurf Rules: SQL Performance Tuning

## Guiding Principles
- **Analyze Execution Plans:** This is paramount. Use `EXPLAIN` (MySQL, PostgreSQL), `EXPLAIN PLAN` (Oracle), or graphical plans (SQL Server) to understand how the database executes your query. Identify full table scans, inefficient joins, poor index usage, and high costs.
- **Effective Indexing:**
    - **Create Necessary Indexes:** Index columns used in `WHERE` clauses, `JOIN` conditions (`ON`), `ORDER BY`, and `GROUP BY`.
    - **Index Selectivity:** Prefer indexes on columns with high selectivity (many unique values).
    - **Compound Indexes:** Create indexes on multiple columns for queries filtering/sorting on those columns. Order matters – match the order used in the query.
    - **Covering Indexes:** Aim for indexes that include all columns needed by a query (using `INCLUDE` or just by having them in the index key) to avoid table lookups.
    - **Avoid Over-Indexing:** Too many indexes slow down write operations (INSERT/UPDATE/DELETE) and consume storage. Remove unused indexes.
    - **Maintain Indexes:** Ensure index statistics are up-to-date (`ANALYZE`, `UPDATE STATISTICS`). Rebuild/reorganize fragmented indexes periodically.
- **Write Sargable Queries:** Ensure conditions in the `WHERE` clause can effectively use indexes (Search ARGument-able). Avoid:
    - Functions on indexed columns (e.g., `WHERE UPPER(LastName) = 'SMITH'`). Rewrite if possible (e.g., function-based index or alternative logic).
    - Leading wildcards in `LIKE` (e.g., `WHERE Name LIKE '%Smith'`).
    - Type mismatches causing implicit conversions.
- **Optimize JOINs:**
    - Ensure join columns are indexed on *both* tables.
    - Ensure join columns have compatible data types.
    - Choose the appropriate join type (`INNER`, `LEFT`, `RIGHT`).
    - Sometimes rewriting subqueries as JOINs (or vice-versa) can improve performance.
- **Reduce Data Fetched/Processed:**
    - `SELECT` only the columns you need. Avoid `SELECT *`.
    - Filter early: Apply `WHERE` clauses as restrictively as possible.
    - Use `LIMIT`/`TOP`/`ROWNUM` to fetch only the required number of rows.
- **Minimize Query Complexity:** Break down extremely complex queries into simpler steps using temporary tables, CTEs, or procedural logic if necessary. Simpler queries are often easier for the optimizer to handle.
- **Batch Operations:** For bulk inserts/updates/deletes, use batching mechanisms provided by the database or client library instead of row-by-row operations.
- **Connection Pooling:** Use connection pooling in the application to avoid the overhead of establishing new database connections for each query.
- **Understand Locking & Concurrency:** Analyze lock contention issues (blocking) using database-specific tools. Optimize transactions to be short. Use appropriate transaction isolation levels.

## AI Instructions
- **Execution Plan Analysis:** When providing SQL, suggest running the database's `EXPLAIN`/`EXPLAIN PLAN` command and interpreting key parts (scans, joins, index usage).
- **Index Recommendations:** Based on `WHERE`, `JOIN`, `ORDER BY` clauses, suggest specific indexes (simple, compound, covering).
- **Sargability Checks:** Identify non-sargable conditions in `WHERE` clauses and suggest rewrites or function-based indexes.
- **Query Rewriting:** Suggest alternative ways to structure a query (e.g., JOIN vs subquery, CTE usage) for potential performance improvements.
- **Column Selection:** Encourage listing specific columns instead of `SELECT *`.
- **Batching Code:** Generate application code examples demonstrating batch inserts/updates.
- **Locking/Concurrency:** Highlight potential locking issues in complex transactions or long-running queries.
