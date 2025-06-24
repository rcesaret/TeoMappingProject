---
trigger: manual
---

# MCP

## MCP INTERACTION
- You have access to external tools via the Model Context Protocol (MCP). Your use of these tools must be transparent, efficient, and safe. All tool usage must be directly related to an action in the current `plan` file.

## TOOL SELECTION
- You MUST always prefer a specialized tool over a general-purpose one if it is available and applicable.
  - For authoritative library/API documentation: `Context7` is the primary choice.
  - For general web research, current events, or community discussions: `Brave-Search` is the primary choice.
  - For local file system operations: `Filesystem` MCP is the primary choice.
  - For repository interactions: `GitHub` MCP is the primary choice.
- When your plan involves invoking an MCP tool, you must briefly state which tool you are using and provide a rationale for why it is the correct choice for the current task. For example: "Using `Context7` to retrieve the official documentation for the `pandas.DataFrame.merge` method to ensure accuracy."

## PARAMETERIZATION & RESOURCE MANAGEMENT
- You have a hard limit of 20 tool calls per prompt session. You MUST manage this budget with extreme efficiency.
- Prioritize critical calls that unblock the primary task.
- If a task requires more than 20 calls, you MUST halt and propose to the user a new, broken-down `plan` that splits the task into multiple, manageable execution sessions.
- You MUST set conservative token limits on tool calls that return natural language to avoid excessive context usage and cost.
- Default: `max_tokens: 4096` for documentation lookups.
- Adjust this value down for simpler lookups or up if more context is explicitly required by the plan.
- For any tool that modifies state (e.g., `GitHub` MCP push, `Filesystem` MCP write), you MUST default to `dry_run: true` mode first to preview the changes. The plan must include a separate step for the user to approve the execution with `dry_run: false`.
- For all network-dependent tools (e.g., `Context7`, `Brave-Search`), you MUST use a reasonable `timeout` parameter (e.g., 30 seconds) to prevent the workflow from hanging.

## FALLBACK & ERROR HANDLING
- For critical information retrieval, you MUST define and use fallback chains.
- Standard Chain: If the primary tool (e.g., `Context7`) fails or returns insufficient results, you should attempt a secondary tool (e.g., `Brave-Search`). If both fail, consult local documentation via the `Filesystem` MCP if available.
- If a tool call fails, you MUST halt the current action. You must report the failure clearly to the user, including any error messages or status codes returned by the tool. Do not proceed with the plan until the user provides guidance.
- Before invoking any MCP tool, you MUST perform a sanity check on the inputs. For example, verify that a URL is well-formed before passing it to `Fetcher`, or that a file path exists before passing it to `Filesystem`.

## TOOL INTEGRATION
- When a plan requires chaining multiple tools (e.g., using a `Filesystem` tool to read a file, then passing its content to a `Code-Reasoning` tool), you must explicitly define the data flow in your execution plan, showing how the output of one tool becomes the input of the next.
- For MCP tools that retrieve static information (e.g., documentation for a specific library version), you should propose caching the result locally to a temporary file to avoid re-fetching the same data within the same session, respecting the 20-call limit.
- Before executing a tool that modifies the file system or external state, you must state the permissions required and ask the user to confirm that those permissions are granted.

## ARCHAEOLOGICAL DATA PROJECT CONSIDERATIONS
- When using `Context7` for geospatial library documentation, prioritize authoritative sources like GDAL, PostGIS, and GeoPandas official documentation.
- For research tasks related to archaeological data standards or tDAR requirements, use `Brave-Search` to find current best practices and metadata schemas.
- When using `GitHub` MCP for version control operations, ensure that large data files (>100MB) are properly handled with Git LFS to avoid repository bloat.
- For database-related tool usage, always verify connection parameters and use read-only access when possible to prevent accidental data modification.

## SECURITY & VALIDATION
- Never pass sensitive information (passwords, API keys, personal data) as parameters to external tools unless absolutely necessary and explicitly approved.
- When using tools to download or fetch external content, implement basic validation to ensure the content is safe and expected.
- For tools that interact with file systems, operate only within the project directory structure unless explicitly authorized to access other areas.
- Validate tool outputs before using them as inputs to subsequent operations, especially for tools that return structured data or code.

## TOOL CONFIGURATION & MANAGEMENT
- When a task requires a new MCP tool not present in `mcp_config.json`, you must first search for an official implementation, then propose the necessary JSON configuration block for `mcp_config.json` and await user approval before attempting to use the tool.
- Before passing any complex data (e.g., a large JSON object, a user-generated string) as input to an MCP tool, you must first validate it against the tool's expected schema or format. If the input is invalid, report the error instead of calling the tool.
- Maintain awareness of tool capabilities and limitations, and choose the most appropriate tool for each specific task rather than defaulting to general-purpose options.
