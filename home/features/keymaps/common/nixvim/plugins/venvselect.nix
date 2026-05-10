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
        cfg = config.programs.nixvim.plugins.venv-selector;
      in
      lib.mkIf cfg.enable [
        {
          mode = "n";
          key = "<Leader>lv";
          action = "<Cmd>VenvSelect<CR>";
          options.desc = "Select VirtualEnv";
        }
      ];
  };
}
