{
  config,
  flakePath,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkOption
    types
    concatStringsSep
    optionalString
    makeBinPath
    mapAttrsToList
    ;
  cfg = config.programs.opencode;
  plugins = cfg.settings.plugin or [ ];
  hasPlugins = builtins.length plugins > 0;
  hasApiKeys = builtins.length (builtins.attrNames cfg.apiKeys) > 0;
in
{
  imports = [
    ./mcp
    ./plugins
    ./providers
  ];

  options.programs.opencode.apiKeys = mkOption {
    type = types.attrsOf types.str;
    default = { };
    description = "API keys to inject into opencode environment. Maps env var name to sops secret path.";
    example = {
      OPENCODE_API_KEY = "api-keys/opencode";
      DEEPSEEK_API_KEY = "api-keys/deepseek";
    };
  };

  config =
    let
      # INFO: Wrapper that injects API keys and adds bun to PATH.
      # API keys are only exposed to the opencode process, not the user shell.
      # Using --run instead of --set defers reading secrets to runtime (activation time),
      # since sops-nix creates secret files during system activation, not build time.
      apiKeyRunCommands =
        mapAttrsToList (name: secretPath: ''
          export ${name}="$(cat ${config.sops.secrets.${secretPath}.path})"
        '') cfg.apiKeys
        |> concatStringsSep "\n"
        |> (args: "--run '${args}'")
        |> optionalString hasApiKeys;

      bunPath = optionalString hasPlugins ''
        --prefix PATH : ${makeBinPath [ pkgs.bun ]}
      '';

      opencode-wrapped = pkgs.symlinkJoin {
        name = "opencode-wrapped";
        paths = [ pkgs.opencode ];
        buildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/opencode ${apiKeyRunCommands} ${bunPath}
        '';
      };
    in
    {
      sops.secrets = lib.genAttrs (builtins.attrValues cfg.apiKeys) (_: { });

      programs.opencode = {
        enable = true;
        package = opencode-wrapped;
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
      programs.fish.shellAbbrs.oc = "opencode --port ${toString cfg.settings.server.port}";

      home = {
        sessionVariables.OPENCODE_EXPERIMENTAL = "true";
        file =
          let
            cfgPath = ".config/opencode";
          in
          {
            "${cfgPath}/AGENTS.md" = {
              text = import ./agents.nix { inherit config lib flakePath; };
              mutable = true;
              force = true;
            };
            "${cfgPath}/instructions" = {
              source = ./instructions;
              recursive = true;
            };
          };
      };
    };
}
