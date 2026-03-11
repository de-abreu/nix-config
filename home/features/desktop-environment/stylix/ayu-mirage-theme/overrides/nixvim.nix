{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = [pkgs.vimPlugins.astrotheme];
    extraConfigLua =
      # lua
      ''
        require("astrotheme").setup({
          -- Setting this to `true` bypasses Lazy/Packer checks
          -- and forcefully injects all supported plugin highlight groups.
          plugin_default = true,
        })

        vim.cmd.colorscheme("astrodark")
      '';
  };
}
