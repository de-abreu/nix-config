{ pkgs, lib, inputs, ... }:
let
  hyprmcp = inputs.hyprmcp;
in
{
  programs.mcp.servers.hyprmcp = {
    command = lib.getExe' pkgs.uv "uv";
    args = [
      "run"
      "--with"
      "mcp[cli]"
      "${hyprmcp}/hyprmcp/server.py"
    ];
    env.HYPRLAND_INSTANCE_SIGNATURE = "{env:HYPRLAND_INSTANCE_SIGNATURE}";
  };
}
