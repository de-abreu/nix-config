{ lib, options, ... }:
{
  config = lib.mkIf (options ? programs.nixvim) {
    programs.nixvim.plugins.mini.modules.splitjoin.mappings.toggle = "gS";
  };
}
