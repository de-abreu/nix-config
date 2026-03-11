{config, ...}: let
  cfg = config.programs.nixvim.plugins.snacks;
in {
  programs.nixvim.plugins.faster.settings.features.snacks = {
    on = cfg.enable;
    defer = false;
    enable.__raw =
      # lua
      ''
        function()
          if pcall(require, "snacks") then
            local snacks = require("snacks")
            if snacks.scroll then snacks.scroll.enable() end
            if snacks.indent then snacks.indent.enable() end
          end
        end
      '';
    disable.__raw =
      # lua
      ''
        function()
          if pcall(require, "snacks") then
            local snacks = require("snacks")
            if snacks.scroll then snacks.scroll.disable() end
            if snacks.indent then snacks.indent.disable() end
          end
        end
      '';
    commands.__raw =
      #lua
      ''
        function()
          vim.api.nvim_create_user_command("FasterEnableSnacks", function()
            if pcall(require, "snacks") then
              local snacks = require("snacks")
              if snacks.scroll then snacks.scroll.enable() end
              if snacks.indent then snacks.indent.enable() end
            end
          end, {})
          vim.api.nvim_create_user_command("FasterDisableSnacks", function()
            if pcall(require, "snacks") then
              local snacks = require("snacks")
              if snacks.scroll then snacks.scroll.disable() end
              if snacks.indent then snacks.indent.disable() end
            end
          end, {})
        end
      '';
  };
}
