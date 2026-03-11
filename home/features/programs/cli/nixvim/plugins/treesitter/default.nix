{
  config,
  importAll,
  ...
}: {
  imports = importAll {dir = ./.;};
  _module.args.treesitter = config.programs.nixvim.plugins.treesitter;
}
