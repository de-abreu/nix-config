{
  featuresEnabled,
  lib,
  snacksAction,
  ...
}: let
  bind = {
    key = "<leader>go";
    action = snacksAction "gitbrowse" {};
  };
in {
  programs.nixvim.keymaps =
    lib.optionals
    (featuresEnabled "gitbrowse")
    (map (m: m // bind) [
      {
        mode = "n";
        options.desc = "Open file in browser";
      }
      {
        mode = "v";
        options.desc = "Open selection in browser";
      }
    ]);
}
