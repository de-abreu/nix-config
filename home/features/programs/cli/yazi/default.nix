{
  inputs,
  system,
  pkgs,
  ...
}:
{
  imports = [
    (inputs.nix-yazi-plugins.legacyPackages.${system}.homeManagerModules.default)
  ];
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";

    plugins = {
      inherit (pkgs.yaziPlugins) mount smart-paste;
      inherit (inputs) cd-git-root;
      smart-switch = ./plugins/smart-switch;
      smart-tab = ./plugins/smart-tab;
    };
    yaziPlugins = {
      enable = true;
      plugins = {
        bypass.enable = true;
        chmod.enable = true;
        copy-file-contents.enable = true;
        full-border.enable = true;
        ouch.enable = true;
        smart-filter.enable = true;
        max-preview.enable = true;
      };
    };
  };
  home.sessionVariables.FILEBROWSER = "yazi";
}
