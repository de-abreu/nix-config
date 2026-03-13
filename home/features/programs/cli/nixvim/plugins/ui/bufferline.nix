let
  icons = import ./lib/icons.nix;
in
{
  programs.nixvim.plugins.bufferline = {
    enable = true;
    lazyLoad.settings.event = [
      "BufReadPre"
      "BufNewFile"
    ];
    settings.options = {
      diagnostics = "nvim_lsp";
      diagnostics_indicator =
        with icons;
        # lua
        ''
          function(count, level, diagnostics_dict, context)
            local s = ""
            for e, n in pairs(diagnostics_dict) do
              local sym = e == "error" and " ${diagnostic.error}"
              or (e == "warning" and " ${diagnostic.warn}" or "" )
              if(sym ~= "") then
                s = s .. " " .. n .. sym
              end
            end
            return s
          end
        '';

      groups = {
        options.toggle_hidden_on_enter = true;

        items = [
          {
            name = "Tests";
            highlight = {
              underline = true;
              fg = "#a6da95";
              sp = "#494d64";
            };
            priority = 2;
            matcher.__raw =
              # lua
              ''
                function(buf)
                  return buf.name:match('%test') or buf.name:match('%.spec')
                end
              '';
          }
          {
            name = "Docs";
            highlight = {
              undercurl = true;
              fg = "#ffffff";
              sp = "#494d64";
            };
            auto_close = false;
            matcher.__raw =
              # lua
              ''
                function(buf)
                  return buf.name:match('%.md') or buf.name:match('%.txt')
                end
              '';
          }
        ];
      };

      show_buffer_close_icons = false;
      show_buffer_icons = true;
      show_close_icon = false;
      sort_by = "extension";
    };
  };
}
