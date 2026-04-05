{ inputs, ... }:
{
  imports = [ inputs.nixvim.homeModules.nixvim ];
  programs = {
    nixvim = {
      enable = true;
      defaultEditor = true;
      nixpkgs.useGlobalPackages = true;
    };
    fish.shellAbbrs."nv" = "nvim";
  };
}
