{
  config,
  flakePath,
  lib,
  pkgs,
  ...
}:
let
  inherit (pkgs) coreutils;
in
{
  # markdown
  home.file.".config/opencode/AGENTS.md" = {
    text = ''
      # NixOS System Instructions

      You are operating on a NixOS system version ${lib.version}. The system's configuration and the home environment of its users are managed through a flake located at the `${flakePath}` folder.

      > [!warn] Editing AGENTS.md
      > Even though this file (${config.xdg.configHome}/opencode/AGENTS.md) is mutable, it is also being managed through Home-Manager and, as such, changes must be added to `${flakePath}/home/features/programs/cli/opencode/default.nix` in order to persist in newer generations. Offer to update the nix configuration accordingly whenever the user asks for changes to be made in this file.

      ## Comma Tool for Ad-hoc Commands

      When a command is not found or not in PATH, use the `,` (comma) prefix to
      temporarily install and run it from nixpkgs.

      **Usage**: `, <command> [args...]`

      **Examples**:

      - `, pdftotext file.pdf -` — extract PDF text
      - `, jq . file.json` — parse JSON
      - `, pip3 install package` — run pip without installing Python globally
      - `, tree` — show directory tree

      ### When to Use Comma

      - When `which <command>` fails or returns nothing
      - When a required tool is missing from PATH
      - For one-off utilities (pdftotext, jq, tree, ripgrep, etc.)

      ### Workflow

      1. First try running the command directly
      2. If it fails with "command not found", retry with `,` prefix
      3. Comma caches package resolutions for fast subsequent runs
    '';
    mutable = true;
    force = true;
  };
}
