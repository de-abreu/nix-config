{
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) getExe;
in
{
  programs.nixvim = {
    plugins = {
      lsp.servers = {
        statix.enable = true;
        nixd.enable = true;
      };

      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft.nix = [ "nixfmt" ];
          formatters.nixfmt.command = getExe pkgs.nixfmt-rfc-style;
        };
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