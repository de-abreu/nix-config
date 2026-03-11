{
  programs.nixvim.plugins.precognition = {
    enable = true;
    settings.startVisible = false;
    lazyLoad.settings.event = "DeferredUIEnter";
  };
}
