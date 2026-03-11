{pkgs}:
pkgs.vimUtils.buildVimPlugin {
  name = "alpha-ascii";
  src = pkgs.fetchFromGitHub {
    owner = "nhattVim";
    repo = "alpha-ascii.nvim";
    rev = "0c64c489745362a26c4839e557b45f49e0c9a093";
    hash = "sha256-Jz+aQv74T49z0y1bBGeC4+g5O0sOa1/D+d3Tj5G8j8E=";
  };
}
