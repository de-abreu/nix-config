{
  config,
  flakePath,
  importAll,
  lib,
  pkgs,
  ...
}:
let
  plugins = config.programs.opencode.settings.plugin or [ ];
  hasPlugins = builtins.length plugins > 0;

  # INFO: Opencode uses bun to install its plugins, this wrapper adds bun to opencode's PATH whenever there are plugins listed in its configuration.
  opencode-wrapped = pkgs.symlinkJoin {
    name = "opencode-wrapped";
    paths = [ pkgs.opencode ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/opencode \
        --prefix PATH : ${lib.makeBinPath [ pkgs.bun ]}
    '';
  };
in
{
  imports = [
    ./mcp
    ./plugins
    ./providers
  ];

  programs = {
    opencode = {
      enable = true;
      package = if hasPlugins then opencode-wrapped else pkgs.opencode;
      settings = {
        server.port = 8765;
        default_agent = "plan";
        model = "opencode-go/glm-5";
      };
    };

    # TODO(upstream): Remove this workaround once OpenCode fixes the bug where
    # server.port from config is ignored. The server binds before reading the
    # config file, so the port setting has no effect. See upstream issues:
    # https://github.com/anomalyco/opencode/issues/17927
    # https://github.com/anomalyco/opencode/issues/19078
    fish.shellAbbrs.oc = "opencode --port ${toString config.programs.opencode.settings.server.port}";
  };

  home = {
    sessionVariables.OPENCODE_EXPERIMENTAL = "true";
    file =
      let
        cfg = "./config/opencode";
      in
      {
        "${cfg}/AGENTS.md" = {
          text =
            # markdown
            ''
              # NixOS System Instructions

              You are operating on a stable release of the NixOS system. The system's configuration and the home environment of its users are managed through a flake located at the `${flakePath}` folder.

              > [!warn] Editing AGENTS.md
              > Even though this file (${config.xdg.configHome}/opencode/AGENTS.md) is mutable, it is also being managed through Home-Manager and, as such, changes must be added to `${flakePath}/home/features/programs/cli/opencode/default.nix` in order to persist in newer generations. Offer to update the nix configuration accordingly whenever the user asks for changes to be made in this file.

              ## Comma Tool for Ad-hoc Commands

              When a command is not found or not in PATH, use the `,` (comma) prefix to
              temporarily install and run it from nixpkgs.

              **Usage**: `, <command> [args...]`

              **Examples**:

              - `, pdftotext file.pdf -` — extract PDF text
              - `, jq . file.json` — parse JSON
              - `, pip3 install package` — run pip without installing Python globally
              - `, tree` — show directory tree

              ### When to Use Comma

              - When `which <command>` fails or returns nothing
              - When a required tool is missing from PATH
              - For one-off utilities (pdftotext, jq, tree, ripgrep, etc.)

              ### Workflow

              1. First try running the command directly
              2. If it fails with "command not found", retry with `,` prefix
              3. Comma caches package resolutions for fast subsequent runs
            '';
          mutable = true;
          force = true;
        };
        "${cfg}/instructions" = {
          source = ./instructions;
          recursive = true;
        };
      };
  };
}
