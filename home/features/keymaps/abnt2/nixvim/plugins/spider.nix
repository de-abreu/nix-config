{ config, lib, ... }:
let
  cfg = config.programs.nixvim.plugins.spider;
  mkAction = key: { __raw = "function() require('spider').motion('${key}') end"; };
in
{
  programs.nixvim.keymaps = lib.mkIf cfg.enable [
    {
      action = mkAction "w";
      key = "w";
      options.desc = "Next word";
    }
    {
      action = mkAction "e";
      key = "e";
      options.desc = "Next end of word";
    }
    {
      action = mkAction "b";
      key = "b";
      options.desc = "Previous word";
    }
    {
      action = mkAction "ge";
      key = "ge";
      options.desc = "Previous end of word";
    }
  ];
}
