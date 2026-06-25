{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.programs.openfortivpn;
in {
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

      systemd.services.openfortivpn = {
        description = "OpenFortiVPN Client";
        after = [ "network-online.target" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.openfortivpn}/bin/openfortivpn -c ${cfg.configFile}";
          Restart = "on-failure";
          RestartSec = 5;
        };
      };

      programs.openfortivpn.package = pkgs.writeShellApplication {
        name = "openfortivpn-toggle";
        runtimeInputs = [ pkgs.libnotify ];
        text = ''
          if systemctl is-active --quiet openfortivpn; then
            systemctl stop openfortivpn
            notify-send "OpenFortiVPN" "Disconnected"
          else
            systemctl start openfortivpn
            notify-send "OpenFortiVPN" "Connected"
          fi
        '';
      };

      environment.systemPackages = [ cfg.package ];
    })
  ];
}
