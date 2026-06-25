{ lib, ... }: with lib; {
  options.programs.openfortivpn = with types; {
    enable = mkEnableOption "OpenFortiVPN client with toggle script";

    configFile = mkOption {
      type = nullOr str;
      default = null;
      description = ''
        Path to the openfortivpn configuration file.
        Typically points to a sops-decrypted secret.
        Setting this automatically enables the module.
      '';
      example = "/run/secrets/openfortivpn-config";
    };

    package = mkOption {
      type = package;
      readOnly = true;
      description = "The toggle script package.";
    };
  };
}
