{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.abnt2-keyboard.hm.hydenix;
in {
  config = mkIf cfg.enable {
    hydenix.hm.hyprland = {
      extraConfig =
        # hyprlang
        ''
          input {
          touchpad {
              natural_scroll=true
          }
          kb_layout=br
          kb_variant=
          sensitivity=1
          }
        '';
      keybindings.overrideConfig = with pkgs; let
        hardware-controls = callPackage ./hardware-controls.nix {};
        launchers = callPackage ./launchers.nix {inherit config;};
        theming = callPackage ./theming.nix {};
        windows = callPackage ./windows.nix {};
        workspaces = callPackage ./workspaces.nix {};

        changeSubmap =
          if config.stylix.enable
          then
            with config.lib.stylix.colors; {
              toHyprmode = "hyprctl keyword general:col.active_border \"rgb(${base08})\"; hyprctl dispatch submap hyprmode";
              toDefault = "hyprctl keyword general:col.active_border \"rgb(${base0B})\"; hyprctl dispatch submap reset";
            }
          else {
            toHyprmode = "hyprctl dispatch submap hyprmode";
            toDefault = "hyprctl dispatch submap reset";
          };
      in
        if cfg.keybinds != null
        then cfg.keybinds
        else
          # hyprlang
          ''
            # Set special keys
            $mainMod = Super
            $apostrophe = code:49
            $ccedilla = code:47
            $printScreen = code:107

            # Commands to change between submaps
            $toHyprmode = ${changeSubmap.toHyprmode}
            $toDefault = ${changeSubmap.toDefault}

            $d=[Hyprmode]
            bindd = $mainMod, Super_L, $d toggle Hyprmode, exec, $toHyprmode

            ${hardware-controls}

            ${windows {hyprmode = false;}}

            ${launchers {hyprmode = false;}}

            ${workspaces {hyprmode = false;}}

            ${theming {hyprmode = false;}}

            submap = hyprmode

            bind = $mainMod, Super_L, exec, $toDefault

            ${hardware-controls}

            ${windows {hyprmode = true;}}

            ${launchers {hyprmode = true;}}

            ${workspaces {hyprmode = true;}}

            ${theming {hyprmode = true;}}

            submap = reset

            $d=#! unset the group name
          '';
    };
  };
}
