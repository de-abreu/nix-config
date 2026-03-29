{ pkgs, ... }:
{
  programs.nixvim.extraPlugins = [
    {
      plugin = pkgs.vimPlugins.tabular;
      optional = true;
    }
  ];

  extra.lz-n.plugins = [
    {
      __unkeyed-1 = "tabular";
      cmd = [ "Tabular" ];
    }
  ];
}
