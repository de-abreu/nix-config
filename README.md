# NixOS Configuration

A declarative NixOS system configuration using flakes, Home Manager, and sops-nix.

## System

**Host:** `argo` - Personal laptop (Intel CPU, Dell, ABNT2 keyboard)

## Quick Start

```bash
# Rebuild and switch
nh os switch

# Rebuild with trace
nh os switch -- --show-trace

# Check flake
nix flake check

# Update inputs
nix flake update
```

## Features

| Feature | Module | Description |
|---------|--------|-------------|
| **Hydenix** | home/features/desktop-environment/hydenix | Hyprland-based desktop with Wayland |
| **Nixvim** | home/features/programs/cli/nixvim | Neovim config with 50+ plugins |
| **Kanata** | modules/nixos/kanata | Advanced keyboard remapping (layers, home-row mods) |
| **Stylix** | home/features/desktop-environment/stylix | System-wide theming (Ayu Mirage) |
| **sops-nix** | secrets/ | Encrypted secrets management |

## Structure

```
.
├── flake.nix              # Flake entry point
├── flake-outputs.nix      # Outputs definition
├── hosts/
│   ├── argo/              # Host configuration
│   └── common/            # Shared system config
├── home/
│   ├── abreu/             # User configuration
│   ├── common.nix         # Shared home settings
│   └── features/          # Modular feature sets
│       ├── cli/           # Astronvim, Nixvim, Fish, etc.
│       ├── desktop-environment/  # Hydenix, Stylix
│       ├── keymaps/      # ABNT2 keyboard mappings
│       └── programs/      # CLI and GUI programs
├── modules/
│   ├── nixos/             # Custom NixOS modules (Kanata)
│   └── home-manager/      # Custom Home Manager modules
├── secrets/              # sops-nix encrypted secrets
└── docs/                 # Documentation
```

## Documentation

See [`docs/`](docs/) for detailed documentation:

- [architecture.md](docs/architecture.md) - Flake structure and data flow
- [hosts/argo.md](docs/hosts/argo.md) - Host-specific configuration
- [modules/nixos/kanata.md](docs/modules/nixos/kanata.md) - Keyboard customization
- [home/features/programs/cli/nixvim.md](docs/home/features/programs/cli/nixvim.md) - Neovim plugins

## Key Inputs

| Input | Purpose |
|-------|---------|
| [nixpkgs](https://github.com/NixOS/nixpkgs) | Package set (nixos-25.11) |
| [home-manager](https://github.com/nix-community/home-manager) | User-level configuration |
| [hydenix](https://github.com/richen604/hydenix) | Hyprland desktop environment |
| [nixvim](https://github.com/nix-community/nixvim) | Neovim configuration |
| [stylix](https://github.com/danthorst/stylix) | System theming |
| [sops-nix](https://github.com/Mic92/sops-nix) | Secrets management |
| [kanata](https://github.com/jtroo/kanata) | Keyboard remapping |

## Requirements

- Nix with flakes enabled
- NixOS unstable or 25.11

## Adding a Secret

```bash
# Edit encrypted secrets
sops secrets/users/abreu.yaml

# Reference in config
sops.secrets."api-keys/my-service" = {};
```

## License

Personal configuration. Use at your own risk.