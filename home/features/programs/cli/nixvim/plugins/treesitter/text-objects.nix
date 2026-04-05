{ config, ... }:
{
  programs.nixvim.plugins.treesitter-textobjects = {
    inherit (config.programs.nixvim.plugins.treesitter) enable;
    settings = {
      select = {
        enable = true;
        lookahead = true;
      };
      move.enable = true;
      swap.enable = true;
    };
  };
}
