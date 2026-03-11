{
  programs.nixvim.keymaps = [
    {
      action = "v:count == 0? 'gj' : 'j'";
      key = "k";
      options = {
        desc = "Move cursor down";
        expr = true;
        silent = true;
      };
      mode = ["n" "o" "x"];
    }

    {
      action = "v:count == 0? 'gk' : 'k'";
      key = "l";
      options = {
        desc = "Move cursor up";
        expr = true;
        silent = true;
      };
      mode = ["n" "o" "x"];
    }

    {
      action = "h";
      key = "j";
      options = {
        desc = "Move cursor left";
        silent = true;
      };
      mode = ["n" "o" "x"];
    }

    {
      action = "l";
      key = "ç";
      options = {
        desc = "Move cursor right";
        silent = true;
      };
      mode = ["n" "o" "x"];
    }
  ];
}
