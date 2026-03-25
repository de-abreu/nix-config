# Architecture

> **Flake entry:** `flake.nix`
> **Purpose:** Declarative NixOS system configuration with Home Manager integration

## Overview

This configuration uses Nix flakes to manage a NixOS system. It separates concerns into:
- **System-level** configuration via NixOS modules (`hosts/`)
- **User-level** configuration via Home Manager (`home/`)
- **Reusable modules** for both scopes (`modules/`)

## Flake Inputs

| Input | Branch | Purpose |
|-------|--------|---------|
| `nixpkgs` | nixos-25.11 | Stable package set |
| `nixpkgs-unstable` | nixos-unstable | Latest packages (optional) |
| `home-manager` | release-25.11 | User-level configuration |
| `sops-nix` | master | Secrets management (age encryption) |
| `hydenix` | master | Hyprland desktop environment |
| `nixvim` | nixos-25.11 | Neovim configuration |
| `stylix` | release-25.11 | System-wide theming |
| `nixos-hardware` | master | Hardware-specific tweaks |

## Flake Outputs

```
flake.nix
    │
    └── flake-outputs.nix
            │
            ├── nixosModules ──────► modules/nixos/
            │
            ├── homeModules ───────► modules/home-manager/
            │
            ├── overlays ──────────► overlays/
            │
            ├── packages ──────────► pkgs/
            │
            ├── devShells ─────────► shell.nix
            │
            └── nixosConfigurations
                    │
                    └── argo ─────────► hosts/argo/
                                              │
                                              ├── configuration.nix
                                              │       │
                                              │       ├── imports home/common/
                                              │       └── imports home/abreu/
                                              │
                                              └── hardware-configuration.nix
```

## Import Flow

### System Configuration

```
hosts/argo/default.nix
    │
    ├── imports hosts/common/ (shared system config)
    │
    └── imports home configuration
            │
            └── home/abreu/default.nix
                    │
                    └── imports home/features/*
```

### Home Manager Features

```
home/features/
    ├── desktop-environment/
    │   ├── hydenix/      # Hyprland desktop
    │   └── stylix/       # System theming
    │
    ├── keymaps/          # ABNT2 keyboard mappings
    │   └── abnt2/
    │
    └── programs/         # Application configs
        ├── cli/
        └── gui/
```

## Import Helper: `importAll`

The `importAll` function auto-imports Nix files from a directory:

```nix
imports = importAll { dir = ./.; };
```

This recursively imports all `.nix` files except `default.nix`. Optionally exclude files:

```nix
imports = importAll { dir = ./.; exclude = [ "file.nix" ]; };
```

## Key Patterns

### Secrets (sops-nix)

```nix
sops.secrets."api-keys/service" = {};
programs.fish.shellInit = ''
  export MY_KEY=$(cat ${config.sops.secrets."api-keys/service".path})
'';
```

### Custom Module Pattern

```nix
{
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.my-module;
in {
  options.programs.my-module = {
    enable = mkEnableOption "description";
  };

  config = mkIf cfg.enable {
    # implementation
  };
}
```

## References

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [sops-nix](https://github.com/Mic92/sops-nix)
- [Hydenix](https://github.com/richen604/hydenix)
- [Nixvim](https://github.com/nix-community/nixvim)
- [Stylix](https://github.com/danthorst/stylix)