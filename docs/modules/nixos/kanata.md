# Kanata

> **Config:** `modules/nixos/kanata/default.nix`, `config.nix`
> **Purpose:** Advanced keyboard customization via software-based key remapping

## Overview

Kanata is a keyboard remapping tool that runs in userspace. This custom NixOSmodule provides declarative configuration for keyboard layers, aliases, and custom key behaviors. It enables features like:
- Home row modifiers (tap for key, hold for modifier)
- Layers (navigation, symbols, etc.)
- Custom key mappings for ABNT2 keyboards

## Key Options

| Option | Type | Default | Purpose |
|--------|------|---------|---------|
| `enable` | bool | false | Enable Kanata service |
| `package` | package | pkgs.kanata | Kanata package to use |
| `devices` | list of str | required | Device paths to intercept |
| `sourceKeys` | list of str | [] | Keys to intercept (defsrc) |
| `layers` | attrs | {} | Layer definitions |
| `aliases` | attrs | {} | Key action aliases |
| `variables` | attrs | {} | Timing and behavior variables |
| `localKeys` | attrs | {} | Custom scancode mappings |
| `primaryLayer` | str | "base" | Default active layer |

## Dependencies

- Requires: `hardware.uinput.enable = true` (auto-configured)
- Uses: `services.kanata` upstream module

## Configuration Example

```nix
programs.kanata = {
  enable = true;
  devices = [ "/dev/input/by-path/platform-i8042-serio-0-event-kbd" ];
  sourceKeys = [ "esc" "caps" "a" "s" "d" "f" ];
  
  aliases = {
    esctrl = "(tap-hold 200 200 esc lctl)";
    nav-layer = "(layer-toggle nav)";
  };
  
  layers = {
    base = {
      caps = "@esctrl";
    };
    nav = {
      h = "left";
      j = "down";
      k = "up";
      l = "right";
    };
  };
};
```

## References

- [Kanata GitHub](https://github.com/jtroo/kanata)
- [Kanata Configuration Guide](https://github.com/jtroo/kanata/blob/main/docs/config.adoc)
- [Keyd vs Kanata](https://github.com/jtroo/kanata#comparison-with-other-tools)