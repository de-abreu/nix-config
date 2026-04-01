{ config, ... }:
let
  envVar = "EXA_API_KEY";
  secretsPath = "api-keys/exa";
  inherit (config.sops) secrets;
in
{
  sops.secrets.${secretsPath} = { };
  home.sessionVariables.OPENCODE_ENABLE_EXA = "true";
  programs.fish.shellInit = "export ${envVar}=$(cat ${secrets.${secretsPath}.path})";
}
