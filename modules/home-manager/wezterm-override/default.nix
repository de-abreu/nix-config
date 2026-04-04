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
    mkOption
    types
    ;

  inherit (types)
    attrsOf
    either
    lines
    path
    ;

  cfg = config.programs.wezterm;
  tomlFormat = pkgs.formats.toml { };
in
{
  meta.maintainers = [
    lib.hm.maintainers.blmhemu
    lib.maintainers.khaneliman
  ];

  disabledModules = [ "programs/wezterm.nix" ];

  options.programs.wezterm = {
    enable = mkEnableOption "wezterm";

    package = lib.mkPackageOption pkgs "wezterm" { };

    # CHANGED: Now accepts an attribute set of paths or strings
    extraConfig = mkOption {
      type = attrsOf (either lines path);
      default = { };
      example = literalExpression ''
        {
          "appearance" = ./lua/appearance.lua;
          "keybinds.overrides" = '''
            local M = {}
            function M.apply_to_config(config)
              config.keys = { ... }
            end
            return M
          ''';
        }
      '';
      description = ''
        Attribute set of WezTerm modules.
        The key is the module namespace (e.g. `keybinds.overrides`), which corresponds
        to `require("modules.keybinds.overrides")`.
        The value is either the path to a Lua file or a string containing the Lua code.
      '';
    };

    colorSchemes = mkOption {
      type = attrsOf (tomlFormat.type);
      default = { };
      description = ''
        Attribute set of additional color schemes to be written to
        {file}`$XDG_CONFIG_HOME/wezterm/colors`.
      '';
    };

    enableBashIntegration = lib.hm.shell.mkBashIntegrationOption { inherit config; };
    enableZshIntegration = lib.hm.shell.mkZshIntegrationOption { inherit config; };
  };

  config = import ./config.nix { inherit cfg lib tomlFormat; };
}
