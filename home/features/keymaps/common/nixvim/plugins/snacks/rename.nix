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
        cfg = config.programs.nixvim.plugins.snacks;
        enable = cfg.enable && ((cfg.settings.rename.enabled or false) == true);
      in
      lib.mkIf enable [
        {
          action.__raw = "function() Snacks.rename.rename_file() end";
          key = "<leader>r";
          mode = "n";
          options.desc = "Rename File";
        }
      ];
  };
}
