{
  config,
  lib,
  ...
}:
let
  cfg = config.programs.nixvim.plugins.snacks;
  enable = cfg.enable && ((cfg.settings.zen.enabled or false) == true);
  prefix = "<leader>u";
  mkAction = func: { __raw = "function() Snacks.${func}() end"; };
in
{
  programs.nixvim.keymaps = lib.mkIf enable [
    {
      key = prefix + "z";
      action = mkAction "zen";
      options.desc = "Toggle Zen Mode";
    }
    {
      key = prefix + "m";
      action = mkAction "zen.zoom";
      options.desc = "Toggle Maximize (Zoom)";
    }
  ];
}
