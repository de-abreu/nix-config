{
  lib,
  mkAction,
  pluginCfg,
  ...
}: let
  action = func: mkAction "smart-splits" func {};
  resize-windows = map (m: m // {mode = "n";}) [
    {
      key = "<M-j>";
      action = action "resize_left";
      options.desc = "Push vertical split left";
    }
    {
      key = "<M-k>";
      action = action "resize_down";
      options.desc = "Push horizontal split down";
    }
    {
      key = "<M-l>";
      action = action "resize_up";
      options.desc = "Push horizontal split up";
    }
    {
      key = "<M-;>";
      action = action "resize_right";
      options.desc = "Push vertical split right";
    }
  ];

  move-cursor = map (m: m // {mode = "n";}) [
    {
      key = "<C-j>";
      action = action "move_cursor_left";
      options.desc = "Move cursor to left window";
    }
    {
      key = "<C-k>";
      action = action "move_cursor_down";
      options.desc = "Move cursor to window below";
    }
    {
      key = "<C-l>";
      action = action "move_cursor_up";
      options.desc = "Move cursor to window above";
    }
    {
      key = "<C-;>";
      action = action "move_cursor_right";
      options.desc = "Move cursor to right window";
    }
  ];

  swap-buffers = map (m: m // {mode = "n";}) [
    {
      key = "J";
      action = action "swap_buf_left";
      options.desc = "Swap the current buffer with the one to the left";
    }
    {
      key = "K";
      action = action "swap_buf_down";
      options.desc = "Swap the current buffer with the one below";
    }
    {
      key = "L";
      action = action "swap_buf_up";
      options.desc = "Swap current buffer with the one above";
    }
    {
      key = "<S-Ç>";
      action = action "swap_buf_right";
      options.desc = "Swap current buffer with the one to the right";
    }
  ];
in {
  programs = {
    nixvim.keymaps = lib.mkIf pluginCfg.smart-splits.enable (resize-windows ++ move-cursor ++ swap-buffers);

    # Wezterm integration untouched
    wezterm.extraConfig."keybinds.smart-splits" = ./smart-splits.lua;
  };
}
