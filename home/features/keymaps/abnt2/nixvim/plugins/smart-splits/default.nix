{
  config,
  lib,
  ...
}:
let
  cfg = config.programs.nixvim.plugins.smart-splits;
  modes = {
    mode = [
      "n"
      "i"
      "x"
      "t"
    ];
  };
  resize-windows = map (m: m // modes) [
    {
      key = "<M-j>";
      action.__raw = "function() require('smart-splits').resize_left() end";
      options.desc = "Push vertical split left";
    }
    {
      key = "<M-k>";
      action.__raw = "function() require('smart-splits').resize_down() end";
      options.desc = "Push horizontal split down";
    }
    {
      key = "<M-l>";
      action.__raw = "function() require('smart-splits').resize_up() end";
      options.desc = "Push horizontal split up";
    }
    {
      key = "<M-;>";
      action.__raw = "function() require('smart-splits').resize_right() end";
      options.desc = "Push vertical split right";
    }
  ];

  move-cursor = map (m: m // modes) [
    {
      key = "<C-j>";
      action.__raw = "function() require('smart-splits').move_cursor_left() end";
      options.desc = "Move cursor to left window";
    }
    {
      key = "<C-k>";
      action.__raw = "function() require('smart-splits').move_cursor_down() end";
      options.desc = "Move cursor to window below";
    }
    {
      key = "<C-l>";
      action.__raw = "function() require('smart-splits').move_cursor_up() end";
      options.desc = "Move cursor to window above";
    }
    {
      key = "<C-;>";
      action.__raw = "function() require('smart-splits').move_cursor_right() end";
      options.desc = "Move cursor to right window";
    }
  ];

  swap-buffers =
    map
      (
        m:
        m
        // {
          mode = [
            "n"
            "x"
          ];
        }
      )
      [
        {
          key = "J";
          action.__raw = "function() require('smart-splits').swap_buf_left() end";
          options.desc = "Swap the current buffer with the one to the left";
        }
        {
          key = "K";
          action.__raw = "function() require('smart-splits').swap_buf_down() end";
          options.desc = "Swap the current buffer with the one below";
        }
        {
          key = "L";
          action.__raw = "function() require('smart-splits').swap_buf_up() end";
          options.desc = "Swap current buffer with the one above";
        }
        {
          key = "<S-Ç>";
          action.__raw = "function() require('smart-splits').swap_buf_right() end";
          options.desc = "Swap current buffer with the one to the right";
        }
      ];
in
{
  programs = {
    nixvim.keymaps = lib.optionals cfg.enable (resize-windows ++ move-cursor ++ swap-buffers);

    # Wezterm integration untouched
    wezterm.extraConfig."keybinds.smart-splits" = ./smart-splits.lua;
  };
}
