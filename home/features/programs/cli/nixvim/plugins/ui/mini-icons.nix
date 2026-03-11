let
  icons = import ./lib/icons.nix;
in {
  programs.nixvim.plugins = {
    mini-icons = {
      enable = true;
      lazyLoad.settings.lazy = true;

      mockDevIcons = true;
      settings = with icons; {
        file = {
          ".keep" = {
            glyph = git.default;
            hl = "MiniIconsGrey";
          };
          "devcontainer.json" = {
            glyph = container;
            hl = "MiniIconsAzure";
          };
        };
        filetype = {
          dotenv = {
            glyph = settings;
            hl = "MiniIconsYellow";
          };
        };
      };
    };

    neo-tree.settings.defaultComponentConfigs = {
      icon.provider.__raw =
        # lua
        ''
          function(icon, node)
            local text, hl
            local mini_icons = require("mini.icons")

            if node.type == "file" then
              text, hl = mini_icons.get("file", node.name)
            elseif node.type == "directory" then
              text, hl = mini_icons.get("directory", node.name)
              -- Original logic: hide icon if expanded (optional)
              if node:is_expanded() then text = nil end
            end

            if text then icon.text = text end
            if hl then icon.highlight = hl end
          end
        '';

      kindIcon.provider.__raw =
        # lua
        ''
          function(icon, node)
            icon.text, icon.highlight = require("mini.icons").get("lsp", node.extra.kind.name)
          end
        '';
    };
  };
}
