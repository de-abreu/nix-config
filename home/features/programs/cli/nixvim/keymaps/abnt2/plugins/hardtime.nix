{ config, lib, ... }:
let
  cfg = config.programs.nixvim.plugins.hardtime;
in
{
  programs.nixvim.keymaps = lib.mkIf cfg.enable [
    {
      action = "<cmd>Hardtime toggle<cr>";
      key = "<leader>uH";
      mode = "n";
    }
  ];
}
