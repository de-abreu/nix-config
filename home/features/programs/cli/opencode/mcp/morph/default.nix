{
  lib,
  pkgs,
  ...
}:
let
  envVar = "MORPH_API_KEY";
  apiKey.${envVar} = "api-keys/morph";
in
{

  xdg.configFile."opencode/instructions/morph.md".source = ./instructions.md;

  programs = {
    opencode = {
      apiKeys = apiKey;
      settings = {
        permission.morph-mcp_edit_file = "deny";
        agent.build.permission.morph-mcp_edit_file = "allow";
        instructions = [ "instructions/morph.md" ];
      };
    };

    mcp.servers.morph-mcp = {
      type = "local";
      command = lib.getExe' pkgs.bun "bunx";
      args = [ "@morphllm/morphmcp" ];
      env = {
        ${envVar} = "{env:${envVar}}";
        PATH = "${pkgs.bun}/bin:{env:PATH}";
      };
    };
  };
}
