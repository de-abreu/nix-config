{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    literalExpression
    mkEnableOption
    mkOption
    mkPackageOption
    types
    ;

  inherit (types) attrsOf path;

  cfg = config.programs.presenterm;
  yamlFormat = pkgs.formats.yaml { };
in
{
  meta.maintainers = [ lib.hm.maintainers.blmhemu ];

  options.programs.presenterm =
    let
      themeType = types.either path yamlFormat.type;
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
    };
  config =
    let
      presenterm-wrapped = inputs.wrappers.lib.wrapPackage {
        inherit pkgs;
        package = cfg.package;
        runtimeInputs = with pkgs; [
          bat # Enables codeblocks with syntax highlighting
          mermaid-cli # Enables rendering mermaid diagrams
          python3Packages.weasyprint # Enables exporting presentations
          typst # Enables Latex rendering
          pandoc
        ];
      };
    in
    import ./config.nix {
      inherit
        cfg
        lib
        presenterm-wrapped
        yamlFormat
        ;
    };
}
