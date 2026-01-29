{
  config,
  lib,
  ...
}: let
  cfg = config.abnt2-keyboard.hm.lazygit;
in {
  config = lib.mkIf cfg.enable {
    programs.lazygit.settings.keybinding.universal = {
      prevItem-alt = "l";
      nextItem-alt = "k";
      scrollLeft = "J";
      scrollRight = "Ç";
      prevBlock-alt = "j";
      nextBlock-alt = "ç";
      scrollUpMain-alt1 = "L";
      scrollDownMain-alt1 = "K";
    };
  };
}
