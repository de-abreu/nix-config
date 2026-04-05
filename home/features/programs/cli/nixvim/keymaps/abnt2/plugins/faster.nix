{
  config,
  lib,
  ...
}: let
  cfg = config.programs.nixvim.plugins;
in {
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
        options.desc = "Toggle ${desc}";
      };
    in
      lib.optionals cfg.faster.enable [
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
      ++ lib.optionals (cfg.noice.enable) [
        (mkFasterToggle "Noice" "<leader>uxn" "Noice")
      ]
      ++ lib.optionals (cfg.lualine.enable) [
        (mkFasterToggle "Lualine" "<leader>uxu" "Lualine")
      ]
      ++ lib.optionals (cfg.bufferline.enable) [
        (mkFasterToggle "Bufferline" "<leader>uxo" "Bufferline")
      ]
      ++ lib.optionals (cfg.gitsigns.enable) [
        (mkFasterToggle "Gitsigns" "<leader>uxg" "Gitsigns")
      ]
      ++ lib.optionals (cfg.blink-indent.enable) [
        (mkFasterToggle "BlinkIndent" "<leader>uxd" "Blink Indent")
      ]
      ++ lib.optionals (cfg.snacks.enable) [
        (mkFasterToggle "Snacks" "<leader>uxk" "Snacks")
      ];

    plugins.which-key.settings.spec = lib.mkIf cfg.faster.enable [
      {
        __unkeyed-1 = "<leader>ux";
        group = "Faster Toggles";
        icon = "󰔡";
      }
    ];
  };
}
