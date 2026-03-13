{
  config,
  lib,
  ...
}:
let
  cfg = config.programs.nixvim.plugins.snacks;
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
    plugins.snacks.settings.picker.sources.explorer.win.list.keys = {
      l = "list_up";
      j = "explorer_close";
      "ç" = "confirm";
      "<cr>" = "confirm";
      h = "flash";
    };
  };
}
