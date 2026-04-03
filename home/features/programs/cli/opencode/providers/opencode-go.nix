{ ... }:
{
  programs.opencode = {
    apiKeys.OPENCODE_API_KEY = "api-keys/opencode";
    settings.provider.opencode-go.options.apiKey = "{env:OPENCODE_API_KEY}";
  };
}
