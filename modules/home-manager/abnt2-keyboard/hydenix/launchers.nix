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
    bindd = ${mod}, space, $d Application finder, exec, $toDefault; pkill -x rofi || $rofi-launch d
    bindd = ${mod}, TAB, $d Window switcher, exec, $toDefault; pkill -x rofi || $rofi-launch w
    bindd = ${mod}, slash, $d Keybind cheatsheet, exec, $toDefault; pkill -x rofi || hyde-shell keybinds_hint c
    bindd = ${mod}, comma, $d Emoji picker, exec, $toDefault; pkill -x rofi || hyde-shell emoji-picker
    bindd = ${mod}, period, $d Gliph picker, exec, $toDefault; pkill -x rofi || hyde-shell glyph-picker
    bindd = ${mod}, V, $d Clipboard history, exec, $toDefault; pkill -x rofi || hyde-shell cliphist -c
    bindd = ${mod} Shift, space, $d Menu layout options, exec, $toDefault; pkill -x rofi || hyde-shell rofiselect
    bindd = ${mod}, $apostrophe, $d Power options, exec, $toDefault; pkill -x rofi || hyde-shell logoutlaunch

    $d = [$l|Shortcuts]
    bindd = ${mod}, T, $d open terminal, exec, $toDefault; ${TERMINAL}
    bindd = ${mod} Control, T, $d Toggle dropdown terminal, exec, $toDefault; hyde-shell pypr console
    bindd = ${mod}, E, $d open file explorer, exec, $toDefault; ${FILEBROWSER}
    bindd = ${mod}, B, $d open web browser, exec, $toDefault; ${BROWSER}
    bindd = ${mod}, S, $d open system monitor, exec, $toDefault; ${SYS_MONITOR}
    bindd = ${mod}, G, $d open game launcher , exec, $toDefault; hyde-shell gamelauncher # run game launcher for steam and lutris
    bindd = ${mod} Alt, G, $d game mode , exec, $toDefault; hyde-shell gamemode # disable hypr effects for gamemode
    bindd = , $printScreen, $d take a screenshot, exec, $toDefault; ${screenshot}/bin/screenshot
  ''
