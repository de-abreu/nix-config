{
  programs.nixvim.keymaps = [
    {
      action = "'Nn'[v:searchforward].'zv'";
      key = "n";
      options = {
        desc = "Next search result";
        expr = true;
      };
      mode = "n";
    }

    {
      action = "'Nn'[v:searchforward]";
      key = "n";
      options = {
        desc = "Next search result";
        expr = true;
      };
      mode = [
        "o"
        "x"
      ];
    }

    {
      action = "'nN'[v:searchforward].'zv'";
      key = "N";
      options = {
        desc = "Previous search result";
        expr = true;
      };
      mode = "n";
    }

    {
      action = "'nN'[v:searchforward]";
      key = "N";
      options = {
        desc = "Previous search result";
        expr = true;
      };
      mode = [
        "o"
        "x"
      ];
    }
  ];
}
