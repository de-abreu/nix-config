{ lib, ... }: with lib;
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
}
