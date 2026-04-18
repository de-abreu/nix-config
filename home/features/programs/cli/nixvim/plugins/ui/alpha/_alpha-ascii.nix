{ pkgs, inputs }:
pkgs.vimUtils.buildVimPlugin {
  pname = "alpha-ascii.nvim";
  version = "master";
  src = inputs.alpha-ascii-nvim;
}
