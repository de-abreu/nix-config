{ config, lib, ... }:
with lib;
{
  options.programs.zathura.floatingWindow = mkOption {
    type = types.functionTo types.str;
    default =
      let
        wezterm = getExe config.programs.wezterm.package;
      in
      cmd:
      "${wezterm} --config enable_tab_bar=false --config initial_cols=120 --config initial_rows=40 start --class floating -- ${cmd}";
    description = "A function that wraps a command in a floating wezterm window.";
  };

  config = {
    programs.zathura = {
      enable = true;
      options.selection-clipboard = "clipboard";
    };

    xdg.mimeApps.defaultApplications."application/pdf" = "org.pwmt.zathura.desktop";
  };
}
