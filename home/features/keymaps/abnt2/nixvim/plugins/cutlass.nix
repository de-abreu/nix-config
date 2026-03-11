{
  lib,
  pluginCfg,
  ...
}: {
  programs.nixvim = {
    plugins.cutlass-nvim.settings.cut_key = "m";

    # NOTE: Solve default "m" keybind conflict: mm and M are handled internally by Cutlass when cut_key is set.
    keymaps =
      lib.optionals
      pluginCfg.cutlass-nvim.enable
      (map (m: m // {mode = "n";}) [
        {
          key = "gm";
          action = "m";
          options = {
            desc = "Set mark";
            silent = true;
          };
        }
        {
          key = "m";
          action = "m";
          options.desc = "Cut operation";
        }
      ]);
  };
}
