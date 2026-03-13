# INFO: Dashboard screen
{
  config,
  lib,
  pkgs,
  ...
}:
let
  alpha-ascii = import ./alpha-ascii.nix { inherit pkgs; };
  mkDashboardButton = import ./mkDashboardButton.nix { inherit config lib; };
  icons = import ../lib/icons.nix;
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

              -- 4. Count Plugins (Filtering out Tree-sitter grammars)
              local plugin_dirs = vim.fn.globpath(vim.o.packpath, "pack/*/start/*", false, true)
              local plugins_count = 0

              for _, dir in ipairs(plugin_dirs) do
                  -- Ignore any directory name that contains "tree-sitter-" or "treesitter-"
                  if not string.match(dir, "tree%-sitter%-") and not string.match(dir, "treesitter%-") then
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
