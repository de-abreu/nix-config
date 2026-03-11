{
  importAll,
  lib,
  pluginCfg,
  ...
}: {
  imports = importAll {dir = ./.;};

  _module.args = {
    snacksAction = func: {opts ? ""}: {
      __raw = "function() Snacks.${func}(${opts}) end";
    };
    snacksCfg = pluginCfg.snacks.settings;
    featuresEnabled = features: let
      cfg = pluginCfg.snacks;
      enabled = f: cfg.settings.${f}.enabled or false;
    in
      if !cfg.enable
      then false
      else if builtins.isList features
      then lib.all enabled features
      else enabled features;
  };
}
