{ pkgs, ... }:
{
  programs.presenterm = {
    enable = true;
    package = pkgs.unstable.presenterm;

    settings = {
      options = {
        list_item_newlines = 2;
        end_slide_shorthand = true;
        implicit_slide_ends = true;
      };
      snippet = {
        exec.enable = true;
        exec_replace.enable = true;
      };
    };

    render = {
      latex.enable = true;
      mermaid.enable = true;
    };

    exportPdf.enable = true;
  };
}
