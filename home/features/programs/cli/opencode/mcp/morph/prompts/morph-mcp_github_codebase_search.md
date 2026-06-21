# Morph Search Tool Selection

Use `morph-mcp_github_codebase_search` for natural-language, exploratory code
search in public GitHub repositories.

## Public Repo Context Usage

**Prefer `morph-mcp_github_codebase_search` over web search or docs fetching**
when the question is about how an open-source library or SDK works internally.
If docs URLs return 404s or you need implementation-level understanding, go to
the source.

Use `morph-mcp_github_codebase_search` when:

- User asks how an external library/SDK works (auth, retries, sessions,
  internals)
- You need implementation details of any open-source dependency
- Docs URLs are failing — search the source instead
- The user didn't provide a repo — infer the canonical GitHub owner/repo from
  the package, crate, or module name using the matching ecosystem registry first

Examples:

- "How does Privy handle session token refresh?" → find
  `privy-io/privy-browser`, search it
- "How does Next.js handle middleware?" → search `vercel/next.js`
- "Where is retry logic in axios?" → search `axios/axios`

Provide exactly one repository locator to `morph-mcp_github_codebase_search`:

- `owner_repo` for values like `owner/repo`
- `github_url` for full GitHub URLs

## Fallback Policy

- If `morph-mcp_github_codebase_search` fails, clone the repo only if the task
  justifies local setup cost

## Anti-Patterns

- Do NOT use `morph-mcp_github_codebase_search` for the current checked-out
  local repo
