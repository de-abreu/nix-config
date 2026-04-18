inputs@{
  nixpkgs,
  self,
  linux,
  ...
}:
let
  inherit (self) outputs;
  lib = nixpkgs.lib;

  pkgsFor = lib.genAttrs (import linux) (system: import nixpkgs { inherit system; });

  forEachSystem = f: lib.genAttrs (import linux) (system: f pkgsFor.${system});
  experimentalFeatures = [
    "nix-command"
    "flakes"
    "pipe-operators"
  ];
in
{
  nixosModules = import ./modules/nixos;
  homeModules = import ./modules/home-manager;

  overlays = import ./overlays { inherit inputs; };

  packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });
  devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });

  nixosConfigurations.argo = lib.nixosSystem {
    modules = [ ./hosts/argo ];
    specialArgs = {
      inherit
        inputs
        outputs
        experimentalFeatures
        ;
    };
  };
}
