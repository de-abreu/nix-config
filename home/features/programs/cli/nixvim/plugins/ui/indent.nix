{
  programs.nixvim.plugins.snacks.settings.indent = {
    enabled = true;
    animate.enabled = true;
    chunk.enaled = true;
    hl = map (s: "RainbowDelimiter" + s) [
      "Red"
      "Yellow"
      "Blue"
      "Orange"
      "Green"
      "Violet"
      "Cyan"
    ];
  };
}
