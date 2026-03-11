{treesitter, ...}: {
  programs.nixvim.plugins.treesitter-context = {
    inherit (treesitter) enable;
    lazyLoad.settings.event = "DeferredUIEnter";

    settings = {
      max_lines = 4;
      min_window_height = 40;
      multiwindow = true;
      separator = "-";
    };
  };
}
