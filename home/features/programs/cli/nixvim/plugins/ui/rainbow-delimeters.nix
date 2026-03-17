{ pkgs, ... }:
{
  extra.lz-n.plugins = [
    {
      plugin = pkgs.vimPlugins.rainbow-delimiters-nvim;
      event = [
        "BufReadPre"
        "BufNewFile"
      ];
    }
  ];
}
