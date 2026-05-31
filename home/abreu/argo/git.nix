# TODO: Merge this configuration with the one defined in cli/git, using sops.template to generate the final config file instead of home-manager's git.settings.
{ config, ... }:
let
  pubKeyFile = ".ssh/git.pub";
in
{
  sops.secrets = {
    "ssh-keys/github/private" = {
      path = "${config.home.homeDirectory}/.ssh/git";
      mode = "0600";
    };
    "api-keys/github" = { };
  };

  home.file.${pubKeyFile}.text = ''
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICszJOQVJNvrR0Mv7HqQsTDiEybj4mLMscXoHbXwVwDL 87032834+de-abreu@users.noreply.github.com
  '';

  programs = {
    git = {
      settings = {
        user = {
          name = "Abreu";
          email = "87032834+de-abreu@users.noreply.github.com";
        };
      };
      signing = {
        format = "ssh";
        key = "${config.home.homeDirectory}/${pubKeyFile}";
        signByDefault = true;
      };
    };
    fish.shellInit = ''
      export GH_TOKEN=(cat ${config.sops.secrets."api-keys/github".path})
    '';
  };
}
