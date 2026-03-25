{ importAll, ... }:
{
  imports = importAll { dir = ./.; };

  programs = {
    nixvim = {
      enable = true;
      defaultEditor = true;
      nixpkgs.useGlobalPackages = true;
    };
    fish.shellAbbrs."nv" = "nvim";
  };
}
