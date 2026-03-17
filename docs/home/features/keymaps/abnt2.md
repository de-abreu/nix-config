# ABNT2 Keymaps

> **Config:** `home/features/keymaps/abnt2/default.nix`
> **Purpose:** Custom keybindings and layouts for Brazilian ABNT2 keyboard

## Overview

This directory contains custom keybindings configured for the ABNT2 (Brazilian Portuguese) keyboard layout. Rather than modifying keyboard hardware, these configurations remap keys and add shortcuts across various applications.

## Key Mappings

The ABNT2 layout has specific keys that differ from US keyboards:
- `ç` (cedilla) - remapped in Kanata for custom functions
- `/` and `?` on the same key near right shift
- `;` and `:` positions differ from US layout

## Structure

```
abnt2/
├── default.nix           # Imports all abnt2 keymaps
├── less.nix              # Less pager keybinds
├── feh.nix               # Image viewer
├── yazi.nix              # File manager
├── zathura.nix           # PDF viewer
├── lazygit.nix           # Git TUI
├── wezterm/              # Terminal keybinds
├── hydenix/              # Desktop environment
│   ├── default.nix
│   ├── theming.nix
│   ├── launchers.nix
│   ├── hardware-controls.nix
│   ├── workspaces.nix
│   └── windows.nix
└── nixvim/               # Neovim keybinds
    └── plugins/          # Plugin-specific keybinds
```

## Dependencies

- Requires: ABNT2 keyboard hardware or software layout
- Uses: Hydenix keybinds for desktop environment
- Uses: Nixvim keybinds for editor

## References

- [ABNT2 Layout](https://en.wikipedia.org/wiki/Portuguese_keyboard_layout)
- [Hyprland Bindings](https://wiki.hyprland.org/Configuring/Binds/)