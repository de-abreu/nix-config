{
  config,
  lib,
  ...
}:
let
  cfg = config.programs.nixvim.plugins.bufferline;
in
{
  programs.nixvim = {
    plugins = {
      bufferline.settings.options.letter_mapping = "asdfjklçghnmertziopwxcvqb\\-";
      which-key.settings.spec = lib.mkIf cfg.enable [
        {
          __unkeyed-1 = "<leader>b";
          group = "Buffers";
          icon = "󰓩 ";
        }
        {
          __unkeyed-1 = "<leader>bs";
          group = "Sort";
          icon = "󱂬 "; # Nerd Font icon for sorting/descending lines
        }
      ];
    };

    keymaps =
      let
        splitWindow =
          orientation:
          # lua
          ''
            function()
              local current_id = vim.api.nvim_get_current_buf()
              require("bufferline.pick").choose_then(function(id)
                vim.cmd("${if orientation == "vertical" then "v" else ""}split")
                if id and id ~= current_id then
                  vim.cmd("buffer " .. id)
                end
              end)
            end
          '';
      in
      lib.optionals cfg.enable (
        map (m: m // { mode = "n"; }) [
          {
            key = "<Right>";
            action.__raw =
              # lua
              ''
                function()
                  require("bufferline.commands").cycle(vim.v.count1)
                end
              '';
            options.desc = "Next buffer";
          }
          {
            key = "<Left>";
            action.__raw =
              # lua
              ''
                function()
                  require("bufferline.commands").cycle(-vim.v.count1)
                end
              '';
            options.desc = "Previous buffer";
          }
          {
            key = "]b";
            action.__raw =
              # lua
              ''
                function()
                  require("bufferline.commands").move(vim.v.count1)
                  end
              '';
            options.desc = "Move buffer tab right";
          }
          {
            key = "[b";
            action.__raw =
              # lua
              ''
                function()
                  require("bufferline.commands").move(-vim.v.count1)
                  end
              '';
            options.desc = "Move buffer tab left";
          }
          {
            key = "<leader>j";
            action.__raw =
              # lua
              ''function() require("bufferline.commands").pick() end'';
            options.desc = "Jump to buffer";
          }
          {
            key = "<leader>bc";
            action.__raw =
              # lua
              ''
                function()
                  require("bufferline.commands").close_others()
                end
              '';
            options.desc = "Close all other buffers";
          }
          {
            key = "<leader>br";
            action.__raw =
              # lua
              ''
                function()
                  require("bufferline.commands").close_in_direction "right"
                end
              '';
            options.desc = "Close buffers to the right";
          }
          {
            key = "<leader>bl";
            action.__raw =
              # lua
              ''
                function()
                  require("bufferline.commands").close_in_direction "left"
                end
              '';
            options.desc = "Close buffers to the left";
          }
          {
            key = "<leader>bp";
            action = "<cmd>BufferLineTogglePin<cr>";
            options.desc = "Toggle pin";
          }
          {
            key = "<leader>bP";
            action = "<Cmd>BufferLineGroupClose ungrouped<CR>";
            options.desc = "Close non-pinned buffers";
          }
          {
            key = "<leader>bse";
            action.__raw =
              # lua
              ''
                function()
                  require("bufferline.commands").sort_by "extension"
                end
              '';
            options.desc = "Sort buffers by extension";
          }
          {
            key = "<leader>bsi";
            action.__raw =
              # lua
              ''function() require("bufferline.commands").sort_by "id" end'';
            options.desc = "Sort buffers by buffer number";
          }
          {
            key = "<leader>bsm";
            action.__raw =
              # lua
              ''
                function()
                  require("bufferline.commands").sort_by(
                    function(a, b)
                      return a.modified and not b.modified
                    end
                  )
                end
              '';
            options.desc = "Sort buffers by buffer number";
          }
          {
            key = "<leader>bsp";
            action.__raw =
              # lua
              ''function() require("bufferline.commands").sort_by "directory" end'';
            options.desc = "Sort buffers by extension";
          }
          {
            key = "<leader>bsr";
            action.__raw =
              # lua
              ''
                function()
                  require("bufferline.commands").sort_by "relative_directory"
                end
              '';
            options.desc = "Sort buffers by extension";
          }
          {
            key = "\\";
            action.__raw = splitWindow "vertical";
            options.desc = "Vertical split";
          }
          {
            key = "-";
            action.__raw = splitWindow "horizontal";
            options.desc = "Horizontal split";
          }
          {
            key = "<leader>ub";
            action.__raw =
              # lua
              ''
                function()
                  vim.g.buffer_limit_enabled = not vim.g.buffer_limit_enabled
                  local status = vim.g.buffer_limit_enabled and "STRICT" or "OFF"
                  local level = vim.g.buffer_limit_enabled and vim.log.levels.INFO or vim.log.levels.WARN

                  vim.notify("Buffer limit: " .. status, level, {
                    title = "Buffer Manager",
                    icon = "󰓩 ";
                  })
                end
              '';
            options.desc = "Toggle open buffer limit";
          }
        ]
      );
  };
}
