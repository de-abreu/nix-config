{ inputs, ... }:
{
  programs.yazi = {
    plugins = { inherit (inputs) smart-arrow; };
    yaziPlugins.require.smart-arrow = { };
  };
}
