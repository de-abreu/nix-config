{
  pkgs,
  lib,
  ...
}:
{
  programs.nixvim.plugins = {
    lsp.servers.lua_ls.enable = true;
    lazydev.enable = true;

    blink-cmp.settings.sources.providers.lazydev = {
      name = "LazyDev";
      module = "lazydev.integrations.blink";
      score_offset = 100;
    };

    conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft.lua = [ "stylua" ];
        formatters.stylua.command = lib.getExe pkgs.stylua;
      };
    };
  };
}
