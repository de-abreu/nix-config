{
  cfg,
  lib,
  presenterm-wrapped,
  yamlFormat,
  ...
}:
lib.mkIf cfg.enable {
  home.packages = [ presenterm-wrapped ];

  xdg.configFile = lib.mkMerge [
    (lib.mkIf (cfg.settings != { }) {
      "presenterm/config.yaml".source = yamlFormat.generate "presenterm-config.yaml" cfg.settings;
    })

    (lib.mapAttrs' (
      name: value:
      lib.nameValuePair "presenterm/themes/${name}.yaml" (
        if builtins.isPath value then
          { source = value; }
        else
          { source = yamlFormat.generate "presenterm-theme-${name}.yaml" value; }
      )
    ) cfg.themes)
  ];
}
