{
  inputs,
  outputs,
  config,
  ...
}: {
  imports =
    [
      ../../features/desktop-environment/hydenix
      ../../features/desktop-environment/stylix/ayu-mirage-theme
      ../../features/keymaps/abnt2
      ../../features/programs
      ../../common.nix
      ./git.nix

      inputs.sops-nix.homeManagerModules.sops
      inputs.nixvim.homeModules.nixvim
    ]
    # Custom modules
    ++ (builtins.attrValues outputs.homeModules);

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
}
