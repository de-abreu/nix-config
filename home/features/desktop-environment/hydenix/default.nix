# INFO: Hydenix desktop environment
{
  importAll,
  inputs,
  ...
}: {
  imports = [inputs.hydenix.homeModules.default] ++ importAll ./.;

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
      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitors.overrideConfig = "monitor=, prefered, auto, 1";
    };
  };
}
