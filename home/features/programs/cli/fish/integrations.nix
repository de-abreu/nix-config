{lib, ...}: {
  programs =
    lib.foldl' (acc: program:
      {
        "${program}" = {
          enable = true;
          enableFishIntegration = true;
        };
      }
      // acc) {
      mcfly = {
        enable = true;
        enableFishIntegration = true;
        fzf.enable = true;
      };
    } [
      "navi" # Interactive cheatsheet tool for the command line
      "fzf" # Command line fuzzy finder
      "zoxide" # Shell agnostic Z directory jumping
      "nix-your-shell" # Allow for nix shell environments be created using the shell currently used, instead of － only －with bash.
    ];
}
