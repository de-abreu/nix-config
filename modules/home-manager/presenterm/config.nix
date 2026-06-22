{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.programs.presenterm;
  presenterm-wrapped = inputs.wrappers.lib.wrapPackage {
    inherit pkgs;
    package = cfg.package;
    runtimeInputs =
      with pkgs;
      optionals cfg.render.latex.enable [
        typst
        pandoc
      ]
      ++ optionals cfg.render.mermaid.enable [
        mermaid-cli
      ]
      ++ optionals cfg.exportPdf.enable [
        python3Packages.weasyprint
      ];
  };
  yamlFormat = pkgs.formats.yaml { };
in
mkIf cfg.enable {
  home.packages = [ presenterm-wrapped ];

  programs.presenterm.finalPackage = presenterm-wrapped;

  xdg.configFile = mkMerge [
    (mkIf (cfg.settings != { }) {
      "presenterm/config.yaml".source = yamlFormat.generate "presenterm-config.yaml" cfg.settings;
    })

    (mapAttrs' (
      name: value:
      {
        source = if isPath value then value else yamlFormat.generate "presenterm-theme-${name}.yaml" value;
      }
      |> nameValuePair "presenterm/themes/${name}.yaml"
    ) cfg.themes)
  ];
}
