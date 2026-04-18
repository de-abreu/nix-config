{
  description = "A NixOS configuration";

  inputs = {
    # INFO: Core system inputs
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wrappers = {
      url = "github:Lassulus/wrappers";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    import-tree.url = "github:vic/import-tree";

    # INFO: Nixvim and vim plugins
    nixvim.url = "github:nix-community/nixvim/nixos-25.11";

    opencode-nvim = {
      url = "github:nickjvandyke/opencode.nvim/v0.6.0";
      flake = false;
    };

    alpha-ascii-nvim = {
      url = "github:nhattVim/alpha-ascii.nvim/8cc22c23c5f0b79bf582340927ce454463c5dfac";
      flake = false;
    };

    beacon-nvim = {
      url = "github:DanilaMihailov/beacon.nvim/098ff96c33874339d5e61656f3050dbd587d6bd5";
      flake = false;
    };

    # INFO: OpenCode and related tools
    anthropics-skills = {
      url = "github:anthropics/skills";
      flake = false;
    };

    upstash-context7 = {
      url = "github:upstash/context7";
      flake = false;
    };

    hyprmcp = {
      url = "github:stefanoamorelli/hyprmcp/13d5195e6a474078183cb031771be7a71b330bb6";
      flake = false;
    };

    # INFO: Desktop environment
    hydenix = {
      url = "github:richen604/hydenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    stylix.url = "github:nix-community/stylix/release-25.11";

    # INFO: System and hardware
    systems.url = "github:nix-systems/default-linux";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    # INFO: Others
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fish-ssh-agent = {
      url = "github:danhper/fish-ssh-agent/f10d95775352931796fd17f54e6bf2f910163d1b";
      flake = false;
    };
  };

  outputs = inputs: import ./outputs.nix inputs;
}
