{
  programs.nixvim.plugins.rainbow-delimeters = {
    enable = true;
    lazyLoad.settings.event = ["BufReadPre" "BufNewFile"];
  };
}
