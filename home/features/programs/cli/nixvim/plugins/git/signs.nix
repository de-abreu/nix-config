{
  config,
  lib,
  ...
}:
{
  programs.nixvim.plugins = {
    gitsigns = lib.mkIf config.programs.git.enable {
      enable = true;
      lazyLoad.settings.event = "DeferredUIEnter";
    };
    faster.settings.behaviours.bigfile.features_disabled = [ "gitsigns" ];
  };
}
