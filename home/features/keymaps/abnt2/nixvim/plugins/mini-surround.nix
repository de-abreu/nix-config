{
  config,
  lib,
  ...
}: let
  cfg = config.nixvim.plugins.mini-surround;
  prefix = "gs";
in {
  programs.nixvim.plugins = lib.mkIf cfg.enable {
    mini-surround.settings = {
      mappings = {
        add = prefix + "a"; # Add surrounding in Normal and Visual modes
        delete = prefix + "d"; # Delete surrounding
        find = prefix + "f"; # Find surrounding (to the right)
        find_left = prefix + "F"; # Find surrounding (to the left)
        highlight = prefix + "h"; # Highlight surrounding
        replace = prefix + "r"; # Replace surrounding
        update_n_lines = prefix + "n"; # Update 'n_lines'
      };
    };

    which-key.settings.spec = [
      {
        __unkeyed-1 = prefix;
        group = "Surround";
        icon = "󰅪 ";
      }
    ];
  };
}
