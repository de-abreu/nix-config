{
  programs.kanata = {
    sourceKeys = ["ç" "a" "s" "t" "i"];

    aliases = {
      # The Toggle: Tap = ç, Hold = Romanian Layer
      rom_mod = "(tap-hold $tt $ht ç (layer-toggle rom))";

      # Syntax: (fork (normal_action) (shifted_action) (modifiers_to_check))
      rom_a = "(fork (unicode ă) (unicode Ă) (lsft rsft))";
      rom_i = "(fork (unicode î) (unicode Î) (lsft rsft))";
      rom_s = "(fork (unicode ș) (unicode Ș) (lsft rsft))";
      rom_t = "(fork (unicode ț) (unicode Ț) (lsft rsft))";
    };

    layers.base = {
      "ç" = "@rom_mod";
    };

    layers.rom = {
      # Map the PHYSICAL keys (lowercase) to the smart aliases
      a = "@rom_a";
      i = "@rom_i";
      s = "@rom_s";
      t = "@rom_t";
    };
  };
}
