{
  # Interactive cheatsheet tool for the command line
  programs = {
    navi = {
      enable = true;
      enableFishIntegration = true;
    };

    # Shell agnostic Z directory jumping
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    # Allow for nix shell environments be created using the shell currently used
    nix-your-shell = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
