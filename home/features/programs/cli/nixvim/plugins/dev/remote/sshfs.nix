{ inputs, pkgs, ... }:
let
  sshfs = pkgs.vimUtils.buildVimPlugin {
    pname = "sshfs.nvim";
    version = "main";
    src = inputs.sshfs-nvim;
  };
in
{
  programs.nixvim = {
    extraPackages = [
      pkgs.openssh
      pkgs.sshfs
    ];
    extraPlugins = [ sshfs ];
    extraConfigLua = ''
      require("sshfs").setup({})
    '';
  };
}