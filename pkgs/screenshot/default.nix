{
  pkgs,
  lib,
  ...
}:
pkgs.writeShellApplication {
  name = "screenshot";
  runtimeInputs = with pkgs; [
    coreutils
    grimblast
    libnotify
    xdg-user-dirs
  ];
  text = builtins.readFile ./screenshot.sh;
  meta = with lib; {
    licenses = licenses.gpl3;
    platforms = platforms.all;
    mainProgram = "screenshot";
  };
}
