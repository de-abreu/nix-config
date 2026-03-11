{config, ...}: let
  cfg = config.programs.nixvim.plugins.gitsigns;
in {
  programs.nixvim.plugins.faster.settings.features.gitsigns = {
    on = cfg.enable;
    defer = false;
    enable.__raw =
      # lua
      ''
        function()
          if pcall(require, "gitsigns") then
            require("gitsigns").toggle_signs(true)
            require("gitsigns").toggle_current_line_blame(true)
          end
        end
      '';
    disable.__raw =
      # lua
      ''
        function()
          if pcall(require, "gitsigns") then
            require("gitsigns").toggle_signs(false)
            require("gitsigns").toggle_linehl(false)
            require("gitsigns").toggle_word_diff(false)
            require("gitsigns").toggle_current_line_blame(false)
          end
        end
      '';
    commands.__raw =
      # lua
      ''
        function()
          vim.api.nvim_create_user_command("FasterEnableGitsigns", function()
            if pcall(require, "gitsigns") then
              require("gitsigns").toggle_signs(true)
              require("gitsigns").toggle_current_line_blame(true)
            end
          end, {})
          vim.api.nvim_create_user_command("FasterDisableGitsigns", function()
            if pcall(require, "gitsigns") then
              require("gitsigns").toggle_signs(false)
              require("gitsigns").toggle_linehl(false)
              require("gitsigns").toggle_word_diff(false)
              require("gitsigns").toggle_current_line_blame(false)
            end
          end, {})
        end
      '';
  };
}
