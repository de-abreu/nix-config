{
  programs.nixvim.plugins.barbecue = {
    enable = true;
    lazyLoad.settings.event = "DeferredUIEnter";
  };
}
