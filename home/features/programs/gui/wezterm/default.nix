{
  inputs,
  ...
}:
{
  programs.wezterm = {
    enable = true;
    extraConfig = {
      "multiplexing" = ./multiplexing.lua;
      "rendering" = ./rendering.lua;
      "scrollback-nvim" = ./scrollback-nvim.lua;
      "tab-bar" = ./tab-bar.lua;
    };
    plugins = { inherit (inputs) tabline-wez; };
  };

  home.sessionVariables.TERMINAL = "wezterm";
}
