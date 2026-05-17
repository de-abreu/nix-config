{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.programs) navi zathura wezterm;
  inherit (lib) mkIf getExe;

  wezterm-floating = getExe wezterm.floatingPackage;

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
      ${wezterm-floating} bash -c '${getExe navi.package} --query "zathura " > "$1"' _ "$navi_out"

      if [ ! -s "$navi_out" ]; then
        exit 0
      fi

      result=$(cat "$navi_out")

      hyprctl dispatch focuswindow address:"$active_win"

      key=''${result%% / *}

      # Ctrl+char (e.g. ^t, ^d)
      case "$key" in
        ^?)
          char=''${key#^}
          wtype -M ctrl "$char"
          exit 0
          ;;
      esac

      # Commands (e.g. :exec, :bmark)
      case "$key" in
        :*)
          cmd=''${key%% *}
          wtype "$cmd"
          wtype -k Return
          exit 0
          ;;
      esac

      # Parse modifier prefixes: A- (Alt), C- (Ctrl), S- (Shift)
      mods=()
      remaining="$key"
      while : ; do
        case "$remaining" in
          A-*) mods+=(-M alt); remaining=''${remaining#A-} ;;
          C-*) mods+=(-M ctrl); remaining=''${remaining#C-} ;;
          S-*) mods+=(-M shift); remaining=''${remaining#S-} ;;
          *) break ;;
        esac
      done

      # Map remaining to wtype key name
      case "$remaining" in
        BackSpace)  wtype "''${mods[@]}" -k BackSpace ;;
        CapsLock)   wtype "''${mods[@]}" -k Caps_Lock ;;
        NumLock)    wtype "''${mods[@]}" -k Num_Lock ;;
        ScrollLock) wtype "''${mods[@]}" -k Scroll_Lock ;;
        Esc|Escape) wtype "''${mods[@]}" -k Escape ;;
        Down)       wtype "''${mods[@]}" -k Down ;;
        Up)         wtype "''${mods[@]}" -k Up ;;
        Left)       wtype "''${mods[@]}" -k Left ;;
        Right)      wtype "''${mods[@]}" -k Right ;;
        PageDown)   wtype "''${mods[@]}" -k Page_Down ;;
        PageUp)     wtype "''${mods[@]}" -k Page_Up ;;
        Return)     wtype "''${mods[@]}" -k Return ;;
        Space)      wtype "''${mods[@]}" -k space ;;
        Super)      wtype "''${mods[@]}" -k Super_L ;;
        Tab)        wtype "''${mods[@]}" -k Tab ;;
        Print)      wtype "''${mods[@]}" -k Print ;;
        F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12)
                    wtype "''${mods[@]}" -k "$remaining" ;;
        *)
          if [ ''${#mods[@]} -gt 0 ]; then
            wtype "''${mods[@]}" "$remaining"
          else
            wtype "$remaining"
          fi
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
