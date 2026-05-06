# INFO: Whenever the cursor jumps the entire line where it lands blinks, making
# it easier after quick movements
{ pkgs, inputs, ... }:
let
  pname = "beacon.nvim";
  beacon = pkgs.vimUtils.buildVimPlugin {
    pname = pname;
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
      __unkeyed-1 = pname;
      event = "DeferredUIEnter";
    }
  ];
}
