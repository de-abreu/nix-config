{
  programs.nixvim.keymaps = [
    {
      action = "<cmd>w<cr>";
      key = "<Leader>w";
      options.desc = "Save file";
      mode = "n";
    }

    {
      action = "<cmd>confirm q<cr>";
      key = "<Leader>q";
      options.desc = "Close window";
      mode = "n";
    }

    {
      action = "<cmd>confirm qall<cr>";
      key = "<Leader>Q";
      options.desc = "Quit Nixvim";
      mode = "n";
    }

    {
      action = "<cmd>enew<cr>";
      key = "<Leader>n";
      options.desc = "New file";
      mode = "n";
    }

    {
      action = "gg^";
      key = "gg";
      options.desc = "Move cursor to the first character";
      mode = "n";
    }

    {
      action = "GG$";
      key = "GG";
      options.desc = "Move cursor to the last character";
      mode = "n";
    }

    {
      action = ">gv";
      key = ">";
      options.desc = "Indent selection";
      mode = "v";
    }

    {
      action = "<gv";
      key = "<";
      options.desc = "Dedent selection";
      mode = "v";
    }

    {
      action = "^y$";
      key = "yy";
      options.desc = "Yank line";
      mode = "n";
    }

    {
      key = "<leader>o";
      action = "<cmd>only<CR>";
      options = {
        silent = true;
        desc = "Close all other windows";
      };
      mode = "n";
    }

    {
      action = ":sort<cr>";
      key = "<leader>S";
      options.desc = "Sort";
      mode = "v";
    }
  ];
}
