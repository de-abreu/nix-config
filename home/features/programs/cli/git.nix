{
  programs = {
    git = {
      enable = true;
      lfs.enable = true;
      settings = {
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
        pull.rebase = true;
        merge.conflictStyle = "zdiff3";
        rerere.enabled = true;
      };
    };
    gh.enable = true;
    gh-dash.enable = true;
    lazygit = {
      enable = true;
      settings.gui.mouseEvents = false;
    };
    fish.shellAbbrs.lg = "lazygit";
  };
}
