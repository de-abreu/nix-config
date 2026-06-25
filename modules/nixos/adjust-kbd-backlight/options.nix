{
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.programs.adjustKeyboardBacklight = with types; {
    enable = mkEnableOption "keyboard backlight adjustment script";

    device = mkOption {
      type = nullOr str;
      default = null;
      example = "tpacpi::kbd_backlight";
      description = "The device identifier for brightnessctl.";
    };

    brightnessctlPackage = mkOption {
      type = package;
      default = pkgs.brightnessctl;
    };

    package = mkOption {
      type = package;
      readOnly = true;
    };
  };
}
