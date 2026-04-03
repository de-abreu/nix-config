{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.stylix.targets.presenterm;
  inherit (config.stylix) polarity;
in
{
  options.stylix.targets.presenterm = {
    enable = mkEnableOption "presenterm theming" // {
      default = config.programs.presenterm.enable;
      defaultText = lib.literalExpression "config.programs.presenterm.enable";
    };
  };

  config = mkIf cfg.enable {
    programs.presenterm.themes.stylix =
      with config.lib.stylix.colors;
      {
        extends = polarity;

        default = {
          margin.percent = 8;
          colors = {
            foreground = base05;
            background = base00;
          };
        };

        slide_title = {
          alignment = "center";
          padding_bottom = 1;
          padding_top = 1;
          colors.foreground = base0E;
          bold = true;
          font_size = 2;
        };

        code = {
          alignment = "center";
          minimum_size = 50;
          minimum_margin.percent = 8;
          theme_name = "base16-stylix";
          padding = {
            horizontal = 2;
            vertical = 1;
          };
          background = false;
        };

        execution_output = {
          colors = {
            foreground = base05;
            background = base01;
          };
          status = {
            running.foreground = base0C;
            success.foreground = base0B;
            failure.foreground = base08;
            not_started.foreground = base09;
          };
        };

        inline_code.colors = {
          foreground = base0B;
          background = base02;
        };

        intro_slide = {
          title = {
            alignment = "center";
            colors.foreground = base0D;
            font_size = 2;
          };
          subtitle = {
            alignment = "center";
            colors.foreground = base0C;
          };
          author = {
            alignment = "center";
            colors.foreground = base06;
            positioning = "page_bottom";
          };
        };

        headings = {
          h1 = {
            prefix = "██";
            colors.foreground = base0D;
          };
          h2 = {
            prefix = "▓▓▓";
            colors.foreground = base0B;
          };
          h3 = {
            prefix = "▒▒▒";
            colors.foreground = base09;
          };
          h4 = {
            prefix = "░░░░░";
            colors.foreground = base04;
          };
          h5 = {
            prefix = "░░░░░░";
            colors.foreground = base03;
          };
          h6 = {
            prefix = "░░░░░░░";
            colors.foreground = base03;
          };
        };

        block_quote = {
          prefix = "▍ ";
          colors = {
            foreground = base06;
            background = base01;
          };
        };

        alert = {
          prefix = "▍ ";
          base_colors = {
            foreground = base06;
            background = base01;
          };
          styles = {
            note.color = base0D;
            tip.color = base0B;
            important.color = base0E;
            warning.color = base09;
            caution.color = base08;
          };
        };

        typst.colors = {
          foreground = base06;
          background = base01;
        };

        footer = {
          style = "template";
          right = "{current_slide} / {total_slides}";
        };

        modals.selection_colors.foreground = base09;

        mermaid = {
          background = "transparent";
          theme = polarity;
        };

        d2.theme = if polarity == "dark" then 200 else 100;

        layout_grid.color = base0D;
      };

    xdg.configFile."presenterm/themes/highlighting/base16-stylix.tmTheme".source =
      config.lib.stylix.colors {
        template = ./base16-stylix.tmTheme.mustache;
        extension = ".tmTheme";
      };

    programs.presenterm.settings.defaults.theme = lib.mkDefault "stylix";
  };
}