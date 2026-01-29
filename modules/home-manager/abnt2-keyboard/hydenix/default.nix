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
      keybindings.overrideConfig = with config.lib.stylix.colors;
      with pkgs; let
        hardware-controls = callPackage ./hardware-controls.nix {};
        launchers = callPackage ./launchers.nix {inherit config;};
        theming = callPackage ./theming.nix {};
        windows = callPackage ./windows.nix {};
        workspaces = callPackage ./workspaces.nix {};

        changeSubmap = name: indicator: "hyprctl keyword general:col.active_border \"rgb(${indicator})\"; hyprctl dispatch submap ${name}";
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
            $toHyprmode = ${changeSubmap "hyprmode" base08}
            $toDefault = ${changeSubmap "reset" base0B}

            $d=[Hyprmode]
            binddn = , Super_L, $d Toggle, exec, $toHyprmode

            ${hardware-controls}

            ${windows {hyprmode = false;}}

            ${launchers {hyprmode = false;}}

            ${workspaces {hyprmode = false;}}

            ${theming {hyprmode = false;}}

            submap = hyprmode

            bindn = , Super_L, exec, $toDefault

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
