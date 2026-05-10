{ lib, options, ... }:
{
  config = lib.mkIf (options ? programs.yazi.yaziPlugins) {
    programs.yazi.yaziPlugins.plugins.bypass.keys = {
      smart-enter = {
        on = [ "ç" ];
        run = "plugin bypass smart-enter";
        desc = "Open a file, or recursively enter child directory, skipping children with only a single subdirectory";
      };
      leave = {
        on = [ "j" ];
        run = "plugin bypass reverse";
        desc = "Recursively enter parent directory, skipping parents with only a single subdirectory.";
      };
    };
  };
}
