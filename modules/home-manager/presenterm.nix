{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    literalExpression
    mkEnableOption
    mkIf
    mkOption
    mkPackageOption
    types
    ;

  inherit (types) attrsOf path;

  cfg = config.programs.presenterm;
  yamlFormat = pkgs.formats.yaml { };
  themeType = types.either path yamlFormat.type;

  presenterm-wrapped = pkgs.symlinkJoin {
    name = "presenterm-wrapped";
    paths = [ cfg.package ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/presenterm \
        --prefix PATH : ${lib.makeBinPath [ pkgs.python3Packages.weasyprint ]}
    '';
  };
in
{
  meta.maintainers = [ lib.hm.maintainers.blmhemu ];

  options.programs.presenterm = {
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
  };

  config = mkIf cfg.enable {
    home.packages = [ presenterm-wrapped ];

    xdg.configFile = lib.mkMerge [
      (lib.mkIf (cfg.settings != { }) {
        "presenterm/config.yaml".source = yamlFormat.generate "presenterm-config.yaml" cfg.settings;
      })

      (lib.mapAttrs' (
        name: value:
        lib.nameValuePair "presenterm/themes/${name}.yaml" (
          if builtins.isPath value then
            { source = value; }
          else
            { source = yamlFormat.generate "presenterm-theme-${name}.yaml" value; }
        )
      ) cfg.themes)
    ];
  };
}

