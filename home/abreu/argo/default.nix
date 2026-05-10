{
  inputs,
  outputs,
  config,
  ...
}:
{
  imports = [
    (inputs.import-tree [
      ../../features/desktop-environment/hydenix
      ../../features/desktop-environment/stylix/astrodark-theme
      ../../features/keymaps
      ../../features/programs
      ../../common
      ./git.nix
    ])

    inputs.sops-nix.homeManagerModules.sops
    inputs.vortriz-nur.homeModules.zotero
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
