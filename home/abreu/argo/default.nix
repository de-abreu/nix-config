{
  inputs,
  outputs,
  config,
  ...
}: {
  imports =
    [
      ../../features/cli
      ../../features/gui
      ../../features/desktop-environment/hydenix
      ../../features/desktop-environment/stylix/ayu-mirage-theme

      ../../common.nix
      ./git.nix
      inputs.sops-nix.homeManagerModules.sops
    ]
    # Custom modules
    ++ (builtins.attrValues outputs.homeManagerModules);

  home = {
    username = "abreu";
    homeDirectory = "/home/${config.home.username}";
  };

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = "${inputs.self}/secrets/users/abreu.yaml";
    secrets = {
      "api-keys/deepseek" = {};
      "api-keys/tavily" = {};
    };
  };

  abnt2-keyboard.hm.enable = true;
}
