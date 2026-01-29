{
  inputs,
  lib,
  outputs,
  experimentalFeatures,
  ...
}: {
  imports = [
    ./global
    ./optional
    ./users
  ];

  nixpkgs.overlays = [
    outputs.overlays.additions
    outputs.overlays.unstable-packages
  ];

  nix = {
    settings = {
      experimental-features = experimentalFeatures;

      # NOTE: This sets the users that are allowed to use the flake command
      trusted-users = ["root" "@wheel"];
    };

    # NOTE: The following takes flakes described as input parameters and makes
    # them globally available to the system. **I'm still not sure why this could
    # necessary**.
    registry = with lib;
      inputs
      |> filterAttrs (_: isType "flake")
      |> mapAttrs (_: flake: {inherit flake;});

    # NOTE: When using flakes, many older tools or scripts might still rely on
    # the NIX_PATH mechanism. Setting this option ensures that our NixOS
    # configuration is compatible with code that uses the older <name> syntax
    # (e.g., import <nixpkgs> {}).
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  };
  users.mutableUsers = false;
}
