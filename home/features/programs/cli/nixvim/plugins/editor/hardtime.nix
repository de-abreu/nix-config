{
  programs.nixvim.plugins.hardtime = {
    enable = true;
    lazyLoad.settings.event = "DeferredUIEnter";

    settings = {
      disabled_keys.__raw = ''
        {
          ["<Up>"] = {},
          ["<Down>"] = {},
          ["<Left>"] = {},
          ["<Right>"] = {},
        }
      '';

      restricted_keys = {
        "<Up>" = [ "" ];
        "<Down>" = [ "" ];
        "<Left>" = [ "" ];
        "<Right>" = [ "" ];
      };
    };
  };
}
