{pkgs, ...}: {
  programs.nixvim = {
    # 1. Add the package so it's on the system
    extraPlugins = with pkgs; [vimPlugins.blink-cmp-words wordnet];

    # 2. Tell lz-n when to "activate" this plugin
    plugins.lz-n.settings.plugins = [
      {
        name = "blink-cmp-words"; # The name of the package/folder
        event = ["InsertEnter" "CmdlineEnter"];
      }
    ];
  };
}
