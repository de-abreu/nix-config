{pkgs, ...}: {
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-curses; # INFO: Input passwords directly through the cli interface
  };
}
