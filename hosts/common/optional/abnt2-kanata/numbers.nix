{lib, ...}:
with lib; let
  # Generate numbers 0-9
  nums = range 0 9 |> map toString;
in {
  programs.kanata = {
    # Add numbers to the list of intercepted keys
    sourceKeys = nums ++ (map (n: "kp${n}") nums);

    # Generate Aliases: n0 -> 0, n1 -> 1 ...
    aliases =
      map (n: {
        name = "n${n}";
        value = "${n}";
      })
      nums
      |> listToAttrs;

    # Generate Mappings for Base Layer: 1 -> (macro @n1) ...
    layers.base =
      # Top row numbers
      (map (n: {
          name = "${n}";
          value = "(macro @n${n})";
        })
        nums)
      ++
      # Numpad numbers
      (map (n: {
          name = "kp${n}";
          value = "(macro kp${n})";
        })
        nums)
      |> listToAttrs;
  };
}
