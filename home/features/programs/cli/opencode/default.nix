{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib;
let
  inherit (types)
    attrsOf
    listOf
    str
    package
    ;
in
{
  options.programs.opencode = {
    apiKeys = mkOption {
      type = attrsOf str;
      default = { };
      description = "API keys to inject into opencode environment. Maps env var name to sops secret path.";
      example = {
        OPENCODE_API_KEY = "api-keys/opencode";
        DEEPSEEK_API_KEY = "api-keys/deepseek";
      };
    };

    extraPackages = mkOption {
      type = listOf package;
      default = [ ];
      description = "List of packages whose binaries will be added to the opencode runtime PATH.";
    };
  };

  config =
    let
      cfg = config.programs.opencode;
      opencode-wrapped = inputs.wrappers.lib.wrapPackage {
        inherit pkgs;
        package = pkgs.opencode;
        preHook =
          mapAttrsToList (name: secretPath: ''
            ${name}="$(cat ${config.sops.secrets.${secretPath}.path})" || exit 1
            export ${name}
            readonly ${name}
          '') cfg.apiKeys
          |> concatStringsSep "\n";
        runtimeInputs = cfg.extraPackages ++ optionals (cfg ? settings.plugins) [ pkgs.bun ];
        flags = optionalAttrs (cfg ? settings.server.port) {
          "--port" = toString cfg.settings.server.port;
        };
      };
    in
    {
      sops.secrets = genAttrs (attrValues cfg.apiKeys) (_: { });

      programs = {
        fish.shellAbbrs.op = "opencode";
        opencode = {
          enable = true;
          package = opencode-wrapped;
          settings = {
            server.port = 8765;
            default_agent = "plan";
            model = "opencode-go/glm-5";
            plugin = [
              "@zenobius/opencode-skillful"
              "@mohak34/opencode-notifier@latest"
            ];
            autoupdate = false;
          };
        };
      };

      home = {
        # INFO: Workaround. Without it the database was rebuilt every time the session was opened.
        activation.createOpencodeSymlink =
          let
            dataHome = "${config.xdg.dataHome}/opencode";
          in
          lib.hm.dag.entryAfter [ "writeBoundary" ] ''
            $DRY_RUN_CMD ln -sfn $VERBOSE_ARG \
              "${dataHome}/opencode-stable.db" \
              "${dataHome}/opencode.db"
          '';
        sessionVariables.OPENCODE_EXPERIMENTAL = "true";
      };
      xdg.configFile."opencode/instructions" = {
        source = ./instructions;
        recursive = true;
      };
    };
}
