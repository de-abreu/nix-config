let
  common = {
    # Movement
    "<c-j>" = false;
    "<c-k>" = "list_down";
    "<c-l>" = "list_up";

    # Layout
    "<c-w>J" = "layout_left";
    "<c-w>K" = "layout_bottom";
    "<c-w>L" = "layout_top";
    "<c-w><S-Ç>" = "layout_right";
  };

  navigation = {
    "ç" = "confirm";
    l = "list_up";
    k = "list_down";
  };

in
{
  programs.nixvim.plugins.snacks.settings.picker.win =
    let
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

      input.keys = (wrapKeys [ "n" "i" ] common) // navigation // { "<c-u>" = false; };
      list.keys = common // navigation;
    };
}
