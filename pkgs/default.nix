{
  pkgs ? import <nixpkgs> { },
  ...
}:
{
  screenshot = pkgs.callPackage ./screenshot { };
  presenter = pkgs.callPackage ./presenter { };
  wfrc = pkgs.callPackage ./wfrc { };
}
