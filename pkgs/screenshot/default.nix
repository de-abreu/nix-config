{
  pkgs,
  lib,
  ...
}:
with lib;
let
  name = "screenshot";
in
pkgs.writeShellApplication {
  name = name;
  runtimeInputs = with pkgs; [
    coreutils
    grimblast
    libnotify
    xdg-user-dirs
  ];
  text = readFile ./screenshot.sh;
  meta = {
    licenses = licenses.gpl3;
    platforms = platforms.all;
    mainProgram = name;
  };
}
