# INFO: Weekly NixOS auto-upgrade with flake.lock update
{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.flake.autoUpgrade;
  flakeDir = "/home/${cfg.owner}/.config/nix-config";
in
{
  options.flake.autoUpgrade = {
    enable = lib.mkEnableOption "automatic flake-based system upgrades";

    owner = lib.mkOption {
      type = lib.types.str;
      description = "Username of the flake directory owner";
    };

    dates = lib.mkOption {
      type = lib.types.str;
      default = "weekly";
      description = ''
        How often to run the auto-upgrade.
        See systemd.time(7) for the format.
        Examples: "weekly", "daily", "Mon *-*-1..7 03:00:00"
      '';
    };

    randomizedDelaySec = lib.mkOption {
      type = lib.types.str;
      default = "1h";
      description = ''
        Random delay to add to the timer. Helps spread load if you have
        multiple machines. Set to "0" to disable.
      '';
    };
  };

  config = import ./_config.nix {
    inherit
      cfg
      config
      flakeDir
      lib
      pkgs
      ;
  };
}
