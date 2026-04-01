{ pkgs, lib, ... }:
let
  hyprmcp = pkgs.fetchFromGitHub {
    owner = "stefanoamorelli";
    repo = "hyprmcp";
    rev = "13d5195e6a474078183cb031771be7a71b330bb6";
    sha256 = "13mkpamrcghf46nd0gch17cxwi4k2qqq1wc0hndbl61jdwr319h7";
  };
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
