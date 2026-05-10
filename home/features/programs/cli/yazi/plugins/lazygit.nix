{ pkgs, ... }:
{
  programs.yazi = {
    extraPackages = [ pkgs.lazygit ];
    plugins = { inherit (pkgs.yaziPlugins) lazygit; };
  };
}
