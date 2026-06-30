{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.monitorToggle;
in
{
  config = lib.mkMerge [
    (lib.mkIf (cfg.primary != null && cfg.secondary != null) {
      programs.monitorToggle.enable = lib.mkDefault true;
    })
    (lib.mkIf cfg.enable {
      assertions = [
        {
          assertion = cfg.primary != null && cfg.secondary != null;
          message = "monitorToggle: both 'primary' and 'secondary' must be set when the module is enabled.";
        }
        {
          assertion = config.programs.hyprland.enable;
          message = "monitorToggle requires programs.hyprland.enable to be true";
        }
      ];

      programs.monitorToggle.package = pkgs.writeShellApplication {
        name = "monitor-toggle";
        runtimeInputs = [
          config.programs.hyprland.package
          pkgs.libnotify
        ];
        text = import ./_script.nix { inherit cfg; };
      };

      environment.systemPackages = [ cfg.package ];
    })
  ];
}
