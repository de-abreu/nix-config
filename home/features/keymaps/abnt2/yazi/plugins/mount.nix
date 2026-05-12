{
  config,
  lib,
  ...
}:
let
  cfg = config.programs.yazi.plugins;
  plugin = "mount";
in
{
  programs.yazi.keymap.mgr.prepend_keymap = lib.mkIf (lib.hasAttr plugin cfg) [
    {
      on = "M";
      run = "plugin ${plugin}";
      desc = "Mount manager";
    }
  ];
}
