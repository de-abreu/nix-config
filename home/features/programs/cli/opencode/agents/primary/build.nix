{ config, lib, ... }: {
  programs.opencode.settings.agent.build =
    let
      tool = "morph-mcp_edit_file";
    in
    lib.mkIf (config.programs.mcp.servers ? morph-mcp) {
      permission.${tool} = "allow";
      prompt = "{file:./prompts/${tool}.md}";
    };
}
