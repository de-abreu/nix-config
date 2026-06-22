{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  inherit (config.programs) yazi zathura;

  wezterm-floating = getExe pkgs.wezterm-floating;

  pdfPicker =
    pkgs.writeShellScriptBin "yazi-pdf-picker" ''
      tmp=$(mktemp /tmp/yazi-pdf-XXXXXX)
      trap "rm -f $tmp" EXIT
      ${getExe yazi.package} --chooser-file="$tmp"
      if [ -s "$tmp" ]; then
        ${getExe zathura.package} --fork "$(cat "$tmp")"
      fi
    ''
    |> lib.getExe;
in
{
  programs.zathura.mappings."e" = ''feedkeys ":exec ${wezterm-floating} ${pdfPicker}<Return>" '';
}
