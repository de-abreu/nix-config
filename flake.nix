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

    # INFO: Nixvim
    nixvim.url = "github:nix-community/nixvim/nixos-25.11";

    opencode-nvim = {
      url = "github:nickjvandyke/opencode.nvim/main";
      flake = false;
    };

    alpha-ascii-nvim = {
      url = "github:nhattVim/alpha-ascii.nvim/main";
      flake = false;
    };

    beacon-nvim = {
      url = "github:DanilaMihailov/beacon.nvim/master";
      flake = false;
    };

    qalc-nvim = {
      url = "github:Apeiros-46B/qalc.nvim/main";
      flake = false;
    };

    sshfs-nvim = {
      url = "github:uhs-robert/sshfs.nvim/main";
      flake = false;
    };

    # INFO: OpenCode
    anthropics-skills = {
      url = "github:anthropics/skills";
      flake = false;
    };

    upstash-context7 = {
      url = "github:upstash/context7";
      flake = false;
    };

    hyprmcp = {
      url = "github:stefanoamorelli/hyprmcp/master";
      flake = false;
    };

    # INFO: Yazi
    nix-yazi-plugins = {
      url = "github:lordkekz/nix-yazi-plugins";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    cd-git-root = {
      url = "github:ciarandg/cd-git-root.yazi";
      flake = false;
    };

    faster-piper = {
      url = "github:alberti42/faster-piper.yazi";
      flake = false;
    };

    smart-arrow = {
      url = "github:jessefarinacci/smart-arrow.yazi";
      flake = false;
    };

    yaziline = {
      url = "github:llanosrocas/yaziline.yazi";
      flake = false;
    };

    # INFO: WezTerm
    tabline-wez = {
      url = "github:michaelbrusegard/tabline.wez";
      flake = false;
    };

    smart-splits-nvim = {
      url = "github:mrjones2014/smart-splits.nvim";
      flake = false;
    };

    wezterm-unicode-input = {
      url = "github:de-abreu/wezterm-unicode-input";
      flake = false;
    };

    # INFO: Zotero
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vortriz-nur = {
      url = "github:Vortriz/nur-packages";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # INFO: Fish
    fish-ssh-agent = {
      url = "github:danhper/fish-ssh-agent/master";
      flake = false;
    };
  };

  outputs = inputs: import ./outputs.nix inputs;
}
