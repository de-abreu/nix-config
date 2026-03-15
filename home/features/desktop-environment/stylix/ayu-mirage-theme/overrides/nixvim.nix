{ pkgs, ... }:
{
  stylix.targets.neovim.enable = false; # Managed by astrotheme
  programs.nixvim = {
    extraPlugins = [ pkgs.vimPlugins.astrotheme ];
    extraConfigLua =
      # lua
      ''
        require("astrotheme").setup({
          plugin_default = true,
          highlights = {
            astrodark = {
              modify_hl_groups = function(hl, c)
                hl.BufferLineError = { fg = c.ui.red }
                hl.BufferLineErrorDiagnostic = { fg = c.ui.red }
              end,
            },
          },
        })

        vim.cmd.colorscheme("astrodark")
      '';
  };
}
