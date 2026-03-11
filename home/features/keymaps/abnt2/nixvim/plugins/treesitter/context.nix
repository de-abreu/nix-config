{
  programs.nixvim.plugins.treesitter-context.lazyLoad.settings.keys = [
    {
      __unkeyed-1 = "<leader>ut";
      __unkeyed-2 = "<cmd>TSContext toggle<cr>";
      mode = "n";
      desc = "Treesitter Context toggle";
    }
  ];
}
