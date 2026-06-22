{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
{
  screenshot = callPackage ./screenshot { };
  presenter = callPackage ./presenter { };
  wezterm-floating = callPackage ./wezterm-floating { };
  wfrc = callPackage ./wfrc { };
}
