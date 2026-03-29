{
  config,
  lib,
  ...
}:
let
  cfg = config.programs.nixvim.plugins.snacks;
  avante = config.programs.nixvim.plugins.avante;
in
{
  programs.nixvim = {
    keymaps = lib.mkIf cfg.enable [
      {
        mode = "n";
        key = "<leader>e";
        action.__raw = "function() Snacks.explorer() end";
        options.desc = "Toggle Explorer";
      }
      {
        mode = "n";
        key = "<leader>o";
        action.__raw =
          # lua
          ''
            function()
              local pickers = Snacks.picker.get({ source = "explorer" })

              if #pickers > 0 then
                local picker = pickers[1]

                -- Use the native snacks method to check if the explorer is focused
                if picker:is_focused() then
                  -- wincmd p is dangerous here; it might bounce between internal picker windows.
                  -- Instead, explicitly find the first window that is a normal code buffer.
                  for _, win in ipairs(vim.api.nvim_list_wins()) do
                    local buf = vim.api.nvim_win_get_buf(win)
                    local ft = vim.bo[buf].filetype
                    local config = vim.api.nvim_win_get_config(win)

                    -- Check if it's a normal window (relative == "") and NOT a snacks window
                    if config.relative == "" and ft ~= "snacks_picker_list" and ft ~= "snacks_picker_input" then
                      vim.api.nvim_set_current_win(win)
                      break
                    end
                  end
                else
                  -- The explorer is open, but we are in a code buffer. Focus the explorer.
                  picker:focus()
                end
              else
                -- The explorer doesn't exist at all. Open it.
                Snacks.explorer()
              end
            end
          '';
        options.desc = "Toggle Explorer Focus";
      }
    ];
    plugins.snacks.settings.picker = {
      actions = lib.mkIf avante.enable {
        explorer_to_avante.__raw = ''
          function(picker)
            local ok, avante = pcall(require, "avante")
            if not ok then
              vim.notify("Avante not available", vim.log.levels.WARN, { title = "Snacks Explorer" })
              return
            end

            local sidebar = avante.get()
            if not sidebar or not sidebar:is_open() then
              vim.notify("Open Avante sidebar first", vim.log.levels.WARN, { title = "Snacks Explorer" })
              return
            end

            local added = 0
            for _, item in ipairs(picker:selected()) do
              if item.file then
                sidebar.file_selector:add_selected_file(item.file)
                added = added + 1
              end
            end

            if added == 0 then
              local current = picker:current()
              if current and current.file then
                sidebar.file_selector:add_selected_file(current.file)
                added = 1
              end
            end

            if added > 0 then
              vim.notify(
                "Added " .. added .. " file(s) to Avante",
                vim.log.levels.INFO,
                { title = "Snacks Explorer" }
              )
            else
              vim.notify("No files to add", vim.log.levels.WARN, { title = "Snacks Explorer" })
            end
          end
        '';
      };
      sources.explorer.win.list.keys = {
        j = "explorer_close";
        l = "list_up";
        h = "flash";
      }
      // lib.optionalAttrs avante.enable {
        "<M-a>" = "explorer_to_avante";
      };
    };
  };
}
