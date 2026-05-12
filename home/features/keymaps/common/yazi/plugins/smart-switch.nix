{ config, lib, ... }:
let
  cfg = config.programs.yazi.plugins;
  plugin = "smart-switch";
in
{
  programs.yazi.keymap.mgr.prepend_keymap =
    lib.range 1 9
    |> map toString
    |> map (idx: {
      on = [ idx ];
      run = "plugin ${plugin} ${idx}";
      desc = "Switch or create tab ${idx}";
    })
    |> lib.mkIf (lib.hasAttr plugin cfg);
}
