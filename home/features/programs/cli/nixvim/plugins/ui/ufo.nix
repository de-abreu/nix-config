{
  programs.nixvim = {
    plugins = {
      # 1. The Language Server Plumbing
      # This tells every LSP server you start that your editor supports advanced folding
      lsp.capabilities = ''
        capabilities.textDocument.foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true,
        }
      '';

      # 2. Ultra Fold in One
      nvim-ufo = {
        enable = true;
        lazyLoad.settings.event = ["BufReadPost" "BufNewFile"];
        settings = {
          provider_selector = ''function() return { "lsp", "indent" } end'';
        };
      };
    };

    # 3. Global UI Options
    opts = {
      foldcolumn = "1";
      foldlevel = 99;
      foldlevelstart = 99;
      foldenable = true;
      # Modern folding icons
      fillchars.__raw = "[[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]";
    };
  };
}
