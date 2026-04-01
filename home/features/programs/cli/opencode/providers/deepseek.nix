{ config, ... }:
let
  envVar = "DEEPSEEK_API_KEY";
  secretsPath = "api-keys/deepseek";
  inherit (config.sops) secrets;
in
{
  sops.secrets.${secretsPath} = { };

  programs = {
    fish.shellInit = "export ${envVar}=$(cat ${secrets.${secretsPath}.path})";
    opencode.settings.provider.deepseek.options.apiKey = "{env:${envVar}}";
  };
}
