{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.abnt2-keyboard.kanata;
in {
  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.devices != [];
        message = "ABNT2-Keyboard: 'kanata.devices' cannot be empty when 'kanata.enable' is true.";
      }
    ];

    environment.systemPackages = [pkgs.kanata];
    boot.kernelModules = ["uinput"];
    hardware.uinput.enable = true; # Explicitly enable the NixOS option for uinput

    services.udev.extraRules = ''
      KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
    '';

    users.groups.uinput = {};

    systemd.services.kanata-internalKeyboard.serviceConfig = {
      SupplementaryGroups = ["input" "uinput"];
    };

    services.kanata = {
      enable = true;
      keyboards = {
        internalKeyboard = {
          devices = cfg.devices;
          extraDefCfg = "process-unmapped-keys yes";

          config =
            if cfg.configuration != null
            then cfg.configuration
            else
              with lib; let
                # 1. Define the numbers
                topNums = map toString (range 0 9);
                padNums = map (i: "kp${i}") topNums;

                # 2. Generate Aliases for 0-9 (Required for macros)
                # Output example: n0 0
                makeAlias = n: "n${n} ${n}";
                digitAliases = concatMapStringsSep "\n" makeAlias topNums;

                # 3. Generate Mappings
                # For top row (0-9): Use the alias (e.g., @n0)
                makeTopKey = n: "${n} (macro @n${n})";

                # For numpad (kp0-kp9): Use directly (safe because they aren't integers)
                makePadKey = k: "${k} (macro ${k})";

                # Combine them into one string for the layer maps
                numKeys =
                  (concatMapStringsSep "\n" makeTopKey topNums)
                  + "\n"
                  + (concatMapStringsSep "\n" makePadKey padNums);
              in ''
                (deflocalkeys-linux
                 ç 39
                )

                (defsrc
                 esc caps tab j k l ç
                )

                (defvar
                 tap-timeout 200
                 hold-timeout 200
                 tt $tap-timeout
                 ht $hold-timeout
                )

                (defalias
                 ${digitAliases}

                 esctrl (tap-hold $tt $ht esc lctl)
                 tab (tap-hold $tt $ht tab (layer-toggle nav))
                )

                (deflayermap (base)
                 esc caps
                 caps @esctrl
                 tab @tab
                 ${numKeys}
                )

                (deflayermap (nav)
                 j left
                 k down
                 l up
                 ç right
                 i pgup
                 m pgdn
                 u home
                 n end
                )
              '';
        };
      };
    };
  };
}
