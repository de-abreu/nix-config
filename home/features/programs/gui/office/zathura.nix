{
  programs.zathura = {
    enable = true;
    options.selection-clipboard = "clipboard"; # Enables copying text to clipboard
  };
  xdg.mimeApps.defaultApplications."application/pdf" = "org.pwmt.zathura.desktop";
}
