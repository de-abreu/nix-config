{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    getExe
    mapAttrs'
    isPath
    readFile
    mapAttrs
    ;

  cfg = config.programs.cheatsheet;

  hyprlandPkg = config.wayland.windowManager.hyprland.package or pkgs.hyprland;

  cheatsheet-navi = pkgs.writeShellApplication {
    name = "cheatsheet-navi";
    runtimeInputs = [
      pkgs.wtype
      hyprlandPkg
      config.programs.navi.package
      config.programs.wezterm.package
    ];
    text = ''
      set -euo pipefail

      navi_out=$(mktemp /tmp/cheatsheet-output-XXXXXX)
      trap 'rm -f "$navi_out"' EXIT

      active_win=$(hyprctl activewindow -j | ${getExe config.programs.jq.package} -r '.address')

      ${getExe config.programs.wezterm.floatingPackage} ${getExe config.programs.navi.package} > "$navi_out"

      if [ ! -s "$navi_out" ]; then
        exit 0
      fi

      result=$(cat "$navi_out")

      hyprctl dispatch focuswindow "address:$active_win"

      key="''${result%% / *}"

      # Hyprland dispatch commands (! prefix)
      case "$key" in
        !*)
          cmd="''${key#!}"
          # shellcheck disable=SC2086
          hyprctl dispatch $cmd
          exit 0
          ;;
      esac

      # Commands (e.g. :exec, :bmark)
      case "$key" in
        :*)
          cmd="''${key%% *}"
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
          A-*) mods+=(-M alt);     remaining="''${remaining#A-}" ;;
          C-*) mods+=(-M ctrl);    remaining="''${remaining#C-}" ;;
          S-*) mods+=(-M shift);    remaining="''${remaining#S-}" ;;
          *)   break ;;
        esac
      done

      # Dispatch key using X11 keysym names
      case "$remaining" in
        BackSpace| \
        Caps_Lock| \
        Num_Lock| \
        Scroll_Lock| \
        Escape| \
        Down| \
        Up| \
        Left| \
        Right| \
        Page_Down| \
        Page_Up| \
        Return| \
        space| \
        Super_L| \
        Tab| \
        Print| \
        F[1-9]|F1[0-2])
          wtype "''${mods[@]}" -k "$remaining"
          ;;
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

  processEntry = name: content: if isPath content then readFile content else content;

  processedEntries = mapAttrs processEntry cfg.entries;
in
{
  options.programs.cheatsheet = {
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
