{
  lib,
  pkgs,
  ...
}: {
  programs.nixvim = {
    extraConfigLuaPre =
      lib.mkOrder 1
      # lua
      ''
        if vim.env.PROF then
          local snacks = "${pkgs.vimPlugins.snacks-nvim}"
          vim.opt.rtp:append(snacks)
          require("snacks.profiler").startup({
            startup = {
              -- stop profiler on this event. Defaults to `VimEnter`
              event = "UIEnter",
            },
          })
        end
      '';

    plugins.snacks.settings.profiler.enabled = true;
  };
}
