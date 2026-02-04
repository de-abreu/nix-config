# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  inputs,
  outputs,
  config,
  pkgs,
  ...
}: let
  hostname = "argo";
in {
  imports =
    [
      inputs.hydenix.nixosModules.default # Hydenix desktop environment
      inputs.sops-nix.nixosModules.sops # Sops secrets management

      # Hardware modules
      ./hardware-configuration.nix # Results of the hardware scan.
      inputs.nixos-hardware.nixosModules.common-cpu-intel # Intel CPU
      inputs.nixos-hardware.nixosModules.common-pc-laptop # Laptops
      inputs.nixos-hardware.nixosModules.common-pc-ssd # SSD storage
    ]
    # Custom modules
    ++ (builtins.attrValues outputs.nixosModules);

  nixpkgs.overlays = [
    inputs.hydenix.overlays.default
  ];

  # Bootloader configuration for legacy boot mode
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    loader.grub = {
      enable = true;
      device = "/dev/sda";
      useOSProber = false;
      theme = pkgs.hyde + "/share/grub/themes/Retroboot";
    };
  };

  hydenix = {
    enable = true;
    hostname = hostname;
    timezone = "America/Sao_Paulo";
    locale = "en_US.UTF-8";
    boot.enable = false;
    gaming.enable = false;
  };

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  programs = {
    adjust_kbd_backlight = {
      enable = true;
      device = "dell::kbd_backlight";
    };
    kanata = {
      enable = true;
      devices = ["/dev/input/by-path/platform-i8042-serio-0-event-kbd"];
      addBinaryToPath = true;
    };
  };

  sops = {
    defaultSopsFormat = "yaml";
    defaultSopsFile = "${inputs.self}/secrets/hosts/argo.yaml";
    secrets.root_password = {neededForUsers = true;};
  };

  users.users.root.hashedPasswordFile = config.sops.secrets.root_password.path;
}
