{ lib, pkgs, ... }:
{
  programs.librewolf = {
    enable = true;
    languagePacks = [
      "en-US"
      "pt-BR"
    ];
    profiles.default = {
      id = 0;
      isDefault = true;
      extensions.packages = [ pkgs.firefox-addons.zotero-connector ];
      settings = {
        "extensions.autoDisableScopes" = 0;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.translations.neverTranslateLanguages" = "pt";
        "privacy.resistFingerprinting.letterboxing" = true;
      };
    };
  };

  home.sessionVariables.BROWSER = "librewolf";
  xdg.mimeApps.defaultApplications = lib.foldr (n: acc: { ${n} = "librewolf.desktop"; } // acc) { } [
    "text/html"
    "x-scheme-handler/http"
    "x-scheme-handler/https"
    "x-scheme-handler/chrome"
    "application/x-extension-htm"
    "application/x-extension-html"
    "application/x-extension-shtml"
    "application/xhtml+xml"
    "application/x-extension-xhtml"
    "application/x-extension-xht"
  ];
}
