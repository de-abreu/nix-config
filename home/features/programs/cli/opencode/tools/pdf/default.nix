# PDF processing tools for opencode skills
{ pkgs, ... }:
{
  programs.opencode.extraPackages = with pkgs; [
    # Command-line utilities
    poppler-utils # pdftotext, pdfimages, etc.
    qpdf # PDF manipulation (merge, split, rotate)
    tesseract # OCR engine for scanned PDFs
    imagemagick # Image manipulation (magick command)
    pdftk # PDF toolkit (merge, split, rotate)

    # Python environment with PDF libraries
    (python3.withPackages (
      ps: with ps; [
        pypdf # Basic PDF operations (merge, split, rotate)
        pdfplumber # Text and table extraction with layout
        reportlab # PDF creation
        pypdfium2 # PDF rendering and advanced features
        pytesseract # Python wrapper for Tesseract OCR
        pdf2image # Convert PDF pages to images
        pandas # Data processing for extracted tables
        pillow # Image processing (PIL fork)
      ]
    ))
  ];

  xdg.configFile."opencode/skills/pdf/".source = ./skills;
}

