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
  xdg.configFile =
    builtins.readDir ./prompts
    |> lib.mapAttrs' (
      name: _: {
        name = "opencode/prompts/${name}";
        value.source = ./prompts/${name};
      }
    );

  programs = {
    opencode = {
      env.apiKeys = apiKey;
      settings.permission."morph-mcp_*" = "deny"; # Selectively enabled in a per agent basis.
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
