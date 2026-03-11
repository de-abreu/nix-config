{
  config,
  importAll,
  ...
}: {
  imports = importAll {dir = ./.;};

  programs.nixvim.plugins = {
    faster = {
      enable = true;
      lazyLoad.settings.event = "DeferredUIEnter";

      settings.behaviours = let
        cfg = config.programs.nixvim.plugins;
        optionalPlugins = plugins:
          builtins.filter (name: cfg.${name}.enable or false) plugins
          |> map (builtins.replaceStrings ["-"] ["_"]);
      in {
        bigfile = {
          on = true;
          features_disabled =
            [
              "filetype"
              "lsp"
              "matchparen"
              "syntax"
              "treesitter"
              "vimopts"
            ]
            ++ optionalPlugins [
              "bufferline"
              "gitsigns"
              "blink-indent"
              "noice"
              "snacks"
            ];
          filesize = 2;
          pattern = "*";
          extra_patterns = [
            # More aggressive for log files
            {
              filesize = 1;
              pattern = "*.log";
            }
            # Even more aggressive for large data files
            {
              filesize = 0.5;
              pattern = "*.{csv,json,xml}";
            }
            # Markdown files can get large with embedded content
            {
              filesize = 1.5;
              pattern = "*.md";
            }
          ];
        };

        bigfile_hugefiles = {
          on = true;
          features_disabled = optionalPlugins [
            "lualine"
            "bufferline"
            "blink-indent"
            "noice"
          ];
        };
      };
    };
  };
}
