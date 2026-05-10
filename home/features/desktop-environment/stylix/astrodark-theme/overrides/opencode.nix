{ config, ... }:
{
  programs.opencode.settings = with config.lib.stylix.colors.withHashtag; {
    agent.build.color = base0F;
    agent.plan.color = base0E;
  };
}
