{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.programs.qalculate;

  iniFormat = pkgs.formats.ini { };
in
{
  options.programs.qalculate = {
    enable = mkEnableOption "Qalculate!, a multi-purpose desktop calculator";

    package = mkOption {
      type = types.nullOr types.package;
      default = pkgs.libqalculate;
      example = "pkgs.qalculate-gtk";
      description = "The libqalculate package to use.";
    };

    settings = mkOption {
      inherit (iniFormat) type;
      default = { };
      example = literalExpression ''
        {
          General = {
            precision = 10;
            colorize = 1;
          };
        }
      '';
      description = ''
        Configuration written to
        {file}`$XDG_CONFIG_HOME/qalculate/qalc.cfg`.
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = mkIf (cfg.package != null) [ cfg.package ];

    xdg.configFile."qalculate/qalc.cfg" = mkIf (cfg.settings != { }) {
      source = iniFormat.generate "qalc.cfg" cfg.settings;
    };
  };
}
