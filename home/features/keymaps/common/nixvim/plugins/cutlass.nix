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
        cfg = config.programs.nixvim.plugins.cutlass-nvim;
      in
      {
        plugins.cutlass-nvim.settings.cut_key = "m";

        # NOTE: Solve default "m" keybind conflict: mm and M are handled internally by Cutlass when cut_key is set.
        keymaps = lib.mkIf cfg.enable (
          map (m: m // { mode = "n"; }) [
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
          ]
        );
      };
  };
}
