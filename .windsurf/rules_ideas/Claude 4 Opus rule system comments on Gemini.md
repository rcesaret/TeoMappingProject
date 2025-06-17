# USER

Can you please overview the attached docs in great detail? I'm trying to create a windsurf rule system optimal for my project, and I need suggestions/help. Gemini 2.5 pro made a suggestion, and I was hoping you could also review this for optimality

# ASSISTANT

I'll analyze your Digital TMP project documentation and review Gemini 2.5 Pro's proposed rule system in detail.

## Project Analysis Summary

Your Digital TMP project is an impressive archaeological data modernization initiative with several key characteristics:

### Project Complexity
- **8 Sequential Phases**: Each with distinct methodologies, tools, and outputs
- **Multi-Generational Data**: 60+ years of legacy data requiring careful transformation
- **Diverse Technical Stack**: PostgreSQL/PostGIS, Python, R, QGIS, GDAL, Docker, FastAPI
- **Multiple Output Formats**: Database, archival packages, WebGIS, tutorials
- **Academic Standards**: Rigorous documentation, metadata, and archival compliance requirements

### Critical Success Factors
1. **Phase Discipline**: Each phase has specific inputs/outputs that must be respected
2. **Spatial Accuracy**: High-precision georeferencing is crucial (custom NTv2 transformations)
3. **Data Integrity**: Maintaining provenance through complex transformations
4. **Reproducibility**: Docker, version control, automated validation
5. **Multi-Stakeholder Outputs**: From researchers to public audiences

## Review of Gemini's Proposed Rule System

### Strengths of the Proposal
1. **Well-Structured Hierarchy**: Global rules → Project conventions → Phase-specific rules
2. **Comprehensive Coverage**: Addresses most project aspects
3. **Good MCP Mapping**: Reasonable tool assignments for different tasks
4. **Dynamic Task Management**: TASKS.MD for progress tracking
5. **Supporting Documents**: GLOSSARY.MD, TOOLING_MCP.MD provide good context

### Areas for Optimization

#### 1. **MCP Tool Selection Refinement**

Based on your project's specific needs, here's my optimized MCP priority ranking:

**Essential MCPs**:
- **Desktop Commander** ⭐ - Perfect for GDAL/ogr2ogr/QGIS CLI operations
- **filesystem** - Core file operations
- **mcp-sequentialthinking-tools** - Better than basic sequential-thinking as it can recommend other tools
- **github** - Version control for all outputs
- **docs-manager** - Critical for tDAR documentation

**High Value**:
- **memory** - Track decisions/parameters across 8 phases
- **smart-thinking** - Complex spatial problem solving
- **brave-search** - Archaeological standards research

**Lower Priority** (for this project):
- **excel** - You're using PostgreSQL/CSV
- **doc-tools-mcp** - Not using Word format
- **code-reasoning** - Overlaps with sequential-thinking tools

#### 2. **Enhanced Phase-Specific Rules Structure**

Instead of one generic `phase_specific_rules.md`, I recommend individual phase rule files:

```
.windsurf/rules/
├── project_conventions.md
├── phase1_database_analysis.md
├── phase2_database_transformation.md
├── phase3_gis_digitization.md
├── phase4_georeferencing.md
├── phase5_integration.md
├── phase6_tdar_archival.md
├── phase7_postgis_deployment.md
├── phase8_tutorials_dashboards.md
├── validation_gates.md
└── error_recovery.md
```

#### 3. **Validation Gates Rule File**

Add a specific validation rule file:

```markdown
# Validation Gates for Digital TMP

## Phase Completion Criteria

### Phase 1 Completion Requirements
- [ ] All 4 legacy databases successfully migrated to PostgreSQL
- [ ] ERDs generated and verified for each database
- [ ] Schema profiling metrics stored in tmp_db_metrics
- [ ] Denormalization white paper completed with benchmarks
- [ ] Git commit with tag: `phase1-complete-v1.0`

### Phase 2 Completion Requirements
- [ ] TMP_DF12 dataset validated (row count: 5,046)
- [ ] REANs_DF4 dataset validated and aligned by SSN
- [ ] All controlled vocabularies documented in CSV/PDF
- [ ] Transformation logs complete
- [ ] Data quality reports pass all checks
- [ ] Git tag: `phase2-complete-v1.0`

[Continue for all phases...]

## Validation Commands
- Database row counts: `SELECT COUNT(*) FROM table_name;`
- Geometry validation: `SELECT COUNT(*) FROM layer WHERE NOT ST_IsValid(geom);`
- CRS verification: `SELECT DISTINCT ST_SRID(geom) FROM layer;`
```

#### 4. **Enhanced TOOLING_MCP.MD Structure**

Organize by project phase rather than by tool:

```markdown
# Digital TMP MCP Tool Orchestration

## Phase 1: Database Analysis
**Primary Tools**: Desktop Commander, filesystem, mcp-sequentialthinking-tools
**Workflow**:
1. Use `mcp-sequentialthinking-tools` to plan migration strategy
2. Use `Desktop Commander` to execute PostgreSQL operations
3. Use `filesystem` to manage SQL scripts and outputs
4. Use `memory` to store schema decisions

**Specific Commands**:
```bash
# Desktop Commander for PostgreSQL
dc: psql -U user -d tmp_legacy -f migrate_df8.sql
dc: pg_dump --schema-only tmp_df8 > schema_df8.sql
```

## Phase 3: GIS Digitization
**Primary Tools**: Desktop Commander, filesystem, smart-thinking
**Workflow**:
1. Use `smart-thinking` for digitization strategy
2. Use `Desktop Commander` for QGIS Python console scripts
3. Use `filesystem` to organize vector outputs

[Continue for each phase...]
```

#### 5. **Progressive Activation Strategy**

Instead of generic activation, use phase-based progression:

```markdown
# PHASE_PROGRESSION.MD

## Current Phase: [PHASE_NUMBER]
## Status: [IN_PROGRESS|VALIDATING|COMPLETE]

### Active Rule Sets
- Always: global_rules.md, project_conventions.md
- Current Phase: phase[N]_[name].md
- Support: validation_gates.md, error_recovery.md

### Phase Transition Protocol
1. Complete all tasks in current phase
2. Run validation gates
3. Create git tag
4. Update this file to next phase
5. Load next phase rules
```

#### 6. **Error Recovery Protocols**

Add specific error handling:

```markdown
# Error Recovery Protocols

## Database Errors
- Connection failures: Check .env, verify PostgreSQL service
- Migration failures: Rollback, check logs, use --verbose flag
- Fallback: Keep original Access files as reference

## Spatial Errors
- Invalid geometries: Use ST_MakeValid(), log problematic features
- CRS conflicts: Verify source CRS, check transformation parameters
- Fallback: Export to multiple formats for debugging

## MCP Tool Failures
- Desktop Commander timeout: Increase timeout, break into smaller operations
- Memory MCP full: Export to filesystem, clear old entries
- GitHub API limit: Wait for reset, use local commits
```

#### 7. **Enhanced TASKS.MD Structure**

Make it more actionable with explicit validation checkpoints:

```markdown
# Digital TMP Project Tasks

## Phase 1: Database Analysis
### Workflow 1.1: Legacy Database Instantiation
- [ ] Configure PostgreSQL environment (.env setup)
- [ ] Run setup_databases.py
  - [ ] Validate: All 4 DBs created successfully
- [ ] Execute schema_viz.py for ERD generation
  - [ ] Validate: 4 ERD PDFs generated
- [ ] Run profile_db.py for metrics
  - [ ] Validate: Metrics in tmp_db_metrics schema
- [ ] CHECKPOINT: Run phase1_validation.sql

### Workflow 1.2: Schema Analysis
- [ ] Compute Join-Dependency Index (JDI)
- [ ] Calculate Lookup Inflation Factor (LIF)
- [ ] Benchmark query performance
- [ ] Write denormalization white paper
- [ ] CHECKPOINT: Peer review of recommendations
```

## Additional Recommendations

### 1. **Add a DECISIONS.MD File**
Track major decisions with rationale:

```markdown
# Project Decisions Log

## 2024-05-23: Denormalization Strategy
**Decision**: Adopt fully denormalized schema for TMP_DF12
**Rationale**:
- No updates needed (historical data)
- Optimizes analytical queries
- Simplifies GIS integration
**Metrics**: 10x query performance improvement

## 2024-05-24: CRS Selection
**Decision**: EPSG:32614 for analysis, EPSG:4326 for web
**Rationale**: UTM for accurate area calculations, WGS84 for web compatibility
```

### 2. **Quality Assurance Rules**
Add QA-specific rules:

```markdown
# qa_rules.md

## Code Quality
- Python: Run `black` formatter before commits
- SQL: Use `sqlfluff` for formatting
- R: Use `styler` package

## Data Quality
- Always validate row counts after transformations
- Check for NULL values in key fields
- Verify spatial topology after edits
- Document any data loss or modifications

## Output Quality
- All deliverables must include metadata
- Version all outputs with date stamps
- Include checksums for large files
```

### 3. **MCP Orchestration Patterns**

Define common MCP usage patterns:

```markdown
# MCP Patterns

## Pattern: Complex Analysis
1. `mcp-sequentialthinking-tools` → Plan approach
2. `memory` → Store key parameters
3. `Desktop Commander` → Execute operations
4. `filesystem` → Save results
5. `github` → Commit outputs

## Pattern: Documentation Generation
1. `smart-thinking` → Structure content
2. `docs-manager` → Create markdown
3. `filesystem` → Save drafts
4. `github` → Version control
```

## Summary

Gemini's proposal provides an excellent foundation. My optimizations focus on:

1. **More granular phase-specific rules** matching your project structure
2. **Validation gates** ensuring phase completion quality
3. **Better MCP tool selection** aligned with your actual tools (emphasizing Desktop Commander)
4. **Error recovery protocols** for common issues
5. **Decision tracking** for long-term project memory
6. **Quality assurance** embedded throughout

The key is making the rule system progressive and phase-aware, since your project has such clear sequential dependencies. Each phase should have its own focused ruleset with explicit validation criteria before proceeding to the next phase.
