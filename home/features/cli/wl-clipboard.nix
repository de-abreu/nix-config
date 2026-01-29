{pkgs, ...}: {
  home.packages = [pkgs.wl-clipboard];
  programs.fish.shellAbbrs = {
    cp = "wl-copy";
    co = "wl-paste";
  };
}
