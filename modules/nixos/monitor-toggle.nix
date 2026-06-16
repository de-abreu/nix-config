{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.programs.monitorToggle;
in
{
  options.programs.monitorToggle = with types; {
    enable = mkEnableOption "Monitor duplication/extension toggle";

    primary = mkOption {
      type = str;
      example = "eDP-1";
      description = "The primary monitor's name. See: `grep -l connected /sys/class/drm/*/status | sed 's|/sys/class/drm/card[0-9]*-||;s|/status||`";
    };
    secondary = mkOption {
      type = str;
      example = "HDMI-A-1";
      description = "The secondary monitor's name. See: `grep -l connected /sys/class/drm/*/status | sed 's|/sys/class/drm/card[0-9]*-||;s|/status||`";
    };

    package = mkOption {
      type = package;
      readOnly = true;
    };
  };

  config = mkIf config.programs.monitorToggle.enable {
    assertions = [
      {
        assertion = config.programs.hyprland.enable;
        message = "monitorToggle requires programs.hyprland.enable to be true";
      }
    ];

    programs.monitorToggle.package = pkgs.writeShellApplication {
      name = "monitor-toggle";
      runtimeInputs = [
        config.programs.hyprland.package
        pkgs.libnotify
      ];
      text = ''
        STATE_FILE="''${XDG_RUNTIME_DIR:-/run/user/$UID}/monitor-toggle/state"
        mkdir -p "$(dirname "$STATE_FILE")"

        if [ ! -f "$STATE_FILE" ] || [ "$(cat "$STATE_FILE")" = "extended" ]; then
          # Switch to Mirror Mode
          hyprctl keyword monitor "${cfg.secondary},preferred,auto,1,mirror,${cfg.primary}"
          echo "mirrored" > "$STATE_FILE"
          notify-send "Display Mode" "Screen Mirrored"
        else
          # Switch back to Extended Mode — disable secondary, then re-enable without mirror
          # to let Hyprland re-apply the default monitor config
          hyprctl keyword monitor "${cfg.secondary},disable"
          hyprctl keyword monitor "${cfg.secondary},preferred,auto,1"
          echo "extended" > "$STATE_FILE"
          notify-send "Display Mode" "Screen Extended"
        fi
      '';
    };

    environment.systemPackages = [ cfg.package ];
  };
}
