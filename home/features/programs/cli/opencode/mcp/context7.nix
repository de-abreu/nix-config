{
  programs =
    let
      envVar = "CONTEXT7_API_KEY";
      apiKey.${envVar} = "api-keys/context7";
    in
    {
      opencode = {
        env.apiKeys = apiKey;
        settings.permission."context7_*" = "deny";
      };
      mcp.servers.context7 = {
        url = "https://mcp.context7.com/mcp";
        headers.${envVar} = "{env:${envVar}}";
      };
    };
}
