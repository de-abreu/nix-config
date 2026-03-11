{
  featuresEnabled,
  lib,
  snacksAction,
  ...
}: let
  action = opt: snacksAction "words.jump" {opt = opt;};
in {
  programs.nixvim.keymaps =
    lib.optionals
    (featuresEnabled "words")
    (map (m: m // {mode = "n";}) [
      {
        key = "]]";
        action = action "vim.v.count1";
        options.desc = "Next Reference";
      }
      {
        key = "[[";
        action = action "-vim.v.count1";
        options.desc = "Previous Reference";
      }
    ]);
}
