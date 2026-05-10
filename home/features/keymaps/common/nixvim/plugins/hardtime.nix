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
        cfg = config.programs.nixvim.plugins.hardtime;
      in
      lib.mkIf cfg.enable [
        {
          action = "<cmd>Hardtime toggle<cr>";
          key = "<leader>uH";
          mode = "n";
        }
      ];
  };
}
