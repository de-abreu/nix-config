{ inputs, ... }:
{
  programs.yazi = {
    plugins = { inherit (inputs) yaziline; };
    yaziPlugins.require.yaziline = { };
  };
}
