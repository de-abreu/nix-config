{
  pkgs,
  lib,
  ...
}: {
  home.packages = [pkgs.celluloid];
  xdg.mimeApps.defaultApplications =
    lib.foldr
    (elem: acc: {"video/${elem}" = "celluloid.desktop";} // acc) {} [
      "x-matroska"
      "mp4"
    ];
}
