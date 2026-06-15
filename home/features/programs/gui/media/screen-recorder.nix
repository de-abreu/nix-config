{ config, pkgs, ... }: {
  programs.wfrc = {
    enable = true;
    recorder = pkgs.wl-screenrec;
    settings = {
      folder = "${config.xdg.userDirs.videos}/screen-recordings";
      scriptName = "screen-recorder";
      notify = true;
    };
  };
}
