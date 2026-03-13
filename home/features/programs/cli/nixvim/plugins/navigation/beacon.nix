# INFO: Whenever the cursor jumps the entire line where it lands blinks, making
# it easier after quick movements
{pkgs, ...}: let
  beacon = pkgs.vimUtils.buildVimPlugin {
    pname = "beacon.nvim";
    version = "master";
    src = pkgs.fetchFromGitHub {
      owner = "DanilaMihailov";
      repo = "beacon.nvim";
      rev = "098ff96c33874339d5e61656f3050dbd587d6bd5";
      hash = "sha256-x/79mRkwwT+sNrnf8QqocsaQtM+Rx6BUvVj5Nnv5JDY=";
    };
  };
in {
  programs.nixvim.extraPlugins = [beacon];
  extra.lz-n.plugins = [
    {
      name = "beacon.nvim";
      event = "DeferredUIEnter";
    }
  ];
}
