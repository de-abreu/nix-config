{}: {hyprmode ? false}: let
  mod =
    if hyprmode
    then ""
    else "$mainMod";
in
  # hyprlang
  ''
    $rice =Theming and Wallpaper
    $d=[$rice]
    bindd = ${mod} Alt, A, $d next global wallpaper , exec, hyde-shell wallpaper -Gn # next global wallpaper
    bindd = ${mod} Alt, F, $d previous global wallpaper , exec, hyde-shell wallpaper -Gp # previous global wallpaper
    bindd = ${mod} Alt, D, $d next waybar layout , exec, hyde-shell wbarconfgen n # next waybar mode
    bindd = ${mod} Alt, S, $d previous waybar layout , exec, hyde-shell wbarconfgen p # previous waybar mode
    bindd = ${mod} Shift, T, $d select a theme, exec, pkill -x rofi || hyde-shell themeselect # launch theme select menu
    bindd = ${mod} Shift, Y, $d select animations, exec, pkill -x rofi || hyde-shell animations --select # launch animations select menu
    bindd = ${mod} Shift, U, $d select hyprlock layout, exec, pkill -x rofi || hyde-shell hyprlock --select # launch hyprlock layout select menu
  ''
