{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = [
      { plugin = pkgs.vimPlugins.blink-cmp-words; }
    ];

    extraPackages = [ pkgs.wordnet ];
  };
}
