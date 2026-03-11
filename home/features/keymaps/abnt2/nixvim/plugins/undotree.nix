{
  pluginCfg,
  lib,
  ...
}: {
  programs.nixvim.keymaps = lib.optional pluginCfg.undotree.enable [
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
