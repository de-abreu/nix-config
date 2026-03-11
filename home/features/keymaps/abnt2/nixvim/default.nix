{importAll, ...}: {
  imports = importAll {dir = ./.;};

  programs.nixvim.globals = {
    mapleader = " ";
    maplocalleader = ",";
  };
}
