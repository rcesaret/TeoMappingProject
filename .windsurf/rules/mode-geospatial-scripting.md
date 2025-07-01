---
trigger: manual
---

# GEOSPATIAL PYTHON SCRIPTING

## CORE GEOSPATIAL PRINCIPLES
- You MUST ALWAYS review and implement the guidelines & protocols from `.windsurf/instructions/guide-geospatial-protocols.md`, which is the PRIMARY SOURCE OF TRUTH for all python geospatial coding tasks.
- The single most critical rule is ensuring that all geospatial data has a correctly defined and appropriate Coordinate Reference System (CRS). All other spatial operations depend on this foundation. An undefined CRS is a critical error.
- All transformations and analytical steps must be scripted to ensure the process is reproducible and the data provenance is clear.

## PYTHON GEOSPATIAL LIBRARIES
- For Python-based geospatial tasks, you MUST use `geopandas`, `pyproj`, `rasterio`, and `fiona`.
- Any `geopandas.GeoDataFrame` that is created or read from a source MUST have its CRS set immediately using `gdf.set_crs()`. You MUST verify `gdf.crs` is not None.
- When writing a GeoDataFrame to a file, the CRS must be correctly passed to the write function.
- The project's sanctioned Coordinate Reference Systems are defined in `docs/CRS_Catalogue.csv`. When assigning a CRS (e.g., `gdf.set_crs("EPSG:4326")`) or transforming to a CRS (`gdf.to_crs("EPSG:32614")`), you MUST use an authority code (e.g., an EPSG code) listed in this catalogue. Do not use raw Proj4 strings unless no EPSG code is available.
- For re-projecting vector data, you MUST use the `geopandas.GeoDataFrame.to_crs()` method.
- For creating custom transformation pipelines, you MUST use the `pyproj.Transformer` class. When creating a transformer, you MUST set `always_xy=True` to ensure consistent (longitude, latitude) or (easting, northing) axis order and prevent silent axis-flipping errors.
- When writing geospatial vector files (e.g., Shapefile, GeoPackage) using `geopandas.to_file()`, you MUST explicitly specify the `driver` and `encoding='UTF-8'` arguments to ensure cross-platform compatibility and prevent attribute data corruption.

## RASTER DATA PROCESSING
- When reading raster files with `rasterio`, you MUST use a `with rasterio.open(...) as src:` block to ensure the file handle is properly closed.
- Before performing any analysis involving multiple raster datasets, you MUST verify that they share the same CRS, resolution, and bounds. If not, generate a script using `rasterio` or `gdal` to reproject and align them.
- All processing scripts must explicitly check for and handle `nodata` values in raster datasets to avoid incorrect calculations.
- When calculating zonal statistics, the vector and raster datasets MUST be in the same projected CRS to ensure accurate area/summary calculations.

## POSTGIS BEST PRACTICES
- All tables with a `geometry` or `geography` column MUST have a GiST (Generalized Search Tree) index created on that column. You must propose the `CREATE INDEX idx_tablename_geom ON tablename USING GIST (geom_column);` command immediately after any `CREATE TABLE` statement involving a geometry column.
- When performing spatial queries (e.g., intersection, distance), you MUST structure the `WHERE` clause to use an indexed operator first to filter the candidate set before applying a more computationally expensive function.
- Correct Pattern: `WHERE a.geom && b.geom AND ST_Intersects(a.geom, b.geom)`
- Incorrect Pattern: `WHERE ST_Intersects(a.geom, b.geom)`
- Use the `geometry` type for projected data (e.g., UTM) where planar calculations are appropriate. Use the `geography` type for unprojected, global data (lon/lat) when great-circle distance or area calculations are required, as it provides higher accuracy.
- For CRS transformations within the database, you MUST use the `ST_Transform(geometry, srid)` function. The target SRID must be a valid entry in the `spatial_ref_sys` table.

## GEOSPATIAL VALIDATION & QA
- Before performing complex operations like unions or intersections, you MUST check for invalid geometries using `geopandas.GeoSeries.is_valid`. For any invalid geometries found, you must report them and attempt to repair them using the `.buffer(0)` technique.
- When performing a spatial join (`gpd.sjoin`) or an attribute join, you MUST report the number of successfully joined records and identify any records from either dataset that failed to find a match.
- For polygon datasets that are expected to form a complete, non-overlapping coverage, you must include checks for gaps and overlaps.

## TMP PROJECT-SPECIFIC REQUIREMENTS
- All spatial operations involving TMP data must account for the custom "Millon Space" coordinate system and its transformation to modern CRS via the project's NTv2 grid shift file.
- When processing legacy TMP vector data, always validate geometry integrity and check for known topological issues (overlaps, gaps, self-intersections).
- For operations involving collection unit polygons, always cross-validate with the SSN (collection unit ID) to ensure spatial-attribute alignment.
- When working with architectural feature data, consider the hierarchical relationship between structures and collection units in spatial analysis.

## COORDINATE SYSTEM MANAGEMENT
- Document all coordinate system transformations with accuracy assessments using appropriate metrics (RMSE, residual analysis).
- For high-precision georeferencing operations, implement spatial autocorrelation analysis to validate transformation quality.
- When creating outputs for different audiences, maintain versions in both analytical CRS (UTM Zone 14N, EPSG:32614) and web-friendly CRS (WGS84, EPSG:4326).
- Always validate coordinate system metadata in output files and ensure proper CRS definitions are embedded.

## PERFORMANCE & DATA MANAGEMENT
- For performance, when passing GeoDataFrames between processes or caching them, you MUST serialize them to a format that preserves geospatial information, such as Feather (with WKB-encoded geometry) or Parquet with GeoParquet metadata, not standard Pickle.
- Implement spatial indexing strategies for large datasets to optimize query performance.
- For vector-raster operations on large datasets, consider tiling strategies to manage memory usage.
- Use appropriate spatial data structures (R-tree, Quadtree) for efficient spatial queries when working with large point datasets.
