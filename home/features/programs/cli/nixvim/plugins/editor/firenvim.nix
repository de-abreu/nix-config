{
  config,
  lib,
  ...
}: let
  cfg = config.programs.nixvim.plugins.lualine;
in {
  programs.nixvim = {
    plugins.firenvim = {
      enable = true;
      settings.localSettings = {
        ".*" = {
          cmdline = "neovim";
          content = "text";
          priority = 0;
          selector = "textarea";
          takeover = "never";
        };
      };
    };

    autoCmd = [
      {
        event = "UIEnter";
        callback = {
          __raw =
            # lua
            ''
              function(event)
                local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
                if client ~= nil and client.name == "Firenvim" then
                  vim.o.laststatus = 0
                  vim.o.showtabline = 0
                  ${lib.optionalString cfg.enable "require('lualine').hide()"}
                  local ok, _ = pcall(vim.cmd, "colorscheme sorbet")
                end
              end
            '';
        };
      }
    ];
  };

  # NOTE: This is an attempt at automatically executing the following command at
  # every nvim update:
  # :call firenvim#install(0)
  home.activation.setupFirenvim =
    lib.hm.dag.entryAfter ["writeBoundary"]
    # bash
    ''
      # Ensure the newly built Neovim is in the PATH
      export PATH="${config.home.path}/bin:$PATH"

      # Run the installation headlessly to generate the native messaging host
      # files with the fresh /nix/store path
      nvim --headless -c "call firenvim#install(0)" -c "qa!"
    '';
}
