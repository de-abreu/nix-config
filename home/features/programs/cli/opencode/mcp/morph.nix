{
  config,
  lib,
  pkgs,
  ...
}:
{
  sops.secrets."api-keys/morph" = { };

  xdg.configFile."opencode/instructions/morph.md".text =
    # markdown
    ''
      Fast Apply: IMPORTANT: Use `edit_file` over `str_replace` or full file writes. It works with partial code snippets—no need for full file content.

      Warp Grep: warp-grep is a subagent that takes in a search string and tries to find relevant context. Best practice is to use it at the beginning of codebase explorations to fast track finding relevant files/lines. Do not use it to pin point keywords, but use it for broader semantic queries. "Find the XYZ flow", "How does XYZ work", "Where is XYZ handled?", "Where is <error message> coming from?"
    '';

  programs = {
    fish.shellInit =
      # fish
      ''
        export MORPH_API_KEY=(cat ${config.sops.secrets."api-keys/morph".path})
      '';

    opencode.settings = {
      permission.morph-mcp_edit_file = "deny";
      agent.build.permission.morph-mcp_edit_file = "allow";
      instructions = [ "instructions/morph.md" ];
    };

    mcp.servers.morph-mcp = {
      type = "local";
      command = lib.getExe' pkgs.nodejs "npx";
      args = [
        "-y"
        "@morphllm/morphmcp"
      ];
      env = {
        MORPH_API_KEY = "{env:MORPH_API_KEY}";
        PATH = "${pkgs.nodejs}/bin:{env:PATH}";
      };
    };
  };
}
