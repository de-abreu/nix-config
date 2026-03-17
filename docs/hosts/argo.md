# Host: Argo

> **Config:** `hosts/argo/configuration.nix`
> **Purpose:** Laptop NixOS configuration for personal use

## Overview

Argo is a Dell laptop running NixOS with Hydenix desktop environment. It uses Intel CPU optimizations, custom keyboard remapping via Kanata, and automatic timezone detection via geoclue2.

## Hardware

- **CPU:** Intel (uses `common-cpu-intel` module)
- **Storage:** SSD
- **Form Factor:** Laptop
- **Boot:** Legacy BIOS (GRUB)

## Key Configuration

| Setting | Value | Purpose |
|---------|-------|---------|
| `hostname` | argo | Machine identifier |
| `timezone` | America/Sao_Paulo | Fallback (overridden by automatic-timezoned) |
| `locale` | en_US.UTF-8 | System language |
| `LC_*` | pt_BR.UTF-8 | Regional formats (Brazilian) |

## Enabled Features

| Feature | Module | Description |
|---------|--------|-------------|
| Hydenix | `inputs.hydenix` | Hyprland desktop |
| Kanata | `programs.kanata` | Keyboard remapping |
| Keyboard backlight | `programs.adjust_kbd_backlight` | Dell keyboard backlight |
| Sops | `inputs.sops-nix` | Secrets management |
| Automatic timezone | `services.automatic-timezoned` | Geoclue2-based timezone |

## Secrets

| Secret | File |
|--------|------|
| `root_password` | `secrets/hosts/argo.yaml` |

## Dependencies

- Imports: `hosts/common/` (shared system config)
- Imports: `home/abreu/` (user configuration)
- Uses: `nixos-hardware` modules for Intel laptop optimizations

## References

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [NixOS Hardware](https://github.com/NixOS/nixos-hardware)
- [Hydenix](https://github.com/richen604/hydenix)
- [automatic-timezoned](https://mynixos.com/nixpkgs/option/services.automatic-timezoned.enable)