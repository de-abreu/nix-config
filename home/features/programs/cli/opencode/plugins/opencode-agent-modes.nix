{ pkgs, ... }:

let
  jsonFormat = pkgs.formats.json { };

  agentModeConfig = {
    currentMode = "economy";
    presets = {
      performance = {
        description = "High-performance models for complex tasks";
        opencode = {
          build.model = "opencodego/glm-5.1";
          plan.model = "opencodego/glm-5.1";
        };
      };
      economy = {
        description = "Cost-efficient model for routine tasks";
        opencode = {
          build.model = "opencodego/kimi-2.5";
          plan.model = "opencodego/kimi-2.5";
        };
      };
    };
  };
in
{
  programs.opencode.settings.plugin = [
    "opencode-agent-modes@latest"
  ];

  home.file.".config/opencode/agent-mode-switcher.json" = {
    source = jsonFormat.generate "agent-mode-switcher.json" agentModeConfig;
    force = true;
    mutable = true;
  };
}
