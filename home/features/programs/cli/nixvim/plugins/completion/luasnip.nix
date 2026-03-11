{
  programs.nixvim.plugins = {
    luasnip = {
      enable = true;
      lazyLoad.settings.event = "InsertEnter";

      settings = {
        history = true;
        delete_check_events = "TextChanged";
        region_check_events = "CursorMoved";
      };
    };

    friendly-snippets.enable = true;
    blink-cmp.settings.snippets.preset = "luasnip";
  };
}
