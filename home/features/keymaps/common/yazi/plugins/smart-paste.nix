{ config, lib, ... }:
let
  cfg = config.programs.yazi.plugins;
in
{
  programs.yazi.keymap.mgr.prepend_keymap = lib.mkIf (lib.hasAttr "smart-paste" cfg) [
    {
      on = [ "p" ];
      run = "plugin smart-paste";
      desc = "Paste into the hovered directory or CWD";
    }
  ];
}
