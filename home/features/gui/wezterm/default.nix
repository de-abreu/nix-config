{
  programs.wezterm = {
    enable = true;
    extraConfig = {
      "keybinds.overrides" = ./modules/keybinds/overrides.lua;
      "keybinds.panes-and-tabs" = ./modules/keybinds/panes-and-tabs.lua;
      "multiplexing" = ./modules/multiplexing.lua;
      "rendering" = ./modules/rendering.lua;
      "scrollback-nvim" = ./modules/scrollback-nvim.lua;
      "tab-bar" = ./modules/tab-bar.lua;
    };
  };

  home.sessionVariables.TERMINAL = "wezterm";
}
