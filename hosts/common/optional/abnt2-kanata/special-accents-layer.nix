# INFO: Adds Romanian characters to the ABNT2 keyboard, and makes
# adding the circumflex to vowels easier.
{lib, ...}: {
  programs.kanata = let
    unicode = hexcode:
      lib.stringToCharacters hexcode
      |> lib.concatStringsSep " "
      |> (seq: "(macro C-S-u ${seq} ent)");
  in {
    sourceKeys = ["ç" "a" "s" "t" "i" "e" "o" "u" "f"];

    aliases = {
      # The Toggle: Tap = ç, Hold = Romanian Layer
      acc_mod = "(tap-hold $tt $ht ç (layer-toggle acc))";

      # Syntax: (fork (normal_action) (shifted_action) (modifiers_to_check))
      rom_a =
        # ă: 0103, Ă: 0102
        "(fork ${unicode "103"} ${unicode "102"} (lsft rsft))";

      rom_s =
        # ș: 0219, Ș: 0218
        "(fork ${unicode "219"} ${unicode "218"} (lsft rsft))";

      rom_t =
        # ț: 021b, Ț : 021a
        "(fork ${unicode "21b"} ${unicode "21a"} (lsft rsft))";

      circ_a =
        # â: 00e2, Â: 00c2
        "(fork ${unicode "e2"} ${unicode "c2"} (lsft rsft))";

      circ_e =
        # ê: 00ea, Ê: 00ca
        "(fork ${unicode "ea"} ${unicode "ca"} (lsft rsft))";

      circ_i =
        # î: 00ee, Î: 00ce
        "(fork ${unicode "ee"} ${unicode "ce"} (lsft rsft))";

      circ_o =
        # ô: 00f4, Ô: 00d4
        "(fork ${unicode "f4"} ${unicode "d4"} (lsft rsft))";

      circ_u =
        # û: 00fb, Û: 00db
        "(fork ${unicode "fb"} ${unicode "db"} (lsft rsft))";
    };

    layers.base."ç" = "@acc_mod";

    layers.acc = {
      # Map the PHYSICAL keys (lowercase) to the smart aliases
      a = "@rom_a";
      s = "@rom_s";
      t = "@rom_t";
      i = "@rom_i";
      f = "@circ_a";
      e = "@circ_e";
      o = "@circ_o";
      u = "@circ_u";
    };
  };
}
