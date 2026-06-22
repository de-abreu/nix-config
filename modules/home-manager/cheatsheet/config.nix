{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.programs.cheatsheet;
  cheatsheet-navi = pkgs.writeShellApplication {
    name = "cheatsheet-navi";
    runtimeInputs = [
      pkgs.wtype
      config.wayland.windowManager.hyprland.package
      config.programs.navi.package
      pkgs.wezterm-floating
    ];
    text = builtins.readFile ./cheatsheet-navi.sh;
  };
  processedEntries = mapAttrs (
    _: content: if isPath content then readFile content else content
  ) cfg.entries;
in
{
  config = mkIf cfg.enable {
    home.packages = [ cheatsheet-navi ];

    programs = {
      cheatsheet.package = cheatsheet-navi;
      navi.settings.cheats.paths = [ "${config.xdg.configHome}/navi/cheats" ];
    };

    xdg.configFile = mapAttrs' (name: content: {
      name = "navi/cheats/${name}.cheat.md";
      value.text = content;
    }) processedEntries;
  };
}
