{lib, ...}: {
  perSystem = {config, ...}: {
    nixosConfigurations.argo = lib.nixosSystem {
      modules = [../../hosts/argo];
      specialArgs = {
        inherit (config) inputs outputs;
        importAll = import ../lib/importDendritic.nix {inherit lib;};
        experimentalFeatures = ["nix-command" "flakes" "pipe-operators" "flake-parts"];
      };
    };
  };
}