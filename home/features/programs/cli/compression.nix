{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnutar
    gzip
    unzip
    zip
  ];
}
