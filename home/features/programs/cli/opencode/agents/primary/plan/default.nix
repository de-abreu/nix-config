{
  config,
  inputs,
  lib,
  ...
}:
let
  context7-enabled = config.programs.mcp.servers ? context7;
in
{
  imports = [ ./_shell.nix ];
  programs.opencode.settings.agent.plan.permission."context7-mcp_*" =
    lib.mkIf context7-enabled "allow";
  xdg.configFile."opencode/skills/context7/SKILL.md".source =
    lib.mkIf context7-enabled "${inputs.upstash-context7}/skills/context7-mcp/SKILL.md";
}
