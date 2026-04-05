{
  config,
  lib,
  ...
}:
{
  programs.nixvim.plugins = {
    snacks = {
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
          "toggle"
          "zen"
        ]
        ++ lib.optionals config.programs.git.enable [ "gitbrowse" ]
        ++ lib.optionals config.programs.lazygit.enable [ "lazygit" ]
        |> (
          l:
          lib.genAttrs l (_: {
            enabled = true;
          })
        );
    };
    faster.settings.behaviours.bigfile.features_disabled = [ "snacks" ];
  };
}
