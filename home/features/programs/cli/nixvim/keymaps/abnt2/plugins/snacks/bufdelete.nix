{
  config,
  lib,
  ...
}:
let
  cfg = config.programs.nixvim.plugins.snacks;
  enable = cfg.enable && ((cfg.settings.bufdelete.enabled or false) == true);
  mkAction = func: { __raw = "function() Snacks.bufdelete.${func}() end"; };
in
{
  programs.nixvim.keymaps = lib.mkIf enable (
    map (m: m // { mode = "n"; }) [
      {
        key = "<leader>c";
        action = mkAction "delete";
        options.desc = "Close buffer";
      }
      {
        key = "<leader>bc";
        action = mkAction "other";
        options.desc = "Close all buffers but current";
      }
      {
        key = "<leader>bC";
        action = mkAction "all";
        options.desc = "Close all buffers";
      }
    ]
  );
}
