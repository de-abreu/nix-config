# INFO: A module to break with the habit of only pressing Shift with the
# dominant hand.
{
  programs.kanata = {
    sourceKeys = [
      "lsft" "rsft"
      "q" "w" "e" "r" "t" "y" "u" "i" "o" "p"
      "a" "s" "d" "f" "g" "h" "j" "k" "l" "ç"
      "z" "x" "c" "v" "b" "n" "m"
    ];

    aliases = {
      s_l = "(layer-toggle shift-left)";
      s_r = "(layer-toggle shift-right)";
    };

    layers = {
      base = {
        lsft = "@s_l";
        rsft = "@s_r";
      };

      shift-left = {
        # Left Hand (Blocked/Lowercase)
        q = "q"; w = "w"; e = "e"; r = "r"; t = "t";
        a = "a"; s = "s"; d = "d"; f = "f"; g = "g";
        z = "z"; x = "x"; c = "c"; v = "v"; b = "b";

        # Right Hand (Allowed/Uppercase)
        y = "S-y"; u = "S-u"; i = "S-i"; o = "S-o"; p = "S-p";
        h = "S-h"; j = "S-j"; k = "S-k"; l = "S-l"; "ç" = "S-ç";
        n = "S-n"; m = "S-m";
      };

      shift-right = {
        # Left Hand (Allowed/Uppercase)
        q = "S-q"; w = "S-w"; e = "S-e"; r = "S-r"; t = "S-t";
        a = "S-a"; s = "S-s"; d = "S-d"; f = "S-f"; g = "S-g";
        z = "S-z"; x = "S-x"; c = "S-c"; v = "S-v"; b = "S-b";

        # Right Hand (Blocked/Lowercase)
        y = "y"; u = "u"; i = "i"; o = "o"; p = "p";
        h = "h"; j = "j"; k = "k"; l = "l"; "ç" = "ç";
        n = "n"; m = "m";
      };
    };
  };
}
