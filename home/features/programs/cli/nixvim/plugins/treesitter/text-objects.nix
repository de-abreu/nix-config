{treesitter, ...}: {
  programs.nixvim.plugins.treesitter-textobjects = {
    inherit (treesitter) enable;
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
