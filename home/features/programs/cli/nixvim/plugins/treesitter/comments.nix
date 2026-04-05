{ config, ... }:
{
  programs.nixvim.plugins.ts-comments = {
    inherit (config.programs.nixvim.plugins.treesitter) enable;
    lazyLoad.settings.event = "DeferredUIEnter";
  };
}
