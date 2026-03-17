{ pkgs, ... }:
{
  extra.lz-n.plugins = [
    {
      plugin = pkgs.vimPlugins.tabular;
      cmd = [ "Tabular" ];
    }
  ];
}
