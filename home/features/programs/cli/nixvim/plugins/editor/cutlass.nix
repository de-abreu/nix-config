{
  programs.nixvim.plugins.cutlass-nvim = {
    enable = true;
    lazyLoad.settings.event = "BufEnter";
    settings.override_del = true;
  };
}
