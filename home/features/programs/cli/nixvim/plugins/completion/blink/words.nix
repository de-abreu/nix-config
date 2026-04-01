{ pkgs, ... }:
{
  programs.nixvim.extraPlugins = [
    { plugin = pkgs.vimPlugins.blink-cmp-words; }
  ];

  programs.nixvim.extraPackages = [ pkgs.wordnet ];
}
