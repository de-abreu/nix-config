{
  cfg,
  config,
  flakeDir,
  lib,
  pkgs,
}:
lib.mkIf cfg.enable {
  # Disable the default auto-upgrade (doesn't work properly with flakes)
  system.autoUpgrade.enable = false;

  # Custom systemd service for flake-based auto-upgrade
  systemd.services.nixos-auto-upgrade-flake = {
    description = "NixOS auto-upgrade with flake.lock update";

    # Ensure git is available in the service PATH
    path = with pkgs; [
      git
      nix
      nixos-rebuild
    ];

    serviceConfig = {
      Type = "oneshot";
      User = "root";
      WorkingDirectory = flakeDir;
    };

    script = ''
      set -e

      echo "[auto-upgrade] Starting flake update..."

      echo "[auto-upgrade] Updating flake inputs..."
      nix flake update

      echo "[auto-upgrade] Staging updated flake.lock..."
      git add flake.lock

      echo "[auto-upgrade] Rebuilding NixOS system with updated lock..."
      nixos-rebuild switch --flake ${flakeDir}#${config.networking.hostName}

      echo "[auto-upgrade] Fixing lock file ownership..."
<<<<<<< HEAD
      chown ${cfg.flakeOwner}:users flake.lock
||||||| parent of c6775ac (feat(auto-upgrade): Make the auto-upgrade module compatible with a local flake use)
=======
      chown ${cfg.owner}:users flake.lock
>>>>>>> c6775ac (feat(auto-upgrade): Make the auto-upgrade module compatible with a local flake use)

      echo "[auto-upgrade] Completed successfully!"
      echo "[auto-upgrade] Remember to commit the lock file when ready:"
      echo "[auto-upgrade]   git commit -m 'chore: update flake.lock'"
    '';
  };

  # Timer configuration
  systemd.timers.nixos-auto-upgrade-flake = {
    description = "Run NixOS auto-upgrade";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = cfg.dates;
      Persistent = true;
      RandomizedDelaySec = cfg.randomizedDelaySec;
    };
  };
}
