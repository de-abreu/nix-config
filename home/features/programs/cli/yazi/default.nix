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
      inherit (pkgs.yaziPlugins)
        mount
        smart-paste
        ;
    };
    yaziPlugins = {
      enable = true;
      plugins = {
        bypass.enable = true;
        chmod.enable = true;
        copy-file-contents.enable = true;
        full-border.enable = true;
        jump-to-char.enable = true;
        ouch.enable = true;
        recycle-bin.enable = true;
        rich-preview.enable = true;
        smart-filter.enable = true;
        relative-motions = {
          enable = true;
          show_numbers = "relative";
          show_motion = true;
        };
        max-preview = {
          enable = true;
          keys.toggle = {
            on = [ "p" ];
            run = "plugin max-preview";
            desc = "Maximize or restore preview";
          };
        };
      };
    };
  };
  home.sessionVariables.FILEBROWSER = "yazi";
}

