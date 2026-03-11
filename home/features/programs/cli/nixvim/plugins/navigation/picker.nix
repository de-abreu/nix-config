{
  config,
  lib,
  ...
}: {
  programs.nixvim.plugins.snacks.settings.picker = let
    truncate =
      # lua
      ''
        function(self)
          self:execute 'calculate_file_truncate_width'
        end
      '';
  in {
    enable = true;
    win.list.on_buf.__raw = truncate;

    preview = {
      on_buf.__raw = truncate;
      on_close.__raw = truncate;
    };

    layouts.select.layout = {
      relative = "cursor";
      width = 70;
      min_width = 0;
      row = 1;
    };

    actions.flash.__raw =
      lib.mkIf config.programs.nixvim.plugins.flash.enable
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
