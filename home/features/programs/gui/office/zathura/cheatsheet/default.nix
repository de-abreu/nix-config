{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.programs) navi zathura;
  inherit (lib) mkIf getExe;

  hyprlandEnabled =
    (config.wayland.windowManager.hyprland.enable) || (config.hydenix.hm.hyprland.enable or false);

  hyprlandPkg = config.wayland.windowManager.hyprland.package or pkgs.hyprland;

  naviWrapper = pkgs.writeShellApplication {
    name = "zathura-navi";
    runtimeInputs = [
      pkgs.wtype
      config.programs.jq.package
      hyprlandPkg
    ];
    text = ''
      set -euo pipefail

      navi_out=$(mktemp /tmp/navi-output-XXXXXX)
      trap 'rm -f $navi_out' EXIT

      active_win=$(hyprctl activewindow -j | jq -r '.address')

      # shellcheck disable=SC2016
      ${zathura.floatingWindow "bash -c '${getExe navi.package} --query \"zathura \" > \"$1\"' _ \"$navi_out\""}

      if [ ! -s "$navi_out" ]; then
        exit 0
      fi

      result=$(cat "$navi_out")

      hyprctl dispatch focuswindow address:"$active_win"

      key=''${result%% / *}

      case "$key" in
        ^?)
          char=''${key#^}
          wtype -M ctrl "$char"
          ;;
        Space)   wtype -k space ;;
        Return)  wtype -k Return ;;
        Tab)     wtype -k Tab ;;
        Esc)     wtype -k Escape ;;
        BackSpace) wtype -k BackSpace ;;
        S-Space) wtype -M shift -k space ;;
        F5)  wtype -k F5 ;;
        F11) wtype -k F11 ;;
        :*)
          cmd=''${key%% *}
          wtype "$cmd"
          wtype -k Return
          ;;
        *)
          wtype "$key"
          ;;
      esac
    '';
  };
in
{
  config = mkIf (navi.enable && zathura.enable && hyprlandEnabled) {
    programs = {
      zathura.mappings."H" = ''
        feedkeys ":exec ${getExe naviWrapper}<Return>"
      '';
      navi.settings.cheats.paths = [ (toString ./cheat) ];
    };
  };
}
