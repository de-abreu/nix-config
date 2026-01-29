# INFO: Smart and user-friendly command line shell. Includes features like syntax highlighting, autosuggest-as-you-type, and fancy tab completions.
{
  imports = [./integrations ./plugins.nix];

  programs.fish = {
    enable = true;
    shellAbbrs = {
      md = "mkdir -p";
      ":q" = "exit";

      fc = "nix flake check --show-trace";
      nd = "nix develop";
      ng = "nix-collect-garbage";
      nr = "nix run";
      ns = "nix shell";
    };
  };
}
