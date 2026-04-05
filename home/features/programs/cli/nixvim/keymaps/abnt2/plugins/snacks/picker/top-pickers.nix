{
  config,
  lib,
  ...
}:
let
  cfg = config.programs.nixvim.plugins.snacks;
  enable = cfg.enable && ((cfg.settings.picker.enabled or false) == true);
  mkAction = func: { __raw = "function() Snacks.picker.${func}() end"; };
in
{
  programs.nixvim.keymaps = lib.mkIf enable (
    map (m: m // { mode = "n"; }) [
      {
        key = "<leader><space>";
        action = mkAction "smart";
        options.desc = "Smart Find Files";
      }
      {
        key = "<leader>b<space>";
        action = mkAction "buffers";
        options.desc = "Search Buffers";
      }
      {
        key = "<leader>:";
        action = mkAction "command_history";
        options.desc = "Command History";
      }
    ]
  );
}
