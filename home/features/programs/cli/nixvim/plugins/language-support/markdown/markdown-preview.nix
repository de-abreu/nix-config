{ pkgs, ... }:
{
  programs.nixvim.plugins.markdown-preview = {
    enable = true;
    package = pkgs.unstable.vimPlugins.markdown-preview-nvim;
    autoLoad = true;
  };
}
