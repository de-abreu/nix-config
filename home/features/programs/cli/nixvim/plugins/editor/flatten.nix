{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.nixvim.plugins.snacks;
  enable = cfg.enable && (cfg.settings.terminal.enabled or false);
in
{
  programs.nixvim = {
    # 1. Pull the raw plugin package from nixpkgs
    extraPlugins = [
      pkgs.vimPlugins.flatten-nvim
    ];

    # 2. Setup the plugin early in the Neovim boot process
    extraConfigLuaPre = ''
      local saved_term_win

        require("flatten").setup({
          window = {
            open = "alternate"
          },
          hooks = {
            pre_open = function()
              -- Grab the Neovim window ID of the Snacks terminal
              saved_term_win = vim.api.nvim_get_current_win()
            end,

            post_open = function()
              -- Hide the terminal window natively; Snacks handles the cleanup
              if saved_term_win and vim.api.nvim_win_is_valid(saved_term_win) then
                vim.api.nvim_win_hide(saved_term_win)
              end
            end,

          ${lib.optionalString enable ''
            block_end = function()
              -- Toggle the Snacks terminal back open when a blocking command finishes
              require("snacks").terminal.toggle()
            end,
          ''}
          }
        })
    '';
  };
}
