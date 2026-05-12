{ lib, stdenvNoCC }:
stdenvNoCC.mkDerivation {
  pname = "smart-switch";
  version = "unstable-2025-01-01";
  src = ./.;
  installPhase = ''
    runHook preInstall
    cp -r . $out
    runHook postInstall
  '';
  meta = with lib; {
    description = "Yazi plugin for smart tab switching by index";
    license = licenses.mit;
    platforms = platforms.all;
  };
}