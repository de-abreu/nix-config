{
  programs.kanata = {
    sourceKeys = ["tab" "j" "k" "l" "u" "n" "i" "ç"];

    aliases.tab = "(tap-hold $tt $ht tab (layer-toggle nav))";

    layers = {
      base.tab = "@tab";
      nav = {
        j = "left";
        k = "down";
        l = "up";
        "ç" = "right";
        i = "pgup";
        u = "home";
        n = "end";
      };
    };
  };
}
