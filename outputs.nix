inputs@{
  nixpkgs,
  self,
  systems,
  ...
}:
let
  inherit (self) outputs;
  lib = nixpkgs.lib;
  pkgsFor = lib.genAttrs (import systems) (system: import nixpkgs { inherit system; });
  forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
  experimentalFeatures = [
    "nix-command"
    "flakes"
    "pipe-operators"
  ];
in
{
  nixosModules = import ./modules/nixos { inherit inputs; };
  homeModules = import ./modules/home-manager { inherit inputs; };
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
