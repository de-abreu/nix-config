{
  programs.wezterm = {
    enable = true;
    extraConfig = {
      "multiplexing" = ./multiplexing.lua;
      "rendering" = ./rendering.lua;
      "scrollback-nvim" = ./scrollback-nvim.lua;
      "tab-bar" = ./tab-bar.lua;
    };
  };

  home.sessionVariables.TERMINAL = "wezterm";
}
