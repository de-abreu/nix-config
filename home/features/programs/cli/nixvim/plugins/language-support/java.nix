# INFO: Java language support using nvim-jdtls
# DAP bundles are extracted from vscode extensions.
{ lib, pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      jdtls = {
        enable = true;

        settings = {
          cmd = [
            "jdtls"
            "-Xms1g"
            "-javaagent:${pkgs.lombok}/share/java/lombok.jar"
            "-data"
            {
              __raw = "vim.fn.stdpath('data') .. '/java/workspace-root/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')";
            }
          ];

          root_dir.__raw = "vim.fs.root(0, {'.root', 'mvnw', 'gradlew'})";

          settings.java = {
            eclipse = {
              downloadSources = true;
            };
            configuration.updateBuildConfiguration = "interactive";
            maven.downloadSources = true;
            implementationsCodeLens.enabled = true;
            referencesCodeLens.enabled = true;
            inlayHints.parameterNames.enabled = "all";
            signatureHelp.enabled = true;
            completion.favoriteStaticMembers = [
              "org.hamcrest.MatcherAssert.assertThat"
              "org.hamcrest.Matchers.*"
              "org.hamcrest.CoreMatchers.*"
              "org.junit.jupiter.api.Assertions.*"
              "java.util.Objects.requireNonNull"
              "java.util.Objects.requireNonNullElse"
              "org.mockito.Mockito.*"
            ];
            sources.organizeImports = {
              starThreshold = 9999;
              staticStarThreshold = 9999;
            };
          };

          init_options.bundles.__raw =
            let
              java-debug = pkgs.vscode-extensions.vscjava.vscode-java-debug;
            in
            # lua
            ''
              vim.split(vim.fn.glob("${java-debug}/share/vscode/extensions/vscjava.vscode-java-debug/server/*.jar"), "\n")
            '';
        };
      };

      conform-nvim.settings = {
        formatters_by_ft.java = [ "google-java-format" ];
        formatters.google-java-format = {
          command = lib.getExe pkgs.google-java-format;
          timeout = 10000;
        };
      };
    };

    autoCmd = [
      {
        event = "LspAttach";
        pattern = "*.java";
        callback.__raw = ''
          function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client.name == "jdtls" then
              require('dap')
              require('jdtls.dap').setup_dap_main_class_configs()
            end
          end
        '';
      }
    ];
  };
}
