{config, ...}: let
  cfg = config.programs.nixvim.plugins.noice;
in {
  programs.nixvim.plugins.faster.settings.features.noice = {
    on = cfg.enable;
    defer = false;
    enable.__raw =
      # lua
      ''
        function()
          if pcall(require, "noice") then
            require("noice").enable()
          end
        end
      '';
    disable.__raw =
      # lua
      ''
        function()
          if pcall(require, "noice") then
            require("noice").disable()
          end
        end
      '';
    commands.__raw =
      # lua
      ''
        function()
          vim.api.nvim_create_user_command("FasterEnableNoice", function()
            if pcall(require, "noice") then
              require("noice").enable()
            end
          end, {})
          vim.api.nvim_create_user_command("FasterDisableNoice", function()
            if pcall(require, "noice") then
              require("noice").disable()
            end
          end, {})
        end
      '';
  };
}
