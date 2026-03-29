{config, lib, ...}: {
  options.extra.lz-n.plugins = lib.mkOption {
    type = lib.types.listOf lib.types.anything;
    default = [];
    description = "Collector to lazy load extra plugins with lz-n";
  };
  config = {
    programs.nixvim.plugins = {
      lzn-auto-require.enable = true;
      lz-n = {
        enable = true;
        plugins = config.extra.lz-n.plugins;
      };
    };
  };
}
