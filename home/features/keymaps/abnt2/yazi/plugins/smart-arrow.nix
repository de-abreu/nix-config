{
  config,
  lib,
  ...
}:
let
  cfg = config.programs.yazi.plugins;
  plugin = "smart-arrow";
in
{
  programs.yazi.keymap.mgr.prepend_keymap = lib.mkIf (lib.hasAttr plugin cfg) [
    {
      on = "<down>";
      run = "plugin ${plugin} '+1'";
      desc = "Move cursor down";
    }

    {
      on = "<up>";
      run = "plugin ${plugin} '-1'";
      desc = "Move cursor up";
    }

    {
      on = "k";
      run = "plugin ${plugin} '+1'";
      desc = "Move cursor down";
    }

    {
      on = "l";
      run = "plugin ${plugin} '-1'";
      desc = "Move cursor up";
    }
  ];
}
