let
  icons = import ./lib/icons.nix;
in {
  programs.nixvim.diagnostic.settings = {
    signs = {
      text = with icons.diagnostic; {
        "[vim.diagnostic.severity.ERROR]" = "${error} ";
        "[vim.diagnostic.severity.WARN]" = "${warn} ";
        "[vim.diagnostic.severity.HINT]" = "${hint}";
        "[vim.diagnostic.severity.INFO]" = "${info} ";
      };
    };
  };
}
