{
  inputs,
  ...
}:
{
  programs.wezterm = {
    extraConfig = {
      "keybinds.overrides" = ./overrides.lua;
      "keybinds.panes-and-tabs" = ./panes-and-tabs.lua;
      "keybinds.unicode-input" = ./unicode-input.lua;
    };
    plugins = { inherit (inputs) wezterm-unicode-input; };
  };
}
