{
  config,
  lib,
  ...
}:
let
  cfg = config.programs.yazi.plugins;
in
{
  programs.yazi.keymap.mgr.prepend_keymap = lib.mkIf (lib.hasAttr "mount" cfg) [
    {
      on = "M";
      run = "plugin mount";
      desc = "Mount manager";
    }
  ];
}
