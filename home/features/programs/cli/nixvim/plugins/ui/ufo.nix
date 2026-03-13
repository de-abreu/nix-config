{
  programs.nixvim = {
    plugins.nvim-ufo = {
      enable = true;
      lazyLoad.settings.event = ["BufReadPost" "BufNewFile"];
      settings = {
        provider_selector = ''function() return { "lsp", "indent" } end'';
      };
    };

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
