{
  pkgs,
  lib,
  presenterm ? pkgs.presenterm,
  ...
}:
with lib;
let
  name = "presenter";
in
pkgs.writeShellApplication {
  name = name;
  runtimeInputs = [
    pkgs.coreutils
    pkgs.hyprland
    pkgs.jq
    pkgs.wezterm
    presenterm
  ];
  text = readFile ./presenter.sh;
  meta = {
    licenses = licenses.gpl3;
    platforms = platforms.all;
    mainProgram = name;
  };
}
