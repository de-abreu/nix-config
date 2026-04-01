# INFO: Hydenix desktop environment
{
  importAll,
  inputs,
  lib,
  ...
}:
{
  imports = [ inputs.hydenix.homeModules.default ] ++ importAll { dir = ./.; };

  hydenix.hm = {
    enable = true;

    # Overrides to default values.
    editors.enable = false;
    fastfetch.enable = false;
    firefox.enable = false;
    git.enable = false;
    shell.enable = false;
    social.enable = false;
    spotify.enable = false;
    terminals.enable = false;
    hyprland = {
      suppressWarnings = true;
      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitors.overrideConfig = "monitor=, preferred, auto, 1";
    };
    waybar.enable = false;
  };
  home.activation.setLockScreen = lib.dm.dag.entryAfter [
    "writeBoundary"
  ] "hyde-shell hyprlock --background";
}
