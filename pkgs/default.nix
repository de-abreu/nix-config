{pkgs ? import <nixpkgs> {}, ...}: {
  screenshot = pkgs.callPackage ./screenshot {};
}
