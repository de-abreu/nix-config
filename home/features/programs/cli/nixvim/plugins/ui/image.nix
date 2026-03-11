{pkgs, ...}: {
  programs.nixvim = {
    extraPackages = with pkgs; [
      imagemagick # Image conversion (required for image module)
      ghostscript # PDF rendering
      mermaid-cli # Mermaid diagrams
      typst # Math expression rendering
      tectonic # LaTeX for math expressions
    ];

    plugins.snacks.settings.image = {
      enabled = true;
      doc = {
        enabled = true;
        inline = true;
        float = true;
        max_width = 100;
        max_height = 50;
      };
    };
  };
}
