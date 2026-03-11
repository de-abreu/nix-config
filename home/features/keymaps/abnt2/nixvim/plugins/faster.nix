{
  pluginCfg,
  lib,
  ...
}: {
  programs.nixvim = {
    keymaps = let
      # Helper to create toggle keymaps for faster features
      mkFasterToggle = feature: key: desc: {
        mode = "n";
        inherit key;
        action.__raw =
          # lua
          ''
            function()
              local enabled_var = "faster_${lib.toLower feature}_enabled"
              if vim.g[enabled_var] == false then
                vim.cmd('FasterEnable${feature}')
                vim.g[enabled_var] = true
              else
                vim.cmd('FasterDisable${feature}')
                vim.g[enabled_var] = false
              end
              vim.notify(string.format("Faster ${desc} %s", tostring(vim.g[enabled_var])), "info")
            end
          '';
        options.esc = "Toggle ${desc}";
      };
    in
      lib.optionals pluginCfg.faster.enable [
        # Global toggles
        (mkFasterToggle "AllFeatures" "<leader>uxa" "All Features")
        (mkFasterToggle "Bigfile" "<leader>uxb" "Bigfile Behavior")
        (mkFasterToggle "Fastmacro" "<leader>uxm" "Fastmacro Behavior")

        # Core feature toggles (always available with faster)
        (mkFasterToggle "Lsp" "<leader>uxl" "LSP")
        (mkFasterToggle "Treesitter" "<leader>uxt" "Treesitter")
        (mkFasterToggle "Syntax" "<leader>uxs" "Syntax")
        (mkFasterToggle "Matchparen" "<leader>uxp" "Matchparen")
        (mkFasterToggle "Vimopts" "<leader>uxy" "Vimopts")
        (mkFasterToggle "Filetype" "<leader>uxv" "Filetype")
      ]
      ++ lib.optionals (pluginCfg.noice.enable) [
        (mkFasterToggle "Noice" "<leader>uxn" "Noice")
      ]
      ++ lib.optionals (pluginCfg.lualine.enable) [
        (mkFasterToggle "Lualine" "<leader>uxu" "Lualine")
      ]
      ++ lib.optionals (pluginCfg.bufferline.enable) [
        (mkFasterToggle "Bufferline" "<leader>uxo" "Bufferline")
      ]
      ++ lib.optionals (pluginCfg.gitsigns.enable) [
        (mkFasterToggle "Gitsigns" "<leader>uxg" "Gitsigns")
      ]
      ++ lib.optionals (pluginCfg.blink-indent.enable) [
        (mkFasterToggle "BlinkIndent" "<leader>uxd" "Blink Indent")
      ]
      ++ lib.optionals (pluginCfg.snacks.enable) [
        (mkFasterToggle "Snacks" "<leader>uxk" "Snacks")
      ];

    plugins.which-key.settings.spec = lib.optionals pluginCfg.faster.enable [
      {
        __unkeyed-1 = "<leader>ux";
        group = "Faster Toggles";
        icon = "󰔡";
      }
    ];
  };
}
