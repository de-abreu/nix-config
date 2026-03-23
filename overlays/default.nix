{ inputs, ... }:
{
  additions = final: _prev: import ../pkgs { pkgs = final; };

  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.stdenv.hostPlatform.system;
    };
  };

  firefox-addons = final: _prev: {
    firefox-addons = inputs.firefox-addons.packages.${final.stdenv.hostPlatform.system};
  };
}
