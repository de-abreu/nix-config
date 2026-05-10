{ lib, options, ... }:
{
  config = lib.mkIf (options ? programs.nixvim) {
    programs.nixvim.plugins.snacks.settings.picker.win =
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

        splits = {
          "<c-s>" = false;
          "-" = "edit_split";

          "<c-v>" = false;
          "\\" = "edit_vsplit";
        };

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
        list.keys = common // navigation // splits;
      };
  };
}
