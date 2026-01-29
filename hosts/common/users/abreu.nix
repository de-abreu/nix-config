{
  config,
  experimentalFeatures,
  importAll,
  inputs,
  outputs,
  pkgs,
  ...
}: let
  username = "abreu";
in {
  imports = [
    inputs.hydenix.inputs.home-manager.nixosModules.home-manager
  ];

  users.users.${username} = {
    isNormalUser = true;
    description = "Abreu";
    extraGroups = ["networkmanager" "wheel" "video"];

    # INFO: The following line explicitly installs the home-manager CLI tool.
    # Even though it should not be used for system updates in a NixOS settings,
    # it is still useful to read documentation (`man home-configuration.nix`) and
    # the inspection of the current generation.
    packages = [
      inputs.hydenix.inputs.home-manager.packages.${pkgs.system}.default
      pkgs.sops
    ];
    hashedPasswordFile = config.sops.secrets."root_password".path;
  };

  sops.age.keyFile = "/home/abreu/.config/sops/age/keys.txt";

  services.displayManager.autoLogin = {
    enable = true;
    user = username;
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs outputs importAll experimentalFeatures;
    };
    backupFileExtension = "bak";
    users.${username} =
      import
      "${inputs.self}/home/${username}/${config.networking.hostName}";
  };
}
