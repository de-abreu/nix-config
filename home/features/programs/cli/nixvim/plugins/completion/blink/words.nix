{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = [pkgs.vimPlugins.blink-cmp-words];
    extraPackages = [pkgs.wordnet];
  };

  extra.lz-n.plugins = [
    {
      name = "blink-cmp-words";
      event = ["InsertEnter" "CmdlineEnter"];
    }
  ];
}
