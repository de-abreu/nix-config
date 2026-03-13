{
  programs.nixvim.plugins = {
    nvim-surround.settings.keymaps = {
      normal = "s";
      normal_cur = "ss";
      normal_line = "S";
      normal_cur_line = "SS";
      visual = "s";
      visual_line = "S";
      delete = "ds";
      change = "cs";
      change_line = "cS";
    };
    cutlass-nvim.settings.exclude = [
      "s"
      "S"
    ];
  };
}
