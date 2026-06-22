{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.programs.wfrc;
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
{
  config = mkIf cfg.enable {
    home.packages = [ wfrc-wrapped ];
  };
}
