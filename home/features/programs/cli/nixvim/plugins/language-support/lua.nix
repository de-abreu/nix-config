{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim.plugins = {
    lsp.servers.lua_ls.enable = true;
    lazydev.enable = true;

    conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft.lua = ["stylua"];
        formatters.stylua.command = lib.getExe pkgs.stylua;
      };
    };
  };
}
