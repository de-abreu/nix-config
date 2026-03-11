{importAll, ...}: {
  imports = importAll {dir = ./.;};

  programs.nixvim.plugins.blink-cmp = {
    enable = true;
    lazyLoad.event = ["InsertEnter" "CmdlineEnter"];

    settings = {
      sources.default = ["lsp" "path" "snippets" "buffer"];

      # Completion Behavior
      completion = {
        list.selection.preselect = false;
        ghost_text.enabled = true;
        accept.auto_brackets = {
          enabled = true;
          override_brackets_for_filetypes = {
            lua = ["{" "}"];
            nix = ["{" "}"];
          };
        };
      };
      trigger = {
        prefetch_on_insert = true;
        show_on_backspace = true;
      };

      accept.auto_brackets.enabled = true;

      menu = {
        border = "rounded";
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None";

        # Smart direction logic (sticky menu)
        direction_priority.__raw =
          # lua
          ''
            function()
              local ctx = require('blink.cmp').get_context()
              local item = require('blink.cmp').get_selected_item()
              if ctx == nil or item == nil then return { 's', 'n' } end
              local item_text = item.textEdit ~= nil and item.textEdit.newText or item.insertText or item.label
              if item_text:find('\n') ~= nil or vim.g.blink_cmp_upwards_ctx_id == ctx.id then
                vim.g.blink_cmp_upwards_ctx_id = ctx.id
                return { 'n', 's' }
              end
              return { 's', 'n' }
            end
          '';

        draw = {
          treesitter = ["lsp"];
          columns = [
            {member = "label";}
            {
              member = "kind_icon";
              gap = 1;
            }
            {member = "kind";}
            {
              member = "source_name";
              gap = 1;
            }
          ];
          components.kind_icon = {
            ellipsis = false;
            text.__raw =
              # lua
              "function(ctx) return _G.get_kind_icon(ctx).text end";
            highlight.__raw =
              # lua
              "function(ctx) return _G.get_kind_icon(ctx).highlight end";
          };
        };
      };

      documentation = {
        autoShow = true;
        window.border = "rounded";
      };

      signature = {
        enabled = true;
        window.border = "rounded";
      };

      fuzzy = {
        implementation = "prefer_rust";
        prebuilt_binaries.download = false;
        sorts = ["exact" "score" "sort_text"];
      };

      snippets.preset = "mini_snippets";

      cmdline.completion = {
        ghostText.enabled = false;
        menu.autoShow = true;
      };
    };
  };
}
