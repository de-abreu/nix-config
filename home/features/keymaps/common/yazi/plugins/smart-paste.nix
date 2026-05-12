{ config, lib, ... }:
let
  cfg = config.programs.yazi.plugins;
  plugin = "smart-paste";
in
{
  programs.yazi.keymap.mgr.prepend_keymap = lib.mkIf (lib.hasAttr plugin cfg) [
    {
      on = [ "p" ];
      run = "plugin ${plugin}";
      desc = "Paste into the hovered directory or CWD";
    }
  ];
}
