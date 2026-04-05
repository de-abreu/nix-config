{ inputs, ... }:
{
  imports = [ inputs.stylix.homeModules.stylix ];
  stylix.targets.librewolf.profileNames = [ "default" ];
}
