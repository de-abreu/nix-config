{
  lib,
  pkgs,
  ...
}:
with lib;
{
  meta.maintainers = [ maintainers.blmhemu ];

  options.programs.presenterm =
    with types;
    let
      yamlFormat = pkgs.formats.yaml { };
      themeType = either path yamlFormat.type;
    in
    {
      enable = mkEnableOption "presenterm, a terminal-based presentation tool";

      package = mkPackageOption pkgs "presenterm" { };

      settings = mkOption {
        type = yamlFormat.type;
        default = { };
        example = literalExpression ''
          {
            defaults = {
              theme = "dark";
              image_protocol = "kitty-local";
            };
            options = {
              implicit_slide_ends = false;
              incremental_lists = false;
            };
          }
        '';
        description = ''
          Configuration written to $XDG_CONFIG_HOME/presenterm/config.yaml.
          See <https://github.com/mfontanini/presenterm/blob/master/config.sample.yaml>
          for available options.
        '';
      };

      themes = mkOption {
        type = attrsOf themeType;
        default = { };
        example = literalExpression ''
          {
            my-theme = ./themes/my-theme.yaml;
            another-theme = {
              default = {
                colors = {
                  foreground = "e6e6e6";
                  background = "040312";
                };
              };
            };
          }
        '';
        description = ''
          Attribute set of themes to be written to
          {file}`$XDG_CONFIG_HOME/presenterm/themes`.
          The key is the theme name, the value is either a path to a YAML file
          or an attribute set that will be converted to YAML.
        '';
      };

      render = {
        latex = {
          enable = mkEnableOption "LaTeX rendering support via typst and pandoc";
        };
        mermaid = {
          enable = mkEnableOption "Mermaid diagram rendering support";
        };
      };

      exportPdf = {
        enable = mkEnableOption "PDF export support via weasyprint";
      };

      finalPackage = mkOption {
        type = package;
        readOnly = true;
        internal = true;
        description = "The presenterm package wrapped with runtime dependencies.";
      };
    };
}
