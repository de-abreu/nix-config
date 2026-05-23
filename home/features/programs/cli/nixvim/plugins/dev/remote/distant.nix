{ pkgs, lib, ... }:
{
  programs.nixvim.plugins.distant = {
    enable = true;
    lazyLoad.settings.cmd = [
      "DistantLaunch"
      "DistantOpen"
      "DistantConnect"
      "DistantInstall"
      "DistantMetadata"
      "DistantShell"
      "DistantSystemInfo"
      "DistantClientVersion"
      "DistantSessionInfo"
      "DistantCopy"
    ];
    settings = {
      client.bin = lib.getExe pkgs.distant;
      network.private = true;
      keymap = {
        dir = {
          up = "J";
          newdir = "C";
        };
        file.up = "J";
      };
    };
  };
}