{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  programs.wezterm = {
    enable = true;
    extraConfig =
      with lib;
      builtins.readDir ./modules
      |> builtins.attrNames
      |> map (f: removeSuffix ".lua" f)
      |> flip genAttrs (f: ./modules/${f}.lua);
    plugins = { inherit (inputs) tabline-wez; };
  };

  home = {
    sessionVariables.TERMINAL = "wezterm";
    packages = [ pkgs.wezterm-floating ];
  };
}
