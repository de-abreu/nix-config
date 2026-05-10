{
  config,
  lib,
  options,
  ...
}:
{
  config = lib.mkIf (options ? programs.nixvim) {

    programs.nixvim.keymaps =
      let
        cfg = config.programs.nixvim.plugins.undotree;
      in
      lib.mkIf cfg.enable [
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
  };
}
