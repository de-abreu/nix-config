{ config, lib, ... }:
let
  cfg = config.programs.nixvim.plugins.avante;
  prefix = "<leader>a";
in
{
  programs.nixvim = {
    keymaps = lib.mkIf cfg.enable [
      {
        action.__raw = ''
          function()
            local sidebar = require("avante").get()
            if sidebar and sidebar:is_open() and sidebar.file_selector:add_current_buffer() then
              vim.notify("Added current buffer to file selector", vim.log.levels.DEBUG, { title = "Avante" })
            else
              vim.notify("Failed to add current buffer (is Avante open?)", vim.log.levels.WARN, { title = "Avante" })
            end
          end
        '';
        key = prefix + ".";
        mode = "n";
        options = {
          silent = true;
          desc = "avante: add current file";
        };

      }
    ];

    plugins = {
      which-key.settings.spec = lib.mkIf cfg.enable [
        {
          __unkeyed-1 = prefix;
          mode = "n";
          group = "Avante";
          icon = "󱙺";
        }
      ];

      avante.settings.mappings = {
        ask = prefix + "a";
        edit = prefix + "e";
        refresh = prefix + "r";
        new_ask = prefix + "n";
        focus = prefix + "f";
        select_model = prefix + "/";
        stop = prefix + "s";
        select_history = prefix + "h";
        toggle = {
          default = prefix + "t";
          debug = prefix + "d";
          hint = prefix + "H";
          suggestion = prefix + "S";
          repomap = prefix + "R";
          selection = prefix + "C";
        };
        zen_mode = prefix + "z";
        diff = {
          next = "]c";
          prev = "[c";
        };
        files.add_all_buffers = prefix + "B";
      };
    };
  };
}
