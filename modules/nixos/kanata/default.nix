{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types;
  inherit (types) attrsOf either listOf int str package;
in {
  imports = [./config.nix];

  options.programs.kanata = {
    enable = mkEnableOption "Kanata advanced keyboard customization";

    package = mkOption {
      type = package;
      default = pkgs.kanata;
      description = "The Kanata package to use.";
    };

    addBinaryToPath = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to add the kanata binary to systemPackages (useful for CLI debugging).";
    };

    devices = mkOption {
      type = listOf str;
      description = ''
        A list of device paths to be managed using Kanata. Use ls `ls
        /dev/input/by-path/` to discover the keyboards available.
      '';
    };

    localKeys = mkOption {
      type = attrsOf int;
      default = {};
      description = "Map of custom key names to scancodes (deflocalkeys-linux).";
      example = {
        "ç" = 39;
        bardot = 86;
      };
    };

    sourceKeys = mkOption {
      type = listOf str;
      default = [];
      description = "List of source keys to be intercepted (defsrc).";
      example = ["esc" "caps" "a" "s" "d" "f"];
    };

    variables = mkOption {
      type = attrsOf (either int str);
      default = {};
      description = "Global variables (defvar).";
      example = {
        tap-timeout = 200;
        hold-timeout = 200;
        tt = "$tap-timeout";
      };
    };

    aliases = mkOption {
      type = attrsOf str;
      default = {};
      description = "Alias definitions (defalias).";
      example = {
        esctrl = "(tap-hold 200 200 esc lctl)";
        nav-layer = "(layer-toggle nav)";
      };
    };

    layers = mkOption {
      type = attrsOf (attrsOf str);
      default = {};
      description = "Layer definitions using deflayermap. Key is layer name.";
      example = {
        base = {
          caps = "@esctrl";
          a = "a";
        };
        nav = {
          h = "left";
          j = "down";
          k = "up";
          l = "right";
        };
      };
    };

    primaryLayer = mkOption {
      type = str;
      default = "base";
      description = "The name of the layer that should be rendered first (active on startup).";
      example = "base";
    };
  };
}
