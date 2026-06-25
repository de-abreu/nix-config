{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.adjustKeyboardBacklight;
in
{
  config = lib.mkMerge [
    (lib.mkIf (cfg.device != null) {
      programs.adjustKeyboardBacklight.enable = lib.mkDefault true;
    })
    (lib.mkIf cfg.enable {
      assertions = [
        {
          assertion = cfg.device != null;
          message = "adjustKeyboardBacklight: 'device' must be set when the module is enabled.";
        }
      ];

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
    })
  ];
}
