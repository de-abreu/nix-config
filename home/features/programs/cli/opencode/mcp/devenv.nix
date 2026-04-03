{ pkgs, lib, ... }:
{
  programs.mcp.servers.devenv = {
    command = lib.getExe pkgs.devenv;
    args = [ "mcp" ];
  };
}
