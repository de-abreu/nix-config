{
  programs.nixvim.plugins = {
    flash = {
      enable = true;
      settings = {
        label.uppercase = false;
        search.exclude = [
          "notify"
          "cmp_menu"
          "noice"
          "flash_prompt"
          {
            __raw =
              # lua
              ''
                function(win)
                  -- exclude non-focusable windows
                  return not vim.api.nvim_win_get_config(win).focusable
                end
              '';
          }
        ];
      };
    };

    snacks.settings.picker.actions.flash.__raw =
      # lua
      ''
        function(picker)
          require("flash").jump({
            pattern = "^",
            label = { after = { 0, 0 } },
            search = {
              mode = "search",
              exclude = {
                function(win)
                  return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
                end,
              },
            },
            action = function(match)
              local idx = picker.list:row2idx(match.pos[1])
              picker.list:_move(idx, true, true)
            end,
          })
        end
      '';
  };
}
