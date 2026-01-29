{
  importAll,
  pkgs,
  ...
}: {
  imports = importAll ./.;

  home.packages = with pkgs; [
    coreutils # GNU Core utilities
    gdu # disk usage analyzer
    imagemagick # Image manipulation
    pb_cli # Output to a pastebin
    pdftk # Manipulate pdf files
    ripgrep # search for text within various files
    devenv # create development environments tailored to specific projects.
    nix-prefetch-git # prefetch git repository data (to then add to nix configs)

    # Requirements to fetch, compress, and uncompress files
    wget
    curl
    gnutar
    gzip
    unzip
    zip
  ];
}
