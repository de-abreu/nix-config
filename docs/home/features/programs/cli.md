# CLI Programs

> **Config:** `home/features/programs/cli/` **Purpose:** Command-line tool
> configurations

## Overview

This directory contains configurations for various CLI tools.

## Tools Configured

| Tool      | Purpose                      |
| --------- | ---------------------------- |
| bat       | Cat with syntax highlighting |
| bottom    | System monitor               |
| eza       | Modern ls replacement        |
| fastfetch | System info display          |
| fd        | Fast find                    |
| gpg       | GnuPG configuration          |
| lazygit   | Git TUI                      |
| nh        | Nix helper                   |
| tealdeer  | TLDR client                  |

## Structure

```
cli/
├── bat.nix        # Cat replacement
├── bottom.nix     # System monitor
├── eza.nix        # Ls replacement
├── fastfetch.nix  # System info
├── fd.nix         # Find replacement
├── gpg.nix        # GPG keys
├── lazygit.nix    # Git TUI
├── nh.nix         # Nix helper
└── tealdeer.nix   # TLDR client
```

## Adding New CLI Tool

1. Create `home/features/programs/cli/<tool>.nix`
2. Use Home Manager `programs.<tool>` options

## References

- [Home Manager Appendix A](https://nix-community.github.io/home-manager/options.xhtml) -
  Program options

## DetailedDocumentation

- [nixvim.md](nixvim.md) - Complete Neovim configuration with all plugins

