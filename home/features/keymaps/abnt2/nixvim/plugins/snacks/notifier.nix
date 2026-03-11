{
  featuresEnabled,
  lib,
  snacksAction,
  ...
}: let
  feat = "notifier";
  action = func: snacksAction "${feat}.${func}" {};
  prefix = "<leader>n";
in {
  programs.nixvim = {
    keymaps = lib.optionals (featuresEnabled feat) [
      {
        mode = "n";
        key = prefix + "d";
        action = action "hide";
        options = {
          desc = "Dismiss all notifications";
          silent = true;
        };
      }

      {
        mode = "n";
        key = prefix + "h";
        action = action "show_history";
        options = {
          desc = "Show notification history";
          silent = true;
        };
      }
    ];

    plugin.which-key.settings.spec = lib.optional (featuresEnabled feat) [
      {
        __unkeyed-1 = prefix;
        group = "Notifications";
        icon = "󰂚 ";
      }
    ];
  };
}
