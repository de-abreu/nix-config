{ lib, options, ... }:
{
  config = lib.mkIf (options ? programs.nixvim) {
    programs.nixvim.plugins.snacks.settings.picker =
      let
        bindings = {
          input.keys = {
            "<C-h>" = {
              __unkeyed-1 = "flash";
              mode = "i";
            };
            "h" = "flash";
          };
          list.keys."h" = "flash";
        };
      in
      {
        actions.flash.__raw =
          # lua
          ''
            function(picker)
              local list = picker.list
              local visible_count = math.max(0, math.min(list:count() - (list.top or 1) + 1, list.state.height))
              if visible_count == 0 then return end
              local pattern
              if list.reverse then
                pattern = "^\\%>" .. (list.state.height - visible_count) .. "l"
              else
                pattern = "^\\%<" .. (visible_count + 1) .. "l"
              end
              require("flash").jump({
                pattern = pattern,
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

        win = bindings;
        sources.explorer.win = bindings;
      };
  };
}
