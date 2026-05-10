{
  config,
  lib,
  options,
  ...
}:
{
  config = lib.mkIf (options ? programs.nixvim) {
    programs.nixvim =
      let
        cfg = config.programs.nixvim.plugins.snacks;
        enable = cfg.enable && ((cfg.settings.notifier.enabled or false) == true);
        mkAction = func: { __raw = "function() Snacks.${func}() end"; };
        prefix = "<leader>n";
      in
      {
        keymaps = lib.mkIf enable [
          {
            mode = "n";
            key = prefix + "d";
            action = mkAction "hide";
            options = {
              desc = "Dismiss all notifications";
              silent = true;
            };
          }

          {
            mode = "n";
            key = prefix + "h";
            action = mkAction "show_history";
            options = {
              desc = "Show notification history";
              silent = true;
            };
          }
        ];

        plugins.which-key.settings.spec = lib.optional enable [
          {
            __unkeyed-1 = prefix;
            group = "Notifications";
            icon = "󰂚 ";
          }
        ];
      };
  };
}
