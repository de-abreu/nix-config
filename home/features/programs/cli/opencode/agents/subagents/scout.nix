{ config, lib, ... }: {
  programs.opencode.settings.agent.scout =
    let
      tool = "morph-mcp_github_codebase_search";
    in
    lib.mkIf (config.programs.mcp.servers ? morph-mcp) {
      permission.${tool} = "allow";
      prompt = "{file:./prompts/${tool}.md}";
    };
}
