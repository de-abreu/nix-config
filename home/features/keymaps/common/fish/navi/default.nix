{ config, lib, ... }:
let
  cfg = config.programs.navi;
  enabled = cfg.enable && cfg.enableFishIntegration;
in
{
  programs.cheatsheet.entries.navi-fish = lib.mkIf (config.programs.cheatsheet.enable && enabled) ./cheat/navi.cheat.md;
}