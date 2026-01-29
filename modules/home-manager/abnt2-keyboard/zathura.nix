{
  config,
  lib,
  ...
}: let
  cfg = config.abnt2-keyboard.hm.zathura;
in {
  config = lib.mkIf cfg.enable {
    programs.zathura.mappings = {
      K = "navigate next";
      L = "navigate previous";
      j = "scroll left";
      k = "scroll down";
      l = "scroll up";
      "ç" = "scroll right";
    };
  };
}
