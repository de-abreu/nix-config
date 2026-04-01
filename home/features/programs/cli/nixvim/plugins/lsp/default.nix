{ importAll, ... }:
{
  imports = importAll { dir = ./.; };
  programs.nixvim.plugins.lsp.enable = true;
}
