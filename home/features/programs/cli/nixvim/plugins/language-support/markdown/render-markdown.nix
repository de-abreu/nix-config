{
  programs.nixvim.plugins.render-markdown = {
    enable = true;
    lazyLoad.settings = {
      event = [
        "BufReadPre *.md"
        "BufNewFile *.md"
        "BufReadPre *.markdown"
        "BufNewFile *.markdown"
      ];
      ft = [
        "markdown"
      ];
    };
  };
}
