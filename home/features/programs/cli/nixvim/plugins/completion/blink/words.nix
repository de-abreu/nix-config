{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = [ pkgs.vimPlugins.blink-cmp-words ];
    extraPackages = [ pkgs.wordnet ];
  };
}
