{
  featuresEnabled,
  lib,
  snacksAction,
  ...
}: let
  feat = "rename";
in {
  programs.nixvim.keymaps = lib.optionals (featuresEnabled feat) [
    {
      action = snacksAction "${feat}.rename_file" {};
      key = "<leader>r";
      mode = "n";
      options.desc = "Rename File";
    }
  ];
}
