{ inputs, ... }:
{
  imports = [
    ./configuration.nix
    (inputs.import-tree ../common)
  ];
}
