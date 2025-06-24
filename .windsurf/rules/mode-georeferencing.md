---
trigger: manual
---

# GEOREFERENCING

## OBJECTIVE
Your objective is to generate Python scripts for the entire high-precision georeferencing workflow. Your scripts must be robust, reproducible, and include detailed validation and reporting.

## GCP & INPUT PREPARATION PROTOCOL
- Scripts must handle the conversion of Ground Control Points (GCPs) from QGIS-exported formats (e.g., .points files) into a GDAL-compatible format.
- Scripts must programmatically attach the converted GCPs to the target raster basemaps using the appropriate GDAL utilities.
- You MUST generate a script to analyze the spatial distribution of GCPs. This script will calculate nearest neighbor distances and use a kernel density plot to create a heatmap visualizing GCP coverage. It must flag areas with sparse GCP coverage as a warning.

## TRANSFORMATION & MODEL SELECTION PROTOCOL
- You MUST use `gdal` (via shell commands or the Python library) and `pyproj` for all transformation tasks.
- Generate a script that performs a sensitivity analysis to select the optimal georeferencing method. This script MUST:
  - Systematically apply multiple transformation algorithms (e.g., Polynomial of degrees 1, 2, 3; Thin Plate Spline).
  - Systematically apply multiple resampling methods (e.g., `lanczos`, `cubic`, `bilinear`).
  - For each combination, calculate the Root Mean Square Error (RMSE).
  - Output a comparative Markdown table of the results to justify the final selection.
- Generate scripts that use GDAL tools to create high-accuracy NTv2 grid shift files (`.gsb`) from the final, refined GCP dataset.
- Scripts that define custom CRS transformation pipelines in PROJ format MUST include the custom 'Millon Space' CRS definition and the generated NTv2 shift grid.

## ACCURACY ASSESSMENT & VALIDATION
- Scripts must calculate and report the full set of GCP residuals (dx, dy, and total error) for the selected transformation model.
- Generate a script to perform spatial autocorrelation analysis (e.g., Moran's I) on the residuals to identify any non-random spatial patterns in the georeferencing error.
- Generate a script that creates a visual validation output. This should be a semi-transparent overlay of the transformed raster on a modern basemap (e.g., from a web map service) and saved as a GeoTIFF or PDF for manual inspection.

## OUTPUT & REPORTING
- All transformation scripts must output a corresponding `.json` or `.txt` file containing the full metadata of the transformation applied, including the source and target CRS, the transformation algorithm used, the resampling method, and the final RMSE.
- For a given raster, you must be able to generate a script that orchestrates the entire workflow (model selection, transformation, validation) and produces a comprehensive Markdown report including: the selected transformation method and rationale, the final RMSE, a plot of residuals, and a link to the visual validation overlay output.

## ADVANCED TRANSFORMATION TECHNIQUES
- Generate a Python script that takes a set of GCPs and systematically applies multiple transformation algorithms. The script must output a comparative table of RMSE values to justify the selection of the optimal algorithm.
- Create a script to analyze the spatial distribution of GCPs, calculating metrics like nearest neighbor distance and flagging areas with sparse coverage.
- Generate a script that programmatically generates the correct PROJ string for a custom CRS based on a set of input parameters (e.g., datum, projection, central meridian).

## ARCHAEOLOGICAL PROJECT INTEGRATION
- Ensure all georeferencing scripts account for the specific challenges of the TMP "Millon Space" coordinate system and its non-linear distortions.
- Generate scripts that validate georeferenced outputs against known archaeological features and modern landmarks for accuracy assessment.
- Include specific validation procedures for archaeological map features, ensuring that spatial relationships between structures, survey boundaries, and topographic elements are preserved.
- Create workflows that prepare georeferenced data for integration with tabular archaeological datasets via spatial joins.

## QUALITY CONTROL & VALIDATION
- Implement comprehensive error checking throughout all transformation scripts, with specific handling for edge cases common in historical map georeferencing.
- Generate validation scripts that compare georeferenced results with independent control data to assess transformation accuracy.
- Include automated detection of transformation artifacts and geometric distortions that could affect subsequent spatial analysis.
- Create diagnostic tools for identifying and correcting systematic errors in GCP placement or transformation parameters.

## REPRODUCIBILITY & DOCUMENTATION
- All scripts must include comprehensive parameter logging and metadata generation to ensure complete reproducibility of georeferencing results.
- Generate automated documentation that describes transformation methods, accuracy assessments, and limitations for inclusion in project reports and archival materials.
- Ensure all custom transformation grids and CRS definitions are properly documented and archived with appropriate provenance information.
- Include version control and change tracking for iterative improvement of transformation accuracy.
