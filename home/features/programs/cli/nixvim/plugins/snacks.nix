{
  config,
  lib,
  ...
}: {
  programs.nixvim.plugins.snacks = {
    enable = true;
    settings =
      [
        "bufdelete"
        "dim"
        "indent"
        "input"
        "picker"
        "profiler"
        "quickfile"
        "rename"
        "scroll"
        "statuscolumn"
        "terminal"
        "zen"
      ]
      ++ lib.optionals config.programs.git.enabled ["gitbrowse"]
      ++ lib.optionals config.programs.lazygit.enabled ["lazygit"]
      |> (l: lib.genAttrs l (_: {enabled = true;}));
  };
}
