{ config, lib, ... }: {
  programs.opencode.settings.agent.explore =
    let
      tool = "morph-mcp_codebase_search";
    in
    lib.mkIf (config.programs.mcp.servers ? morph-mcp) {
      mode = "subagent";
      permission.${tool} = "allow";
      prompt = "{file:./prompts/${tool}.md}";
    };
}
