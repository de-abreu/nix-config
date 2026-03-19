{
  config,
  pkgs,
  ...
}:
{
  home = {
    packages = with pkgs; [
      waybar # system bar
      playerctl # media player cli
      gobject-introspection # for python packages
      (python3.withPackages (ps: with ps; [ pygobject3 ])) # python with pygobject3
      python-pyamdgpuinfo # AMD GPU information library
      lm_sensors # sensors information library
      power-profiles-daemon # power profiles daemon
    ];
    file = {
      "${config.xdg.dataHome}/waybar" = {
        source = ./data;
        recursive = true;
      };
      "${config.xdg.configHome}/waybar" = {
        source = ./config;
        recursive = true;
      };
    };
  };
}
