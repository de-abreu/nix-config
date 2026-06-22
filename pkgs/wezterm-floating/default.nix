{
  pkgs,
  lib,
  wezterm ? pkgs.wezterm,
  ...
}:
with lib;
let
  name = "wezterm-floating";
in
pkgs.writeShellApplication {
  name = name;
  runtimeInputs = [ wezterm ];
  text = readFile ./wezterm-floating.sh;
  meta = {
    licenses = licenses.gpl3;
    platforms = platforms.all;
    mainProgram = name;
  };
}
