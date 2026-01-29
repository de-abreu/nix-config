# INFO: "Nix helper": utilities to aid manipulating Nix
{
  config,
  flakePath,
  lib,
  ...
}: {
  programs = {
    nh = {
      enable = true;
      flake = flakePath;
    };
    fish.shellAbbrs.nos =
      lib.mkIf config.programs.fish.enable
      "nh os switch -- --show-trace";
  };
}
