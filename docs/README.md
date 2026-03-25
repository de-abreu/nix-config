# NixOS Configuration Documentation

This directory contains documentation for the NixOS configuration. Each document mirrors the configuration structure for easy navigation.

## Quick Navigation

| Directory | Description |
|-----------|-------------|
| [architecture.md](architecture.md) | Flake structure, inputs, outputs, and data flow |
| [hosts/](hosts/) | Per-host NixOS configurations |
| [home/](home/) | Home Manager feature documentation |
| [modules/](modules/) | Custom NixOS and Home Manager modules |
| [pkgs/](pkgs/) | Custom package definitions |

## Documentation Structure

Documentation mirrors the configuration directory structure:

```
docs/
├── hosts/argo.md          ← hosts/argo/
├── home/features/programs/cli/nixvim.md  ← home/features/programs/cli/nixvim/
└── ...
```

**Rule:** `path/to/config.nix` → `docs/path/to/config.md`

## Document Template

Each documentation file follows this template:

```markdown
# [Component Name]

> **Config:** `path/to/config.nix`
> **Purpose:** [One sentence summary]

## Overview
[2-4 sentences explaining what and why]

## Key Options
| Option | Default | Purpose |
|--------|---------|---------|

## Dependencies
- Requires: [links to related docs]
- Used by: [what depends on this]

## References
- [Upstream documentation links]
```

## Finding Documentation

### For AI Agents
1. From a config path, map directly: `home/features/programs/cli/nixvim` → `docs/home/features/programs/cli/nixvim.md`
2. Start at [architecture.md](architecture.md) for high-level structure
3. Check `# INFO:` comments in Nix files for quick context

### For Humans
- Browse by directory or use grep: `grep -r "keyword" docs/`

## Contributing

When adding new configuration:
1. Create corresponding doc file following the template
2. Add `# INFO:` comment to the Nix file for quick context
3. Link related docs in the Dependencies section