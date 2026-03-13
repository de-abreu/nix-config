{
  config,
  lib,
  ...
}: let
  cfg = config.programs.nixvim.plugins.snacks;
  enable =
    cfg.enable
    && (cfg.settings.explorer.enable or false)
    && (cfg.settings.toggle.enable or false);
in {
  programs.nixvim.keymaps = lib.mkIf enable [
    {
      mode = "n";
      key = "<leader>e";
      action.__raw = "function() Snacks.toggle.explorer():toggle() end";
      options.desc = "Toggle Explorer";
    }
    {
      mode = "n";
      key = "<leader>o";
      action.__raw =
        # lua
        ''
          function()
            -- Ask snacks if the explorer is currently active
            local pickers = Snacks.picker.get({ source = "explorer" })

            if #pickers > 0 then
              local picker = pickers[1]
              local current_buf = vim.api.nvim_get_current_buf()

              -- Check if our cursor is currently inside the explorer's list or input buffer
              local is_explorer_focused = current_buf == picker.list.buf or (picker.input and current_buf == picker.input.buf)

              if is_explorer_focused then
                -- We are in the explorer. Jump back to the previously active window.
                vim.cmd("wincmd p")
              else
                -- The explorer is open, but we are in a code buffer. Focus the explorer.
                picker:focus()
              end
            else
              -- The explorer doesn't exist at all. Open it.
              Snacks.toggle.explorer():toggle()
            end
          end
        '';
      options.desc = "Toggle Explorer Focus";
    }
  ];
}
