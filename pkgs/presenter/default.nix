{ pkgs, lib, ... }:
pkgs.writeShellApplication {
  name = "presenter";
  runtimeInputs = with pkgs; [
    coreutils
    hyprland
    jq
    mermaid-cli
    unstable.presenterm
    wezterm
  ];
  text = builtins.readFile ./presenter.sh;
  meta = with lib; {
    licenses = licenses.gpl3;
    platforms = platforms.all;
    mainProgram = "presenter";
  };
}
