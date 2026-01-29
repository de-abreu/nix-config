{
  config,
  lib,
  ...
}: let
  cfg = config.abnt2-keyboard.hm.less;
in {
  config = {
    home.file.".lesskey".text = lib.mkIf cfg.enable ''
      j invalid
      k forw-line
      l back-line
    '';
  };
}
