{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption mkEnableOption mkIf types;
  inherit (types) lines nullOr listOf str;
  cfg = config.abnt2-keyboard;
in {
  imports = [./kanata.nix];

  options.abnt2-keyboard = {
    enable = mkEnableOption "System configuration for the ABNT2
        keyboard";
    kanata = {
      enable = mkEnableOption "Kanata keyboard configuration";
      devices = mkOption {
        type = listOf str;
        description = ''
          A list of device paths to be managed using Kanata. Use ls `ls
          /dev/input/by-path/` to discover the keyboards available.
        '';
      };
      configuration = mkOption {
        type = nullOr lines;
        default = null;
        description = ''
          Override the default Kanata configuration. By default, the Kanata configuration enables the following functionalities:

          1. Caps Lock: Acts as Escape when tapped, Control when held.

          2. Tab: Acts as Tab when tapped, Nav Layer (Vim-style jklç arrows
          + Paging) when held. When holding Tab, your right hand becomes a
          navigation cluster:

          | Key | Action    |
          | :-- | :-------- |
          | J   | Left      |
          | K   | Down      |
          | L   | Up        |
          | Ç   | Right     |
          | I   | Page Up   |
          | M   | Page Down |
          | U   | Home      |
          | N   | End       |


          3. Numbers: Both top-row and numpad keys have anti-repeat protection.
          You must physically tap the key for every input.

          4. Escape: Demoted to acting as Caps Lock.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    console.keyMap = "br-abnt2";
  };
}
