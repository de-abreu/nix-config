{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.programs.opencode = with types; {
    env = {
      apiKeys = mkOption {
        type = attrsOf str;
        default = { };
        description = "API keys to inject into the opencode environment. Maps env var name to sops secret path.";
        example = {
          OPENCODE_API_KEY = "api-keys/opencode";
          DEEPSEEK_API_KEY = "api-keys/deepseek";
        };
      };

      vars = mkOption {
        type =
          oneOf [
            str
            bool
            int
          ]
          |> attrsOf;
        default = { };
        description = "Environemnt variables to inject into the opencode environment.";
        example = {
          OPENCODE_EXPERIMENTAL = true;
          OPENCODE_ENABLE_EXA = "true";
        };
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
          '') cfg.env.apiKeys
          |> concatStringsSep "\n";
        runtimeInputs = cfg.extraPackages ++ optionals (cfg ? settings.plugin) [ pkgs.bun ];
        flags = optionalAttrs (cfg ? settings.server.port) {
          "--port" = toString cfg.settings.server.port;
        };
        env = mapAttrs (_: toString) cfg.env.vars;
      };
    in
    {
      sops.secrets = genAttrs (attrValues cfg.env.apiKeys) (_: { });

      programs = {
        fish.shellAbbrs.op = "opencode";
        opencode = {
          enable = true;
          package = opencode-wrapped;
          settings = {
            autoupdate = false;
            default_agent = "plan";
            server.port = 8765;
            permission.bash."sudo *" = "deny";
          };
          env.vars.OPENCODE_EXPERIMENTAL = true;
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
      };
      xdg.configFile."opencode/instructions" = {
        source = ./instructions;
        recursive = true;
      };
    };
}
