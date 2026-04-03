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
    settings = {
      file_types = [ "markdown" ];
      # Keep Setext headings (===, ---) as-is instead of rendering as ATX (#)
      heading.setext = false;
      # Show concealed text (e.g., HTML comments) as greyed out instead of hidden
      win_options.conceallevel.rendered = 2;
    };
  };
}
