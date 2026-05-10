{
  flakePath,
  ...
}:
{
  programs = {
    nh = {
      enable = true;
      flake = flakePath;
    };
    fish.shellAbbrs.nos = "sudo -v && nh os switch -- --show-trace";
  };

  # Extends sudo credential cache to 6 hours, so that "sudo -v" at the start of the update command can last through the entire build time, even if it is very long.
  security.sudo.extraConfig = "Defaults timestamp_timeout=360";
}
