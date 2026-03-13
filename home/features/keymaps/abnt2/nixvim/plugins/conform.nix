{
  config,
  lib,
  ...
}: let
  cfg = config.programs.nixvim.plugins.conform-nvim;
in {
  programs.nixvim.keymaps = lib.mkIf cfg.enable [
    {
      action.__raw =
        # lua
        ''
          function(args)
            vim.cmd({cmd = 'Format', args = args});
          end
        '';
      key = "<leader>lf";
      mode = "v";
      options = {
        silent = true;
        buffer = false;
        desc = "Format selection";
      };
    }
    {
      action.__raw =
        # lua
        ''
          function()
            vim.cmd('Format');
          end
        '';
      key = "<leader>lf";
      mode = "n";
      options = {
        silent = true;
        desc = "Format buffer";
      };
    }
    {
      action.__raw =
        # lua
        ''
          function()
            vim.b.autoformat = not vim.F.if_nil(vim.b.autoformat, vim.g.autoformat, true)
            vim.notify(string.format("Buffer autoformatting %s", vim.b.autoformat and "on" or "off"))
          end
        '';
      mode = "n";
      key = "<Leader>uf";
      options.desc = "Toggle autoformatting (buffer)";
    }
    {
      action.__raw =
        # lua
        ''
          function()
            -- Fixed assignment logic for standard lua
            vim.g.autoformat = not vim.F.if_nil(vim.g.autoformat, true)
            vim.b.autoformat = nil
            vim.notify(string.format("Global autoformatting %s", vim.g.autoformat and "on" or "off"))
          end
        '';
      key = "<Leader>uF";
      mode = "n";
      options.desc = "Toggle autoformatting (global)";
    }
  ];
}
