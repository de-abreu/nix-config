{ config, ... }:
{
  programs.nixvim.plugins.treesitter-context = {
    inherit (config.programs.nixvim.plugins.treesitter) enable;
    lazyLoad.settings.event = "DeferredUIEnter";

    settings = {
      max_lines = 4;
      min_window_height = 40;
      multiwindow = true;
      separator = "-";
    };
  };
}
