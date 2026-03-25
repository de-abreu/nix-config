{
  inputs,
  outputs,
  config,
  ...
}:
{
  imports = [
    ../../features/desktop-environment/hydenix
    ../../features/desktop-environment/stylix/astrodark-theme
    ../../features/keymaps/abnt2
    ../../features/programs
    ../../common
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
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    defaultSopsFile = "${inputs.self}/secrets/users/abreu.yaml";
  };
}
