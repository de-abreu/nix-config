# INFO: Dashboard screen
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  alpha-ascii = import ./_alpha-ascii.nix { inherit pkgs inputs; };
  mkDashboardButton = import ./_mkDashboardButton.nix { inherit config lib; };
  icons = import ../_icons.nix;
in
{
  programs.nixvim = {
    extraConfigLuaPre = "vim.g.start_time = vim.uv.hrtime()";
    extraPlugins = [
      alpha-ascii
      pkgs.vimPlugins.alpha-nvim
    ];

    extraConfigLua =
      # lua
      ''
        require("alpha_ascii").setup({ header = "random" })

        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.buttons.val = {
            ${mkDashboardButton "New file" icons.file.new}
            ${mkDashboardButton "Smart Find Files" icons.search}
            ${mkDashboardButton "Grep Files" icons.file.word}
            ${mkDashboardButton "Find marks" icons.bookmarks}
            ${mkDashboardButton "Find Config File" icons.config}
            ${mkDashboardButton "Restore Session" icons.refresh}
            dashboard.button("SPC c i", "  Change header image", ":AlphaAsciiNext<CR>"),
        }

        alpha.setup(dashboard.config)
      '';

    autoGroups.alpha_startup.clear = true;
    autoCmd = [
      {
        event = "User";
        pattern = "AlphaReady";
        group = "alpha_startup";
        desc = "Update Alpha dashboard footer with true startup stats";
        once = true;
        callback.__raw =
          # lua
          ''
            function()
              local dashboard = require("alpha.themes.dashboard")

              -- 2. Calculate True Startup Time
              -- hrtime is in nanoseconds. Divide by 1,000,000 for milliseconds,
              -- and then format it to seconds with 3 decimal places.
              local end_time = vim.uv.hrtime()
              local duration_ms = (end_time - vim.g.start_time) / 1000000
              local s = (math.floor(duration_ms) / 1000)

              -- 3. Get Neovim Version
              local v = vim.version()
              local version = "v" .. v.major .. "." .. v.minor .. "." .. v.patch

              -- 4. Update the Footer
              dashboard.section.footer.val = {
                  " ",
                  " Nixvim " .. version .. "    " .. s .. "s",
              }

              -- Force redraw
              pcall(vim.cmd.AlphaRedraw)
            end
          '';
      }
    ];
  };
}
