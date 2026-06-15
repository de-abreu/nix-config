{ ... }:
{
  programs.opencode = {
    env.apiKeys.DEEPSEEK_API_KEY = "api-keys/deepseek";
    settings.provider.deepseek.options.apiKey = "{env:DEEPSEEK_API_KEY}";
  };
}
