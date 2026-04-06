{ inputs, ... }:
{
  imports = [
    (inputs.import-tree [
      ./configuration.nix
      ../common
    ])
  ];
}
