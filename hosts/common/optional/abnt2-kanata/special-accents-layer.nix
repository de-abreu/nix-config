# INFO: Adds Romanian characters to the ABNT2 keyboard, and makes
# adding the circumflex to vowels easier.
{
  programs.kanata =
    {
      sourceKeys = ["ç" "a" "s" "t" "i" "e" "o" "u" "f"];

      aliases = {
        # The Toggle: Tap = ç, Hold = Romanian Layer
        acc_mod = "(tap-hold $tt $ht ç (layer-toggle acc))";

        # Syntax: (fork (normal_action) (shifted_action) (modifiers_to_check))
        rom_a = "(fork (unicode ă) (unicode Ă) (lsft rsft))";
        rom_s = "(fork (unicode ș) (unicode Ș) (lsft rsft))";
        rom_t = "(fork (unicode ț) (unicode Ț) (lsft rsft))";
        circ_a = "(fork (unicode â) (unicode Â) (lsft rsft))";
        circ_e = "(fork (unicode ê) (unicode Ê) (lsft rsft))";
        circ_i = "(fork (unicode î) (unicode Î) (lsft rsft))";
        circ_o = "(fork (unicode ô) (unicode Ô) (lsft rsft))";
        circ_u = "(fork (unicode û) (unicode Û) (lsft rsft))";
      };

      layers.base."ç" = "@acc_mod";

      layers.acc = {
        # Map the PHYSICAL keys (lowercase) to the smart aliases
        a = "@rom_a";
        s = "@rom_s";
        t = "@rom_t";
        i = "@circ_i";
        f = "@circ_a";
        e = "@circ_e";
        o = "@circ_o";
        u = "@circ_u";
      };
    };
}
