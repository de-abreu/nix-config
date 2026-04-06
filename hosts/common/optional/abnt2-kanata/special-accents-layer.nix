# INFO: Adds Romanian characters to the ABNT2 keyboard, and makes
# adding the circumflex to vowels easier.
{ lib, ... }:
{
  programs.kanata =
    let
      # Helper to map numbers to keypad keys so Kanata types them instead of delaying
      mapHexChar =
        c:
        let
          numMap = {
            "0" = "kp0";
            "1" = "kp1";
            "2" = "kp2";
            "3" = "kp3";
            "4" = "kp4";
            "5" = "kp5";
            "6" = "kp6";
            "7" = "kp7";
            "8" = "kp8";
            "9" = "kp9";
          };
        in
        numMap.${c} or c;
    in
    {
      sourceKeys = [
        "ç"
        "a"
        "s"
        "t"
        "i"
        "e"
        "o"
        "u"
        "f"
      ];

      aliases = {
        # The Toggle: Tap = ç, Hold = Romanian Layer
        acc_mod = "(tap-hold $tt $ht ç (layer-toggle acc))";

        # Syntax: (fork (normal_action) (shifted_action) (modifiers_to_check))
        rom_a =
          # ă: 0103, Ă: 0102
          "(fork (unicode ă) (unicode Ă) (lsft rsft))";

        rom_s =
          # ș: 0219, Ș: 0218
          "(fork (unicode ș) (unicode Ș) (lsft rsft))";

        rom_t =
          # ț: 021b, Ț : 021a
          "(fork (unicode ț) (unicode Ț) (lsft rsft))";

        circ_a =
          # â: 00e2, Â: 00c2
          "(fork (unicode â) (unicode Â) (lsft rsft))";

        circ_e =
          # ê: 00ea, Ê: 00ca
          "(fork (unicode ê) (unicode Ê) (lsft rsft))";

        circ_i =
          # î: 00ee, Î: 00ce
          "(fork (unicode î) (unicode Î) (lsft rsft))";

        circ_o =
          # ô: 00f4, Ô: 00d4
          "(fork (unicode ô) (unicode Ô) (lsft rsft))";

        circ_u =
          # û: 00fb, Û: 00db
          "(fork (unicode û) (unicode Û) (lsft rsft))";
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
