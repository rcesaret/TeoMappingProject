# Debugging & Error Resolution Guidelines & Protocol

## 1. Overall Goal & Philosophy

The primary objective is to systematically diagnose the root cause of a specific failure, leverage all available project context, propose and implement a correct fix consistent with project standards, rigorously verify its effectiveness, and meticulously document the entire process for future reference and learning.

The core philosophy is to **understand before acting and verify before committing**.

---

## 2. The Core Debugging Workflow

This protocol MUST be followed systematically when an error occurs or a debugging task is initiated.

### Phase 1: Diagnose — Gather Context & Reproduce the Failure

The first step is to collect all necessary information to understand the problem in its full context.

1.  **Ingest Primary Failure Data:**
    *   Collect the complete and unabridged error message and stack traceback.
    *   Collect all available logs, user symptoms, and the exact steps to reproduce the failure. If steps are not provided, request them.

2.  **Analyze Source Code & Intended Behavior:**
    *   Ingest the full source code of the file(s) where the error occurred, paying close attention to the lines indicated in the traceback.
    *   Collect information on the user's symptoms and the exact steps to reproduce the failure. If steps are not provided, request them.

3.  **Mandatory Project Memory Consultation:**
    *   To understand the "why" behind the code, you must consult the following memory files:
        *   `TASKS.md`: What was the original goal of the failing task or plan step? Compare the intent with the actual outcome described by the error.
        *   **Relevant Plan File**: What were the most recent changes? What was being attempted immediately before the failure?
        *   `architecture.md` & Phase-Level `README.md`: How does the failing component fit into the overall system architecture?
        *   `technical_specs.md` & `PLANNING.md`: Does the failing code adhere to project-specific standards, patterns, and conventions? Are there known data issues at play?
        *   `error-documentation.md` & `lessons-learned.md`: Has this or a similar issue been encountered and solved before?

4.  **Reliably Reproduce the Failure:**
    *   Using the gathered context, find a reliable way to reproduce the bug consistently. This is essential for verification later.
    *   For highly complex or deeply embedded bugs, you must first attempt to create a **minimal, self-contained, reproducible example (MRE)** of the bug. This isolates the problem from the wider application.

5.  **Determine Project Context and Consult Diagnostic Matrix:**
    *   **Identify the current project phase (1-8)** based on the task and file context. State the identified phase clearly in your analysis (e.g., "This error is occurring within Phase 2: Database Transformation").
    *   Consult the **Phase-Aware Diagnostic Matrix** (see Appendix A) to understand common errors for this phase and to select the most probable diagnostic path.
    *   Consult the **Legacy Data Constraints** (`technical_specs.md`, Section 9) to check if the error might be caused by a known data quality issue (e.g., "The Total Counts Problem," unresolved REANS collections).

### Phase 2: Analyze — Isolate the Cause & Formulate Hypotheses

With all context gathered, perform a deep analysis to move from symptom to root cause.

1.  **Perform Detailed Error Analysis:**
    *   Analyze the traceback to identify the exact line, operation, and variable states that led to the failure.
    *   Conduct a focused dependency and control-flow analysis around the failure point, interpreting the findings **in the context of `architecture.md` and `technical.md`**.

2.  **Formulate & Refine Hypotheses:**
    *   Based on the evidence, formulate 3-5 distinct hypotheses for the root cause. Consider the following categories:
        *   **Logic Error:** A flaw in the algorithm, conditional flow, or an incorrect assumption within the code.
        *   **Data State Issue:** A variable holds incorrect, unexpected, `None`, or malformed data.
        *   **Interaction/Dependency Issue:** An interaction with another component, library, or external resource did not behave as assumed.
        *   **Architectural Mismatch:** The code violates constraints or patterns defined in `architecture.md`.
        *   **Environment Issue:** A problem with a library version, configuration, or other external factor.
    *   Rigorously reason through the evidence (logs, code, test results, memory context) to discard less likely hypotheses. Distill your analysis down to the 1-2 most probable root causes.

### Phase 3: Verify — Validate the Hypothesis Before Fixing

**You MUST NOT propose a code fix immediately.** The primary goal of this phase is to prove the root cause hypothesis with a targeted diagnostic action.

*   Propose **one** specific, minimal action from the following options to confirm your primary hypothesis:
    *   **Hypothesis-Driven Logging:** Propose a specific, diagnostic print statement that tests a hypothesis. For example: `print(f'Is geometry valid? {geom.is_valid}')`, `print(f'Are CRS equal? {gdf1.crs == gdf2.crs}')`, or `print(f'Is column "ssn" a unique key? {df["ssn"].is_unique}')`.
    *   **Strategic Data Inspection:** For data transformation errors, propose writing the problematic variable (e.g., a DataFrame or GeoDataFrame) to a temporary file (`df.to_csv('debug.csv')`, `gdf.to_file('debug.geojson')`) for external inspection.
    *   **Interactive Debugging:** Propose inserting a `breakpoint()` call immediately before the failing line. Instruct the user on which specific variables or expressions to inspect once inside the Python Debugger (`pdb`) to confirm the problem state.
    *   **Isolation via a Failing Test:** Propose writing a new, minimal unit test that specifically and reliably reproduces the bug with the simplest possible input.

### Phase 4: Implement — Plan and Execute the Fix

Once the root cause is confirmed, proceed with implementing a solution.

1.  **Plan the Fix & Validate the Plan:**
    *   Outline the minimal, targeted code change necessary to correct the issue.
    *   Provide a concise explanation of *why* the proposed fix resolves the identified root cause.
    *   Validate that the proposed fix is fully consistent with the project's `architecture.md` and `technical.md`.

2.  **Flag Documentation Issues:**
    *   If your analysis suggests a flaw, ambiguity, or gap in the project-level or phase-level architecture specified in the phase-level `README.md`, `architecture.md`, `technical_specs.md`, or other documentation, you **MUST explicitly note this** as a separate issue needing attention.

3.  **Implement the Fix:**
    *   Apply the validated fix, adhering strictly to all project standards.

### Phase 5: Verify — Confirm the Fix and Check for Regressions

A bug is not fixed until it is proven to be fixed and has not introduced new problems. Run a tiered series of tests:

1.  **Confirm the Fix:** Run the specific test that was previously failing (either the one from Phase 3 or the test that originally caught the bug). Verify that it now passes.
2.  **Check for Local Regressions:** Run all other directly related tests to ensure the fix has not broken adjacent functionality.
3.  **Check for Broad Regressions:** Run the complete test suite, if applicable, to check for wider, unexpected side effects.
4.  **Add a Regression Test:** If not already created in Phase 3, add a new test that specifically covers the bug that was fixed. This test MUST be kept in the test suite.

### Phase 6: Report, Document, and Learn

This step is mandatory upon concluding a debugging session, whether successful or not.

1.  **Report Final Status:**
    *   Clearly state whether the issue was diagnosed, fixed, and verified.
    *   If successful, provide the corrected code and any new tests.
    *   If debugging failed, report all findings, the last known state, and the reason for being stuck, as per Phase 7.

2.  **Propose Specific Memory Updates:**
    *   **`error-documentation.md` (Mandatory):** Create a new, detailed entry. Document the symptoms, the project phase where it occurred (if applicable), the verified root cause, and the final solution implemented.
    *   `TASKS.md` / Relevant Plan Mode Plan: Propose an update to the status of the affected task to reflect the resolution.
    *   `lessons-learned.md`: If the fix or analysis revealed a broader pattern, anti-pattern, or important architectural learning, propose adding it here.
    *   `architecture.md` / `technical_specs.md` / Phase-Level `README.md`: If the root cause was traced to a flaw in these documents, explicitly flag them as needing updates.

### Phase 7: Handling Persistent Failures (Getting Stuck)

If you are unable to resolve the issue after reasonable, structured attempts, do not loop indefinitely.

1.  **State the Difficulty:** Explicitly report that debugging has failed.
2.  **Summarize Efforts:** Detail the diagnostic approaches you tried, the hypotheses you tested, and why they failed, referencing your analysis against the project memory context.
3.  **Suggest New Avenues:** Propose trying a different diagnostic approach (e.g., if logging failed, suggest a debugger or creating a minimal reproducible example).
4.  **Request Assistance:** Request human assistance or suggest stepping back to re-evaluate the problem from a higher level.

---

## Appendices: Project-Specific & Advanced Protocols

### Appendix A: Phase-Aware Diagnostic Matrix

| Phase | Common Error Types | Primary Diagnostic Questions for AI | Recommended First Action |
| :--- | :--- | :--- | :--- |
| **P1: DB Analysis** | SQL syntax errors, `psycopg2` connection failures, incorrect performance metrics. | Is the raw SQL query valid for PostgreSQL 17? Are the database credentials in `config.ini` correct? Is the Pandas `read_sql` call structured correctly? | Propose executing the failing SQL query directly in a DB client (e.g., via `postgres-mcp`) to isolate it from the Python code. |
| **P2: DB Transformation** | `KeyError` on DataFrame, `TypeError` from data type mismatch, silent data corruption (e.g., from joins), constraint violations. | Does the input DataFrame have the expected columns/dtypes? Is this error due to a known legacy issue (e.g., "Total Counts Problem")? Which specific row is failing? | Propose `print(df.info())` and `df.head()` on the DataFrame just before the failing line. If possible, isolate and print the single row causing the exception. |
| **P3: GIS Digitization** | N/A (Manual Process) | N/A | N/A |
| **P4: Georeferencing**| `CRSError` from `pyproj`, GDAL exceptions, mathematical errors (`NaN`/`inf`) from `RBFInterpolator`. | Are the source and target CRS correctly defined in the code? Do the Ground Control Points (GCPs) have a correct spatial distribution? Are there `None` or non-numeric values being passed to the interpolation? | Propose visualizing the Ground Control Points (GCPs) and their error vectors. Inspect the data types (`.dtype`) and for nulls in NumPy arrays passed to Scipy. |
| **P5: Geospatial Integration** | Geometry errors (`TopologicalError`), failed spatial joins (`Empty GeoDataFrame`), incorrect attribute assignment. | Are the geometries in all joining layers valid? Do they all share the exact same CRS? Do the attribute join keys (`ssn`) exist and match in both datasets? | Propose running `.is_valid.all()` on the GeoDataFrames. Verify `.crs` attribute on all inputs. Perform an attribute join first to see how many keys match before the spatial join. |
| **P6: tDAR Outputs** | File I/O errors (`PermissionDenied`), `ogr2ogr` failures, attribute name errors from 10-char limit truncation logic. | Does the target directory exist and have write permissions? Is the field name truncation logic generating duplicate names? Are all required sidecar files (e.g., `.prj`) being created for Shapefiles? | Propose printing the full `ogr2ogr` command string before execution to check paths and parameters. Inspect the column names of the DataFrame before it's written to file. |
| **P7: PostGIS Deployment** | Docker build/run failures, `pg_restore` errors, data import failures from constraint violations (`NOT NULL`, `UNIQUE`). | Is the Dockerfile pointing to the correct files? Is there a port conflict on the host? Does the data row being imported violate a table constraint (e.g., a null `ssn`)? | Propose inspecting the Docker container logs. For import errors, check the specific row of data against the table's `CREATE TABLE` statement to find the constraint violation. |
| **P8: API / Dashboards**| Pydantic validation errors (`422 Unprocessable Entity`), 500 server errors, incorrect GeoJSON serialization. | Does the API request body match the FastAPI Pydantic model exactly? Is the database query behind the endpoint returning results as expected? Can the geometries be properly serialized? | Propose logging the incoming request body and the results from the database query just before the response is serialized and returned by the endpoint function. |

### Appendix B: Specialized Debugging Playbooks

#### Geospatial Data (GeoPandas, Shapely, PostGIS) Playbook

1.  **Validate Geometry:** This is the first suspect for many `geopandas` errors. Immediately propose a check using `.is_valid.all()` on the input GeoDataFrames. If false, propose finding the invalid shapes with `gdf[~gdf.geometry.is_valid]`. For PostGIS, use an `ST_IsValid` query. Invalid geometries can result from legacy data or complex transformations.
2.  **Verify Coordinate Reference System (CRS):** Spatial operations require identical CRSs. Propose checking the `.crs` attribute on all GeoDataFrames involved (e.g., `print(f"GDF1 CRS: {gdf1.crs}")`, `print(f"GDF2 CRS: {gdf2.crs}")`). If they differ, the fix is to use `.to_crs()`.
3.  **Visualize the Problem:** When an output is unexpected (e.g., an empty spatial join), numbers and logs are often insufficient. Propose generating a simple plot (`.plot()`) or, more powerfully, saving the intermediate GeoDataFrames to temporary files (`gdf1.to_file("debug_input1.geojson", driver="GeoJSON")`). This allows the user to visually inspect the inputs in QGIS to immediately spot issues like non-overlapping features.
4.  **Check for Emptiness or `None`:** Check for empty geometries (`.is_empty`) or geometries that are `None`, as these can cause failures in operations like `unary_union` or buffer calculations.

#### Database & ETL (SQLAlchemy, Pandas) Playbook

1.  **Inspect DataFrame Structure and Types (`.info()`):** The most common ETL error is an unexpected schema or data type. The first action for a DataFrame-related error should be to propose a `df.info()` call on the input DataFrame. Look for columns with the wrong `dtype` (e.g., a number column being parsed as `object`) and unexpected null counts.
2.  **Isolate the Failing Row/Data Point:** When a transformation fails on a large dataset, a generic traceback is not enough. Propose a `try-except` block inside a loop or `.apply()` function to catch the exception and print the specific data from the row that caused the failure.
3.  **Turn on SQLAlchemy Echo:** If the problem seems to be in the interaction with the database (e.g., an unexpected query result), propose modifying the SQLAlchemy engine creation to `create_engine(..., echo=True)`. This will print the *exact* SQL statement being sent to PostgreSQL, which is invaluable for debugging ORM-generated queries.
4.  **Check for Silent Join Failures:** After a `pd.merge()` or `gdf.sjoin()`, propose an immediate check to see if the join worked as expected. Print the length of the DataFrame before and after, and check for a high number of nulls in the newly joined columns, which indicates that many keys failed to match.

#### API (FastAPI) Playbook

1.  **Check Pydantic Models:** Most `422 Unprocessable Entity` errors are due to a mismatch between the incoming JSON and the endpoint's Pydantic model. Propose adding a logging statement to the endpoint to print the raw request body and compare it, field by field, to the Pydantic class definition in the code.
2.  **Test Database Logic Separately:** An API endpoint's logic should be thin. If an error occurs, propose to isolate the core logic (especially database queries and data transformations) into a separate simple script. Run this script directly to determine if the error lies in the data layer or the API serialization/request-handling layer.
3.  **Inspect Object Before Serialization:** Just before the `return` statement in the endpoint, especially when returning a custom GeoJSON response, propose inserting a `print()` or `breakpoint()` to inspect the Python dictionary or object being returned. This helps catch issues (like non-serializable data types) before FastAPI tries to convert it to JSON.

### Appendix C: General & Advanced Protocols

*   **Logical Error Debugging:** For errors where the code runs but the output is incorrect, propose adding assertions (`assert`) at intermediate steps of the function. This helps pinpoint exactly where the data state first diverges from expectations.
*   **Performance Debugging:** For performance issues, you MUST use Python's built-in `cProfile` module. Propose generating a script to run the slow function under the profiler and output the statistics sorted by cumulative time (`tottime`).
*   **Minimal Reproducible Examples:** For complex bugs, you must first attempt to create a minimal, self-contained, reproducible example of the bug. This isolates the problem from the rest of the application and is a critical debugging step.
*   **Git Bisect Recommendation:** When a bug was introduced recently and the exact commit is unknown, recommend that the user employ `git bisect` to efficiently locate the commit that introduced the regression.
*   **"Rubber Duck" Debugging:** As a final diagnostic step for subtle bugs, propose explaining the logic of the failing code block back to the user, line-by-line, in plain English. This articulation can often reveal a flawed assumption.
*   **Visualization for Spatial Errors:** For spatial data processing errors, lean heavily on proposing visualization techniques to inspect intermediate results. A visual inspection in QGIS can often identify where spatial relationships break down more effectively than code-based checks.

---
