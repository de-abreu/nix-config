{ config, lib, ... }:
let
  cfg = config.programs.yazi.plugins;
  plugin = "smart-tab";
in
{
  programs.yazi.keymap.mgr.prepend_keymap = lib.mkIf (lib.hasAttr plugin cfg) [
    {
      on = [ "t" "t" ];
      run = "plugin ${plugin}";
      desc = "Create a tab and enter the hovered directory";
    }
  ];
}
