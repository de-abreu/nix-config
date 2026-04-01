{ pkgs, ... }:
{
  programs.nixvim = {
    extraPackages = [ pkgs.gh pkgs.glab ];
    plugins = let
      mkBlinkPlugin = { enable ? true, ... } @ args:
        { inherit enable; } // (builtins.removeAttrs args ["enable"]);
    in {
      blink-cmp-git = mkBlinkPlugin {};
      blink-cmp-spell = mkBlinkPlugin {};
      # blink-copilot = mkBlinkPlugin {};
      blink-emoji = mkBlinkPlugin {};
      blink-ripgrep = mkBlinkPlugin {};
    };
  };
}
