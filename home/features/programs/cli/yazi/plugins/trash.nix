{ pkgs, ... }:
{
  programs.yazi = {
    plugins = { inherit (pkgs.yaziPlugins) recycle-bin restore; };
    extraPackages = [ pkgs.trashy ];
  };
}
