{
  config,
  lib,
  pkgs,
}: {hyprmode ? false}:
with config.home.sessionVariables; let
  mod =
    if hyprmode
    then ""
    else "$mainMod";
  screenshot = lib.getExe pkgs.screenshot;
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
    bindd = ${mod}, $apostrophe, $d Power options, exec, pkill -x rofi || hyde-shell logoutlaunch; $toDefault

    $d = [$l|Shortcuts]
    bindd = ${mod}, T, $d open terminal, exec, $toDefault; ${TERMINAL}
    bindd = ${mod} Control, T, $d Toggle dropdown terminal, exec, $toDefault; hyde-shell pypr console
    bindd = ${mod}, E, $d open file explorer, exec, $toDefault; ${FILEBROWSER}
    bindd = ${mod}, B, $d open web browser, exec, $toDefault; ${BROWSER}
    bindd = ${mod}, S, $d open system monitor, exec, $toDefault; ${SYS_MONITOR}
    bindd = ${mod} Shift, G, $d open game launcher , exec, $toDefault; hyde-shell gamelauncher # run game launcher for steam and lutris
    bindd = ${mod} Alt, G, $d game mode , exec, $toDefault; hyde-shell gamemode # disable hypr effects for gamemode
    bindd = , $printScreen, $d take a screenshot, exec, $toDefault; ${screenshot}
  ''
