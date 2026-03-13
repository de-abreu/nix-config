{
  config,
  lib,
  ...
}: let
  cfg = config.programns.nixvim.plugins.snacks;
  enable = cfg.enable && (cfg.settings.words.enabled or false);
  mkAction = direction: {
    __raw = "function() Snacks.words.jump(${
      if direction == "next"
      then "vim.v.count1"
      else "-vim.v.count1"
    }) end";
  };
in {
  programs.nixvim.keymaps =
    lib.optionals
    enable
    (map (m: m // {mode = "n";}) [
      {
        key = "]]";
        action = mkAction "next";
        options.desc = "Next Reference";
      }
      {
        key = "[[";
        action = mkAction "previous";
        options.desc = "Previous Reference";
      }
    ]);
}
