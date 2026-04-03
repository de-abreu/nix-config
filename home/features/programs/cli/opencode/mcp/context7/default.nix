let
  envVar = "CONTEXT7_API_KEY";
  apiKey.${envVar} = "api-keys/context7";
in
{
  programs = {
    opencode.apiKeys = apiKey;
    mcp.servers.context7 = {
      url = "https://mcp.context7.com/mcp";
      headers.${envVar} = "{env:${envVar}}";
    };
  };
  xdg.configFile."opencode/skills/context7/SKILL.md".source = ./skill.md;
}
