{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf getExe;
  inherit (config.programs) cheatsheet zathura;

  hyprlandEnabled =
    (config.wayland.windowManager.hyprland.enable) || (config.hydenix.hm.hyprland.enable or false);
in
{
  config = mkIf (cheatsheet.enable && zathura.enable && hyprlandEnabled) {
    programs = {
      cheatsheet.entries.zathura = ./cheat/zathura.cheat.md;
      zathura.mappings."H" = ''
        feedkeys ":exec ${getExe cheatsheet.package}<Return>"
      '';
    };
  };
}