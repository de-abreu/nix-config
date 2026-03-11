let
  prefix = "gc";
in {
  programs.nixvim.keymaps = [
    {
      action = prefix + "c";
      key = "<Leader>/";
      options.desc = "Toggle comment line";
      mode = "n";
    }

    {
      action = prefix;
      key = "<Leader>/";
      options.desc = "Toggle comment";
      mode = "x";
    }

    {
      action = "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>";
      key = prefix + "o";
      options = {
        remap = true;
        desc = "Insert comment after";
      };
      mode = "n";
    }

    {
      action = "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>";
      key = prefix + "O";
      options = {
        remap = true;
        desc = "Insert comment before";
      };
      mode = "n";
    }
  ];
}
