{ config, lib, ... }:
let
  cfg = config.programs.yazi.plugins;
  plugin = "cd-git-root";
in
{
  programs.yazi.keymap.mgr.prepend_keymap = lib.mkIf (lib.hasAttr plugin cfg) [{
    on = ["g" "r"];
    run = "plugin ${plugin}";
    desc = "Go to git repo root";
  }];
}
