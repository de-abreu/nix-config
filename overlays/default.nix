{ inputs, ... }:
{
  additions = final: _prev: import ../pkgs { pkgs = final; };

  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.stdenv.hostPlatform.system;
    };
  };

  yazi-plugins = inputs.nix-yazi-plugins.overlays.default;

  firefox-addons = final: _prev: {
    firefox-addons = inputs.firefox-addons.packages.${final.stdenv.hostPlatform.system};
  };

  modifications = final: prev: {
    yazi = final.unstable.yazi;
    opencode = final.unstable.opencode;
    yaziPlugins = prev.yaziPlugins // {
      smart-switch = final.callPackage ../pkgs/smart-switch { };
      smart-tab = final.callPackage ../pkgs/smart-tab { };
      max-preview = prev.yaziPlugins.max-preview.overrideAttrs (_: {
        postInstall = ''
          substituteInPlace $out/main.lua --replace-fail 'app_emit' 'emit'
        '';
      });
    };
  };
}
