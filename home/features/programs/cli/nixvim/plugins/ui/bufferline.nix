let
  icons = import ./lib/icons.nix;
in {
  programs.nixvim = {
    globals.buffer_limit_count = 8;
    extraConfigLua =
      # lua
      ''
        vim.g.buffer_limit_enabled = true

        _G.enforce_smart_buffer_limit = function()
            -- Check the global toggle
            if not vim.g.buffer_limit_enabled then return end

            -- Pull the limit from globals
            local max_buffers = vim.g.buffer_limit_count or 8
            local bufs = vim.fn.getbufinfo({buflisted = 1})

            if #bufs <= max_buffers then return end

            for _, buf in ipairs(bufs) do
              local bufnr = buf.bufnr
              local is_visible = vim.fn.win_findbuf(bufnr)[1] ~= nil

              -- Pin protection check
              local is_pinned = vim.t.bufferline_pinned_buffers
                                and vim.tbl_contains(vim.t.bufferline_pinned_buffers, bufnr)

              if not is_visible and not is_pinned then
                vim.schedule(function()
                  -- confirm bdelete: asks to save if modified
                  vim.cmd("confirm bdelete " .. bufnr)
                end)
                break
              end
            end
          end
      '';

    autoCmd = [
      {
        event = "BufAdd";
        callback.__raw =
          # lua
          ''function() vim.schedule(_G.enforce_buffer_limit) end'';
      }
    ];
    plugins.bufferline = {
      enable = true;
      lazyLoad.settings.event = [
        "BufReadPre"
        "BufNewFile"
      ];
      settings.options = {
        diagnostics = "nvim_lsp";
        diagnostics_indicator = with icons;
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
  };
}
