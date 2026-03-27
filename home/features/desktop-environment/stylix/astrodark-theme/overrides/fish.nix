{
  pkgs,
  ...
}:
{
  stylix.targets.fish.enable = false;
  programs.fish = {
    shellInitLast =
      # fish
      ''
        fish_config theme choose "ayu Mirage"
        set --universal pure_color_success green
        set --universal pure_enable_nixdevshell true
        set --universal pure_symbol_nixdevshell_prefix " "
      '';
    plugins = [
      {
        name = "pure"; # INFO:  Shell prompt
        inherit (pkgs.fishPlugins.pure) src;
      }
    ];
  };
}
