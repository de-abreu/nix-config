inputs@{
  nixpkgs,
  self,
  systems,
  ...
}:
with builtins;
let
  inherit (self) outputs;
  lib = nixpkgs.lib;

  importAll =
    with lib;
    with builtins;
    {
      dir,
      exclude ? [ ],
    }:
    readDir dir
    |> filterAttrs (
      name: type:
      let
        isNixFile = hasSuffix ".nix" name && name != "default.nix";
        isDirectory = type == "directory";
        isNotExcluded = !(elem name exclude);
      in
      (isNixFile || isDirectory) && isNotExcluded
    )
    |> attrNames
    |> map (name: dir + "/${name}");

  pkgsFor = lib.genAttrs (import systems) (system: import nixpkgs { inherit system; });

  forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
  experimentalFeatures = [
    "nix-command"
    "flakes"
    "pipe-operators"
    "flake-parts"
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
        importAll
        experimentalFeatures
        ;
    };
  };
}
