{
  config,
  lib,
  ...
}: let
  cfg = config.programs.nixvim.plugins.snacks;
  enable =
    cfg.enable
    && (cfg.settings.picker.enabled or false)
    && config.programs.git.enable;
  prefix = "<leader>g";
  mkAction = func: {__raw = "function() Snacks.picker.${func}() end";};
in {
  programs.nixvim.keymaps = lib.mkIf enable (map (el: el // {mode = "n";}) [
    {
      action = mkAction "git_branches";
      key = prefix + "b";
      options.desc = "Branches";
    }
    {
      action = mkAction "git_log";
      key = prefix + "l";
      options.desc = "Log";
    }
    {
      action = mkAction "git_log_line";
      key = prefix + "L";
      options.desc = "Log Line";
    }
    {
      action = mkAction "git_status";
      key = prefix + "s";
      options.desc = "Status";
    }
    {
      action = mkAction "git_stash";
      key = prefix + "S";
      options.desc = "Stash";
    }
    {
      action = mkAction "git_diff";
      key = prefix + "d";
      options.desc = "Diff (Hunks)";
    }
    {
      action = mkAction "git_log_file";
      key = prefix + "f";
      options.desc = "Log File";
    }
  ]);
}
