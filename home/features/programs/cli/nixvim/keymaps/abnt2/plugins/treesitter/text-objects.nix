{
  programs.nixvim.plugins.treesitter-textobjects.settings = {
    select.keymaps = {
      aa = "@parameter.outer";
      ia = "@parameter.inner";
      af = "@function.outer";
      "if" = "@function.inner";
      ac = "@class.outer";
      ic = "@class.inner";
      ii = "@conditional.inner";
      ai = "@conditional.outer";
      il = "@loop.inner";
      al = "@loop.outer";
      at = "@comment.outer";
    };
    move = {
      gotoNextStart = {
        "]m" = "@function.outer";
        "]]" = "@class.outer";
      };
      gotoNextEnd = {
        "]M" = "@function.outer";
        "][" = "@class.outer";
      };
      gotoPreviousStart = {
        "[m" = "@function.outer";
        "[[" = "@class.outer";
      };
      gotoPreviousEnd = {
        "[M" = "@function.outer";
        "[]" = "@class.outer";
      };
    };
    swap = {
      swapNext = {
        "<leader>a" = "@parameters.inner";
      };
      swapPrevious = {
        "<leader>A" = "@parameter.outer";
      };
    };
  };
}
