{ pkgs, ... }:
{
  home.packages = with pkgs; [
    axel
    curl
    wget
  ];
}
