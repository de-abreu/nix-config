# INFO: Whenever the cursor jumps the entire line where it lands blinks, making
# it easier after quick movements
{ pkgs, inputs, ... }:
let
  beacon = pkgs.vimUtils.buildVimPlugin {
    pname = "beacon.nvim";
    version = "master";
    src = inputs.beacon-nvim;
  };
in
{
  programs.nixvim.extraPlugins = [
    {
      plugin = beacon;
      optional = true;
    }
  ];

  extra.lz-n.plugins = [
    {
      __unkeyed-1 = "beacon.nvim";
      event = "DeferredUIEnter";
    }
  ];
}
