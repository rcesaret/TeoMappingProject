# Instructional Guide: Geospatial Data & Processing Protocols

## 1. Introduction & Core Philosophy

### 1.1. Purpose

This document is the definitive technical manual for all geospatial data operations within the Digital Teotihuacan Mapping Project (TMP). It provides the detailed protocols, algorithms, code examples, and scientific rationale that give substance to the concise rules found in `mode-geospatial-scripting.md` and `mode-georeferencing.md`.  It is the primary reference for any task involving spatial data.

### 1.2. Core Principles

The following principles are the foundation of all geospatial work and MUST be adhered to without exception.

-   **CRS Integrity is Non-Negotiable:** A geospatial dataset without a correctly defined and appropriate Coordinate Reference System (CRS) is not data; it is a drawing. All subsequent spatial operations depend on a correct CRS definition. This is the most critical principle in this guide. An undefined or incorrect CRS is a critical error.
-   **Scripted, Reproducible Operations:** All transformations, analyses, and data manipulations MUST be performed via version-controlled scripts (primarily Python or SQL). Manual, "point-and-click" modifications in GIS software are strictly forbidden for creating any official project data product. This ensures full reproducibility and clear data provenance.
-   **Validate at Every Stage:** Geospatial data is complex and prone to subtle errors. You must script validation checks for geometries, attributes, and spatial relationships at each major step of a processing pipeline to prevent the propagation of errors.

## 2. The Project's Foundational Challenge: From "Millon Space" to a Geodetic World

The central geospatial challenge of the TMP is the transformation of legacy data from a local, arbitrary, non-georeferenced Cartesian grid known as "Millon Space" into a modern, standard, projected CRS.

-   **Defining "Millon Space":** This is a custom engineering coordinate system developed in the 1960s. It is oriented approximately 16° off true north and contains significant local and systematic distortions due to historical mapping methods. It lacks any inherent geodetic datum and must be handled as a custom CRS.
-   **The Official Transformation Pathway:** A direct, single-step transformation is insufficient. The official project methodology involves a multi-stage process:
    1.  A high-accuracy transformation from the "Millon Space" Engineering CRS to the verified historical CRS (**EPSG:26714 - NAD27 / UTM Zone 14N**). This step uses a custom NTv2 grid shift file.
    2.  A second standard transformation from the historical CRS to the final modern project CRS (**EPSG:6362 - ITRF2008 / UTM Zone 14N**).

## 3. Environment, Libraries, and Tooling

### 3.1. Python Geospatial Stack

The following libraries are sanctioned for use in Python scripts.

-   **Primary Libraries:**
    -   `geopandas`: For all high-level vector data manipulation.
    -   `rasterio`: For all raster data I/O and processing.
    -   `pyproj`: For all programmatic CRS definitions and transformations.
    -   `shapely`: For low-level geometry operations.
    -   `fiona`: As a dependency for `geopandas` for file I/O.
-   **Secondary & Specialized Libraries:**
    -   `rioxarray`: For advanced raster processing and analysis.
    -   `rasterstats`: For zonal statistics calculations.
    -   `whitebox`: For advanced geomorphological analysis.

### 3.2. Command-Line Tools (GDAL/OGR)

The GDAL/OGR command-line utilities are the standard for batch processing and format conversion.

-   `gdal_warp` & `gdal_translate`: For all raster georeferencing, reprojection, and format conversion.
-   `ogr2ogr`: For all vector format conversion and reprojection.
-   **Execution Environment:** Use **Desktop Commander** for executing GDAL/OGR commands on rasters and vectors.

### 3.3. Desktop GIS Software

-   **Primary Desktop GIS:** QGIS 3.40.5 is the standard for manual inspection, visualization, and digitization tasks.
-   **Georeferencing:** For georeferencing tasks, use the QGIS Georeferencer for GCP placement, but the final transformation MUST be scripted using GDAL tools as specified in Section 7.

## 4. Coordinate Reference System (CRS) & Transformation Management

### 4.1. The Project CRS Catalogue

The file `docs/CRS_Catalogue.csv` is the project's single source of truth for all sanctioned CRSs. All scripts MUST reference this catalogue to ensure consistency. It contains the full definitions (e.g., WKT or PROJ strings) for all required CRSs.

### 4.2. Standard Project CRSs

-   **Analysis CRS:** **EPSG:32614** (WGS 84 / UTM Zone 14N). This projected CRS MUST be used for all analytical work involving distance or area calculations.
-   **Web/Dissemination CRS:** **EPSG:4326** (WGS 84). This geographic CRS is for public-facing web maps and final data dissemination.
-   **Custom Legacy CRS:** "Millon Space" (definition sourced from the catalogue).

### 4.3. The NTv2 Grid Shift Approach

For the high-accuracy transformation from "Millon Space" to NAD27, this project will use the **NTv2 grid shift method**. This was chosen because it creates a reusable grid file (`.gsb`) that accurately models the complex, non-linear, local distortions present in the original hand-drawn maps, which simple polynomial transformations cannot fully capture. Scripts using `gdal` or `pyproj` for this transformation MUST be configured to correctly locate and apply this `.gsb` file.

### 4.4. CRS Handling in Python (`pyproj` & `geopandas`)

#### 4.4.1. Immediate CRS Assignment

Any `geopandas.GeoDataFrame` that is created or read from a source MUST have its CRS defined immediately. You MUST verify that `gdf.crs` is not `None`.

```python
import geopandas as gpd
from pyproj import CRS

# Example: Reading a legacy shapefile with no .prj file
gdf = gpd.read_file("path/to/legacy_data.shp")

# The CRS MUST be set immediately using the definition from the catalogue.
# The full PROJ string would be sourced from docs/CRS_Catalogue.csv
millon_space_proj_string = "+proj=ob_tran +o_proj=longlat +o_lon_p=-98.87 ..."
millon_space_crs = CRS.from_proj4(millon_space_proj_string)
gdf = gdf.set_crs(millon_space_crs, allow_override=True)
```

#### 4.4.2. CRS Transformation

For re-projecting vector data, you MUST use the `geopandas.GeoDataFrame.to_crs()` method.

```python
# Transform to the project's standard projected CRS for analysis
gdf_utm = gdf.to_crs("EPSG:32614")
```

#### 4.4.3. Critical `pyproj.Transformer` Rule

When creating a manual transformation pipeline, you MUST instantiate `pyproj.Transformer` with `always_xy=True`. This prevents silent, hard-to-debug errors caused by inconsistent axis ordering (e.g., lat/lon vs. lon/lat).

```python
from pyproj import Transformer

# Correct way to create a transformer
transformer = Transformer.from_crs("EPSG:4326", "EPSG:32614", always_xy=True)
```

### 4.5. CRS Handling in PostGIS

Custom CRS definitions MUST be added to the `spatial_ref_sys` table with their correct PROJ strings to be usable within the database. All transformations MUST use the `ST_Transform(geometry, target_srid)` function, referencing the integer SRID from `spatial_ref_sys`.

## 5. Vector Data Protocols

### 5.1. File I/O and Serialization

-   **Default Format:** For all intermediate and final vector datasets, you MUST use the **GeoPackage (`.gpkg`)** format. It is a modern, open standard that avoids the severe limitations of the ESRI Shapefile format.
    ```python
    # Writing to a GeoPackage with explicit driver and encoding
    gdf.to_file("processed_data.gpkg", driver="GPKG", encoding="utf-8")
    ```
-   **Performance Serialization:** For performance-critical tasks, when passing GeoDataFrames between processes or caching them, you MUST serialize them to a format that preserves geospatial information, such as **Feather** (with WKB-encoded geometry) or **Parquet** with GeoParquet metadata. Do not use standard Pickle.

### 5.2. Spatial Operations

#### 5.2.1. Feature Engineering

Scripts must be able to engineer new spatial features from existing data, such as calculating centroids (`.centroid`), creating buffers (`.buffer`), or deriving distances.

#### 5.2.2. Spatial Joins (`sjoin`)

-   **Predicate Selection:** You must choose the correct spatial predicate for the desired relationship:
    -   `intersects`: Returns true if the geometries have any point in common.
    -   `within`: Returns true if geometry A is entirely inside geometry B.
    -   `contains`: Returns true if geometry B is entirely inside geometry A.
-   **Join Validation:** After performing a spatial join (`gpd.sjoin`), you MUST report the number of successfully joined records and identify any records from the source datasets that failed to find a match, as this may indicate data or CRS issues.

### 5.3. Quality Assurance (QA) Protocols (Phase 3: Digitization)

#### 5.3.1. Geometry and Topology Validation

Scripts MUST validate the geometric integrity of all digitized vector layers.
-   **In Python:** Use `geopandas.GeoSeries.is_valid`. For any invalid geometries found, report them and attempt to repair them using the `.buffer(0)` technique.
    ```python
    import logging
    import geopandas as gpd

    def validate_and_repair_geometries(gdf: "gpd.GeoDataFrame") -> "gpd.GeoDataFrame":
        """Checks for and attempts to repair invalid geometries in a GeoDataFrame."""
        invalid_geoms = gdf[~gdf.geometry.is_valid]
        if not invalid_geoms.empty:
            logging.warning(f"Found {len(invalid_geoms)} invalid geometries. Attempting repair with .buffer(0).")
            gdf['geometry'] = gdf.geometry.buffer(0)
            still_invalid_mask = ~gdf.geometry.is_valid
            if still_invalid_mask.any():
                logging.error(f"{still_invalid_mask.sum()} geometries could not be repaired.")
        return gdf
    ```
-   **In PostGIS:** Use the `ST_IsValid` function.
    ```sql
    SELECT COUNT(*) FROM my_table WHERE NOT ST_IsValid(geom);
    ```
-   **Topological Checks:** For polygon datasets that are expected to form a complete, non-overlapping coverage (e.g., survey tracts), you must include scripted checks to identify gaps and overlaps.

#### 5.3.2. Attribute Validation

Scripts must validate table attributes against the project's defined schemas (e.g., the "Map Assignations System").
```python
def validate_attributes(gdf: "gpd.GeoDataFrame", schema: dict) -> bool:
    """Validates DataFrame columns and values against a schema."""
    is_valid = True
    for column, rules in schema.items():
        if column not in gdf.columns:
            logging.error(f"Missing required column: {column}")
            is_valid = False
            continue
        if 'allowed_values' in rules:
            invalid_values = gdf[~gdf[column].isin(rules['allowed_values'])]
            if not invalid_values.empty:
                logging.warning(f"Found invalid values in column '{column}': {invalid_values[column].unique()}")
                is_valid = False
    return is_valid
```

#### 5.3.3. Formal Schema Validation

To make attribute validation more robust and maintainable, validation schemas SHOULD be externalized into a formal `JSON Schema` document (e.g., `schemas/map_assignations_schema.json`). The Python validation script can then load this schema and use a library like `jsonschema` to validate the attributes for each feature. This decouples the validation rules from the validation logic.

## 6. Raster Data Protocols

### 6.1. Raster I/O Protocol

You MUST use a `with` statement when opening raster files with `rasterio` to ensure that file handles are properly managed and closed, preventing resource leaks and file corruption.
```python
import rasterio

with rasterio.open("path/to/raster.tif") as src:
    crs = src.crs
    transform = src.transform
    data_band1 = src.read(1)
```

### 6.2. Raster Alignment

Before performing any analysis involving multiple raster datasets (e.g., map algebra), you MUST verify that they share the same CRS, resolution, and grid alignment (bounds and transform). If not, you must generate a script using `rasterio.warp.reproject` or `gdal_warp` to reproject and align them to a common grid.

### 6.3. `nodata` Value Handling

All processing scripts must explicitly check for and handle `nodata` values in raster datasets to avoid incorrect calculations. When reading with `rasterio`, use `masked=True` to get a NumPy masked array, which automatically handles this in most statistical calculations.
```python
import numpy as np

with rasterio.open("my_raster.tif") as src:
    # nodata values are automatically masked
    data = src.read(1, masked=True)
    # This calculation correctly ignores nodata pixels
    mean_value = np.mean(data)
```

### 6.4. Zonal Statistics

When calculating zonal statistics (e.g., summarizing raster values within vector polygons using `rasterstats`), the vector and raster datasets MUST be in the same projected CRS to ensure accurate area and summary calculations.

## 7. The Georeferencing Workflow Pipeline (Phase 4)

This section details the protocols for the scripted portions of the georeferencing workflow.

### 7.1. Ground Control Point (GCP) Processing and Validation

Before use, Ground Control Points (GCPs) must be rigorously validated. The scripted protocol is:
1.  **Ingest and Clean:** Load GCPs from their source file (e.g., CSV).
2.  **Preliminary Transformation:** Apply a preliminary transformation (e.g., a global polynomial) to calculate initial error residuals for each GCP.
3.  **Outlier Detection:** Perform statistical outlier detection on the residuals (e.g., using z-scores or an Interquartile Range (IQR) threshold) to automatically flag or remove points that are clear measurement errors. This "cleans" the GCP set before it's used to build the final high-accuracy model.
4.  **Spatial Distribution Analysis:** Perform spatial autocorrelation (e.g., Moran’s I) or kernel density analysis on the cleaned GCPs to identify spatial clustering and areas of sparse coverage, which can bias the transformation model.
5.  **Error Trend Analysis:** Analyze the residuals of a preliminary transformation to check for non-random spatial trends in the georeferencing error.

### 7.2. Transformation and Resampling Method Selection

The choice of transformation and resampling methods must be justified.
-   **Transformation Algorithms:**
    -   **Polynomial (1st, 2nd, 3rd):** Good for correcting systematic, low-frequency distortions.
    -   **Thin Plate Spline (TPS):** The chosen method for this project's core "Millon Space" transformation. It is a non-linear method that excels at correcting localized, non-systematic distortions characteristic of the hand-drawn TMP maps.
-   **Resampling Methods:**
    -   **Nearest Neighbor:** MUST be used for categorical or thematic raster data to preserve original pixel values.
    -   **Cubic Convolution / Lanczos:** SHOULD be used for continuous data like aerial photographs to produce a smoother, more visually appealing result.

### 7.3. Canonical Georeferencing Script

Scripts for raster georeferencing must be parameterized and well-documented, using `gdal.Warp`.
```python
import gdal

def georeference_raster(source_path, output_path, gcps, transform_method='tps', resample_method='lanczos', target_crs="EPSG:6362"):
    """Georeferences a raster using GDAL Warp."""
    options = gdal.WarpOptions(
        gcps=gcps,
        resampleAlg=resample_method,
        transformerOptions=[f"METHOD={transform_method}"],
        dstSRS=target_crs
    )
    gdal.Warp(output_path, source_path, options=options)
```

### 7.4. Accuracy Reporting

The georeferencing workflow must conclude with a comprehensive, scripted accuracy report in Markdown format, including:
-   The final transformation method (e.g., TPS) and resampling algorithm (e.g., Lanczos) used, with justification.
-   The overall Root Mean Square Error (RMSE) value.
-   A plot of error residuals to visualize spatial patterns in the error.
-   A link to a visual validation overlay image (e.g., a semi-transparent GeoTIFF).
```python
# Scripted RMSE Calculation
import numpy as np
# Assume residuals_x and residuals_y are numpy arrays of the errors
# for each GCP in the x and y dimensions.
rmse = np.sqrt(np.mean(residuals_x**2 + residuals_y**2))
print(f"Overall RMSE: {rmse} meters")
```

## 8. Spatial Database (PostGIS) Protocols

### 8.1. Spatial Indexing (The GiST Imperative)

A **GiST (Generalized Search Tree) index** on a `geometry` or `geography` column is not optional; it is a mandatory performance requirement. An `EXPLAIN ANALYZE` will clearly show the shift from an unacceptable `Seq Scan` to a highly performant `Index Scan`. You must propose the `CREATE INDEX` command immediately after any `CREATE TABLE` statement involving a spatial column.
```sql
CREATE INDEX idx_structures_geom ON structures USING GIST (geom);
```

### 8.2. Data Types

-   Use the `geometry` type for projected data (e.g., UTM) where planar calculations are appropriate.
-   Use the `geography` type for unprojected, global data (lon/lat) when great-circle distance or area calculations are required, as it provides higher accuracy for these cases.

### 8.3. Optimized Spatial Queries

-   **Optimized Spatial Join:** You MUST use the `&&` operator (bounding box intersection) to leverage the spatial index *before* performing the more expensive, exact intersection check with a function like `ST_Intersects`. This is the most important PostGIS performance pattern.
    ```sql
    -- CORRECT: Find all artifacts within each survey tract
    SELECT t.tract_id, a.artifact_id
    FROM survey_tracts AS t
    JOIN artifacts AS a ON (t.geom && a.geom AND ST_Intersects(t.geom, a.geom));
    ```
-   **Proximity/Radius Queries:** To find all features within a certain distance, you MUST use `ST_DWithin`. It is index-aware and vastly superior to using `ST_Distance` in the `WHERE` clause, which is a severe performance anti-pattern.
    ```sql
    -- CORRECT: Find all structures within 50 meters of a known temple
    SELECT s.structure_id FROM structures AS s
    WHERE ST_DWithin(s.geom, (SELECT geom FROM structures WHERE structure_name = 'Temple of the Sun'), 50.0);
    ```

### 8.4. Advanced Analytical Functions

For advanced analysis directly within the database, leverage PostGIS's powerful analytical functions:
-   **Clustering:** Use `ST_ClusterDBSCAN` or `ST_ClusterKMeans` to identify spatial clusters of artifacts or features.
-   **Aggregation:** Use `ST_Collect` to create a `MULTI` geometry from a set of individual geometries. Use `ST_Union` to dissolve the boundaries between adjacent polygons into a single geometry.
-   **Boundary Generation:** Use `ST_ConcaveHull` to generate a "tight" boundary around a set of points, which is often more representative of a site's extent than `ST_ConvexHull`.

### 8.5. Common Pitfalls to Avoid

-   **CRS Mismatches:** Never perform spatial operations between columns that have different CRSs (SRIDs). You must use `ST_Transform` to align them first.
-   **Calculations on Geographic Coordinates:** **Never perform distance (`ST_Distance`) or area (`ST_Area`) calculations on data in geographic coordinates (lon/lat, e.g., EPSG:4326).** The units will be in degrees, which is not meaningful. You MUST first transform the data to a suitable *projected* CRS (like UTM) using `ST_Transform` before performing these calculations.

## 9. Versioning Geospatial Data

Geospatial data, particularly large binary files like GeoTIFFs, are not handled efficiently by Git. To ensure full reproducibility of data artifacts, this project will adopt a formal data versioning protocol.

-   **Principle:** All key intermediate and final geospatial datasets MUST be versioned.
-   **Tooling:** **DVC (Data Version Control)** MUST be used alongside Git for this purpose. DVC versions large files by storing small metadata "pointer" files in Git, while the actual data is stored in a remote location (e.g., an S3 bucket, Google Cloud Storage).
-   **Workflow:**
    1.  After generating a new data artifact (e.g., `georeferenced_map.tif`), add it to DVC tracking: `dvc add data/processed/georeferenced_map.tif`.
    2.  Commit the resulting small `georeferenced_map.tif.dvc` file to Git: `git commit -m "feat: Add georeferenced raster v1.0"`.
    3.  Push the actual data file to remote storage: `dvc push`.
-   **Benefit:** This keeps the Git repository small and fast while providing full, commit-by-commit reproducibility for all data artifacts.

---
