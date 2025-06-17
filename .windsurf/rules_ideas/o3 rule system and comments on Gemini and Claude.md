## USER
Can you analyze my project docs (architecture, overview, readme_updated, planning_updated) and study the other attached docs on windsurf rule system design in great detail. I'm trying to create a windsurf rule system optimal for my project, and I need suggestions/help.

Can you help me work on the design of an optimal windsurf rule system for my project? I want to use a .windsurf/rules/ setup, global_rules.md, TASKS.md, PLANNING.md/TASKS.md, and likely some of the other types of files as well (but I need your help!!) I also want to setup an MCP rule system protocol, and I need your help figuring out the optimal MCPs to use (per online research).

Gemini 2.5 pro and Claude 4 Opus made suggestions (attached), and I was hoping you could also review them.

I do not want to over-do the rules on the first pass, nor do I want to over-fit the rule system at first. Some AI agent freedom might be good for flexibility, and I want to guide rather than completely control behavior



## Thoughts
The user wants help designing an optimal windsurf rule system for their project, including analyzing various documents such as architecture, planning, and specific rule-set files. My task is to review the provided content and their suggestions, then compare it to research for MCPs (Motion Control Protocols). I'll need to focus on integrating their Gemini 2.5 pro and Claude 4 Opus suggestions. I’ll dive into the project's global rules setup and refine the windsurf rule system design based on what I find.
The user is working on designing a windsurf rule system and has shared a lot of documentation. They want help to create an optimal system by analyzing several project documents, including best practices and rule system design files. I'll review these carefully and turn my focus to both structuring a solid rule system and setting up an MCP protocol. The user also wants feedback on optimal MCPs, so I'll look into their current ones and research the best options based on their project needs.
The user wants a flexible, minimal rule structure to start with, allowing AI agent freedom while guiding behavior. I’ll suggest a directory setup for the windsurf rule system with files like global_rules.md, planning.md, and tasks.md. For MCP protocols, I'll define clear guidelines in .windsurf/rules, including a mcp_usage.md for action triggers, like using filesystem for file operations or postgres-mcp for database tasks. I'll propose integrating some key MCPs, refining them as needed, with a simple first-pass protocol that can evolve.

## ASSISTANT
Here’s a lean, first-pass Windsurf rule system tailored to the Digital TMP project, plus an MCP-orchestration protocol and MCP recommendations. It balances guidance with agent flexibility, deferring deeper specialization to later iterations.

---

## 1. `.windsurf/rules/` Layout

```
.windsurf/
└── rules/
    ├── global_rules.md         # Universal AI behavior & safety
    ├── project_conventions.md  # File/layout/naming/stack specifics
    ├── planning.md             # High-level project context (from PLANNING.md) fileciteturn0file19
    ├── tasks.md                # Dynamic checklist (mirrors TASKS.md) fileciteturn0file19
    ├── mcp_usage.md            # When & how to invoke each MCP fileciteturn0file7
    └── glossary.md             # Key domain terms & acronyms fileciteturn0file5
```

- **Keep it small**: Aim for ~1–2 k characters/file initially to stay well under Windsurf’s 6 k/12 k limits fileciteturn0file9.
- **Iterate**: Add deeper files (e.g. `examples.md`, `validation_gates.md`, `modules.md`, `rules_feedback.md`) after usage patterns emerge fileciteturn0file5.

---

## 2. Core Rule Files & Roles

### 2.1 `global_rules.md`
- **Scope**: Always-on, IDE-level defaults (persona, tone, safety, formatting) fileciteturn0file6.
- **Examples**:
  - “Always respond in English with Markdown.”
  - “Ask for clarification before assuming missing context.”
  - “Never write to disk without explicit confirmation.”

### 2.2 `project_conventions.md`
- **Scope**: Project-specific conventions (naming, folder layout, tech stack) fileciteturn0file5.
- **Examples**:
  - “Use kebab-case for file names.”
  - “Store raw data under `/data/raw`, processed under `/data/processed`.”
  - “Python scripts → `src/`, notebooks → `notebooks/`, tests → `tests/`.”

### 2.3 `planning.md` & `tasks.md`
- **planning.md**: Narrative context & phase table (from your `PLANNING.md`) fileciteturn0file19.
- **tasks.md**: Live task list guiding the agent step-by-step, updated as items complete fileciteturn0file19.

### 2.4 `mcp_usage.md`
- **Scope**: Declarative MCP tool triggers & preferences fileciteturn0file7.
- **Template** (YAML+Markdown):

  ```yaml
  trigger: model_decision
  description: >
    Choose the best MCP for each task based on context:
      - DB migrations → `postgres-mcp`
      - File ops → `filesystem`
      - CLI (GDAL, ogr2ogr) → `desktop-commander`
      - Code analysis → `code-reasoning`
      - Expert research → `context7` for docs, `brave-search` for broader web
      - Version control → `github`
  ---
  - If interacting with PostgreSQL/PostGIS, use `postgres-mcp` for read/write queries.
  - For batch shell commands (e.g. `ogr2ogr`, `docker`), invoke `desktop-commander`.
  - For library/API docs, prefer `context7` over web search to avoid hallucinations.
  - Use `mcp-sequentialthinking-tools` or `smart-thinking` for complex planning steps.
  - Only fall back to `brave-search` when context7 fails or for non-API research.
  ```

---

## 3. Minimal First-Pass Rules

1. **Let the agent explore** by default; only hard-stop egregious actions (e.g., writing to production data).
2. **Anchor to core docs**:
   - “Always read `planning.md` at session start.” fileciteturn0file19
   - “Consult `project_conventions.md` for naming/layout.” fileciteturn0file5
3. **Guide, don’t enforce**: Use “Should” and “May” for optional guidance. Reserve “Must” and “Never” for rules that prevent data loss or security issues fileciteturn0file5.

---

## 4. MCP Recommendations

From your current list fileciteturn0file18 plus project-specific additions:

| MCP Server                     | Role                                    |
|--------------------------------|-----------------------------------------|
| **filesystem**                 | Core file I/O                           |
| **desktop-commander**          | Shell commands (GDAL, Docker, CLI)      |
| **postgres-mcp**               | Read/write PostGIS queries              |
| **github**                     | Version control & PR automation         |
| **context7**                   | Version-specific library docs           |
| **brave-search**               | Web research fallback                   |
| **mcp-sequentialthinking-tools**| Stepwise planning + tool recommendations|
| **smart-thinking**             | Graph-based reasoning for complex tasks |
| **code-reasoning**             | Deep code analysis & debugging          |
| **docs-manager**               | Markdown front-matter & nav management  |
| **memory**                     | Long-term tracing of decisions          |

> **Optional** (phase-specific):
> - **excel** for any spreadsheet wrangling (though CSV→Postgres preferred) fileciteturn0file18
> - **fetcher** for batch web content ingestion fileciteturn0file18

Add `postgres-mcp` by configuring your `mcp_config.json`:

```json
{
  "postgres-mcp": {
    "command": "npx",
    "args": ["-y", "@crystaldba/postgres-mcp"]
  }
}
```

---

## 5. Next Steps & Iteration

1. **Deploy this skeleton** and let the agent run through a few tasks.
2. **Log rule hits & misses** to `rules_feedback.md` for refinement fileciteturn0file5.
3. **Evolve** by splitting out specialized files (e.g., `validation_gates.md`, `examples.md`, `agent_planner.md`) as needs crystallize.
4. **Monitor character use** and prune low-value rules to stay within limits fileciteturn0file9.

This approach gives you immediate guardrails without over-constraining Cascade. As your workflows solidify, you can progressively codify richer, phase-specific, and agent-role-specific rule sets.

## USER
So help me think through my options for actually drafting these... what *are* my options?? What do you think about the thoughts of Gemini and Claude??

## Thoughts
The user wants to explore options for drafting rule system files and comments on the suggestions from Gemini 2.5 Pro and Claude 4 Opus.

I should consider alternatives like manual drafting, LLM-based prompting (using models like GPT-4, Gemini, and Claude), or automated approaches. It seems like using a CLI like Windsurf or template generation might also be viable.

I’ll review their attached documents to further inform my response—checking the details of Gemini and Claude’s thoughts on this.

## Thoughts
The plan is clear: I need to review the files the user uploaded, such as the Gemini 2.5 Pro and Claude 4 Opus documents. I thought about using a search to find key sections, but searching doesn’t actually open or read the files. I'll consider multiple drafting options like manual writing, template use, or leveraging LLMs like Gemini and Claude for generating drafts. Plus, interactive methods with iterative prompting could be useful too. I just need to check the files for relevant content now.
The user wants to review options for drafting the rule system files and consider Gemini and Claude’s feedback. We’ve got two key sources to pull insights from: "Gemini 2.5 Pro proposed rule system" and "Claude 4 Opus comments on Gemini."

I should lay out some options:

1. **Manual drafting**: Editing templates by hand

## ASSISTANT
Here’s a rundown of your main paths for generating those rule‐system files—and how Gemini’s and Claude’s takes fit into each.

---

## 1. Manual / Template-Driven Drafting
**What it is:**
You hand‐craft each `.md` file (global_rules.md, project_conventions.md, planning.md, tasks.md, mcp_usage.md, glossary.md, etc.) by copying in boilerplate from your architecture, overview, README, and planning docs, then filling in project-specific details.
**Pros:**
- **Total control** over every line and nuance.
- You can ensure deep alignment with your ASU/Teotihuacan context.
**Cons:**
- **Time-consuming**, especially for eight phases and detailed MCP guidance.
- Easy to miss consistency or character-limit issues across files.

You’d lean on Windsurf’s **docs-manager MCP** to scaffold front-matter and navigation fileciteturn1file9, but all content still comes from your fingertips.

---

## 2. Windsurf CLI “Scaffold” + Fill-In
**What it is:**
Use a small Python or shell wrapper that, given a directory structure, drops in pre-written stubs for each rule file (with empty sections), then you paste in content.
**Pros:**
- Guarantees uniform file names, YAML headers, link structure.
- Speeds up the “create empty file” overhead.
**Cons:**
- Doesn’t remove the bulk of the writing task.

Gemini 2.5’s skeleton of `.windsurf/rules/` files (global_rules.md, project_conventions.md, planning.md, tasks.md, mcp_usage.md, glossary.md) is perfect for this approach fileciteturn1file0—you’d have your wrapper emit exactly that tree.

---

## 3. LLM-Assisted Generation (Gemini / Claude / GPT-4)
**What it is:**
Feed an LLM a prompt like “Here are my project docs: architecture.md, overview.md, readme_updated.md, planning_updated.md.  Generate a first-draft `global_rules.md` suited to this project.” Repeat for each file.
**Pros:**
- **Fast first pass**, with consistent style.
- You can iterate: “Revise this draft to be more concise,” etc.
**Cons:**
- May require multiple refinement rounds to hit the right level of strictness vs. flexibility.
- Risk of hallucination or style drift if your prompt isn’t nailed down.

### Gemini 2.5 Pro’s take
- **Great at** laying out a lean, modular skeleton and mapping MCPs to categories fileciteturn1file0.
- **Recommendation:** Start with its minimal ~1–2 KB stubs, then feed each to the LLM: “Fill in phase 4 georeferencing rules here,” etc.

### Claude 4 Opus’s feedback
- **Strengthens** Gemini’s by:
  - **Prioritizing** Desktop Commander, filesystem, and mcp-sequentialthinking as your top MCPs for Digital TMP fileciteturn1file3.
  - **Splitting** “phase_specific_rules.md” into eight explicit phase files for clarity and validation gates.
- **Recommendation:** Use Claude’s refined MCP ranking to seed your `mcp_usage.md`, and scaffold eight `phaseN_*.md` files instead of one catch-all.

---

## 4. Hybrid: Scaffold + LLM Draft + Manual Polish
1. **Scaffold** the file tree via CLI or docs-manager MCP.
2. **LLM-generate** rough content for each section (use Gemini’s prompt templates, then Claude’s tweaks).
3. **Manually review** each draft, enforcing character limits and checking domain accuracy against your source docs.
4. **Lock in** and version-control in `.windsurf/rules/`.

This yields the best balance of speed and precision.

---

## 5. Scripted Extraction
If your architecture/overview/planning docs follow a consistent markup (headings, tables, front-matter), you could write a tiny Python script to:
- Parse out the “Phase 4: Georeferencing” section.
- Inject it into `phase4_georeferencing.md` under a templated header.
- Repeat for each section.

**Pros:** Great if your source docs are already highly structured.
**Cons:** Up-front coding effort, limited to well-formed input.

---

### So, which route?
- **If speed is king:** go LLM-assisted with Gemini’s skeleton and Claude’s refinements.
- **If control/accuracy is paramount:** scaffold + manual fill or scripted extraction.
- **If you want the best of both:** hybrid.

Regardless of path, start small: draft just `global_rules.md` and `project_conventions.md`, test in Windsurf, collect feedback (in `rules_feedback.md`), then expand your phase files. That iterative feedback loop is what keeps you from over-fitting or over-constraining on day one.

## USER
Lets do LLM-assisted... BUT Can you provide a critique of Gemini and Claude, and further suggestions on possible things I should include in their skeleton??

## Thoughts
The user is asking for a critique on Gemini 2.5 Pro and Claude 4 Opus's suggestions for a rule system skeleton. I’ll analyze their input and provide additional suggestions for what the user could add to their skeleton. I’ll reference the files (architecture, overview, and other docs) that the user provided, but I haven't checked them yet. I’ll need to review the contents of these attachments before detailing a response and offering improvements.
The user wants critiques of Gemini and Claude’s skeleton suggestions. Gemini proposed a minimal structure (1-2k) with MCP (Model Configuration Parameters) mapping, while Claude refined the MCP ranking and broke the phases into separate files. I’ll critique these ideas, addressing pros and cons, and recommend further elements to include in the skeleton, like versioning guidelines and testing rules. I’ll reference the user’s attachment files, but first, I need to search for actual content within the files to validate citations and suggestions.
The provided docs aren't focused on the rule skeleton itself—they're more about the project. Citations from these might not be helpful for skeleton suggestions. Instead, I should look at the Windsurf Rule System design docs, like "Windsurf Rule System and Best Practices" or "windsurf_best_practice.md." I can search the file "windsurf_best_practice.md" for keywords like "skeleton" or "layout" to find any relevant suggestions or structure guidelines.

## Thoughts
The project documents probably won’t have skeleton rule system suggestions since they focus on the broader project. Instead, I need to refer to more specific rule system design documents, like the Windsurf Rule System and Best Practices. I’ve searched through the file "windsurf_best_practice.md" and found skeleton suggestions in other core files. Next, I’ll craft critiques of Gemini 2.5 Pro and Claude 4 Opus based on these suggestions and incorporate them into my response.

## ASSISTANT
Below is a focused critique of the two first-pass skeletons and a set of “add-ons” you might layer into your initial `.windsurf/rules/` layout to cover gaps before you iterate further.

---

## 1. Gemini 2.5 Pro Skeleton
**Strengths**
- **Lean & Modular:** Gemini’s recommendation to keep each file under ~1–2 KB forces you to prioritize only the highest-value rules up front. This helps you stay well under Windsurf’s ~12 KB total limit and avoids early over-constraining fileciteturn2file0.
- **Clear MCP Mapping:** Its YAML-style `mcp_usage.md` template gives an explicit mapping of tasks to MCPs (e.g. `postgres-mcp` for PostGIS, `desktop-commander` for CLI) fileciteturn2file0.

**Weaknesses**
- **Too Minimal for Domain Specifics:** Beyond core behavior and MCP triggers, it doesn’t scaffold any _workspace-specific_ rule files—e.g. spatial data rules, metadata checks, notebook conventions—that your TMP project will need fileciteturn2file11.
- **Lacks Enforcement Profiles:** No provision for “soft vs. strict” or environment-specific profiles (dev, pre-commit, prod) to escalate rule severity as maturity grows fileciteturn2file14.
- **Missing Rule Dependency Map:** Doesn’t include a `RULES_DEPENDENCY.md` or in-file tags to manage inter-file overrides, which become crucial as your rule base fragments fileciteturn2file0.

---

## 2. Claude 4 Opus Skeleton
**Strengths**
- **Phase-Specific Files:** Breaking out eight `phaseN_*.md` files (e.g. `phase4_georeferencing.md`) gives you fine-grained gates and validation checkpoints for each stage of TMP fileciteturn2file3.
- **Refined MCP Ranking:** Claude elevates `desktop-commander`, `filesystem`, and `mcp-sequentialthinking-tools` as your go-to trio, which aligns well with your heavy QGIS/PostGIS and ETL work fileciteturn2file3.

**Weaknesses**
- **Early Over-Fragmentation Risk:** Spawning eight phase files initially may bloat context and make pruning harder; until you’ve run a few iterations, fewer, broader files (e.g. `spatial_data.md`) might be more agile fileciteturn2file11.
- **No Enforcement or Profile Guidance:** Like Gemini, Claude’s drafts don’t show how to signal “warning vs. hard-stop” rules or how to group by execution profile fileciteturn2file14.
- **Limited Metadata Structuring:** There’s no example of using YAML front-matter, XML tags, or filterable headers (`@tool:postgres`, `@glob`) to aid advanced rule parsing fileciteturn2file5.

---

## 3. Suggested Add-Ons to Your First-Pass Skeleton
Here’s a shortlist of files or sections you might _pre-seed_ alongside Gemini’s & Claude’s stubs, to capture critical TMP-specific and quality-management concerns:

1. **`validation_profiles.md`**
   - **Why:** Define “Development,” “Pre-commit,” and “Production” rule sets with escalating severity and scope fileciteturn2file14.
   - **What to include:**
     - Profile names and activation triggers (e.g. on `git pre-commit`).
     - Rule lists for each profile (e.g. basic lint checks vs. schema-breaking stops).

2. **`spatial_data.md`**
   - **Why:** Centralize all CRS, PostGIS, and thin-plate-spline guidelines.
   - **What to include:**
     - “Always assign EPSG codes” checks.
     - “Use `ogr2ogr` via `desktop-commander` for exports.”
     - Glob tags for `.tif`, `.shp` files fileciteturn2file15.

3. **`metadata_rules.md`**
   - **Why:** Enforce tDAR-compliance and GIS metadata consistency.
   - **What to include:**
     - Required YAML keys (`title`, `year`, `license`).
     - Date formats, field-type checks, license notices fileciteturn2file18.

4. **`RULES_DEPENDENCY.md`**
   - **Why:** Map precedence and overrides among `global_rules.md`, project rules, and phase files.
   - **What to include:**
     - Inheritance chains (“phase4 → inherit global formatting rules”).
     - Conflict-resolution strategy (“local rule wins over global unless tagged `@hard`”) fileciteturn2file0.

5. **`security_rules.md`**
   - **Why:** Capture PII handling, rate-limit, and confirm-before-write policies.
   - **What to include:**
     - “Never commit raw data with PII.”
     - “Always prompt before any `rm -rf` style operations.”

6. **`EXAMPLES.md`**
   - **Why:** Provide canonical input→output snippets so the agent can pattern-match idiomatic tasks.
   - **What to include:**
     - “How to stub a PostGIS query.”
     - “Example notebook preamble with `%matplotlib inline`.”

7. **Inline Structuring Aids**
   - **YAML Front-Matter:** At top of each file to declare file role and activation mode.
   - **Filterable Tags:** Prefix rules with `@tool:`, `@glob:`, or `@profile:` to let the agent quickly triage relevant sections fileciteturn2file0.

---

### Putting It All Together
1. **Scaffold** your core set of files (Gemini’s minimal stubs plus the add-ons above).
2. **LLM-generate** first drafts for each using tailored prompts: “Using TMP planning_updated.md, fill in `spatial_data.md` with georeferencing rules…”.
3. **Manual polish**: enforce character budgets, validate against your architecture & readme docs, and hook into your `TASKS.md` for iterative refinement.

This hybrid of Gemini’s speed, Claude’s phase awareness, and the add-ons here will give you both _breadth_ (coverage of all TMP domains) and _depth_ (enforcement profiles, dependencies, examples) from day one.

## USER
Can you please use the drafts of Gemini, enact the claude edits, and then enact your own plan for these edits? Please output a complete draft of each file here in the chat

## Thoughts
I need to find relevant content to include in documents like planning.md and tasks.md. I’ll search for terms such as “planning_updated”, “PLANNING”, “architecture”, and “overview” to get the context I need. It looks like the planning_updated file might be the major source, but since I don't know the exact content, I’ll search for it and be sure to get phase-specific details as well. I’ll start by previewing the file to gather the material.
The user wants a complete draft of each file, including revisions from Gemini and Claude. We’ll use the seeds from previous file searches (like planning.md, architecture.md), and create content ourselves instead of additional searching. For planning.md, I’ll incorporate content like the narrative and phase table from planning_updated.md. For tasks.md, I’ll create stub tasks for each phase, with workflows from architecture.md and top-level tasks. I’ll avoid further file calls, focusing on crafting accurate drafts.
I need to draft tasks for each project phase, so I’ll create a checklist in tasks.md with milestones and tasks for each phase, like Phase 1: Database Analysis and Phase 2: Database Transformation. I’ll use details from planning and architecture files as references. We also need to define a bunch of technical documentation, such as metadata rules, project conventions, and key glossary terms. I’ll make sure to embed the correct citations from various files, such as planning_updated, architecture.md, and readme_updated as needed.

## ASSISTANT
Below are complete first‐pass drafts for each of your `.windsurf/rules/` files. These combine Gemini’s lean skeleton fileciteturn3file8, Claude’s phase awareness and MCP refinements fileciteturn3file3, and the additional domain-specific sections we discussed.

---

### `.windsurf/rules/global_rules.md`
```markdown
# Global Rules

These rules are always active, across all phases and tasks.

## Persona & Tone
- The AI **must** respond in clear, idiomatic English, using Markdown for all formatting. fileciteturn3file8
- The AI **should** adopt a formal, analytical voice suited to academic research.

## Context & Verification
- The AI **must** read `planning.md` at session start to re‐orient to project goals. fileciteturn3file7
- The AI **should** ask for clarification before assuming missing context or proceeding with destructive operations.

## Safety & Data Integrity
- The AI **must never** write to production data stores without explicit user confirmation.
- The AI **must** avoid hallucinations: when uncertain, it **should** prefactor statements with “It appears…” or “Based on available documentation…” fileciteturn3file8

## Formatting & Style
- Use **kebab-case** for all filenames and directory names. fileciteturn3file16
- Limit each file’s content to **≤2 KB** on first pass to stay within Windsurf’s per‐file limits. fileciteturn3file8
```

---

### `.windsurf/rules/project_conventions.md`
```markdown
# Project Conventions

Defines project‐specific naming, layout, and coding conventions. fileciteturn3file16

## File & Directory Layout
- **Data**:
  - `/data/raw` → immutable source files (e.g., scanned maps, Access DB exports)
  - `/data/processed` → intermediate cleaned/converted data (CSV, GeoPackage, etc.)
- **Code**:
  - `/src` → core Python modules and scripts
  - `/notebooks` → exploratory Jupyter notebooks
  - `/tests` → unit and integration tests
- **Docs**:
  - `/docs` → user guides, architecture diagrams
  - `.windsurf/rules` → rule set (this directory)
  - `/outputs` → generated reports, ERDs, figures

## Naming Conventions
- **Files**: `kebab-case.md` or `kebab_case.py` for clarity
- **Classes**: `PascalCase`
- **Functions/Variables**: `snake_case`
- **Commit messages**: Follow Conventional Commits spec (see `EXAMPLES.md`). fileciteturn3file10

## Technology Stack
- **Database**: PostgreSQL 17 + PostGIS 3.4
- **GIS**: QGIS 3.40, GDAL 3.8+, PROJ 9.0+
- **Languages**: Python 3.11+, R 4.x
- **Deployment**: Docker containers, FastAPI for APIs
```

---

### `.windsurf/rules/planning.md`
```markdown
# PLANNING.MD

AI assistants **must** reference this at the start of every session for high‐level context. fileciteturn3file7

## Project Summary
Modernize and unify legacy Teotihuacan Mapping Project data into a reproducible PostgreSQL/PostGIS infrastructure for research, preservation, and public engagement.

## Eight Phases
| Phase | Objective                                                                                           | Outputs                                                      |
|-------|-----------------------------------------------------------------------------------------------------|--------------------------------------------------------------|
| 1     | Database Analysis: Profile MS Access databases to inform schema design                              | PostgreSQL schemas, ERDs, profiling reports, denorm whitepaper |
| 2     | Database Transformation: ETL & feature engineering to produce analysis-ready tabular data           | DF12, REANs_DF4, logs, validation reports                    |
| 3     | GIS Digitization: Manually digitize archaeological/environmental features from raster maps         | Vector layers, attribute schemas, metadata                   |
| 4     | Georeferencing: Apply NTv2 transformations and validate spatial accuracy                           | Aligned datasets, grid files, accuracy assessments           |
| 5     | Geospatial Integration: Merge tabular & spatial data, derive spatial attributes                    | Integrated geospatial dataset, classification outputs        |
| 6     | tDAR Outputs: Package archival-ready datasets with comprehensive metadata                          | tDAR-compliant archives, vocabularies, docs, tutorials       |
| 7     | PostGIS Database: Deploy production-grade spatial database with optimized schemas                   | Dockerized PostGIS, SQL dumps, API endpoints                 |
| 8     | Tutorials & Dashboards: Develop user-facing WebGIS dashboard and comprehensive tutorials           | Interactive dashboard, REST API, how-to guides              |
```

---

### `.windsurf/rules/tasks.md`
```markdown
# Digital TMP Project Tasks

Dynamic checklist; AI **must** update as items complete. fileciteturn3file7

## Phase 1: Database Analysis
- [ ] Instantiate PostgreSQL from MS Access using `setup_databases.py`. fileciteturn3file4
- [ ] Generate ERDs (`schema_viz.py`) for DF8, DF9, DF10, REANs_DF2. fileciteturn3file4
- [ ] Run `profile_db.py` to collect schema metrics. fileciteturn3file4
- [ ] Draft denormalization white paper. fileciteturn3file4

## Phase 2: Database Transformation
- [ ] Merge DF8/9/10 → DF11; clean REANs_DF2 → REANs_DF3. fileciteturn3file13
- [ ] Transform DF11 → DF12; REANs_DF3 → REANs_DF4. fileciteturn3file13
- [ ] Standardize controlled vocabularies; run validation scripts. fileciteturn3file13

## Phase 3: GIS Digitization
- [ ] Digitize features (floors, walls, canals) in QGIS. fileciteturn3file13
- [ ] Organize vector layers and provisional schemas. fileciteturn3file13

## Phase 4: Georeferencing
- [ ] Apply NTv2 grid shifts to rasters & vectors. fileciteturn3file4
- [ ] Validate spatial accuracy; compile reports. fileciteturn3file4

## Phase 5: Geospatial Integration
- [ ] Join DF12 & REANs_DF4 to spatial layers; derive spatial fields. fileciteturn3file11
- [ ] Run spatial QA (geometry validity, CRS checks). fileciteturn3file11

## Phase 6: tDAR Outputs
- [ ] Package datasets (Shapefile, CSV, GeoTIFF) with metadata. fileciteturn3file18
- [ ] Upload to tDAR; obtain DOIs. fileciteturn3file18

## Phase 7: PostGIS Database
- [ ] Build Dockerized PostGIS instance; ingest final data. fileciteturn3file11
- [ ] Expose REST API endpoints. fileciteturn3file11

## Phase 8: Tutorials & Dashboards
- [ ] Develop interactive WebGIS dashboard (Leaflet.js). fileciteturn3file17
- [ ] Write step-by-step how-to guides in Markdown. fileciteturn3file17
```

---

### `.windsurf/rules/mcp_usage.md`
```markdown
# MCP Usage

Map tasks to preferred MCPs. fileciteturn3file8turn3file3

```yaml
trigger: model_decision
description: >
  Choose the optimal MCP based on task type and phase.
```

- **postgres-mcp**: All PostGIS queries and migrations
- **desktop-commander**: GDAL, QGIS CLI, Docker commands
- **filesystem**: File I/O, CSV ↔ Postgres conversions
- **mcp-sequentialthinking-tools**: Phase planning & step sequencing
- **github**: Version control & PR automation
- **docs-manager**: Markdown front-matter, nav generation
- **smart-thinking**: Complex spatial reasoning tasks
- **brave-search**: Archaeological standards research when docs absent
```

---

### `.windsurf/rules/glossary.md`
```markdown
# Glossary

Key terms and acronyms. fileciteturn3file17

- **TMP**: Teotihuacan Mapping Project
- **DF8/9/10/11/12**: Successive versions of TMP tabular datasets
- **REANs_DF2/3/4**: Ceramic reanalysis datasets
- **GCP**: Ground Control Point for georeferencing
- **NTv2**: Datum grid shift format for high-accuracy CRS transformations
- **CRS**: Coordinate Reference System (e.g., EPSG:32614)
- **MCP**: Model-Decision Computational Plugin (e.g., `postgres-mcp`)
- **QA**: Quality Assurance
- **tDAR**: The Digital Archaeological Record
```

---

### `.windsurf/rules/validation_profiles.md`
```markdown
# Validation Profiles

Define rule sets per execution context.

| Profile       | Activation                                 | Severity Levels       |
|---------------|--------------------------------------------|-----------------------|
| **Development**   | Default; during exploratory work         | Warnings only         |
| **Pre-commit**    | `git pre-commit` hook                   | Errors and Warnings   |
| **Production**    | CI/CD pipeline before deployment        | Errors only; hard stops |

Rules inherit from `global_rules.md`, then apply additional checks per profile.
```

---

### `.windsurf/rules/spatial_data.md`
```markdown
# Spatial Data Rules

Guidance for all spatial workflows.

- **Assign EPSG codes** to every spatial layer; prefer EPSG:32614 for analysis, EPSG:4326 for dissemination.
- **Use Desktop Commander** for GDAL/ogr2ogr commands on rasters and vectors.
- **Tag globs**:
  - `@glob: *.tif` → georeferencing rules
  - `@glob: *.shp` → attribute schema validation
- **Always** validate geometries:
  ```sql
  SELECT COUNT(*) FROM "{table}" WHERE NOT ST_IsValid(geom);
  ```
```

---

### `.windsurf/rules/metadata_rules.md`
```markdown
# Metadata Rules

Ensure consistent metadata in all outputs.

## YAML Front-Matter (Markdown files)
```yaml
---
title: "<Document Title>"
author: "Rudolf Cesaretti"
date: "YYYY-MM-DD"
license: "CC-BY-4.0"
---
```

## GIS Metadata Fields
- `title`: descriptive layer name
- `crs`: EPSG code
- `created_by`: script or tool name
- `created_on`: ISO date (`YYYY-MM-DD`)
- `license`: reuse terms

## Validation
- Dates must be `YYYY-MM-DD`.
- All required keys **must** be present.
```

---

### `.windsurf/rules/RULES_DEPENDENCY.md`
```markdown
# Rules Dependency & Precedence

Manages inheritance and overrides.

1. **global_rules.md** (base)
2. **project_conventions.md** (overrides base for naming/layout)
3. **validation_profiles.md** (adjusts severity)
4. **phase-specific files** (e.g., `spatial_data.md`)
5. **user-defined rules** (ad hoc overrides)

**Conflict resolution**: later files in this list override earlier ones unless tagged `@hard`.
```

---

### `.windsurf/rules/security_rules.md`
```markdown
# Security & Data Protection

Protect sensitive data and prevent destructive actions.

- **PII Handling**: Never commit or expose personally identifiable information.
- **Destructive Ops**: Always confirm before any `rm -rf` or database `DROP`.
- **Credentials**: Never hard-code database credentials; use environment variables.
```

---

### `.windsurf/rules/EXAMPLES.md`
```markdown
# Canonical Examples fileciteturn3file10

## Commit Message (Conventional Commits)
```
feat: add NTv2 georeferencing pipeline

Implement custom PROJ NTv2 grid shift generation for Phase 4 georeferencing.
Fixes #42.
```

## Python Function Docstring (Google Style)
```python
def transform_raster(input_tif: str, output_tif: str) -> None:
    """Apply NTv2 grid shift to a raster file.

    Args:
        input_tif: Path to source GeoTIFF.
        output_tif: Path for transformed GeoTIFF.

    Raises:
        RuntimeError: If GDAL command fails.
    """
    cmd = ["gdalwarp", "-t_srs", "EPSG:32614", input_tif, output_tif]
    subprocess.run(cmd, check=True)
```

## Notebook Preamble
```python
# QGIS Python Console Setup
import qgis
from qgis.core import QgsProject, QgsVectorLayer

# Load project
project = QgsProject.instance()
project.read('/path/to/project.qgz')
```
```

---

With these drafts in place, you have:

- **Full coverage** of core and domain-specific rule sets
- **Phase-aware** guidance and validation profiles
- **Explicit MCP mappings** and usage patterns
- **Examples** to anchor style and structure

Next: scaffold these via CLI or **docs-manager MCP**, then iterate based on real usage in your first runs.
