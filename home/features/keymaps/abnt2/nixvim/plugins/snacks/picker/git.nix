{
  config,
  featuresEnabled,
  lib,
  pickerAction,
  ...
}: let
  prefix = "<leader>g";
  enable = featuresEnabled "picker" && config.programs.git.enable;
in {
  programs.nixvim.keymaps = lib.optionals enable (map (el: el // {mode = "n";}) [
    {
      action = pickerAction "git_branches";
      key = prefix + "b";
      options.desc = "Branches";
    }
    {
      action = pickerAction "git_log";
      key = prefix + "l";
      options.desc = "Log";
    }
    {
      action = pickerAction "git_log_line";
      key = prefix + "L";
      options.desc = "Log Line";
    }
    {
      action = pickerAction "git_status";
      key = prefix + "s";
      options.desc = "Status";
    }
    {
      action = pickerAction "git_stash";
      key = prefix + "S";
      options.desc = "Stash";
    }
    {
      action = pickerAction "git_diff";
      key = prefix + "d";
      options.desc = "Diff (Hunks)";
    }
    {
      action = pickerAction "git_log_file";
      key = prefix + "f";
      options.desc = "Log File";
    }
  ]);
}
