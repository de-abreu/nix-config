{ config, lib }:
let
  cfgHome = "${config.xdg.configHome}/waybar/modules";
  dataHome = "${config.xdg.dataHome}/waybar/modules";

  configModules = map (f: "${cfgHome}/${f}") [
    "backlight.jsonc"
    "battery.jsonc"
    "bluetooth.jsonc"
    "cava.jsonc"
    "cliphist.jsonc"
    "clock##alt.jsonc"
    "clock.jsonc"
    "cpu.jsonc"
    "cpuinfo.jsonc"
    "custom-hyde-menu.jsonc"
    "custom-mediaplayer.jsonc"
    "display.jsonc"
    "footer.jsonc"
    "gamemode.jsonc"
    "github_hyde.jsonc"
    "github_hyprdots.jsonc"
    "gpuinfo.jsonc"
    "group-eyecare.jsonc"
    "group-hide-tray.jsonc"
    "group-mediaplayer.jsonc"
    "group-volumecontrol.jsonc"
    "header.jsonc"
    "hyprland-window.jsonc"
    "hyprsunset.jsonc"
    "idle_inhibitor.jsonc"
    "keybindhint.jsonc"
    "language.jsonc"
    "memory.jsonc"
    "mpd.jsonc"
    "mpris.jsonc"
    "network.jsonc"
    "notifications.jsonc"
    "power.jsonc"
    "privacy.jsonc"
    "pulseaudio#microphone.jsonc"
    "pulseaudio.jsonc"
    "sensorsinfo.jsonc"
    "spotify.jsonc"
    "taskbar##custom.jsonc"
    "taskbar##windows.jsonc"
    "taskbar.jsonc"
    "temperature.jsonc"
    "theme.jsonc"
    "tray.jsonc"
    "updates.jsonc"
    "wallchange.jsonc"
    "wbar.jsonc"
    "weather.jsonc"
    "window.jsonc"
    "workspaces##kanji.jsonc"
    "workspaces##roman.jsonc"
    "workspaces.jsonc"
  ];

  dataModules = map (f: "${dataHome}/${f}") [
    "wlr-taskbar#windows.json"
    "wlr-taskbar.json"
    "privacy.json"
    "tray.json"
    "custom-cava.jsonc"
    "custom-clipboard.jsonc"
    "custom-cliphist.jsonc"
    "custom-cpuinfo.jsonc"
    "custom-display.jsonc"
    "custom-dunst.jsonc"
    "custom-gamemode.jsonc"
    "custom-github_hyde.jsonc"
    "custom-gpuinfo#amd.jsonc"
    "custom-gpuinfo#intel.jsonc"
    "custom-gpuinfo#nvidia.jsonc"
    "custom-gpuinfo.jsonc"
    "custom-hyprsunset.jsonc"
    "custom-keybindhint.jsonc"
    "custom-power.jsonc"
    "custom-powermenu.jsonc"
    "custom-sensorsinfo.jsonc"
    "custom-spotify.jsonc"
    "custom-theme.jsonc"
    "custom-updates.jsonc"
    "custom-wallchange.jsonc"
    "custom-wbar.jsonc"
    "custom-weather.jsonc"
    "hyprland-language.jsonc"
    "hyprland-workspaces.jsonc"
    "custom-swaync.jsonc"
    "wlr-taskbar.jsonc"
    "wlr-taskbar#windows.jsonc"
    "clock.jsonc"
    "cpu.jsonc"
    "idle_inhibitor.jsonc"
    "memory.jsonc"
    "mpris.jsonc"
    "network.jsonc"
    "privacy.jsonc"
    "pulseaudio.jsonc"
    "pulseaudio#microphone.jsonc"
    "tray.jsonc"
    "power-profiles-daemon.jsonc"
    "image#hyde-menu.jsonc"
    "network#bandwidth.jsonc"
  ];
in
lib.generators.toJSON { } {
  include = configModules ++ dataModules;

  "wlr/taskbar#windows" = {
    icon-size = 16.0;
    icon-size-multiplier = 1.6;
  };
  "wlr/taskbar" = {
    icon-size = 16.0;
    icon-size-multiplier = 1.6;
  };
  privacy = {
    icon-size = 10;
    icon-size-multiplier = 1;
  };
  tray = {
    icon-size = 16.0;
    icon-size-multiplier = 1.6;
  };
}
