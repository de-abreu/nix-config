{
  config,
  lib,
  ...
}: let
  cfg = config.programs.nixvim.plugins.snacks;
  enable =
    cfg.enable
    && ((cfg.settings.gitbrowse.enabled or false) == true)
    && (config.programs.git.enable);
  bind = {
    key = "<leader>go";
    action.__raw = "function () Snacks.gitbrowse() end";
  };
in {
  programs.nixvim.keymaps = lib.mkIf enable (map (m: m // bind) [
    {
      mode = "n";
      options.desc = "Open file in browser";
    }
    {
      mode = "v";
      options.desc = "Open selection in browser";
    }
  ]);
}
