# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

The **Digital TMP Data Integration Initiative** is a comprehensive data science project modernizing the fragmented legacy datasets of the Teotihuacan Mapping Project (TMP) into a unified, reproducible PostgreSQL/PostGIS geospatial research infrastructure. This transforms over 60 years of archaeological data from one of the world's most significant ancient urban sites into a modern, accessible digital platform through an 8-phase systematic pipeline.

## Environment Setup

### Prerequisites
- **Python**: 3.11+ (mandatory)
- **Database**: PostgreSQL 17 + PostGIS 3.4 (via Docker)
- **GIS**: QGIS 3.40.5 for spatial digitization
- **Conda**: For environment management

### Initial Setup
```bash
# Create and activate conda environment
conda env create -f envs/digital_tmp_base_env.yml
conda activate digital_tmp_base

# Start PostgreSQL/PostGIS database
cd infrastructure/db/
docker-compose up -d

# Initialize legacy databases
python phases/01_LegacyDB/src/00_setup_databases.py
```

### Environment Activation
**CRITICAL**: Always activate the conda environment before any work:
```bash
conda activate digital_tmp_base
```

## Common Development Commands

### Phase 1: Legacy Database Analysis (Complete)
```bash
# Setup legacy databases from SQL dumps
python phases/01_LegacyDB/src/00_setup_databases.py --config config.ini

# Verify database setup
python phases/01_LegacyDB/src/00_setup_databases.py --verify-only

# Run database profiling pipeline
python phases/01_LegacyDB/src/02_run_profiling_pipeline.py

# Generate ERDs for databases
python phases/01_LegacyDB/src/03_generate_erds.py

# Run database comparison analysis
python phases/01_LegacyDB/src/04_run_comparison.py
```

### Testing
```bash
# Run all tests
pytest

# Run specific phase tests
pytest tests/p1_w1/  # Phase 1 Week 1
pytest tests/p1_w2/  # Phase 1 Week 2
pytest tests/p1_w3/  # Phase 1 Week 3

# Run with coverage (minimum 80% required)
pytest --cov=phases/01_LegacyDB/src/

# Run specific test file with verbose output
pytest tests/p1_w2/test_metrics_basic.py -v
```

### Code Quality
```bash
# Format code with ruff (88-character line limit)
ruff format .

# Lint code with ruff
ruff check .

# Format SQL files (PostgreSQL dialect)
sqlfluff format --dialect postgres phases/01_LegacyDB/sql/

# Lint SQL files
sqlfluff lint --dialect postgres phases/01_LegacyDB/sql/
```

## Project Architecture

### 8-Phase Pipeline Structure

#### **Phase 1: Legacy Database Analysis** ✅ *Complete*
- Database profiling, performance benchmarking, ERD generation
- Location: `phases/01_LegacyDB/`
- Deliverables: PostgreSQL migrations, schema profiling reports

#### **Phase 2: Database Transformation** 🔄 *Pending*
- ETL pipeline: DF8/9/10 → DF11 → DF12, controlled vocabulary
- Location: `phases/02_TransformDB/`
- Deliverables: `TMP_DF12`, `TMP_REANs_DF4`, validation reports

#### **Phase 3: GIS Digitization** 🔄 *Pending*
- Manual digitization of archaeological features from historical maps
- Location: `phases/03_DigitizeGIS/`
- Deliverables: Complete digitized vector layers, topology validation

#### **Phase 4: Georeferencing** 🔄 *Pending*
- Custom NTv2 transformation from "Millon Space" to UTM Zone 14N
- Location: `phases/04_Georef/`
- Deliverables: Georeferenced datasets, accuracy assessments (<2m RMSE)

#### **Phase 5: Geospatial Integration** 🔄 *Pending*
- Merge cleaned tabular and spatial datasets with feature engineering
- Location: `phases/05_GeoIntegration/`
- Deliverables: Fully integrated spatial dataset (DF13)

#### **Phase 6: tDAR Outputs** 🔄 *Pending*
- Archival preparation for The Digital Archaeological Record
- Location: `phases/06_tDAR/`
- Deliverables: tDAR-compliant packages, metadata

#### **Phase 7: PostGIS Database** 🔄 *Pending*
- Production-grade spatial database deployment
- Location: `phases/07_PostGIS/`
- Deliverables: Docker-containerized PostGIS, API endpoints

#### **Phase 8: Tutorials & Dashboards** 🔄 *Pending*
- User-friendly access through interactive tools
- Location: `phases/08_Dashboards/`
- Deliverables: WebGIS dashboard, RESTful API, tutorials

## Key Technologies

### Core Stack
- **Database**: PostgreSQL 17 + PostGIS 3.4
- **Python**: 3.11+ with conda environment management
- **GIS**: QGIS 3.40.5, GDAL 3.6+, PROJ 9.0+
- **Containerization**: Docker & Docker Compose
- **Web**: FastAPI, Leaflet.js

### Essential Libraries
- **Data Processing**: pandas, GeoPandas, SQLAlchemy, psycopg2
- **Geospatial**: Shapely, Rasterio, pyproj, GDAL
- **Validation**: Great Expectations (98.5% pass rate target)
- **Testing**: pytest (80% coverage minimum)
- **Quality**: ruff (formatting/linting), sqlfluff (SQL)

## Development Standards

### Python Code Standards
- **Version**: Python 3.11+ mandatory
- **Environment**: Work in `digital_tmp_base` conda environment
- **Formatting**: Use `ruff` with 88-character line limit
- **Type Hints**: Mandatory for all functions using `typing` module
- **Documentation**: Google-style docstrings for all public APIs
- **Path Handling**: Use `pathlib.Path` objects exclusively
- **Error Handling**: Specific exceptions with try-except blocks

### Database Standards
- **Connection**: Use SQLAlchemy Core (not ORM) for all database operations
- **Validation**: Validate all SQL identifiers, use parameterized queries
- **Spatial**: GiST indexes mandatory for all geometry columns
- **Performance**: Use `&&` operator before expensive spatial functions
- **Schema**: Logical organization (raw_legacy, staging, production, analytics)

### Geospatial Standards
- **CRS First**: All geospatial data must have correctly defined CRS
- **Scripted Operations**: All transformations must be reproducible
- **Validation**: Check geometry validity, spatial relationships
- **File Formats**: Prefer GeoPackage over Shapefile for vector data
- **TMP-Specific**: Handle custom "Millon Space" CRS and NTv2 transformations

## Key Files and Directories

### Configuration Files
- `envs/digital_tmp_base_env.yml`: Conda environment definition
- `pyproject.toml`: Python tool configuration (ruff, pytest, sqlfluff)
- `phases/01_LegacyDB/src/config.ini`: Database connection settings

### Legacy Database Files
- `infrastructure/db/legacy_db_sql_scripts/`: SQL dumps for legacy databases
- `phases/01_LegacyDB/src/00_setup_databases.py`: Main database setup script
- `phases/01_LegacyDB/src/profiling_modules/`: Modular database profiling system

### Documentation
- `TASKS.md`: Current project status and task tracking
- `docs/`: Comprehensive project documentation
- `.windsurf/instructions/`: Development guidelines
- `.windsurf/rules/`: AI assistant behavior rules

## Data Flow and Key Concepts

### Legacy Database Evolution
- **DF8** (1975-1977): Flat-file VAX mainframe database
- **DF9** (1990s): Highly normalized MS Access relational structure
- **DF10** (2022): "Long format" restructuring for modern analysis
- **REANS**: Parallel ceramic reanalysis database

### Spatial Data Handling
- **Millon Space**: Custom local coordinate system requiring NTv2 transformation
- **Collection Units**: 5,046 archaeological collection units across 37.5 km²
- **Ground Control Points**: >1,900 points for high-precision georeferencing
- **Target Accuracy**: <2m RMSE for all spatial transformations

### Final Data Products
- **TMP_DF12**: Denormalized main dataset (5,046 collection units)
- **TMP_REANs_DF4**: Ceramic analysis with enhanced typology
- **Spatial Integration**: PostGIS-enabled with geometry columns
- **Web Services**: RESTful API and interactive WebGIS dashboard

## Task Management

### Task-Driven Development
- **TASKS.md Protocol**: All work must correspond to atomic tasks
- **Dependency Management**: Respect task dependencies in execution order
- **Validation Steps**: Each task includes testable completion criteria
- **Context Files**: Complete file lists provided for task execution

### Current Status
- **Phase 1**: ✅ Complete (database analysis and profiling)
- **Phases 2-8**: 🔄 Pending implementation

## Quality Assurance

### Testing Requirements
- **Framework**: pytest exclusively
- **Coverage**: Minimum 80% for new/modified modules
- **Test Types**: Unit tests (primary), integration tests, pipeline tests
- **Structure**: Mirror source structure in `tests/` directory

### Code Review Standards
- **Multi-Faceted**: Strategic alignment, quality, performance, security
- **Architectural Compliance**: Check against project patterns
- **Performance Audit**: Identify optimization opportunities
- **Security Scan**: Input validation, secret detection

### Documentation Quality
- **Accuracy**: Documentation must reflect current implementation
- **Dual Audience**: Technical experts and domain experts (archaeologists)
- **Consistency**: Use project glossary for controlled vocabulary
- **Completeness**: Cover setup, usage, troubleshooting, and edge cases

## Common Issues and Solutions

### Database Connection
- **Issue**: Database connection failures
- **Solution**: Verify Docker container status and configuration
- **Check**: `docker-compose ps` and `config.ini` settings

### Environment Issues
- **Issue**: Missing dependencies or wrong Python version
- **Solution**: Ensure conda environment is activated
- **Check**: `conda info --envs` and `python --version`

### Spatial Data Problems
- **Issue**: CRS transformation errors
- **Solution**: Verify CRS definitions and transformation parameters
- **Check**: Use `gdalinfo` or `ogrinfo` for spatial file inspection

### Testing Failures
- **Issue**: Test failures in CI/CD
- **Solution**: Run locally with same environment
- **Check**: `pytest -v` for detailed output

## Important Notes

- **Never work outside the conda environment**: Always activate `digital_tmp_base`
- **Follow task-driven development**: All work must correspond to TASKS.md entries
- **Maintain spatial data integrity**: CRS definition is non-negotiable
- **Use proper error handling**: Comprehensive try-except blocks for I/O operations
- **Document all changes**: Update documentation when code changes
- **Validate all inputs**: Never trust external data without validation

## Phase-Specific Guidance

### Phase 1 (Complete)
- Database setup scripts are idempotent and can be run multiple times
- Use `--verify-only` flag to check database status without modifications
- All profiling modules follow consistent interface patterns

### Future Phases (Pending)
- Each phase will have similar structure: `src/`, `notebooks/`, `outputs/`, `tests/`
- Phase dependencies must be respected in execution order
- All spatial operations must maintain CRS integrity throughout pipeline

This project represents a methodological breakthrough in digital archaeology, establishing new standards for legacy data integration while creating reusable frameworks for spatial data transformation.