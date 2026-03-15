{ config, ... }:
{
  stylix.targets.opencode.enable = false;
  programs.opencode =
    let
      theme = "ayu-mirage";
    in
    {
      settings.theme = theme;
      themes.${theme} =
        with config.lib.stylix.colors.withHashtag;
        let
          astrodark_bg = "#1A1D23";
        in
        {
          theme = {
            primary = {
              dark = base0D;
              light = base0F;
            };
            secondary = {
              dark = base0E;
              light = base0D;
            };
            accent = {
              dark = base0F;
              light = base07;
            };
            error = {
              dark = base08;
              light = base08;
            };
            warning = {
              dark = base0A;
              light = base0A;
            };
            success = {
              dark = base0B;
              light = base0B;
            };
            info = {
              dark = base0C;
              light = base0F;
            };
            text = {
              dark = base05;
              light = base00;
            };
            textMuted = {
              dark = base04;
              light = base01;
            };
            background = {
              dark = astrodark_bg;
              light = base06;
            };
            backgroundPanel = {
              dark = base01;
              light = base05;
            };
            backgroundElement = {
              dark = base01;
              light = base04;
            };
            border = {
              dark = base02;
              light = base03;
            };
            borderActive = {
              dark = base03;
              light = base02;
            };
            borderSubtle = {
              dark = base02;
              light = base03;
            };
            diffAdded = {
              dark = base0B;
              light = base0B;
            };
            diffRemoved = {
              dark = base08;
              light = base08;
            };
            diffContext = {
              dark = base03;
              light = base03;
            };
            diffHunkHeader = {
              dark = base03;
              light = base03;
            };
            diffHighlightAdded = {
              dark = base0B;
              light = base0B;
            };
            diffHighlightRemoved = {
              dark = base08;
              light = base08;
            };
            diffAddedBg = {
              dark = base01;
              light = base05;
            };
            diffRemovedBg = {
              dark = base01;
              light = base05;
            };
            diffContextBg = {
              dark = base01;
              light = base05;
            };
            diffLineNumber = {
              dark = base03;
              light = base04;
            };
            diffAddedLineNumberBg = {
              dark = base01;
              light = base05;
            };
            diffRemovedLineNumberBg = {
              dark = base01;
              light = base05;
            };
            markdownText = {
              dark = base05;
              light = base00;
            };
            markdownHeading = {
              dark = base0E;
              light = base0F;
            };
            markdownLink = {
              dark = base0D;
              light = base0D;
            };
            markdownLinkText = {
              dark = base0C;
              light = base07;
            };
            markdownCode = {
              dark = base0B;
              light = base0B;
            };
            markdownBlockQuote = {
              dark = base03;
              light = base01;
            };
            markdownEmph = {
              dark = base0A;
              light = base09;
            };
            markdownStrong = {
              dark = base09;
              light = base0A;
            };
            markdownHorizontalRule = {
              dark = base04;
              light = base03;
            };
            markdownListItem = {
              dark = base0D;
              light = base0F;
            };
            markdownListEnumeration = {
              dark = base0C;
              light = base07;
            };
            markdownImage = {
              dark = base0D;
              light = base0D;
            };
            markdownImageText = {
              dark = base0C;
              light = base07;
            };
            markdownCodeBlock = {
              dark = base01;
              light = base00;
            };
            syntaxComment = {
              dark = base04;
              light = base03;
            };
            syntaxKeyword = {
              dark = base0E;
              light = base0D;
            };
            syntaxFunction = {
              dark = base0D;
              light = base0C;
            };
            syntaxVariable = {
              dark = base07;
              light = base07;
            };
            syntaxString = {
              dark = base0B;
              light = base0B;
            };
            syntaxNumber = {
              dark = base09;
              light = base0E;
            };
            syntaxType = {
              dark = base0A;
              light = base07;
            };
            syntaxOperator = {
              dark = base0C;
              light = base0D;
            };
            syntaxPunctuation = {
              dark = base05;
              light = base00;
            };
          };
        };
    };
}
