{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.programs.cheatsheet;

  hyprlandPkg = config.wayland.windowManager.hyprland.package or pkgs.hyprland;

  cheatsheet-navi = pkgs.writeShellApplication {
    name = "cheatsheet-navi";
    runtimeInputs = [
      pkgs.wtype
      hyprlandPkg
      config.programs.navi.package
      config.programs.wezterm.floatingPackage
    ];
    text = builtins.readFile ./cheatsheet-navi.sh;
  };

  processEntry = _: content: if isPath content then readFile content else content;

  processedEntries = mapAttrs processEntry cfg.entries;
in
{
  options.programs.cheatsheet = with types; {
    enable = mkEnableOption "context-aware cheatsheet via navi in floating wezterm";

    entries = mkOption {
      type = attrsOf (either lines path);
      default = { };
      description = ''
        Attribute set of navi cheat entries. The key is the cheat name
        (e.g. "zathura", "hyprland") and the value is either a path to
        a .cheat.md file or a string of navi cheat content.
      '';
    };

    package = mkOption {
      type = package;
      default = cheatsheet-navi;
      description = "The cheatsheet-navi wrapper package.";
      internal = true;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cheatsheet-navi ];

    xdg.configFile = mapAttrs' (name: content: {
      name = "navi/cheats/${name}.cheat.md";
      value.text = content;
    }) processedEntries;

    programs.navi.settings.cheats.paths = [ "${config.xdg.configHome}/navi/cheats" ];
  };
}
