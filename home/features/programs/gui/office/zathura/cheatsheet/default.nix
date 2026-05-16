{ config, lib, ... }:
let
  inherit (config.programs) navi wezterm zathura;
  inherit (lib) mkIf getExe;
in
{
  config = mkIf (navi.enable && wezterm.enable && zathura.enable) {
    programs = {
      zathura.mappings."H" = ''
        feedkeys ":exec ${getExe wezterm.package} --config enable_tab_bar=false --config 'window_close_confirmation=\"NeverPrompt\"' start --class floating -- ${getExe navi.package} --query zathura<Return>"
      '';
      navi.settings.cheats.paths = [ (toString ./cheat) ];
    };
  };
}
