{
  pkgs,
  lib,
  fetchFromGitHub,
  ...
}:

pkgs.stdenv.mkDerivation {
  pname = "wfrc";
  version = "0.1.5";

  src = fetchFromGitHub {
    owner = "Vescrity";
    repo = "wfrc";
    rev = "v0.1.5";
    hash = "sha256-M9duZz3nPn6BuleMi0VlkSRAOYHXpq/uizAZvXVIsCI=";
  };

  dontBuild = true;

  nativeBuildInputs = [ pkgs.makeWrapper ];

  installPhase = ''
    install -Dm755 wfrc $out/bin/wfrc
    wrapProgram $out/bin/wfrc \
      --prefix PATH : ${lib.makeBinPath [
        pkgs.slurp
        pkgs.wl-clipboard
        pkgs.libnotify
        pkgs.pulseaudio
      ]}
  '';

  meta = with lib; {
    description = "A simple Wayland screen recorder wrapper with toggle";
    homepage = "https://github.com/Vescrity/wfrc";
    license = licenses.lgpl21Only;
    platforms = platforms.linux;
    maintainers = [ ];
    mainProgram = "wfrc";
  };
}
