# Nixvim (Neovim Configuration)

> **Config:** `home/features/programs/cli/nixvim/` **Keymaps:**
> `home/features/keymaps/abnt2/nixvim/` **Theme:**
> `home/features/desktop-environment/stylix/ayu-mirage-theme/overrides/nixvim.nix`
> **Purpose:** Declarative Neovim configuration using nixvim

## Overview

Nixvim is used to configure Neovim declaratively via Nix. This configuration is
modular, with plugins organized by category (completion, LSP, navigation, UI,
etc.).

## Entry Points

| File                    | Purpose                                |
| ----------------------- | -------------------------------------- |
| `default.nix`           | Enables nixvim, sets as default editor |
| `settings/default.nix`  | Core settings (lua loader, clipboard)  |
| `settings/opts.nix`     | Vim options (82 lines of settings)     |
| `settings/lsp.nix`      | LSP configuration                      |
| `keymaps/abnt2/nixvim/` | ABNT2 keyboard keymaps                 |

## Vim Options Summary

| Category        | Settings                                                      |
| --------------- | ------------------------------------------------------------- |
| **Clipboard**   | Uses system clipboard (`unnamedplus`)                         |
| **Indentation** | 2-space tabs, expand tab, preserve indent                     |
| **Search**      | Smart case, incremental search, highlight                     |
| **UI**          | Relative line numbers, cursorline, global statusline          |
| **Performance** | 100ms updatetime, lazy redraw disabled, syntax limit 240 cols |
| **Files**       | Undo file enabled, no swap/backup files                       |
| **Spelling**    | en_us, pt_br, ro dictionaries                                 |

---

## Plugin Categories

### Completion (`plugins/completion/`)

| Plugin        | Purpose                                                                                                                                 |
| ------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| **blink-cmp** | Fast completion engine with LSP, snippet, and buffer sources. Features smart direction menu, ghost text, auto-brackets, signature help. |
| **luasnip**   | Snippet engine for code snippets                                                                                                        |

**Sourcesconfigured (blink):**

- LSP (`lsp`)
- Snippets (`luasnip`)
- Buffer words (`words`)
- Community plugins via compatibility layer

### LSP (`plugins/lsp/`)

| Plugin           | Purpose                                       |
| ---------------- | --------------------------------------------- |
| **lspconfig**    | Language Server Protocol configuration        |
| **conform-nvim** | Code formatter with format-on-save            |
| **lint**         | Asynchronous linter integration               |
| **fastaction**   | Fast code actions                             |
| **neoconf**      | Local LSP settings per project                |
| **otter**        | LSP for embedded languages (e.g., JS in HTML) |
| **mini.ai**      | Enhanced text objects                         |

**Formatters configured:**

- `squeeze_blanks`, `trim_whitespace`, `trim_newlines` for all filetypes
- Biome for JS/TS with editorconfig support

### Treesitter (`plugins/treesitter/`)

| Plugin                     | Purpose                                                                                                                   |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| **treesitter**             | Syntax highlighting, indentation, textobjects. Excludes large unused grammars (agda, cuda, fortran, haskell, julia, etc.) |
| **treesitter-context**     | Shows context (function signature) at top of screen                                                                       |
| **treesitter-textobjects** | Text objects based on treesitter nodes                                                                                    |
| **treesitter-refactor**    | Refactoring tools (rename, highlight references)                                                                          |
| **ts-comments**            | Context-aware comment strings                                                                                             |

### Navigation (`plugins/navigation/`)

| Plugin                       | Purpose                                    |
| ---------------------------- | ------------------------------------------ |
| **yazi**                     | Terminal file manager integration          |
| **flash**                    | Fast jump to any location                  |
| **smart-splits**             | Seamless window/split navigation           |
| **snacks** (picker/explorer) | Fuzzy finder, file explorer, buffer picker |
| **beacon**                   | Show cursor position after jump            |

### UI (`plugins/ui/`)

| Plugin                 | Purpose                                                       |
| ---------------------- | ------------------------------------------------------------- |
| **alpha**              | Dashboard start screen with custom buttons                    |
| **bufferline**         | Tab/buffer bar with diagnostics, grouped bytype (Tests, Docs) |
| **lualine**            | Status line                                                   |
| **which-key**          | Shows available keybindings                                   |
| **noice**              | Enhanced command line and messages                            |
| **fidget**             | LSP progress spinner                                          |
| **illuminate**         | Highlight same word under cursor                              |
| **barbecue**           | LSP context in winbar                                         |
| **mini-icons**         | Icon set for UI                                               |
| **image.nvim**         | Image rendering in terminal                                   |
| **ufo**                | Code folding                                                  |
| **indent-snacks**      | Indent guides                                                 |
| **precognition**       | Hint available motions                                        |
| **lightbulb**          | Show available code actions                                   |
| **diagnostic**         | Diagnostic virtual text                                       |
| **notifier**           | Notification manager                                          |
| **opencode**           | Integration with opencode CLI                                 |
| **rainbow-delimiters** | Colored brackets matching                                     |

### Git (`plugins/git/`)

| Plugin           | Purpose                                          |
| ---------------- | ------------------------------------------------ |
| **gitsigns**     | Git signs in sign column, blame, hunk navigation |
| **git-conflict** | Git conflict markers and resolution              |

### Editor (`plugins/editor/`)

| Plugin            | Purpose                                                     |
| ----------------- | ----------------------------------------------------------- |
| **surround**      | Add/change/delete surrounding characters (quotes, brackets) |
| **trim**          | Automatically trim trailing whitespace                      |
| **neogen**        | Generate documentation comments                             |
| **img-clip**      | Paste images into markdown                                  |
| **yanky**         | Yank history manager                                        |
| **lz-n**          | Lazy loading system                                         |
| **cutlass**       | Cut without yanking                                         |
| **firenvim**      | Neovim in browser textareas                                 |
| **flatten**       | Open files in existing instance                             |
| **better-escape** | Escape with jk/jj                                           |
| **autopairs**     | Auto-close brackets, quotes                                 |
| **hardtime**      | Discourage bad vim habits                                   |
| **spider**        | Move by sub-word (camelCase, snake_case)                    |
| **tabular**       | Align text by pattern                                       |
| **grug-far**      | Find and replace with picker                                |

### Development (`plugins/dev/`)

| Plugin       | Purpose                 |
| ------------ | ----------------------- |
| **trouble**  | Diagnostics list viewer |
| **profiler** | Neovim startup profiler |

### Debugging (`plugins/debugger/`)

| Plugin     | Purpose                                              |
| ---------- | ---------------------------------------------------- |
| **dap**    | Debug Adapter Protocol - breakpoints, stepping, REPL |
| **dap-ui** | UI for debugging sessions                            |

### Language Support (`plugins/language-support/`)

| Language     | Features                    |
| ------------ | --------------------------- |
| **nix**      | LSP, formatting, treesitter |
| **lua**      | LSP, formatting, treesitter |
| **cpp**      | LSP, DAP, treesitter        |
| **markdown** | LSP, preview, treesitter    |

---

## Key Configuration Files

### blink-cmp (`completion/blink/default.nix`)

- Smart direction menu (opens above when multiline completion)
- Ghost text for preview
- Auto-brackets for Lua and Nix
- Signature help window
- Prefetch on insert, show on backspace

### conform-nvim (`lsp/conform.nix`)

- Format on save (configurable per buffer)
- Default formatters for all filetypes
- `:Format` command forrange formatting
- Integrates with lz-n for lazy loading

### gitsigns (`git/gitsigns.nix`)

- Lazy loaded on `DeferredUIEnter`
- Only enabled if git is enabled
- Shows git signs in sign column

### bufferline (`ui/bufferline.nix`)

- Tabs grouped by file type (Tests, Docs)
- Diagnostic indicators
- Sorted by extension

---

## Lazy Loading Strategy

Most plugins use `lz-n` for lazy loading via events:

| Event                | Plugins             |
| -------------------- | ------------------- |
| `DeferredUIEnter`    | gitsigns, which-key |
| `BufReadPre`         | bufferline          |
| `BufWritePre`        | conform-nvim        |
| Cmd (`:Yazi`)        | yazi                |
| Cmd (`:DapContinue`) | dap                 |

---

## Keymaps Structure

Keymaps are in `home/features/keymaps/abnt2/nixvim/`:

```
keymaps/abnt2/nixvim/
├── default.nix       # Leader keys
├── general.nix       # General keymaps
├── movement.nix      # Movement keymaps
├── search.nix        # Search keymaps
├── comments.nix      # Comment keymaps
├── lsp.nix           # LSP keymaps
└── plugins/          # Plugin-specific keymaps
    ├── blink.nix
    ├── dap.nix
    ├── snacks/
    └── ...
```

---

## Dependencies

- **Inputs:** `nixvim` flake input
- **Theme:** Stylix `ayu-mirage-theme` override
- **External:** Tree-sitter grammars (excludes large unused ones)

## References

- [Nixvim Documentation](https://nix-community.github.io/nixvim/)
- [Nixvim Options](https://nix-community.github.io/nixvim/options/)
- [Neovim Documentation](https://neovim.io/doc/)
- [Blink-cmp](https://github.com/Saghen/blink.cmp)
- [Conform-nvim](https://github.com/stevearc/conform.nvim)
- [Gitsigns](https://github.com/lewis6991/gitsigns.nvim)

