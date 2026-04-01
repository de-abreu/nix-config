{ pkgs, lib, ... }:
{
  programs.mcp.servers.nixos.command = lib.getExe pkgs.mcp-nixos;
}
