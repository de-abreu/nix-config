{ inputs, ... }:
{
  # This adds custom packages from the ../pkgs directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # This makes unstable packages accessible via `pkgs.unstable`
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
    };
  };
}
