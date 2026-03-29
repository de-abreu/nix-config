{ pkgs, ... }:
{
  programs.nixvim.extraPlugins = [
    {
      plugin = pkgs.vimPlugins.rainbow-delimiters-nvim;
      optional = true;
    }
  ];

  extra.lz-n.plugins = [
    {
      __unkeyed-1 = "rainbow-delimiters.nvim";
      event = [
        "BufReadPre"
        "BufNewFile"
      ];
    }
  ];
}
