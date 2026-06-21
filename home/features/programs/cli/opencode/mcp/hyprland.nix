{
  inputs,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  hyprmcp = inputs.hyprmcp;
in
{
  programs.mcp.servers.hyprmcp = lib.mkIf osConfig.programs.hyprland.enable {
    disabled = true;
    command = lib.getExe pkgs.uv;
    args = [
      "run"
      "--with"
      "mcp[cli]"
      "${hyprmcp}/hyprmcp/server.py"
    ];
    env.HYPRLAND_INSTANCE_SIGNATURE = "{env:HYPRLAND_INSTANCE_SIGNATURE}";
  };
}
