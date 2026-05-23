{ config, lib, ... }:
let
  enabled = lib.any (p: p.name == "fzf-fish") config.programs.fish.plugins;
in
{
  config = lib.mkIf enabled {
    programs = {
      fzf.enableFishIntegration = false;
      fish.shellInit = ''
        fzf_configure_bindings --directory=ctrl-f
      '';
      cheatsheet.entries.fzf-fish = lib.mkIf config.programs.cheatsheet.enable ./cheat/fzf.cheat.md;
    };
  };
}