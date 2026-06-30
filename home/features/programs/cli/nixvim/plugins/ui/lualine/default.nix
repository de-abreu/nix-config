{
  imports = [ ./_recording.nix ];
  programs.nixvim.plugins.lualine = {
    enable = true;
    lazyLoad.settings.event = "DeferredUIEnter";
  };
}
