{
  config,
  lib,
  ...
}: let
  cfg = config.programs.nixvim.plugins.precognition;
in {
  programs.nixvim.keymaps = lib.mkIf cfg.enable [
    {
      mode = "n";
      key = "<leader>up";
      action.__raw =
        # lua
        ''
          function()
            if require("precognition").toggle() then
                vim.notify("Precognition on")
            else
                vim.notify("Precognition off")
            end
          end
        '';

      options = {
        desc = "Precognition Toggle";
        silent = true;
      };
    }
  ];
}
