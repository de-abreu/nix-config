{
  lib,
  pkgs,
  ...
}:
with builtins; let
  transparent = foldl' (acc: el: acc + "windowrulev2=opacity 0.8 0.7 1.0, ${el}\n") "" [
    "class:^org.wezfurlong.wezterm$"
    "class:^org.pwmt.zathura$"
  ];
  floating = foldl' (acc: el: acc + "windowrulev2=float, ${el}\n") "" [
    "title:^Calculator$"
    "title:^Choose Files$"
    "title:^Confirm to replace files$"
    "title:^File Operation Progress$"
    "title:^Save as$"
    "class:^(xdg-desktop-portal-gtk)$"
  ];
in {
  # FIX: A patch legacy hyprland configuration that is incompatible with the
  # recent breaking changes.

  home.file.".local/share/hypr/" = lib.mkForce {
    recursive = true;
    source = pkgs.runCommand "hyde-hypr-patched" {} ''
      # 1. Create the output directory
      mkdir -p $out

      # 2. Copy the original Hydenix files into it
      cp -r ${pkgs.hyde}/Configs/.local/share/hypr/* $out/

      # 3. Give ourselves write permission (Store files are read-only by default)
      chmod -R +w $out

      # 4. Overwrite the specific file with your custom version
      rm $out/windowrules.conf
      cp ${./default-window-rules.conf} $out/windowrules.conf
    '';
  };
  hydenix.hm.hyprland.windowrules.overrideConfig =
    (readFile ./application-window-rules.conf) + transparent + floating;
}
