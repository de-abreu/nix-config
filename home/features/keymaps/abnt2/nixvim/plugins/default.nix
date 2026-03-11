{
  config,
  importAll,
  ...
}: {
  imports = importAll {dir = ./.;};

  _module.args = {
    pluginCfg = config.programs.nixvim.plugins;
    mkAction = plugin: func: {opts ? ""}: {
      __raw = "function() require('${plugin}').${func}(${opts}) end";
    };
  };
}
