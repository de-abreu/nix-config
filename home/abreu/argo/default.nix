{
  inputs,
  outputs,
  config,
  ...
}:
{
  imports =
    with inputs;
    [
      (import-tree ../../features/desktop-environment/hydenix)
      (import-tree ../../features/desktop-environment/stylix/astrodark-theme)
      (import-tree ../../features/keymaps/abnt2)
      (import-tree ../../features/programs)
      (import-tree ../../common)
      ./git.nix

      sops-nix.homeManagerModules.sops
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
