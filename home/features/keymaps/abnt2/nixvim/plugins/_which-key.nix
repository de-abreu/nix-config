{
  programs.nixvim.plugins.which-key.settings.spec = [
    {
      __unkeyed-1 = "<leader>u";
      mode = [
        "n"
        "x"
      ];
      group = "UI/UX";
    }

    {
      __unkeyed-1 = "<leader>g";
      mode = "n";
      group = "Git";
    }
  ];
}
