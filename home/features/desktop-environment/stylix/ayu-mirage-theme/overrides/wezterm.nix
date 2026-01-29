{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.programs.wezterm.enable {
    stylix.targets.wezterm.enable = false;
    programs.wezterm.extraConfig."appearance" = with config.lib.stylix.colors;
    with config.stylix.fonts;
    # lua
      ''
        local wezterm = require("wezterm")
        local module = {}

        function module.apply_to_config(config)
          -- Colorscheme
          local theme = "Ayu Mirage"
          local custom = wezterm.color.get_builtin_schemes()[theme]
          custom.background = "${base00}"
          custom.cursor_bg = "${base07}"
          custom.tab_bar = {
          background = "${base01}",
            new_tab = {
              bg_color = "${base01}",
              fg_color = "${base07}",
            },
          }
          custom.cursor_border = custom.cursor_bg
          config.color_schemes = { [theme] = custom }
          config.color_scheme = theme

          -- Font settings
          config.warn_about_missing_glyphs = false
          config.font = wezterm.font_with_fallback {
            "${monospace.name}",
            "${emoji.name}",
          }
          config.font_size = ${toString sizes.terminal}
          config.line_height = 1.2

          -- Windows and tabs
          config.window_decorations = "NONE"
          config.tab_bar_at_bottom = true
          config.use_fancy_tab_bar = false
          config.hide_tab_bar_if_only_one_tab = false
        end

        return module
      '';
  };
}
