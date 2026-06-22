{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  inherit (types) package str;
  cfg = config.programs.adjustKeyboardBacklight;
in
{
  options.programs.adjustKeyboardBacklight = {
    enable = mkEnableOption "keyboard backlight adjustment script";

    device = mkOption {
      type = str;
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

  config = mkIf cfg.enable {
    programs.adjustKeyboardBacklight.package = pkgs.writeShellApplication {
      name = "adjust-keyboard-backlight";
      runtimeInputs = [ cfg.brightnessctlPackage ];
      text = ''
        device="${cfg.device}"

        # Get current brightness
        current=$(brightnessctl -d "$device" get)

        # Calculate next level (0 -> 1 -> 2 -> 0)
        next=$(( (current + 1) % 3 ))

        # Set the new brightness
        brightnessctl -d "$device" set "$next"
      '';
    };

    environment.systemPackages = [ cfg.package ];
  };
}
