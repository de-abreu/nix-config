{ config, ... }:
{
  programs.nixvim.plugins.treesitter-refactor = {
    inherit (config.programs.nixvim.plugins.treesitter) enable;

    settings = {
      highlightDefinitions = {
        enable = true;
        clearOnCursorMove = true;
      };
      smartRename = {
        enable = true;
        keymaps = {
          smart_rename = "gR";
        };
      };
      navigation.enable = true;
    };
  };
}
