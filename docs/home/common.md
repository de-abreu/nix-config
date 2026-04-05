# Home Common

> **Config:** `home/common/` **Purpose:** Shared Home Manager configuration
> applied to all users

## Overview

The `home/common/` directory contains Home Manager modules that apply to all
users on the system.

## Modules

| File               | Purpose                                                       |
| ------------------ | ------------------------------------------------------------- |
| `default.nix`      | Auto-imports all modules in the directory                     |
| `flakePath.nix`    | Sets `_module.args.flakePath` to the config location          |
| `mimeAppsList.nix` | Forces MIME type associations to be managed declaratively     |
| `opencode.nix`     | Configures OpenCode AI agent with NixOS-specific instructions |

## Key Patterns

### Flake Path Module

```nix
_module.args.flakePath = "${config.xdg.configHome}/nix-config";
```

This makes `flakePath` available as a module argument throughout the
configuration.

### MIME Apps

```nix
xdg.configFile."mimeapps.list".force = true;
```

Ensures Home Manager can overwrite user MIME associations without conflict.

## Dependencies

- Required by: `home/abreu/` (imported first)

## References

- [Home Manager Manual](https://nix-community.github.io/home-manager/)

