{lib, ...}: {
  programs = {
    librewolf = {
      enable = true;
      languagePacks = ["en-US" "pt-BR"];
      settings = {
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.translations.neverTranslateLanguages" = "pt";
        "privacy.resistFingerprinting.letterboxing" = true;
      };
    };
  };

  home.sessionVariables.BROWSER = "librewolf";
  xdg.mimeApps.defaultApplications =
    lib.foldr (n: acc: {${n} = "librewolf.desktop";} // acc) {}
    [
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
