# Hydenix

> **Config:** `home/features/desktop-environment/hydenix/default.nix`
> **Purpose:** Hyprland-based desktop environment with Wayland support

## Overview

Hydenix is a Hyprland desktop environment configuration. This module imports the Hydenix home-manager module and disables default applications in favor of custom configurations defined elsewhere. The actualwindow manager, keybindings, and theming are configured in subdirectories.

## Key Options

| Option | Default | Purpose |
|--------|---------|---------|
| `hydenix.hm.enable` | true | Enable Hydenix home module |
| `editors.enable` | false | Use default editors (disabled) |
| `fastfetch.enable` | false | Use default fastfetch (disabled) |
| `firefox.enable` | false | Use default firefox (disabled) |
| `git.enable` | false | Use default git config (disabled) |
| `shell.enable` | false | Use default shell config (disabled) |
| `social.enable` | false | Use default social apps (disabled) |
| `spotify.enable` | false | Use default Spotify (disabled) |
| `terminals.enable` | false | Use default terminals (disabled) |

## Dependencies

- Requires: `inputs.hydenix`
- Uses: Hyprland configuration from `hydenix/hypr/`
- Uses: Theme overrides from `stylix/`

## Structure

```
hydenix/
├── default.nix      # Main enable + overrides
└── hypr/
    ├── default.nix      # Hyprland settings
    ├── window-rules/    # Window-specific rules
    └── console-dropdown.nix  # Dropdown terminal
```

## References

- [Hydenix GitHub](https://github.com/richen604/hydenix)
- [Hyprland Wiki](https://wiki.hyprland.org/)
- [Hyprland Config](https://wiki.hyprland.org/Configuring/Configuring-Hyprland/)