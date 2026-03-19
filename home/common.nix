{ config, ... }:
{
  _module.args.flakePath = "${config.xdg.configHome}/nix-config";
  xdg.configFile."mimeapps.list".force = true;
}
