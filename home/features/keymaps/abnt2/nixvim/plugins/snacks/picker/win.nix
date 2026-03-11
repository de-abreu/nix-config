let
  common = {
    # Opening files
    "ç" = ["pick_win" "jump"];
    "<cr>" = ["pick_win" "jump"];
    "<s-cr>" = false;

    "<c-s>" = false;
    "-" = ["pick_win" "edit_split"];

    "<c-v>" = false;
    "\\" = ["pick_win" "edit_vsplit"];

    # Movement
    "<c-j>" = false;
    "<c-k>" = "list_down";
    "<c-l>" = "list_up";
    k = "list_down";
    l = "list_up";

    # Layout
    "<c-w>J" = "layout_left";
    "<c-w>K" = "layout_bottom";
    "<c-w>L" = "layout_top";
    "<c-w><S-Ç>" = "layout_right";

    h = "toggle_hidden";
  };
  wrapForInput = builtins.mapAttrs (
    _: value:
      if builtins.isList value
      then {
        __unkeyed-1 = value;
        mode = ["n" "i"];
      }
      else value
  );
in {
  programs.nixvim.plugins.snacks.picker.win = {
    input.keys = wrapForInput common;
    list.keys = common;
  };
}
