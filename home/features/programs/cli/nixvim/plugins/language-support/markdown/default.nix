{
  importAll,
  lib,
  pkgs,
  ...
}:
{
  imports = importAll { dir = ./.; };

  programs.nixvim.plugins = {
    lsp.servers.marksman.enable = true;
    conform-nvim.settings.formatters_by_ft.markdown = [ "deno_fmt" ];
    lint = {
      lintersByFt.markdown = [ "markdownlint" ];
      linters.markdownlint.cmd = lib.getExe pkgs.markdownlint-cli;
    };
  };
}
