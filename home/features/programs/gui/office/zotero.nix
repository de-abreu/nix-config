{ pkgs, ... }:
{
  home.packages = [ pkgs.zotero ];
  # Browser extensions
  programs = {
    chromium.extensions = [ { id = "ekhagklcjbdpajgpjgmbionohlpdbjgc"; } ];
    librewolf.profiles.default.extensions.packages = [ pkgs.firefox-addons.zotero-connector ];
  };
}
