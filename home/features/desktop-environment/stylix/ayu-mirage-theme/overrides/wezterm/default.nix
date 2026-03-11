{
  config,
  lib,
  pkgs,
  ...
}: let
  colorscheme = "${pkgs.vimPlugins.astrotheme}/extras/wezterm/astrodark.toml";
in {
  config = lib.mkIf config.programs.wezterm.enable {
    stylix.targets.wezterm.enable = false;
    programs.wezterm.extraConfig."appearance" =
      # lua
      ''
        local wezterm = require("wezterm")
        local module = {}

        function module.apply_to_config(config)
          config.color_scheme = astrodark
        end

        return module
      '';
    xdg.configFile."wezterm/colors/astrodark.toml".source = colorscheme;
  };
}
