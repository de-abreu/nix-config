{
  config,
  lib,
  ...
}:
{
  programs.nixvim.plugins.git-conflict = lib.mkIf config.programs.git.enable {
    enable = true;
    lazyLoad.settings.event = "DeferredUIEnter";
  };
}
