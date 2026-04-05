{
  config,
  lib,
  ...
}: let
  cfg = config.programs.nixvim.plugins.snacks;
  enable = cfg.enable && ((cfg.settings.rename.enabled or false) == true);
in {
  programs.nixvim.keymaps = lib.mkIf enable [
    {
      action.__raw = "function() Snacks.rename.rename_file() end";
      key = "<leader>r";
      mode = "n";
      options.desc = "Rename File";
    }
  ];
}
