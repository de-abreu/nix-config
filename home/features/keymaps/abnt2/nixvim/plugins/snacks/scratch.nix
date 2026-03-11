{
  featureEnabled,
  lib,
  snacksAction,
  ...
}: let
  feat = "scratch";
  prefix = "<leader>N";
in {
  programs.nixvim = {
    which-key.settings.spec = lib.optional (featureEnabled feat) [
      {
        __unkeyed-1 = prefix;
        group = "Notes";
        icon = " ";
      }
    ];

    keymaps = lib.optionals (featureEnabled feat) (map (m: m // {mode = "n";}) [
      {
        key = prefix + "n";
        action = snacksAction "scratch" {};
        options.desc = "New Scratch Buffer";
      }
      {
        key = prefix + "s";
        action = snacksAction "scratch.select" {};
        options.desc = "Select Scratch Buffer";
      }
    ]);
  };
}
