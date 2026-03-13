{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    opts.formatexpr = "v:lua.require'conform'.formatexpr()";

    plugins = {
      conform-nvim = {
        enable = true;

        autoInstall = {
          enable = true;
          overrides.swift_format =
            lib.mkIf pkgs.stdenv.hostPlatform.isLinux null;
        };

        lazyLoad.settings = {
          cmd = ["ConformInfo"];
          event = ["BufWritePre"];
        };

        luaConfig.pre =
          # lua
          ''local slow_format_filetypes = {}'';

        settings = {
          default_format_opts.lsp_format = "fallback";

          format_on_save.__raw =
            # lua
            ''
              function(bufnr)
                if vim.F.if_nil(vim.b[bufnr].autoformat, vim.g.autoformat, true) then
                  return { lsp_format = "fallback" }
                end
              end
            '';

          formatters_by_ft = {
            # Use the "_" filetype to run formatters on filetypes that don't have other formatters configured.
            "_" = [
              "squeeze_blanks"
              "trim_whitespace"
              "trim_newlines"
            ];
          };

          formatters.biome.env.BIOME_CONFIG_PATH = pkgs.writeTextFile {
            name = "biome.json";
            text = lib.generators.toJSON {} {
              "$schema" = "${pkgs.biome}/node_modules/@biomejs/biome/configuration_schema.json";
              formatter.useEditorconfig = true;
            };
          };
        };
      };
    };

    userCommands.Format = {
      desc = "Format buffer";
      range = true;
      command.__raw =
        # lua
        ''
          function(args)
            ${lib.optionalString
            config.programs.nixvim.plugins.lz-n.enable
            "require('lz.n').trigger_load('conform.nvim')"}
            local range = nil
            if args.count ~= -1 then
              local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
              range = {
                start = { args.line1, 0 },
                ["end"] = { args.line2, end_line:len() },
              }
            end
            require("conform").format({ async = true, lsp_format = "fallback", range = range },
              function(err)
                if not err then
                  local mode = vim.api.nvim_get_mode().mode
                  if vim.startswith(string.lower(mode), "v") then
                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
                  end
                end
              end)
          end
        '';
    };
  };
}
