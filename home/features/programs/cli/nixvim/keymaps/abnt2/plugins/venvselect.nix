{ config, lib, ... }:
let
  cfg = config.programs.nixvim.plugins.venv-selector;
in
{
  programs.nixvim.keymaps = lib.mkIf cfg.enable [
    {
      mode = "n";
      key = "<Leader>lv";
      action = "<Cmd>VenvSelect<CR>";
      options.desc = "Select VirtualEnv";
    }
  ];
}
