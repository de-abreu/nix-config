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
    bindd = ${mod} Shift, W, $d Change Wallpaper, exec, pkill -x rofi || hyde-shell wallpaper -SG; $toDefault # launch wallpaper select menu
    bindd = ${mod} Shift, T, $d select a theme, exec, pkill -x rofi || hyde-shell themeselect; $toDefault # launch theme select menu
    bindd = ${mod} Shift, Y, $d select animations, exec, pkill -x rofi || hyde-shell animations --select; $toDefault # launch animations select menu
    bindd = ${mod} Shift, U, $d select hyprlock layout, exec, pkill -x rofi || hyde-shell hyprlock --select; $toDefault # launch hyprlock layout select menu
  ''
