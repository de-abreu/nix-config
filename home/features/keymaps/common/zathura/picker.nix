{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.programs) yazi zathura wezterm;
  inherit (lib) getExe;

  wezterm-floating = getExe wezterm.floatingPackage;

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
  programs.zathura.mappings."e" =
    ''feedkeys ":exec ${wezterm-floating} ${getExe pdfPicker}<Return>" '';
}