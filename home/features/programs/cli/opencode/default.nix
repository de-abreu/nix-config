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
    "api-keys/opencode-go"
  ] (_: { });

  programs = {
    fish.shellInit =
      let
        inherit (config.sops) secrets;
      in
      ''
        export DEEPSEEK_API_KEY=(cat ${secrets."api-keys/deepseek".path})
        export OPENCODE_API_KEY=(cat ${secrets."api-keys/opencode-go".path})
      '';

    opencode = {
      enable = true;
      package = pkgs.unstable.opencode;
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
