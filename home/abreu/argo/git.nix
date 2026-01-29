{config, ...}: let
  pubKeyFile = ".ssh/git.pub";
in {
  sops.secrets."ssh-keys/github/private" = {
    path = "${config.home.homeDirectory}/.ssh/git";
    mode = "0600";
  };
  home.file.${pubKeyFile}.text = ''
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICszJOQVJNvrR0Mv7HqQsTDiEybj4mLMscXoHbXwVwDL 87032834+de-abreu@users.noreply.github.com
  '';

  programs.git = {
    enable = true;
    lfs.enable = true; # Large file storage
    settings = {
      user = {
        name = "Abreu";
        email = "87032834+de-abreu@users.noreply.github.com";
      };
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
      merge.conflictStyle = "zdiff3";
      rerere.enabled = true;
    };
    signing = {
      format = "ssh";
      key = "${config.home.homeDirectory}/${pubKeyFile}";
      signByDefault = true;
    };
  };
}
