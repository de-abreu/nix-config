{
  config,
  inputs,
  pkgs,
  system,
  ...
}:
let
  userJs = "${config.home.homeDirectory}/.zotero/zotero/${config.home.username}/user.js";
  zoteroAddons = inputs.vortriz-nur.legacyPackages.${system}.zoteroAddons;
in
{

  programs.zotero = {
    enable = true;
    package = pkgs.unstable.zotero;

    profiles.${config.home.username} = {
      isDefault = true;

      extensions = with zoteroAddons; [
        zotero-better-bibtex
        zotero-scipdf
        zotmoov
      ];
    };
  };

  sops = {
    secrets = {
      "zotero/username" = { };
      "zotero/apiKey" = { };
    };
    templates."zotero-user-js" = {
      mode = "0600";
      path = userJs;
      content =
        let
          username = config.sops.placeholder."zotero/username";
          apiKey = config.sops.placeholder."zotero/apiKey";
        in
        # js
        ''
          user_pref("extensions.zotero.sync.server.username", "${username}");
          user_pref("extensions.zotero.sync.server.apiKey", "${apiKey}");
          user_pref("extensions.zotero.betterBibTeX.autoPinInCitations", true);
          user_pref("extensions.zotero.betterBibTeX.citekeyFormat", "[auth][year]");
          user_pref("extensions.zotero.dataDir", "${config.xdg.userDirs.documents}/Zotero");
          user_pref("extensions.zotero.firstRun2", false);
          user_pref("extensions.zotero.useDataDir", true);
        '';
    };
  };

  # Browser extensions
  programs = {
    chromium.extensions = [ { id = "ekhagklcjbdpajgpjgmbionohlpdbjgc"; } ];
    librewolf.profiles.default.extensions.packages = [ pkgs.firefox-addons.zotero-connector ];
  };
}
