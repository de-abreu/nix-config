inputs @ {
  nixpkgs,
  self,
  systems,
  ...
}:
with builtins; let
  inherit (self) outputs;
  lib = nixpkgs.lib;
  importAll = with lib;
    dir:
      builtins.readDir dir
      |> filterAttrs (name: type:
        type
        == "directory"
        || (hasSuffix ".nix" name && name != "default.nix"))
      |> attrNames
      |> map (name: dir + "/${name}");
  pkgsFor = lib.genAttrs (import systems) (
    system: import nixpkgs {inherit system;}
  );
  forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
  experimentalFeatures = ["nix-command" "flakes" "pipe-operators"];
in {
  nixosModules = import ./modules/nixos;
  homeManagerModules = import ./modules/home-manager;

  overlays = import ./overlays {inherit inputs;};

  packages = forEachSystem (pkgs: import ./pkgs {inherit pkgs;});
  devShells = forEachSystem (pkgs: import ./shell.nix {inherit pkgs;});

  nixosConfigurations.argo = lib.nixosSystem {
    modules = [./hosts/argo];
    specialArgs = {
      inherit inputs outputs importAll experimentalFeatures;
    };
  };
}
