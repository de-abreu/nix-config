{
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    waybar # system bar
    playerctl # media player cli
    gobject-introspection # for python packages
    (python3.withPackages (ps: with ps; [ pygobject3 ])) # python with pygobject3
    python-pyamdgpuinfo # AMD GPU information library
    lm_sensors # sensors information library
    power-profiles-daemon # power profiles daemon
  ];
  xdg.configFile =
    let
      waybarCfg = "${pkgs.hyde}/Configs/.config/waybar";
    in
    {
      "waybar/config.jsonc".source = ./config.jsonc;

      "waybar/style.css".source = ./style.css;

      "waybar/modules" = {
        source = "${waybarCfg}/modules";
        recursive = true;
      };

      "waybar/layouts" = {
        source = "${waybarCfg}/layouts";
        recursive = true;
      };

      "waybar/styles" = {
        source = "${waybarCfg}/styles";
        recursive = true;
      };

      "waybar/includes" = {
        source = ./includes;
        recursive = true;
      };

      "waybar/includes/includes.json".text =
        # json
        ''
          {
            "include": [
              "${config.xdg.configHome}/waybar/modules/backlight.jsonc",
              "${config.xdg.configHome}/waybar/modules/battery.jsonc",
              "${config.xdg.configHome}/waybar/modules/bluetooth.jsonc",
              "${config.xdg.configHome}/waybar/modules/cava.jsonc",
              "${config.xdg.configHome}/waybar/modules/cliphist.jsonc",
              "${config.xdg.configHome}/waybar/modules/clock##alt.jsonc",
              "${config.xdg.configHome}/waybar/modules/clock.jsonc",
              "${config.xdg.configHome}/waybar/modules/cpu.jsonc",
              "${config.xdg.configHome}/waybar/modules/cpuinfo.jsonc",
              "${config.xdg.configHome}/waybar/modules/display.jsonc",
              "${config.xdg.configHome}/waybar/modules/footer.jsonc",
              "${config.xdg.configHome}/waybar/modules/github_hyde.jsonc",
              "${config.xdg.configHome}/waybar/modules/github_hyprdots.jsonc",
              "${config.xdg.configHome}/waybar/modules/gpuinfo.jsonc",
              "${config.xdg.configHome}/waybar/modules/header.jsonc",
              "${config.xdg.configHome}/waybar/modules/hyprsunset.jsonc",
              "${config.xdg.configHome}/waybar/modules/idle_inhibitor.jsonc",
              "${config.xdg.configHome}/waybar/modules/keybindhint.jsonc",
              "${config.xdg.configHome}/waybar/modules/language.jsonc",
              "${config.xdg.configHome}/waybar/modules/memory.jsonc",
              "${config.xdg.configHome}/waybar/modules/mpris.jsonc",
              "${config.xdg.configHome}/waybar/modules/network.jsonc",
              "${config.xdg.configHome}/waybar/modules/notifications.jsonc",
              "${config.xdg.configHome}/waybar/modules/power.jsonc",
              "${config.xdg.configHome}/waybar/modules/privacy.jsonc",
              "${config.xdg.configHome}/waybar/modules/pulseaudio#microphone.jsonc",
              "${config.xdg.configHome}/waybar/modules/pulseaudio.jsonc",
              "${config.xdg.configHome}/waybar/modules/sensorsinfo.jsonc",
              "${config.xdg.configHome}/waybar/modules/spotify.jsonc",
              "${config.xdg.configHome}/waybar/modules/taskbar##custom.jsonc",
              "${config.xdg.configHome}/waybar/modules/taskbar##windows.jsonc",
              "${config.xdg.configHome}/waybar/modules/taskbar.jsonc",
              "${config.xdg.configHome}/waybar/modules/theme.jsonc",
              "${config.xdg.configHome}/waybar/modules/tray.jsonc",
              "${config.xdg.configHome}/waybar/modules/updates.jsonc",
              "${config.xdg.configHome}/waybar/modules/wallchange.jsonc",
              "${config.xdg.configHome}/waybar/modules/wbar.jsonc",
              "${config.xdg.configHome}/waybar/modules/weather.jsonc",
              "${config.xdg.configHome}/waybar/modules/window.jsonc",
              "${config.xdg.configHome}/waybar/modules/workspaces##kanji.jsonc",
              "${config.xdg.configHome}/waybar/modules/workspaces##roman.jsonc",
              "${config.xdg.configHome}/waybar/modules/workspaces.jsonc",
              "${config.xdg.configHome}/waybar/modules/hyprland-window.jsonc",
              "${config.xdg.dataHome}/waybar/modules/wlr-taskbar#windows.json",
              "${config.xdg.dataHome}/waybar/modules/wlr-taskbar.json",
              "${config.xdg.dataHome}/waybar/modules/privacy.json",
              "${config.xdg.dataHome}/waybar/modules/tray.json",
              "${config.xdg.dataHome}/waybar/modules/custom-cava.jsonc",
              "${config.xdg.dataHome}/waybar/modules/custom-clipboard.jsonc",
              "${config.xdg.dataHome}/waybar/modules/custom-cliphist.jsonc",
              "${config.xdg.dataHome}/waybar/modules/custom-cpuinfo.jsonc",
              "${config.xdg.dataHome}/waybar/modules/custom-display.jsonc",
              "${config.xdg.dataHome}/waybar/modules/custom-dunst.jsonc",
              "${config.xdg.dataHome}/waybar/modules/custom-gamemode.jsonc",
              "${config.xdg.dataHome}/waybar/modules/custom-github_hyde.jsonc",
              "${config.xdg.dataHome}/waybar/modules/custom-gpuinfo#amd.jsonc",
              "${config.xdg.dataHome}/waybar/modules/custom-gpuinfo#intel.jsonc",
              "${config.xdg.dataHome}/waybar/modules/custom-gpuinfo#nvidia.jsonc",
              "${config.xdg.dataHome}/waybar/modules/custom-gpuinfo.jsonc",
              "${config.xdg.dataHome}/waybar/modules/custom-hyprsunset.jsonc",
              "${config.xdg.dataHome}/waybar/modules/custom-keybindhint.jsonc",
              "${config.xdg.dataHome}/waybar/modules/custom-power.jsonc",
              "${config.xdg.dataHome}/waybar/modules/custom-powermenu.jsonc",
              "${config.xdg.dataHome}/waybar/modules/custom-sensorsinfo.jsonc",
              "${config.xdg.dataHome}/waybar/modules/custom-spotify.jsonc",
              "${config.xdg.dataHome}/waybar/modules/custom-theme.jsonc",
              "${config.xdg.dataHome}/waybar/modules/custom-updates.jsonc",
              "${config.xdg.dataHome}/waybar/modules/custom-wallchange.jsonc",
              "${config.xdg.dataHome}/waybar/modules/custom-wbar.jsonc",
              "${config.xdg.dataHome}/waybar/modules/custom-weather.jsonc",
              "${config.xdg.dataHome}/waybar/modules/hyprland-language.jsonc",
              "${config.xdg.dataHome}/waybar/modules/hyprland-workspaces.jsonc",
              "${config.xdg.dataHome}/waybar/modules/custom-swaync.jsonc",
              "${config.xdg.dataHome}/waybar/modules/wlr-taskbar.jsonc",
              "${config.xdg.dataHome}/waybar/modules/wlr-taskbar#windows.jsonc",
              "${config.xdg.dataHome}/waybar/modules/clock.jsonc",
              "${config.xdg.dataHome}/waybar/modules/cpu.jsonc",
              "${config.xdg.dataHome}/waybar/modules/idle_inhibitor.jsonc",
              "${config.xdg.dataHome}/waybar/modules/memory.jsonc",
              "${config.xdg.dataHome}/waybar/modules/mpris.jsonc",
              "${config.xdg.dataHome}/waybar/modules/network.jsonc",
              "${config.xdg.dataHome}/waybar/modules/privacy.jsonc",
              "${config.xdg.dataHome}/waybar/modules/pulseaudio.jsonc",
              "${config.xdg.dataHome}/waybar/modules/pulseaudio#microphone.jsonc",
              "${config.xdg.dataHome}/waybar/modules/tray.jsonc",
              "${config.xdg.dataHome}/waybar/modules/power-profiles-daemon.jsonc",
              "${config.xdg.dataHome}/waybar/modules/image#hyde-menu.jsonc",
              "${config.xdg.dataHome}/waybar/modules/custom-hyde-menu.jsonc",
              "${config.xdg.dataHome}/waybar/modules/network#bandwidth.jsonc",
              "${config.xdg.configHome}/waybar/modules/custom-mediaplayer.jsonc",
              "${config.xdg.configHome}/waybar/modules/gamemode.jsonc",
              "${config.xdg.configHome}/waybar/modules/group-eyecare.jsonc",
              "${config.xdg.configHome}/waybar/modules/group-hide-tray.jsonc",
              "${config.xdg.configHome}/waybar/modules/group-mediaplayer.jsonc",
              "${config.xdg.configHome}/waybar/modules/group-volumecontrol.jsonc",
              "${config.xdg.configHome}/waybar/modules/mpd.jsonc",
              "${config.xdg.configHome}/waybar/modules/temperature.jsonc"
            ],
            "wlr/taskbar#windows": {
                "icon-size": 16.0,
                "icon-size-multiplier": 1.6
            },
            "wlr/taskbar": {
                "icon-size": 16.0,
                "icon-size-multiplier": 1.6
            },
            "privacy": {
                "icon-size": 10,
                "icon-size-multiplier": 1
            },
            "tray": {
                "icon-size": 16.0,
                "icon-size-multiplier": 1.6
            }
          }
        '';

      "waybar/modules/hyprland-window.jsonc".source = ./user-modules/hyprland-window.jsonc;
    };
}
