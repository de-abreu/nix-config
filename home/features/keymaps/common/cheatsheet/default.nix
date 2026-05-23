{ config, lib, ... }:
let
  enabled = config.programs.cheatsheet.enable;
in
{
  programs.cheatsheet.enable = true;
  programs.cheatsheet.entries.hyprland = lib.mkIf enabled ./cheat/hyprland.cheat.md;
}