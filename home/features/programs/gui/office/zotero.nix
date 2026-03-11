{pkgs, ...}: {
  home.packages = [pkgs.zotero];
  # The zotero extension for Chromium
  programs.chromium.extensions = [{id = "ekhagklcjbdpajgpjgmbionohlpdbjgc";}];
}
