{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.programs) yazi zathura;
  inherit (lib) getExe;
  pdfPicker = pkgs.writeShellScriptBin "yazi-pdf-picker" ''
    tmp=$(mktemp /tmp/yazi-pdf-XXXXXX)
    trap "rm -f $tmp" EXIT
    ${getExe yazi.package} --chooser-file="$tmp"
    if [ -s "$tmp" ]; then
      ${getExe zathura.package} --fork "$(cat "$tmp")"
    fi
  '';
in
{
  programs.zathura.mappings."e" = ''
    feedkeys ":exec ${zathura.floatingWindow (getExe pdfPicker)}<Return>"
  '';
}
