let
  prefix = "gc";
in
{
  programs.nixvim.keymaps = [
    {
      action = prefix + "c";
      key = "<leader>/";
      mode = "n";
      options = {
        desc = "Toggle comment line";
        remap = true;
      };
    }

    {
      action = prefix;
      key = "<leader>/";
      mode = "x";
      options = {
        desc = "Toggle comment";
        remap = true;
      };
    }

    {
      action = "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>";
      key = prefix + "o";
      options = {
        desc = "Insert comment after";
        remap = true;
      };
      mode = "n";
    }

    {
      action = "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>";
      key = prefix + "O";
      options = {
        desc = "Insert comment before";
        remap = true;
      };
      mode = "n";
    }
  ];
}
