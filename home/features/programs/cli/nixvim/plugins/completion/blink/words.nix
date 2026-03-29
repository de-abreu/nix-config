{ pkgs, ... }:
{
  programs.nixvim.extraPlugins = [
    {
      plugin = pkgs.vimPlugins.blink-cmp-words;
      optional = true;
    }
  ];

  extra.lz-n.plugins = [
    {
      __unkeyed-1 = "blink-cmp-words";
      event = [
        "InsertEnter"
        "CmdlineEnter"
      ];
    }
  ];

  programs.nixvim.extraPackages = [ pkgs.wordnet ];
}
