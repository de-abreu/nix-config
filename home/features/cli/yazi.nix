{flakePath, ...}: {
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
    keymap.mgr.prepend_keymap = [
      {
        on = ["g" "n"];
        run = "cd ${flakePath}";
        desc = "Go to Nix configuration";
      }
    ];
  };
  home.sessionVariables.FILEBROWSER = "yazi";
}
