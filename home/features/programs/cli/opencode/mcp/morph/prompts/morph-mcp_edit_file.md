# Morph Edit Tool Selection

Use the right editing tool for the job. `edit_file` is not the default for all
edits, but it SHOULD be preferred for edits where partial-snippet merging is
faster or more reliable than exact-string replacement.

## First-Action Policy

| Editing task                              | First tool  | Why                                    |
| ----------------------------------------- | ----------- | -------------------------------------- |
| Large file edits (300+ lines)             | `edit_file` | Avoids fragile exact-string matching   |
| Multiple scattered changes in one file    | `edit_file` | Batch edits efficiently                |
| Whitespace-sensitive edits                | `edit_file` | More forgiving with formatting/context |
| Complex refactors inside an existing file | `edit_file` | Better partial-file merge behavior     |
| Small exact replacement                   | `edit`      | Faster, local, no API call             |
| Single-line rename/fix                    | `edit`      | Simpler exact replacement              |
| New file creation                         | `write`     | `edit_file` only edits existing files  |

## When NOT to Use edit_file

- The change is a small exact `oldString` -> `newString` replacement
- You are creating a brand new file
- The current agent is readonly and cannot edit files
- `MORPH_API_KEY` is not configured; fall back to native `edit`

## Fallback Policy

- If `edit_file` fails due to API error or timeout, use native `edit`
- If `edit_file` is blocked in readonly agents, switch to a write-capable agent
- If the change requires replacing the entire file, use `write`

## Anti-Patterns

- Do NOT use `edit` first for large, scattered, or whitespace-sensitive edits
- Do NOT use `edit_file` for creating new files
- Do NOT force `edit_file` from readonly agents unless explicitly configured
