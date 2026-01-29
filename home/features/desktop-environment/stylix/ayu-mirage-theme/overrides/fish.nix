{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.programs.fish.enable {
    stylix.targets.fish.enable = false;
    programs.fish = {
      shellInitLast =
        # fish
        ''
          fish_config theme choose "ayu Mirage"
          set --universal pure_color_success green
          set --universal pure_enable_nixdevshell true
        '';
      plugins = [
        {
          name = "pure"; # INFO:  Shell prompt
          inherit (pkgs.fishPlugins.pure) src;
        }
      ];
    };
  };
}
