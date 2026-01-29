{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.stylix.homeModules.stylix
    ./overrides
  ];

  stylix = with pkgs; {
    enable = true;
    base16Scheme = "${base16-schemes}/share/themes/ayu-mirage.yaml";
    polarity = "dark";

    fonts = {
      serif = {
        package = libre-baskerville;
        name = "LibreBaskerville";
      };
      sansSerif = {
        package = inter;
        name = "Inter";
      };
      monospace = {
        package = nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      emoji = {
        package = noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        terminal = 10;
        desktop = 12;
      };
    };
  };
}
