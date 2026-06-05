{
  pkgs ? import <nixpkgs> { },
  ...
}:
{
  screenshot = pkgs.callPackage ./screenshot { };
  presenter = pkgs.callPackage ./presenter { };
}
