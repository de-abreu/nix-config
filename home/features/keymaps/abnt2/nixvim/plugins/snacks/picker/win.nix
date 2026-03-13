let
  common = {
    # Opening files
    "ç" = [
      "pick_win"
      "jump"
    ];
    "<cr>" = [
      "pick_win"
      "jump"
    ];
    "<s-cr>" = false;

    "<c-s>" = false;
    "-" = [
      "pick_win"
      "edit_split"
    ];

    "<c-v>" = false;
    "\\" = [
      "pick_win"
      "edit_vsplit"
    ];

    # Movement
    "<c-j>" = false;
    "<c-k>" = "list_down";
    "<c-l>" = "list_up";
    k = "list_down";
    l = "list_up";
    "<a-s>" = "flash";

    # Layout
    "<c-w>J" = "layout_left";
    "<c-w>K" = "layout_bottom";
    "<c-w>L" = "layout_top";
    "<c-w><S-Ç>" = "layout_right";
  };

  # Upgraded wrapper to handle any mode
  wrapKeys =
    mode:
    builtins.mapAttrs (
      _: value:
      if builtins.isList value then
        {
          __unkeyed-1 = value;
          inherit mode;
        }
      else
        value
    );
in
{
  programs.nixvim.plugins.snacks.settings.picker = {
    actions.flash.__raw =
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

    win = {
      input.keys = (wrapKeys [ "n" "i" ] common) // {
        "<c-u>" = false;
        "h" = "flash";
      };
      list.keys = wrapKeys [ "n" ] common;
    };
  };
}
