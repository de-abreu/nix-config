{
  config,
  lib,
  options,
  ...
}: {
  config = lib.mkIf (options ? hydenix && config.hydenix.hm.enable) {
    hydenix.hm.theme = {
      enable = true;
      active = "One Dark";
      themes = ["One Dark" "Gruvbox Retro"];
    };

    # INFO: Remove items set using HyDE theming
    stylix.targets = {
      qt.enable = false;
      kde.enable = false;
      gtk.enable = false;
      hyprland.enable = false;
      hyprpaper.enable = false;
      hyprlock.enable = false;
      kitty.enable = false;
      rofi.enable = false;
      waybar.enable = false;
    };
  };
}
