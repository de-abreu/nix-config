{ config, lib, ... }:
with lib;
let
  wezterm-floating = getExe config.programs.wezterm.floatingPackage;
in {
  options.programs.zathura.floatingWindow = mkOption {
    type = types.functionTo types.str;
    default = cmd: "${wezterm-floating} ${cmd}";
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
