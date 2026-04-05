{config, ...}: let
  cfg = config.programs.nixvim.plugins.bufferline;
in {
  programs.nixvim.plugins.faster.settings.features.bufferline = {
    on = cfg.enable;
    defer = false;
    enable.__raw =
      # lua
      ''
        function()
          if pcall(require, "bufferline") then
            vim.opt.showtabline = 2
          end
        end
      '';
    disable.__raw =
      # lua
      ''
        function()
          vim.opt.showtabline = 0
        end
      '';
    commands.__raw =
      # lua
      ''
        function()
          vim.api.nvim_create_user_command("FasterEnableBufferline", function()
            if pcall(require, "bufferline") then
              vim.opt.showtabline = 2
            end
          end, {})
          vim.api.nvim_create_user_command("FasterDisableBufferline", function()
            vim.opt.showtabline = 0
          end, {})
        end
      '';
  };
}
