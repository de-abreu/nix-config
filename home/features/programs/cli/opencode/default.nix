{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.sessionVariables = {
    OPENCODE_EXPERIMENTAL = "true";
    OPENCODE_ENABLE_EXA = "true";
  };

  sops.secrets = lib.genAttrs [
    "api-keys/deepseek"
    "api-keys/opencode"
    "api-keys/exa"
  ] (_: { });

  programs = {
    fish.shellInit =
      let
        inherit (config.sops) secrets;
      in
      ''
        export DEEPSEEK_API_KEY=(cat ${secrets."api-keys/deepseek".path})
        export OPENCODE_API_KEY=(cat ${secrets."api-keys/opencode".path})
        export EXA_API_KEY=(cat ${secrets."api-keys/exa".path})
      '';

    opencode = {
      enable = true;
      enableMcpIntegration = true;
      settings = {
        server.port = 8765;
        model = "opencode-go/glm-5";
        provider = {
          "opencode-go" = {
            options.apiKey = "{env:OPENCODE_API_KEY}";
          };
          deepseek = {
            options.apiKey = "{env:DEEPSEEK_API_KEY}";
          };
        };
      };
    };

    mcp = {
      enable = true;
    };
  };
}
