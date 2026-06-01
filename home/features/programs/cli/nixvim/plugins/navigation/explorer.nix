{
  programs.nixvim.plugins.snacks.settings = {
    explorer.enabled = true;

    picker.sources.explorer = {
      cycle = true;
      auto_close = true;
      layout.preview = "main";
    };
  };
}
