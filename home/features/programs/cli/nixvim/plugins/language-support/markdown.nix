{
  lib,
  pkgs,
  ...
}:
{
  extra.lz-n.plugins = [
    {
      plugin = pkgs.vimPlugins.markdown-preview-nvim;
      ft = [ "markdown" ];
    }
  ];

  programs.nixvim = {
    plugins = {
      lsp.servers.marksman.enable = true;

      conform-nvim.settings.formatters_by_ft.markdown = [ "deno_fmt" ];

      lint = {
        lintersByFt.markdown = [ "markdownlint" ];
        linters.markdownlint.cmd = lib.getExe pkgs.markdownlint-cli;
      };

      render-markdown = {
        enable = true;

        lazyLoad.settings = {
          event = [
            "BufReadPre *.md"
            "BufNewFile *.md"
            "BufReadPre *.markdown"
            "BufNewFile *.markdown"
          ];
          ft = [
            "markdown"
          ];
        };
      };
    };
  };
}
