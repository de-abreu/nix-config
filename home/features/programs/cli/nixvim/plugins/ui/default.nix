{importAll, ...}: {
  imports = importAll {
    dir = ./.;
    exclude = ["lib"];
  };
}
