{ pkgs, ... }:
# TODO: There is a Home Manager module for Anki, now. Migrate this to the new configuration format.
{
  home.packages = [ pkgs.anki ];
}
