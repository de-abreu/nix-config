{lib, ...}: {
  systems = import (builtins.fetchTarball {
    url = "github:nix-systems/default-linux";
    sha256 = "sha256:0j04dhqsh8dg5b6mp1as61bigpivq2n2ddv5qy5hnbm4jq000hzm";
  });
}