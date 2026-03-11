{pkgs, ...}: {
  programs.nixvim = {
    extraPackages = with pkgs; [gh wordnet glab];
    plugins = let
      mkBlinkPlugin = {enable ? true, ...} @ args:
        {
          inherit enable;
          lazyLoad.settings.event = ["InsertEnter" "CmdlineEnter"];
        }
        // (builtins.removeAttrs args ["enable"]);
    in {
      blink-cmp-git = mkBlinkPlugin {};
      blink-cmp-spell = mkBlinkPlugin {};
      blink-cmp-words = mkBlinkPlugin {};
      blink-copilot = mkBlinkPlugin {};
      blink-emoji = mkBlinkPlugin {};
      blink-ripgrep = mkBlinkPlugin {};
    };
  };
}
