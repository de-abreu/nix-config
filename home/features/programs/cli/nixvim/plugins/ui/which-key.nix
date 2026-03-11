{
  programs.nixvim.plugins.which-key = {
    enable = true;
    lazyLoad.settings.event = "DeferredUIEnter";
    settings.win.boarder = "single";
  };
}
