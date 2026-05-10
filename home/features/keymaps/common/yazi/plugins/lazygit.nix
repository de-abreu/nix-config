{
  config,
  lib,
  ...
}:
let
  cfg = config.programs.yazi.plugins;
in
{
  programs.yazi.keymap.mgr.prepend_keymap = lib.mkIf (lib.hasAttr "smart-paste" cfg) [
    {
      on = [ "m" ];
      run = "plugin relative-motions";
      desc = "Trigger a new relative motion";
    }
  ];
}
