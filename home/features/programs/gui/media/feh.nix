# INFO: Minimal image viewer
{lib, ...}: {
  programs.feh.enable = true;
  xdg.mimeApps.defaultApplications =
    lib.foldr
    (n: acc: {"image/${n}" = "feh.desktop";} // acc) {} [
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
}
