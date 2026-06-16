{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
let
  cfg = config.programs.wezterm;
  tomlFormat = pkgs.formats.toml { };
  wezterm-floating = inputs.wrappers.lib.wrapPackage {
    inherit pkgs;
    package = cfg.package;
    binName = "wezterm-floating";
    args =
      let
        configArgs =
          [
            "enable_tab_bar=false"
            "initial_cols=120"
            "initial_rows=40"
            "window_close_confirmation=NeverPrompt"
          ]
          |> concatMap (v: [
            "--config"
            v
          ]);
      in
      configArgs
      ++ [
        "start"
        "--class"
        "floating"
        "--"
        "$@"
      ];
  };
in
{
  meta.maintainers = [
    hm.maintainers.blmhemu
    maintainers.khaneliman
  ];

  disabledModules = [ "programs/wezterm.nix" ];

  options.programs.wezterm = with types; {
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

    plugins = mkOption {
      type = attrsOf path;
      default = { };
      example = literalExpression ''
        {
          tabline-wez = inputs.tabline-wez;
        }
      '';
      description = ''
        Attribute set mapping plugin names to source paths (typically
        flake inputs). Each source must contain a {file}`plugin/init.lua`
        file. The module will symlink each plugin into
        {file}`$XDG_CONFIG_HOME/wezterm/plugins/<name>/`, making it
        accessible via {lua}`require("plugins.<name>")`.
      '';
    };

    enableBashIntegration = lib.hm.shell.mkBashIntegrationOption { inherit config; };
    enableZshIntegration = lib.hm.shell.mkZshIntegrationOption { inherit config; };

    floatingPackage = mkOption {
      type = types.package;
      default = wezterm-floating;
      description = "Wezterm wrapped with floating window defaults for transient commands.";
      internal = true;
    };
  };

  config = import ./_config.nix { inherit cfg lib tomlFormat; };
}
