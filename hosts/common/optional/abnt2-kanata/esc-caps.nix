{
  programs.kanata = {
    sourceKeys = ["esc" "caps"];
    aliases.esctrl = "(tap-hold $tt $ht esc lctl)";
    layers.base = {
      esc = "caps";
      caps = "@esctrl";
    };
  };
}
