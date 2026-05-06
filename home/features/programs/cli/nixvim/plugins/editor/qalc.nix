{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  qalc = pkgs.vimUtils.buildVimPlugin {
    pname = "qalc.nvim";
    version = "main";
    src = inputs.qalc-nvim;
  };
in
lib.mkIf config.programs.qalculate.enable {
  programs.nixvim.extraPlugins = [ { plugin = qalc; } ];
}
