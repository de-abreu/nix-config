{ config, lib, ... }:
let
  cfg = config.programs.navi;
  enabled = cfg.enable && cfg.enableFishIntegration;
in
{
  programs.navi.settings.cheats.paths = lib.mkIf enabled [ (toString ./cheat) ];
}
