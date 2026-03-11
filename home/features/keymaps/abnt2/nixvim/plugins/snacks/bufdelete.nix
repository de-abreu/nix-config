{
  featuresEnabled,
  snacksAction,
  lib,
  ...
}: let
  feat = "bufdelete";
  action = func: snacksAction func {};
in {
  programs.nixvim.keymaps =
    lib.optionals
    (featuresEnabled feat)
    (map (m: m // {mode = "n";}) [
      {
        key = "<leader>c";
        action = action "delete";
        options.desc = "Close buffer";
      }
      {
        key = "<leader>bc";
        action = action "other";
        options.desc = "Close all buffers but current";
      }
      {
        key = "<leader>bC";
        action = action "all";
        options.desc = "Close all buffers";
      }
    ]);
}
