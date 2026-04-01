{ config, ... }:
let
  envVar = "OPENCODE_API_KEY";
  secretsPath = "api-keys/opencode";
  inherit (config.sops) secrets;
in
{
  sops.secrets.${secretsPath} = { };

  programs = {
    fish.shellInit = "export ${envVar}=$(cat ${secrets.${secretsPath}.path})";
    opencode.settings.provider.opencode-go.options.apiKey = "{env:${envVar}}";
  };
}
