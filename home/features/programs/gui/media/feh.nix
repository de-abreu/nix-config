# INFO: Minimal image viewer
{ lib, ... }:
let
  mimeTypes = map (el: "image/" + el) [
    "bmp"
    "gif"
    "jpeg"
    "png"
    "svg+xml"
    "tiff"
    "webp"
    "x-portable-bitmap"
    "x-portable-graymap"
    "x-portable-pixmap"
    "x-xbitmap"
    "x-xpixmap"
  ];

in
{
  programs.feh.enable = true;

  xdg.desktopEntries.feh = {
    name = "feh";
    genericName = "Image Viewer";
    exec = "feh %U";
    terminal = false;
    categories = [
      "Graphics"
      "Viewer"
    ];
    mimeType = mimeTypes;
  };

  xdg.mimeApps.defaultApplications = lib.foldr (
    el: acc: { ${el} = "feh.desktop"; } // acc
  ) { } mimeTypes;
}
