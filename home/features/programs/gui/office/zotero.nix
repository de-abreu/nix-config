{
  config,
  inputs,
  pkgs,
  system,
  ...
}:
let
  zoteroAddons = inputs.vortriz-nur.legacyPackages.${system}.zoteroAddons;
in
{
  sops.secrets = {
    "api-keys/zotero" = { };
    "mail/usp" = { };
  };

  programs.zotero = {
    enable = true;

    profiles.default = {
      isDefault = true;

      extensions = with zoteroAddons; [
        zotero-better-bibtex
        zotero-scipdf
        zotmoov
      ];

      settings = {
        # Better BibTeX
        "extensions.zotero.betterBibTeX.autoPinInCitations" = true;
        "extensions.zotero.betterBibTeX.citekeyFormat" = "[auth][year]";

        # Data directory
        "extensions.zotero.dataDir" = config.xdg.userDirs.documents;
        "extensions.zotero.useDataDir" = true;

        # Skip first-run wizard
        "extensions.zotero.firstRun2" = false;
      };

      extraConfig = builtins.readFile config.sops.templates."zotero-prefs.js".file;
    };
  };

  sops.templates."zotero-prefs.js".content = ''
    user_pref("extensions.zotero.sync.server.username", "${config.sops.placeholder."mail/usp"}");
    user_pref("extensions.zotero.sync.server.apiKey", "${config.sops.placeholder."api-keys/zotero"}");
  '';

  # Browser extensions
  programs = {
    chromium.extensions = [ { id = "ekhagklcjbdpajgpjgmbionohlpdbjgc"; } ];
    librewolf.profiles.default.extensions.packages = [ pkgs.firefox-addons.zotero-connector ];
  };
}

