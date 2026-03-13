{
  programs.nixvim.plugins = {
    luasnip = {
      enable = true;
      lazyLoad.settings.event = "InsertEnter";
      fromVscode = [{}];

      settings = {
        history = true;
        delete_check_events = "TextChanged";
        region_check_events = "CursorMoved";
      };
    };

    blink-cmp.settings.snippets.preset = "luasnip";
    friendly-snippets.enable = true;
    neogen.settings.snippet_engine = "luasnip";
  };
}
