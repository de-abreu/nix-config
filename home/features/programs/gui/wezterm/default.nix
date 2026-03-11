{
  programs.wezterm = {
    enable = true;
    extraConfig = {
      "multiplexing" = ./modules/multiplexing.lua;
      "rendering" = ./modules/rendering.lua;
      "scrollback-nvim" = ./modules/scrollback-nvim.lua;
      "tab-bar" = ./modules/tab-bar.lua;
    };
  };

  home.sessionVariables.TERMINAL = "wezterm";
}
