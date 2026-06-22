{ lib, ... }:
with lib;
{
  options.programs.cheatsheet = with types; {
    enable = mkEnableOption "context-aware cheatsheet via navi in floating wezterm";

    entries = mkOption {
      type = types.attrsOf (types.either types.lines types.path);
      default = { };
      description = ''
        Attribute set of navi cheat entries. The key is the cheat name
        (e.g. "zathura", "hyprland") and the value is either a path to
        a .cheat.md file or a string of navi cheat content.
      '';
    };

    package = mkOption {
      type = types.package;
      internal = true;
      description = "The cheatsheet-navi wrapper package.";
    };
  };
}
