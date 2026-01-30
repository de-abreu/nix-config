{
  config,
  pkgs,
}: {hyprmode ? false}:
with pkgs;
with config.home.sessionVariables; let
  mod =
    if hyprmode
    then ""
    else "$mainMod";
in
  #hyprlang
  ''
    $l=Launchers

    $d = [$l|Menus]
    $rofi-launch=hyde-shell rofilaunch
    bindd = ${mod}, space, $d Application finder, exec, pkill -x rofi || $rofi-launch d; $toDefault
    bindd = ${mod}, TAB, $d Window switcher, exec, pkill -x rofi || $rofi-launch w; $toDefault
    bindd = ${mod}, slash, $d Keybind cheatsheet, exec, pkill -x rofi || hyde-shell keybinds_hint c; $toDefault
    bindd = ${mod}, comma, $d Emoji picker, exec, pkill -x rofi || hyde-shell emoji-picker; $toDefault
    bindd = ${mod}, period, $d Gliph picker, exec, pkill -x rofi || hyde-shell glyph-picker; $toDefault
    bindd = ${mod}, V, $d Clipboard history, exec, pkill -x rofi || hyde-shell cliphist -c; $toDefault
    bindd = ${mod} Shift, space, $d Menu layout options, exec, pkill -x rofi || hyde-shell rofiselect; $toDefault
    bindd = ${mod} Shift, W, $d Change Wallpaper, exec, pkill -x rofi || hyde-shell wallpaper -SG # launch wallpaper select menu
    bindd = ${mod}, $apostrophe, $d Power options, exec, pkill -x rofi || hyde-shell logoutlaunch

    $d = [$l|Shortcuts]
    bindd = ${mod}, T, $d open terminal, exec, ${TERMINAL}; $toDefault
    bindd = ${mod} Control, T, $d Toggle dropdown terminal, exec, hyde-shell pypr console; $toDefault
    bindd = ${mod}, E, $d open file explorer, exec, ${FILEBROWSER}; $toDefault
    bindd = ${mod}, B, $d open web browser, exec, ${BROWSER}; $toDefault
    bindd = ${mod}, S, $d open system monitor, exec, ${SYS_MONITOR}; $toDefault
    bindd = ${mod}, G, $d open game launcher , exec, hyde-shell gamelauncher; $toDefault # run game launcher for steam and lutris
    bindd = ${mod} Alt, G, $d game mode , exec, hyde-shell gamemode; $toDefault # disable hypr effects for gamemode
    bindd = , $printScreen, $d take a screenshot, exec, ${screenshot}/bin/screenshot; $toDefault
  ''
