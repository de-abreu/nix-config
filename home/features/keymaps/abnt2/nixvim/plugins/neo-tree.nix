{
  config,
  lib,
  ...
}: let
  cfg = config.programs.nixvim.plugins.neo-tree;
in {
  programs.nixvim = {
    keymaps = lib.mkIf cfg.enable [
      {
        action = "<cmd>Neotree Toggle<cr>";
        key = "<Leader>e";
        options.desc = "Toggle Explorer";
        mode = "n";
      }

      {
        action.__raw =
          # lua
          ''
            function()
              if vim.bo.filetype == "neo-tree" then
                vim.cmd.wincmd "p"
              else
                vim.cmd.Neotree "focus"
              end
            end
          '';
        key = "<Leader>o";
        options.desc = "Toggle Explorer Focus";
        mode = "n";
      }
    ];

    plugins.neo-tree.settings = {
      window.mappings = {
        l = false;
        "<space>" = false;
        j = "parent_or_close";
        O = "system_open";
        Y = "copy_selector";
        s = "file_picker";
        S = "grep_picker";

        "ç" = "open";
        "-" = "open_split";
        "\\" = "open_vsplit";
      };
      filesystem.window.mappings.h = "toggle_hidden";
    };
  };
}
