{
  config,
  lib,
  ...
}: let
  cfg = config.programs.nixvim.plugins.undotree;
in {
  programs.nixvim.keymaps = lib.optional cfg.enable [
    {
      mode = "n";
      key = "<leader>ut";
      action = "<cmd>UndotreeToggle<CR>";
      options = {
        silent = true;
        desc = "Undotree";
      };
    }
  ];
}
