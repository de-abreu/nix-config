# INFO: Dashboard screen
{
  config,
  lib,
  pkgs,
  ...
}: let
  alpha-ascii = import ./alpha-ascii.nix {inherit pkgs;};
  mkDashboardButton = import ./mkDashbordButton.nix {inherit config lib;};
  icons = import ../icons.nix;
in {
  programs.nixvim = {
    extraConfigLuaPre = ''vim.g.start_time = vim.uv.hrtime()'';
    extraPlugins = [alpha-ascii];

    plugins.alpha = {
      enable = true;
      luaConfig.content = with icons;
      # lua
        ''
          require("alpha-ascii").setup({ header = "random" })

          local alpha = require("alpha")
          local dashboard = require("alpha.themes.dashboard")

          dashboard.section.buttons.val = {
              ${mkDashboardButton "New file" file.new},
              ${mkDashboardButton "Smart Find File" search},
              ${mkDashboardButton "Search Word (visual or cursor)" file.word},
              ${mkDashboardButton "Find marks" bookmarks},
              ${mkDashboardButton "Find Config File" config},
              ${mkDashboardButton "Restore Session" refresh}
              dashboard.button("SPC c i", "  Change header image", ":AlphaAsciiNext<CR>"),
          }

          alpha.setup(dashboard.opts)
        '';
    };

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

              -- 4. Count Plugins (Heuristic for Nixvim)
              local plugins_count = 0
              for _, path in ipairs(vim.api.nvim_list_runtime_paths()) do
                  if path:match("/nix/store/") and not path:match("vim%-pack%-dir") then
                      plugins_count = plugins_count + 1
                  end
              end

              -- 5. Update the Footer
              dashboard.section.footer.val = {
                  " ",
                  " Nixvim " .. version .. "    " .. plugins_count .. " plugins    " .. s .. "s",
              }

              -- Force redraw
              pcall(vim.cmd.AlphaRedraw)
            end
          '';
      }
    ];
  };
}
