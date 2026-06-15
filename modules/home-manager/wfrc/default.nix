{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.programs.wfrc;
in
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
      description = "Additional configuration settings for wfrc.";
    };
  };

  config =
    let
      recorderBinaryName =
        let
          name = cfg.recorder.pname or cfg.recorder.name;
        in
        assert assertMsg (name == "wf-recorder" || name == "wl-screenrec")
          "programs.wfrc.recorder: package must have pname \"wf-recorder\" or \"wl-screenrec\", got \"${name}\"";
        name;

      wfrc-wrapped = inputs.wrappers.lib.wrapPackage {
        inherit pkgs;
        package = cfg.package;
        runtimeInputs = [ cfg.recorder ];
        env =
          let
            envVars =
              with cfg.settings;
              {
                WFRC_FOLDER = folder;
                SCRIPT_NAME = scriptName;
                WFRC_ICON = icon;
                WFRC_NOTIFY = notify;
                WFRC_FULL_SCREEN = fullScreen;
                WFRC_AUDIO_DEV = audioDevice;
              }
              |> filterAttrs (_: v: v != null);
          in
          { WFRC_RECORDER = recorderBinaryName; } // mapAttrs (_: toString) envVars;
      };
    in
    mkIf cfg.enable {
      home.packages = [ wfrc-wrapped ];
    };
}
