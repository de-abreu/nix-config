{
  pkgs,
  lib,
  flakePath,
  ...
}:
let
  inherit (lib) getExe;

  flakeExpr = "(builtins.getFlake \"${flakePath}\")";
in
{
  programs.nixvim = {
    plugins = {
      lsp.servers = {
        statix.enable = true;
        nixd = {
          enable = true;
          settings = {
            options = {
              nixos.expr = "${flakeExpr}.nixosConfigurations.argo.options";
              home_manager.expr = "${flakeExpr}.nixosConfigurations.argo.options.home-manager.users.type.getSubOptions []";
            };
            nixpkgs.expr = "${flakeExpr}.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}";
          };
        };
      };

      conform-nvim.settings = {
        formatters_by_ft.nix = [ "nixfmt" ];
        formatters.nixfmt.command = getExe pkgs.nixfmt-rfc-style;
      };

      lint = {
        enable = true;
        lintersByFt.nix = [ "deadnix" ];
        linters.deadnix.cmd = getExe pkgs.deadnix;
      };

      nix.enable = true;
      direnv.enable = pkgs.stdenv.hostPlatform.isLinux;
      nix-develop.enable = true;
    };
  };
}

