{importAll, ...}: {
  imports = importAll {dir = ./.;};

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
  };
}
