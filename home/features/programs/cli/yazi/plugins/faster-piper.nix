{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib)
    flatten
    optionalString
    getExe
    getExe'
    ;

  euporiePreview = getExe' pkgs.python3Packages.euporie "euporie-preview";
  rich = getExe' pkgs.rich-cli "rich";
  eza = getExe' pkgs.eza "eza";
  hexyl = getExe pkgs.hexyl;

  mkFpConfig =
    config:
    config
    |> map (
      {
        cmd,
        files,
        formatUrl ? false,
      }:
      map (pattern: {
        preloader = {
          url = pattern;
          run = "faster-piper -- ${cmd}";
        };
        previewer = {
          url = pattern;
          run = "faster-piper --rely-on-preloader" + optionalString formatUrl " --format=url";
        };
      }) files
    )
    |> flatten
    |> (entries: {
      prepend_preloaders = map (e: e.preloader) entries;
      prepend_previewers = map (e: e.previewer) entries;
    });

  fp = mkFpConfig [
    {
      cmd = "${euporiePreview} \"$1\"";
      files = [ "*.ipynb" ];
    }
    {
      cmd = "${rich} -j --left --panel=rounded --guides --line-numbers --force-terminal \"$1\"";
      files = [
        "*.md"
        "*.json"
        "*.csv"
        "*.rst"
      ];
    }
    {
      cmd = "tar tf \"$1\"";
      files = [ "*.tar*" ];
      formatUrl = true;
    }
    {
      cmd = "${eza} -TL=3 --color=always --icons=always --group-directories-first --no-quotes \"$1\"";
      files = [ "*/" ];
    }
  ];
in
{
  programs.yazi = {
    plugins = { inherit (inputs) faster-piper; };
    settings.plugin = {
      prepend_preloaders = fp.prepend_preloaders;
      prepend_previewers = fp.prepend_previewers;
      append_previewers = [
        {
          url = "*";
          run = "faster-piper -- ${hexyl} --border=none --terminal-width=$w \"$1\"";
        }
      ];
    };
  };
}
