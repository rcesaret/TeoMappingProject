---
trigger: model_decision
---

# MCP USAGE

Choose the best MCP for each task based on context:
- DB migrations → `postgres-mcp`
- File ops → `filesystem`
- CLI (GDAL, ogr2ogr) → `desktop-commander`
- Code analysis → `code-reasoning`
- Expert research → `context7` for docs, `brave-search` for broader web
- Version control → `github`


- If interacting with PostgreSQL/PostGIS, use `postgres-mcp` for read/write queries.
- For batch shell commands (e.g. `ogr2ogr`, `docker`), invoke `desktop-commander`.
- For library/API docs, prefer `context7` over web search to avoid hallucinations.
- Use `mcp-sequentialthinking-tools` or `smart-thinking` for complex planning steps.
- Only fall back to `brave-search` when context7 fails or for non-API research.
