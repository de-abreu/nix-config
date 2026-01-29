{config, ...}: {
  _module.args.flakePath = "${config.xdg.configHome}/nix-config";
}
