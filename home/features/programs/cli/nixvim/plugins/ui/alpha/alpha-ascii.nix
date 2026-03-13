{pkgs}:
pkgs.vimUtils.buildVimPlugin {
  pname = "alpha-ascii.nvim";
  version = "master";
  src =
    pkgs.fetchFromGitHub
    {
      owner = "nhattVim";
      repo = "alpha-ascii.nvim";
      rev = "8cc22c23c5f0b79bf582340927ce454463c5dfac";
      hash = "sha256-sc6w9666CnW94xWW9tuiHseoWvdTM2EMdioIo6EDcjQ=";
    };
}
