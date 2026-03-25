{
  config,
  lib,
  pkgs,
  ...
}:
let
  waybarCfg = "${pkgs.hyde}/Configs/.config/waybar";
in
{
  home.packages = with pkgs; [
    waybar
    playerctl
    gobject-introspection
    (python3.withPackages (ps: with ps; [ pygobject3 ]))
    python-pyamdgpuinfo
    lm_sensors
    power-profiles-daemon
  ];

  xdg.configFile = {
    "waybar/config.jsonc".source = ./config.jsonc;
    "waybar/style.css".source = ./style.css;

    "waybar/modules" = {
      source = pkgs.symlinkJoin {
        name = "waybar-modules";
        # INFO: In case of collisions, the modules defined by latter entries override those defined previously.
        paths = [
          "${waybarCfg}/modules"
          ./modules
        ];
      };
      recursive = true;
    };

    "waybar/layouts" = {
      source = "${waybarCfg}/layouts";
      recursive = true;
    };

    "waybar/styles" = {
      source = "${waybarCfg}/styles";
      recursive = true;
    };

    "waybar/menus" = {
      source = ./menus;
      recursive = true;
    };

    "waybar/includes" = {
      source = ./includes;
      recursive = true;
    };

    "waybar/includes/includes.json".text = import ./includes.nix { inherit config lib; };
  };
}
