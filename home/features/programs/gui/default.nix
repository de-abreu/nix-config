{
  importAll,
  pkgs,
  ...
}: {
  imports = importAll {dir = ./.;};

  config.home.packages = with pkgs; [anki];
}
