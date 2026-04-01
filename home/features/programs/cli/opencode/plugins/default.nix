{ importAll, ... }:
{
  imports = importAll { dir = ./.; };

  programs.opencode.settings.plugin = [
    "@zenobius/opencode-skillful"
    "@mohak34/opencode-notifier@latest"
  ];
}
