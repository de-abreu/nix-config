{pkgs, ...}: {
  home.packages = [pkgs.trashy];
  programs.fish = {
    shellAbbrs.rm = "trash";
    shellInit =
      # fish
      ''
        if command -q trash
          trash completions fish | source
        end
      '';
  };
}
