{treesitter, ...}: {
  programs.nixvim.plugins.ts-comments = {
    inherit (treesitter) enable;
    lazyLoad.settings.event = "DeferredUIEnter";
  };
}
