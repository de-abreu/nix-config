let
  icons = import ./_icons.nix;
in
{
  programs.nixvim.diagnostic.settings = {
    virtual_lines.current_line = true;
    virtual_text = false;
    signs = {
      text = with icons.diagnostic; [
        "${error} "
        "${warn} "
        "${hint} "
        "${info} "
      ];
    };
  };
}
