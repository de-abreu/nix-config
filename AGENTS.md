# AGENTS.md

Coding agent instructions for this NixOS configuration repository.

## Project Overview

This is a NixOS flake-based configuration using:
- **home-manager** for user-level configuration
- **sops-nix** for secrets management
- **nixvim** for Neovim configuration
- **hydenix** for desktop environment

## Build Commands

### Rebuild NixOS System
```bash
nh os switch -- --show-trace
```

### Check Flake
```bash
nix flake check
```

### Evaluate without Building
```bash
nix eval .#nixosConfigurations.argo.config.system.build.toplevel
```

### Update Flake Inputs
```bash
nix flake update              # Update all inputs
nix flake update nixpkgs       # Update specific input
```

### Enter Dev Shell
```bash
nix develop
# or
nix-shell
```

## Testing

Run `nix flake check` to validate the flake evaluates correctly.

## Project Structure

```
.
├── flake.nix           # Flake entry point
├── flake-outputs.nix   # Flake outputs definition
├── hosts/              # NixOS host configurations
│   └── argo/           # Host-specific config
├── home/               # Home Manager configurations
│   ├── common.nix      # Shared home settings
│   ├── abreu/          # User-specific home config
│   └── features/       # Modular feature sets
│       ├── desktop-environment/
│       ├── keymaps/
│       └── programs/
├── modules/            # Custom NixOS and HM modules
│   ├── nixos/          # NixOS modules
│   └── home-manager/   # Home Manager modules
├── overlays/           # Nixpkgs overlays
├── pkgs/                # Custom packages
└── secrets/            # sops-nix encrypted secrets
```

## Code Style Guidelines

### Nix Formatting

- **Indent:** 2 spaces
- **Pipe operators:** Use `|>` for transformations (enabled via experimental features)
- **Attributes:** Place `options` before `config` in modules

### Module Structure

Follow this pattern for custom modules:

```nix
{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  inherit (types) package str;  # Import needed types
  cfg = config.programs.my-module;
in {
  options.programs.my-module = {
    enable = mkEnableOption "description";
    
    someOption = mkOption {
      type = str;
      default = "value";
      description = "What this option does";
    };
  };

  config = mkIf cfg.enable {
    # Implementation
  };
}
```

### Importing Modules

Use the `importAll` helper for auto-importing:

```nix
{ importAll, ... }: {
  imports = importAll { dir = ./.; };
}
```

For conditional imports:

```nix
imports = importAll {
  dir = ./.;
  exclude = [ " undesired.nix " ];
};
```

### Comments

Use `# INFO:` prefix for section headers:

```nix
# INFO: Hydenix desktop environment
{
  ...
}
```

### Home Manager Patterns

**Environment variables:**

```nix
home.sessionVariables.MY_VAR = "value";
```

**Shell init (for fish):**

```nix
programs.fish.shellInit = ''
  export MY_VAR=value
'';
```

**sops secrets:**

```nix
sops.secrets = lib.genAttrs [
  "api-keys/service-name"
] (_: { });
```

## Secrets Management

When adding new API keys or secrets:

1. Add the secret to `secrets/users/abreu.yaml` using sops:

   ```bash
   sops secrets/users/abreu.yaml
   ```

2. Reference in Nix config:

   ```nix
   sops.secrets."api-keys/my-service" = {};
   programs.fish.shellInit = ''
     export MY_API_KEY=(cat ${config.sops.secrets."api-keys/my-service".path})
   '';
   ```

## Naming Conventions

- **Files:** `kebab-case.nix`
- **Directories:** `kebab-case`
- **Options:** `camelCase` for option names
- **Variables:** `camelCase` for local variables

## Key Experimental Features

Enabled by default:
- `nix-command`
- `flakes`
- `pipe-operators`

## Common Tasks

### Adding a New Program

Create a module in `home/features/programs/cli/`:

```nix
{ pkgs, ... }:
{
  programs.my-program = {
    enable = true;
    package = pkgs.my-package;
    settings = { ... };
  };
}
```

Then import in `default.nix` or use `importAll`.

### Adding a New Host

1. Create `hosts/hostname/` directory
2. Add `configuration.nix` and `hardware-configuration.nix`
3. Register in `flake-outputs.nix`:

   ```nix
   nixosConfigurations.hostname = lib.nixosSystem {
     modules = [ ./hosts/hostname ];
     specialArgs = { inherit inputs outputs importAll experimentalFeatures; };
   };
   ```

### Adding a Custom Module

1. Create module in `modules/nixos/` or `modules/home-manager/`
2. Export in `default.nix`:

   ```nix
   {
     my-module = import ./my-module.nix;
   }
   ```

## Important Files

- `.sops.yaml` - Sops configuration
- `secrets/users/abreu.yaml` - User secrets (encrypted)
- `secrets/hosts/argo.yaml` - Host secrets (encrypted)