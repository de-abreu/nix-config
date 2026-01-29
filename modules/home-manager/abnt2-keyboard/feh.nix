{
  config,
  lib,
  ...
}: let
  cfg = config.abnt2-keyboard.hm.feh;
in {
  config = lib.mkIf cfg.enable {
    programs.feh.keybindings = {
      prev_img = "j";
      next_img = "ç";
    };
  };
}
