{
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.programs.wfrc = with types; {
    enable = mkEnableOption "wfrc, a Wayland screen recorder wrapper with toggle";

    package = mkOption {
      type = package;
      default = pkgs.wfrc;
      defaultText = literalExpression "pkgs.wfrc";
      description = "The wfrc package to use.";
    };

    recorder = mkOption {
      type = package;
      default = pkgs.wf-recorder;
      defaultText = literalExpression "pkgs.wf-recorder";
      description = "The screen recorder backend package. Must be wf-recorder or wl-screenrec.";
    };

    settings = mkOption {
      type = submodule {
        options = {
          folder = mkOption {
            type = nullOr str;
            default = null;
            description = "Directory where recordings are stored (WFRC_FOLDER).";
          };

          scriptName = mkOption {
            type = nullOr str;
            default = null;
            description = "Base name for the output recording file (SCRIPT_NAME).";
          };

          icon = mkOption {
            type = nullOr str;
            default = null;
            description = "Icon name for desktop notifications (WFRC_ICON).";
          };

          notify = mkOption {
            type = nullOr bool;
            default = null;
            description = "Whether to show desktop notifications (WFRC_NOTIFY).";
          };

          fullScreen = mkOption {
            type = nullOr bool;
            default = null;
            description = "Record full screen without area selection (WFRC_FULL_SCREEN).";
          };

          audioDevice = mkOption {
            type = nullOr str;
            default = null;
            description = "PulseAudio source device for audio capture (WFRC_AUDIO_DEV).";
          };
        };
      };
      default = { };
      description = "Configuration settings for wfrc.";
    };
  };
}
