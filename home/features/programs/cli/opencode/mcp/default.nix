{ importAll, ... }:
{
  imports = importAll { dir = ./.; };

  programs = {
    mcp.enable = true;
    opencode.enableMcpIntegration = true;
  };
}
