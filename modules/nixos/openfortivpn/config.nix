{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.programs.openfortivpn;
in
{
  config = mkMerge [
    (mkIf (cfg.configFile != null) {
      programs.openfortivpn.enable = mkDefault true;
    })
    (mkIf cfg.enable {
      assertions = [
        {
          assertion = cfg.configFile != null;
          message = "openfortivpn: 'configFile' must be set when the module is enabled.";
        }
      ];

      # Allow users in the wheel group to start/stop openfortivpn without a
      # password prompt. The Polkit JavaScript engine checks the action ID,
      # unit name, and group membership before authorizing.
      security.polkit.extraConfig =
        # javascript
        ''
          polkit.addRule(function(action, subject) {
            if (action.id == "org.freedesktop.systemd1.manage-units" &&
                action.lookup("unit") == "openfortivpn.service" &&
                subject.isInGroup("wheel")) {
              return polkit.Result.YES;
            }
          });
        '';

      # Stop/start the VPN in response to global connectivity changes.
      # Uses a flag file to only restart if the VPN was *already running* when
      # connectivity was lost — never auto-starts a VPN the user never started.
      networking.networkmanager.dispatcherScripts = [
        {
          type = "basic";
          source = ./openfortivpn-dispatcher.sh;
        }
      ];

      systemd.services.openfortivpn = {
        description = "OpenFortiVPN Client";
        after = [ "network-online.target" ];
        wants = [ "network-online.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${getExe pkgs.openfortivpn} -c ${cfg.configFile}";
          Restart = "on-failure";
          RestartSec = 5;
        };
      };

      programs.openfortivpn.package = pkgs.writeShellApplication {
        name = "openfortivpn-toggle";
        runtimeInputs = with pkgs; [
          libnotify
          networkmanager
        ];
        text = builtins.readFile ./openfortivpn-toggle.sh;
      };

      environment.systemPackages = [ cfg.package ];
    })
  ];
}
