{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.programs) yazi wezterm zathura;
  inherit (lib) mkIf getExe;
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
  config = mkIf (yazi.enable && wezterm.enable) {
    programs.zathura.mappings."e" = ''
      feedkeys ":exec ${getExe wezterm.package} --config enable_tab_bar=false --config 'window_close_confirmation=\"NeverPrompt\"' start --class floating -- ${getExe pdfPicker}<Return>"
    '';
  };
}
