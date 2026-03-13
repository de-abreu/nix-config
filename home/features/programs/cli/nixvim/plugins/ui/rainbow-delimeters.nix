{pkgs, ...}: {
  programs.nixvim.extraPlugins = [pkgs.vimPlugins.rainbow-delimiters-nvim];
  extra.lz-n.plugins = [
    {
      name = "rainbow-delimiters.nvim";
      event = ["BufReadPre" "BufNewFile"];
    }
  ];
}
