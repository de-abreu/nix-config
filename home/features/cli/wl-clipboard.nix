{pkgs, ...}: {
  home.packages = [pkgs.wl-clipboard];
  programs.fish.shellAbbrs = {
    c = "wl-copy";
    co = "wl-paste";
  };
}
