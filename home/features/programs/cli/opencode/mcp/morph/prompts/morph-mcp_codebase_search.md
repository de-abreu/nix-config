# Morph Search Tool Selection

Use `morph-mcp_codebase_search` for natural-language, exploratory code search in
the local codebase.

## Codebase Search Usage

Use `morph-mcp_codebase_search` for semantic, exploratory searches:

- "Find the authentication flow"
- "How does error handling work in the API layer"
- "Where is the database connection configured"

Do NOT use it for exact keyword lookups (function names, variable names, error
strings). Use `grep` or `read` for those.

## Fallback Policy

- If `morph-mcp_codebase_search` fails, fall back to `grep` + `read`

## Anti-Patterns

- Do NOT use `morph-mcp_codebase_search` for exact string/keyword lookups
