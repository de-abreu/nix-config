{pkgs, ...}: {
  home = {
    packages = [pkgs.lynx];
    file.".lynxrc".source = ./lynxrc;
  };
}
