{
  config,
  importAll,
  lib,
  ...
}: let
  inherit (lib) mkOption mkEnableOption types;
  inherit (types) bool lines nullOr;
  cfg = config.abnt2-keyboard.hm;
in {
  imports = importAll ./.;

  options.abnt2-keyboard.hm = {
    enable = mkEnableOption "Global ABNT2 key remapping for JKLÇ resting position";

    hydenix = {
      enable = mkOption {
        type = bool;
        default = cfg.enable && config.hydenix.hm.hyprland.enable;
        description = "Set Hyprland's keyboard layout and keybindings";
      };
      keybinds = mkOption {
        type = nullOr lines;
        default = null;
        description = "Override of the keybinding configuration";
      };
    };
    feh.enable = mkOption {
      type = bool;
      default = cfg.enable && config.programs.feh.enable;
      description = "Set feh's directional keybindings";
    };
    lazygit.enable = mkOption {
      type = bool;
      default = cfg.enable && config.programs.lazygit.enable;
      description = "Set lazygit's directional keybindings";
    };
    less.enable = mkOption {
      type = bool;
      default =
        cfg.enable
        && (config.programs.less.enable
          || config.programs.bat.enable);
      description = "Set less' directional keybindings";
    };
    yazi.enable = mkOption {
      type = bool;
      default = cfg.enable && config.programs.yazi.enable;
      description = "Set yazi's directional keybindings";
    };
    zathura.enable = mkOption {
      type = bool;
      default = cfg.enable && config.programs.zathura.enable;
      description = "Set zathura's directinal keybindings";
    };
  };
}
